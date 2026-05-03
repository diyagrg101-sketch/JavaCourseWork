package com.sipserve.controller.auth;

import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import jakarta.servlet.RequestDispatcher;

@WebServlet("/login")
public class LoginServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        RequestDispatcher rd = request.getRequestDispatcher("/WEB-INF/views/auth/login.jsp");
        rd.forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String role = request.getParameter("role"); // 👈 IMPORTANT (from JSP)

        System.out.println("Email: " + email);
        System.out.println("Role: " + role);

        HttpSession session = request.getSession();

        // =========================
        // TEMP LOGIN LOGIC
        // =========================

        if ("admin".equals(role)) {

            if ("admin@gmail.com".equals(email) && "1234".equals(password)) {
                session.setAttribute("user", email);
                session.setAttribute("role", "admin");

                response.sendRedirect(request.getContextPath() + "/admin/dashboard");
            } else {
                request.setAttribute("error", "Invalid admin credentials");
                forwardToLogin(request, response);
            }

        } else {

            if ("user@gmail.com".equals(email) && "1234".equals(password)) {
                session.setAttribute("user", email);
                session.setAttribute("role", "member");

                response.sendRedirect(request.getContextPath() + "/home");
            } else {
                request.setAttribute("error", "Invalid member credentials");
                forwardToLogin(request, response);
            }
        }
    }

    private void forwardToLogin(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        RequestDispatcher rd = request.getRequestDispatcher("/WEB-INF/views/auth/login.jsp");
        rd.forward(request, response);
    }
}