package com.sipserve.controller.auth;

import java.io.IOException;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import jakarta.servlet.RequestDispatcher;

import com.sipserve.dao.UserDAO;

@WebServlet("/login")
public class LoginServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        RequestDispatcher rd =
                request.getRequestDispatcher("/WEB-INF/views/auth/login.jsp");

        rd.forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String email = request.getParameter("email");
        String password = request.getParameter("password");

        UserDAO dao = new UserDAO();

        String role = dao.validateLogin(email, password);

        if (role != null) {

            HttpSession session = request.getSession();

            String fullname = dao.getUserNameByEmail(email);

            // STORE IN SESSION
            session.setAttribute("user", fullname);
            session.setAttribute("email", email);
            session.setAttribute("role", role);

            // ADMIN LOGIN
            if ("ADMIN".equalsIgnoreCase(role)) {

                response.sendRedirect(
                        request.getContextPath() + "/admin/dashboard"
                );

            }
            // CUSTOMER LOGIN
            else {

                response.sendRedirect(
                        request.getContextPath() + "/dashboard"
                );
            }

        } else {

            request.setAttribute(
                    "error",
                    "Invalid email or password"
            );

            request.getRequestDispatcher(
                    "/WEB-INF/views/auth/login.jsp"
            ).forward(request, response);
        }
    }
}