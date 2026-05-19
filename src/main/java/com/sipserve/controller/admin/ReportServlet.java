package com.sipserve.controller.admin;

import java.io.IOException;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

import com.sipserve.dao.FeedbackDAO;
import com.sipserve.model.Feedback;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/report")
public class ReportServlet extends HttpServlet {

    private static final Logger log = Logger.getLogger(ReportServlet.class.getName());

    private final FeedbackDAO feedbackDAO = new FeedbackDAO();

    // ── GET ───────────────────────────────────────────────────────────────────
    @Override
    protected void doGet(HttpServletRequest request,
                         HttpServletResponse response)
            throws ServletException, IOException {

        // ── 1. Admin role guard ────────────────────────────────────────────
        HttpSession session = request.getSession(false);
        if (!isAdmin(session)) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        // ── 2. Ensure a CSRF token exists in session for the delete forms ──
        if (session.getAttribute("csrfToken") == null) {
            session.setAttribute("csrfToken", java.util.UUID.randomUUID().toString());
        }
        request.setAttribute("csrfToken", session.getAttribute("csrfToken"));

        // ── 3. Feedback data — single stats round-trip ─────────────────────
        try {
            List<Feedback> allFeedbacks = feedbackDAO.getAll();
            double[]       stats        = feedbackDAO.getStats();
            int            totalReviews = (int) stats[0];
            double         avgRating    = stats[1];

            request.setAttribute("allFeedbacks", allFeedbacks);
            request.setAttribute("totalReviews", totalReviews > 0 ? totalReviews : null);
            request.setAttribute("avgRating",    avgRating   > 0 ? String.format("%.1f", avgRating) : null);
        } catch (RuntimeException e) {
            log.log(Level.SEVERE, "Failed to load feedback data", e);
            request.setAttribute("allFeedbacks", java.util.Collections.emptyList());
        }

        // ── 4. Consume flash from redirect ─────────────────────────────────
        Object flash = session.getAttribute("reportFlash");
        if (flash != null) {
            request.setAttribute("successMsg", flash.toString());
            session.removeAttribute("reportFlash");
        }

        // ── 5. Forward ─────────────────────────────────────────────────────
        request.getRequestDispatcher("/WEB-INF/views/admin/reports.jsp")
                .forward(request, response);
    }

    // ── POST ──────────────────────────────────────────────────────────────────
    @Override
    protected void doPost(HttpServletRequest request,
                          HttpServletResponse response)
            throws ServletException, IOException {

        // ── 1. Admin role guard ────────────────────────────────────────────
        HttpSession session = request.getSession(false);
        if (!isAdmin(session)) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        // ── 2. CSRF validation ─────────────────────────────────────────────
        String sessionToken = (String) session.getAttribute("csrfToken");
        String formToken    = request.getParameter("csrfToken");
        if (sessionToken == null || !sessionToken.equals(formToken)) {
            log.log(Level.WARNING, "CSRF token mismatch on /report POST — possible CSRF attack");
            response.sendError(HttpServletResponse.SC_FORBIDDEN, "Invalid CSRF token");
            return;
        }

        // ── 3. Handle action ───────────────────────────────────────────────
        String action = request.getParameter("action");
        if ("deleteFeedback".equals(action)) {
            try {
                int     id = Integer.parseInt(request.getParameter("feedbackId"));
                boolean ok = feedbackDAO.deleteById(id);

                if (ok) {
                    log.log(Level.INFO, "Admin deleted feedback id={0}", id);
                    session.setAttribute("reportFlash", "Review #" + id + " deleted.");
                } else {
                    session.setAttribute("reportFlash", "Delete failed — review not found.");
                }
            } catch (NumberFormatException e) {
                log.log(Level.WARNING, "Invalid feedbackId parameter in delete request");
                session.setAttribute("reportFlash", "Invalid review ID.");
            } catch (RuntimeException e) {
                log.log(Level.SEVERE, "Error deleting feedback", e);
                session.setAttribute("reportFlash", "A server error occurred. Please try again.");
            }
        }

        // PRG — always redirect after POST
        response.sendRedirect(request.getContextPath() + "/report");
    }

    // ── Helper ─────────────────────────────────────────────────────────────────
    private boolean isAdmin(HttpSession session) {
        if (session == null) return false;
        return "ADMIN".equalsIgnoreCase(String.valueOf(session.getAttribute("role")));
    }
}