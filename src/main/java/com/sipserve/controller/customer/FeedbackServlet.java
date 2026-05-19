package com.sipserve.controller.customer;

import com.sipserve.dao.FeedbackDAO;
import com.sipserve.model.Feedback;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.util.List;
import java.util.UUID;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 * GET  /feedback        → show feedback page (stats + community feed)
 * POST /feedback/submit → save new review, redirect back (PRG pattern)
 */
@WebServlet(urlPatterns = {"/feedback", "/feedback/submit"})
public class FeedbackServlet extends HttpServlet {

    private static final Logger log = Logger.getLogger(FeedbackServlet.class.getName());
    private final FeedbackDAO dao = new FeedbackDAO();

    // ── GET ───────────────────────────────────────────────────────────────────
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        loadPage(req, resp);
    }

    // ── POST ──────────────────────────────────────────────────────────────────
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        req.setCharacterEncoding("UTF-8");

        // ── 1. Authentication guard ────────────────────────────────────────
        HttpSession session = req.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            resp.sendRedirect(req.getContextPath() + "/login");
            return;
        }

        // ── 2. CSRF validation ─────────────────────────────────────────────
        String sessionToken = (String) session.getAttribute("csrfToken");
        String formToken    = req.getParameter("csrfToken");
        if (sessionToken == null || !sessionToken.equals(formToken)) {
            resp.sendError(HttpServletResponse.SC_FORBIDDEN, "Invalid CSRF token");
            return;
        }

        // ── 3. Parse inputs ────────────────────────────────────────────────
        String ratingStr = req.getParameter("rating");
        String message   = req.getParameter("message");

        int rating = 0;
        try { rating = Integer.parseInt(ratingStr); }
        catch (NumberFormatException ignored) {}

        // ── 4. Server-side validation ──────────────────────────────────────
        if (rating < 1 || rating > 5) {
            req.setAttribute("errorMsg", "Please select a valid star rating (1–5).");
            loadPage(req, resp);
            return;
        }
        if (message == null || message.trim().length() < 5) {
            req.setAttribute("errorMsg", "Review must be at least 5 characters.");
            loadPage(req, resp);
            return;
        }
        if (message.length() > 500) {
            message = message.substring(0, 500);
        }

        // ── 5. Read logged-in user from session ────────────────────────────
        String userName  = session.getAttribute("user").toString();
        String userEmail = "";
        Object e = session.getAttribute("email");
        if (e != null) userEmail = e.toString();

        // ── 6. Persist ─────────────────────────────────────────────────────
        try {
            Feedback fb = new Feedback(userName, userEmail, rating, message.trim());
            int newId = dao.insert(fb);

            if (newId > 0) {
                // Rotate CSRF token after successful use
                session.setAttribute("csrfToken", UUID.randomUUID().toString());
                // PRG — flash message survives the redirect
                session.setAttribute("flashSuccess",
                        userName +"Thank you for your review! ");
                resp.sendRedirect(req.getContextPath() + "/feedback");
            } else {
                req.setAttribute("errorMsg", "Something went wrong. Please try again.");
                loadPage(req, resp);
            }
        } catch (RuntimeException ex) {
            log.log(Level.SEVERE, "Failed to save feedback", ex);
            req.setAttribute("errorMsg", "A server error occurred. Please try again later.");
            loadPage(req, resp);
        }
    }

    // ── Shared page-load helper ───────────────────────────────────────────────
    private void loadPage(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        // ── CSRF token: generate once per session, reuse until rotated ─────
        HttpSession session = req.getSession(true);
        if (session.getAttribute("csrfToken") == null) {
            session.setAttribute("csrfToken", UUID.randomUUID().toString());
        }
        req.setAttribute("csrfToken", session.getAttribute("csrfToken"));

        // ── Consume flash from redirect ────────────────────────────────────
        String flash = (String) session.getAttribute("flashSuccess");
        if (flash != null) {
            req.setAttribute("successMsg", flash);
            session.removeAttribute("flashSuccess");
        }

        // ── Stats — single DB round-trip (was 2 separate calls) ───────────
        try {
            double[] stats = dao.getStats();
            int    total = (int) stats[0];
            double avg   = stats[1];
            req.setAttribute("avgRating",    avg   > 0 ? String.format("%.1f", avg) : null);
            req.setAttribute("totalReviews", total > 0 ? total : null);
        } catch (RuntimeException ex) {
            log.log(Level.WARNING, "Could not load stats", ex);
            // Non-fatal — page still renders without stats
        }

        // ── Community feed — 10 most recent ───────────────────────────────
        try {
            List<Feedback> feedbacks = dao.getRecent(10);
            req.setAttribute("feedbacks", feedbacks);
        } catch (RuntimeException ex) {
            log.log(Level.WARNING, "Could not load feed", ex);
            req.setAttribute("feedbacks", java.util.Collections.emptyList());
        }

        req.getRequestDispatcher("/WEB-INF/views/customer/feedback.jsp")
                .forward(req, resp);
    }
}