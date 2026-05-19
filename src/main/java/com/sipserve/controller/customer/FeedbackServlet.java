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
 * GET  /feedback        → show feedback form (loads product dropdown + stats)
 * POST /feedback/submit → validate, save to DB, redirect (PRG)
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

        // ── 1. Auth guard ──────────────────────────────────────────────────
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
        String ratingStr    = req.getParameter("rating");
        String productIdStr = req.getParameter("productId");
        String review       = req.getParameter("message");  // textarea name="message"

        int rating    = 0;
        int productId = 0;
        try { rating    = Integer.parseInt(ratingStr);    } catch (NumberFormatException ignored) {}
        try { productId = Integer.parseInt(productIdStr); } catch (NumberFormatException ignored) {}

        // ── 4. Validation ──────────────────────────────────────────────────
        if (rating < 1 || rating > 5) {
            req.setAttribute("errorMsg", "Please select a valid star rating (1–5).");
            loadPage(req, resp);
            return;
        }
        if (productId <= 0) {
            req.setAttribute("errorMsg", "Please select a product to review.");
            loadPage(req, resp);
            return;
        }
        if (review == null || review.trim().length() < 5) {
            req.setAttribute("errorMsg", "Review must be at least 5 characters.");
            loadPage(req, resp);
            return;
        }
        if (review.length() > 1000) {
            review = review.substring(0, 1000);
        }

        // ── 5. Resolve user_id from session email ──────────────────────────
        //      LoginServlet stores: session.setAttribute("email", email)
        String email  = session.getAttribute("email") != null
                ? session.getAttribute("email").toString() : "";
        String userName = session.getAttribute("user").toString();

        int userId = dao.getUserIdByEmail(email);
        if (userId <= 0) {
            req.setAttribute("errorMsg", "Could not identify your account. Please log in again.");
            loadPage(req, resp);
            return;
        }

        // ── 6. Persist ─────────────────────────────────────────────────────
        try {
            Feedback fb = new Feedback(userId, productId, rating, review.trim());
            int newId = dao.insert(fb);

            if (newId > 0) {
                // Rotate CSRF token after successful submit
                session.setAttribute("csrfToken", UUID.randomUUID().toString());
                session.setAttribute("flashSuccess",
                        "Thank you for your review, " + userName + "! ☕");
                resp.sendRedirect(req.getContextPath() + "/feedback");
            } else {
                req.setAttribute("errorMsg", "Something went wrong. Please try again.");
                loadPage(req, resp);
            }

        } catch (RuntimeException ex) {
            // Duplicate review for same user + product
            if ("DUPLICATE".equals(ex.getMessage())) {
                req.setAttribute("errorMsg",
                        "You have already reviewed this product. Thank you!");
            } else {
                log.log(Level.SEVERE, "Failed to save feedback", ex);
                req.setAttribute("errorMsg", "A server error occurred. Please try again later.");
            }
            loadPage(req, resp);
        }
    }

    // ── Page loader ───────────────────────────────────────────────────────────
    private void loadPage(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        // CSRF token
        HttpSession session = req.getSession(true);
        if (session.getAttribute("csrfToken") == null) {
            session.setAttribute("csrfToken", UUID.randomUUID().toString());
        }
        req.setAttribute("csrfToken", session.getAttribute("csrfToken"));

        // Flash message from redirect
        String flash = (String) session.getAttribute("flashSuccess");
        if (flash != null) {
            req.setAttribute("successMsg", flash);
            session.removeAttribute("flashSuccess");
        }

        // Stats
        try {
            double[] stats = dao.getStats();
            int    total = (int) stats[0];
            double avg   = stats[1];
            req.setAttribute("avgRating",    avg   > 0 ? String.format("%.1f", avg) : null);
            req.setAttribute("totalReviews", total > 0 ? total : null);
        } catch (RuntimeException ex) {
            log.log(Level.WARNING, "Could not load stats", ex);
        }

        // Product dropdown list
        try {
            List<Object[]> products = dao.getAllProducts();
            req.setAttribute("products", products);
        } catch (RuntimeException ex) {
            log.log(Level.WARNING, "Could not load products", ex);
            req.setAttribute("products", java.util.Collections.emptyList());
        }

        // Community feed — 10 most recent
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
