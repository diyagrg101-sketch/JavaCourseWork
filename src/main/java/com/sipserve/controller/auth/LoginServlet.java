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

        // DEBUG (optional)
        System.out.println("Email: " + email);
        System.out.println("Password: " + password);

        // TEMP LOGIN LOGIC
        if ("admin@gmail.com".equals(email) && "1234".equals(password)) {
            response.sendRedirect(request.getContextPath() + "/home");
        } else {
            request.setAttribute("error", "Invalid credentials");
            RequestDispatcher rd = request.getRequestDispatcher("/WEB-INF/views/auth/login.jsp");
            rd.forward(request, response);
        }
    }
}