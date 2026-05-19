package com.sipserve.controller.auth;

import java.io.IOException;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import jakarta.servlet.RequestDispatcher;

import com.sipserve.dao.UserDAO;
import com.sipserve.util.ValidationUtil;

@WebServlet("/register")
public class RegisterServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Show registration page
        RequestDispatcher rd = request.getRequestDispatcher("/WEB-INF/views/auth/register.jsp");
        rd.forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        //Gets form data
        String fullname = request.getParameter("fullname");
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String confirmPassword = request.getParameter("confirmPassword");

        // Input validation
        if (ValidationUtil.isEmpty(fullname) ||
                ValidationUtil.isEmpty(email) ||
                ValidationUtil.isEmpty(password) ||
                ValidationUtil.isEmpty(confirmPassword)) {

            request.setAttribute("errorMessage", "All fields are required!");

            request.getRequestDispatcher("/WEB-INF/views/auth/register.jsp")
                    .forward(request, response);
            return;
        }

        // Check email format
        if (!ValidationUtil.isValidEmail(email)) {

            request.setAttribute("errorMessage", "Invalid email format!");

            request.getRequestDispatcher("/WEB-INF/views/auth/register.jsp")
                    .forward(request, response);
            return;
        }

        // Check password strength
        if (!ValidationUtil.isValidPassword(password)) {

            request.setAttribute("errorMessage", "Password must be at least 8 characters!");

            request.getRequestDispatcher("/WEB-INF/views/auth/register.jsp")
                    .forward(request, response);
            return;
        }

        // Check password match
        if (!password.equals(confirmPassword)) {

            request.setAttribute("errorMessage", "Passwords do not match!");

            request.getRequestDispatcher("/WEB-INF/views/auth/register.jsp")
                    .forward(request, response);

            return;
        }

        //Saves user to database
        UserDAO dao = new UserDAO();
        boolean success = dao.registerUser(fullname, email, password);

        if (success) {

            // Create session after successful registration
            HttpSession session = request.getSession();

            // Store user data in session
            session.setAttribute("user", fullname);
            session.setAttribute("email", email);

            // Store first letter for profile avatar
            session.setAttribute("initial", fullname.substring(0, 1).toUpperCase());

            // Redirect to profile page
            response.sendRedirect(request.getContextPath() + "/profile");

        } else {

            request.setAttribute("errorMessage", "Registration failed! Try again.");

            request.getRequestDispatcher("/WEB-INF/views/auth/register.jsp").forward(request, response);
        }
    }
}