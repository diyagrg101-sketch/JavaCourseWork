package com.sipserve.controller.admin;


import com.sipserve.dao.ReportDAO;
import com.sipserve.model.*;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.util.List;

@WebServlet("/report")
public class ReportServlet extends HttpServlet {

    private final ReportDAO reportDAO = new ReportDAO();

    @Override
    protected void doGet(HttpServletRequest request,
                         HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);

        if (session == null ||
                session.getAttribute("role") == null ||
                !session.getAttribute("role")
                        .toString()
                        .equals("ADMIN")) {

            response.sendRedirect(
                    request.getContextPath() + "/login"
            );
            return;
        }

        ReportStats stats = reportDAO.getDashboardStats();

        List<TopProduct> topProducts =
                reportDAO.getTopProducts();

        List<DailyRevenue> revenues =
                reportDAO.getDailyRevenue();

        List<PaymentStat> paymentStats =
                reportDAO.getPaymentStats();

        request.setAttribute("stats", stats);
        request.setAttribute("topProducts", topProducts);
        request.setAttribute("revenues", revenues);
        request.setAttribute("paymentStats", paymentStats);

        request.getRequestDispatcher(
                "/WEB-INF/views/admin/reports.jsp"
        ).forward(request, response);
    }
}