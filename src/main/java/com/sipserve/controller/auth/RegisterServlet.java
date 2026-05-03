package com.sipserve.controller.auth;

import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import jakarta.servlet.RequestDispatcher;

import com.sipserve.dao.UserDAO;

@WebServlet("/register")
public class RegisterServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        RequestDispatcher rd = request.getRequestDispatcher("/WEB-INF/views/auth/register.jsp");
        rd.forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Get form data
        String fullname = request.getParameter("fullname");
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String confirmPassword = request.getParameter("confirmPassword");

        // Validation
        if (fullname == null || email == null || password == null || confirmPassword == null ||
                fullname.trim().isEmpty() || email.trim().isEmpty() ||
                password.trim().isEmpty() || confirmPassword.trim().isEmpty()) {

            request.setAttribute("errorMessage", "All fields are required!");
            request.getRequestDispatcher("/WEB-INF/views/auth/register.jsp").forward(request, response);
            return;
        }

        if (!password.equals(confirmPassword)) {

            request.setAttribute("errorMessage", "Passwords do not match!");
            request.getRequestDispatcher("/WEB-INF/views/auth/register.jsp").forward(request, response);
            return;
        }

        // SAVE TO DATABASE
        UserDAO dao = new UserDAO();
        boolean success = dao.registerUser(fullname, email, password);

        if (success) {

            response.sendRedirect(request.getContextPath() + "/home");
        } else {
            request.setAttribute("errorMessage", "Registration failed! Try again.");
            request.getRequestDispatcher("/WEB-INF/views/auth/register.jsp").forward(request, response);
        }
    }
}