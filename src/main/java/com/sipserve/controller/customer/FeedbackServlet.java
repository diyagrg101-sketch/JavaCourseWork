package com.sipserve.controller.customer;

import com.sipserve.dao.FeedbackDAO;
import com.sipserve.model.Feedback;
import com.sipserve.model.User;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.util.List;
import java.util.UUID;
import java.util.logging.Level;
import java.util.logging.Logger;

@WebServlet(urlPatterns = {"/feedback", "/feedback/submit"})
public class FeedbackServlet extends HttpServlet {

    private static final Logger log = Logger.getLogger(FeedbackServlet.class.getName());
    private final FeedbackDAO dao = new FeedbackDAO();

    // ───────────────────────── GET ─────────────────────────
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        loadPage(req, resp);
    }

    // ───────────────────────── POST ────────────────────────
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        req.setCharacterEncoding("UTF-8");

        HttpSession session = req.getSession(false);

        // ✔ LOGIN CHECK
        if (session == null || session.getAttribute("user") == null) {
            resp.sendRedirect(req.getContextPath() + "/login");
            return;
        }

        User user = (User) session.getAttribute("user");

        // ✔ CSRF CHECK
        String sessionToken = (String) session.getAttribute("csrfToken");
        String formToken = req.getParameter("csrfToken");

        if (sessionToken == null || !sessionToken.equals(formToken)) {
            resp.sendError(HttpServletResponse.SC_FORBIDDEN, "Invalid CSRF token");
            return;
        }

        // ── INPUTS ─────────────────────────────
        String ratingStr = req.getParameter("rating");
        String review = req.getParameter("review"); // FIXED NAME
        String productIdStr = req.getParameter("productId");

        int rating = 0;
        int productId = 0;

        try {
            rating = Integer.parseInt(ratingStr);
            productId = Integer.parseInt(productIdStr);
        } catch (NumberFormatException e) {
            req.setAttribute("errorMsg", "Invalid input data.");
            loadPage(req, resp);
            return;
        }

        // ── VALIDATION ─────────────────────────
        if (rating < 1 || rating > 5) {
            req.setAttribute("errorMsg", "Please select rating 1–5 stars.");
            loadPage(req, resp);
            return;
        }

        if (review == null || review.trim().length() < 5) {
            req.setAttribute("errorMsg", "Review must be at least 5 characters.");
            loadPage(req, resp);
            return;
        }

        if (review.length() > 500) {
            review = review.substring(0, 500);
        }

        // ── SAVE FEEDBACK ──────────────────────
        try {
            Feedback fb = new Feedback();
            fb.setUserId(user.getId());
            fb.setProductId(productId);
            fb.setRating(rating);
            fb.setReview(review.trim()); // FIXED

            int newId = dao.insert(fb);

            if (newId > 0) {

                session.setAttribute("csrfToken", UUID.randomUUID().toString());
                session.setAttribute("flashSuccess", "Thank you for your review!");

                resp.sendRedirect(req.getContextPath() + "/feedback");
            } else {
                req.setAttribute("errorMsg", "Failed to submit feedback.");
                loadPage(req, resp);
            }

        } catch (Exception ex) {
            log.log(Level.SEVERE, "Error saving feedback", ex);
            req.setAttribute("errorMsg", "Server error occurred.");
            loadPage(req, resp);
        }
    }

    // ───────────────────────── PAGE LOADER ─────────────────────────
    private void loadPage(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        HttpSession session = req.getSession(true);

        // CSRF
        if (session.getAttribute("csrfToken") == null) {
            session.setAttribute("csrfToken", UUID.randomUUID().toString());
        }
        req.setAttribute("csrfToken", session.getAttribute("csrfToken"));

        // Flash
        String flash = (String) session.getAttribute("flashSuccess");
        if (flash != null) {
            req.setAttribute("successMsg", flash);
            session.removeAttribute("flashSuccess");
        }

        // Stats
        try {
            double[] stats = dao.getStats();
            int total = (int) stats[0];
            double avg = stats[1];

            req.setAttribute("avgRating",
                    avg > 0 ? String.format("%.1f", avg) : null);

            req.setAttribute("totalReviews",
                    total > 0 ? total : 0);

        } catch (Exception ex) {
            log.log(Level.WARNING, "Stats load failed", ex);
        }

        // Recent feedback
        try {
            List<Feedback> feedbacks = dao.getRecent(10);
            req.setAttribute("feedbacks", feedbacks);
        } catch (Exception ex) {
            log.log(Level.WARNING, "Feedback load failed", ex);
            req.setAttribute("feedbacks", java.util.Collections.emptyList());
        }

        req.getRequestDispatcher("/WEB-INF/views/customer/feedback.jsp")
                .forward(req, resp);
    }
}