package com.sipserve.controller.auth;

import java.io.IOException;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import jakarta.servlet.RequestDispatcher;

import com.sipserve.dao.UserDAO;
import com.sipserve.util.ValidationUtil;

@WebServlet("/login")
public class LoginServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Forward request to login.jsp page
        RequestDispatcher rd =
                request.getRequestDispatcher("/WEB-INF/views/auth/login.jsp");

        rd.forward(request, response);
    }

    // Handles login form submission
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        //Gets from data from login page
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String loginType = request.getParameter("loginType");

        //Checks if email or password is empty
        if (ValidationUtil.isEmpty(email) ||
                ValidationUtil.isEmpty(password)) {

            request.setAttribute("error", "Email and password are required");

            request.getRequestDispatcher("/WEB-INF/views/auth/login.jsp")
                    .forward(request, response);
            return;
        }

        // Check email format
        if (!ValidationUtil.isValidEmail(email)) {

            request.setAttribute("error", "Invalid email format");

            request.getRequestDispatcher("/WEB-INF/views/auth/login.jsp")
                    .forward(request, response);
            return;
        }

        //Creates DAO object for database
        UserDAO dao = new UserDAO();

        // Validate login credentials
        String role = dao.validateLogin(email, password, loginType);

        if (role != null) {
            // Create session
            HttpSession session = request.getSession();

            // Get full name from DB
            String fullname = dao.getUserNameByEmail(email);

            // Store session data
            session.setAttribute("user", fullname);
            session.setAttribute("email", email);
            session.setAttribute("role", role);

            // Session valid for 1 day
            session.setMaxInactiveInterval(60 * 60 * 24);

            // Redirect based on role
            if ("ADMIN".equalsIgnoreCase(role)) {
                // This will trigger your AdminFilter if it's mapped to /adminDashboard
                response.sendRedirect(request.getContextPath() + "/adminDashboard");
            } else {
                response.sendRedirect(request.getContextPath() + "/profile");
            }

        } else {
            // Login Failure Logic: Forward back to login with error
            request.setAttribute("error", "Invalid email or password");
            request.getRequestDispatcher("/WEB-INF/views/auth/login.jsp")
                    .forward(request, response);
        }
    }
}
