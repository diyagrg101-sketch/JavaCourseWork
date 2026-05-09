package com.sipserve.controller.customer;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet("/dashboard")
public class UserDashboardServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        // (Optional) You can pass dynamic data here later
        // Example:
        // req.setAttribute("username", "Arjun K.");

        // Forward to JSP
        req.getRequestDispatcher("/WEB-INF/views/customer/user-dashboard.jsp")
                .forward(req, resp);
    }
}