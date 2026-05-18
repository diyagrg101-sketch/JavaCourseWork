package com.sipserve.controller.auth;

import java.io.IOException;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/logout")
public class LogoutServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request,
                         HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");

        // ACTUAL LOGOUT
        if ("confirm".equals(action)) {

            HttpSession session = request.getSession(false);

            if (session != null) {
                session.invalidate();
            }

            response.sendRedirect(
                    request.getContextPath() + "/home");

            return;
        }

        // SHOW LOGOUT PAGE
        request.getRequestDispatcher(
                        "/WEB-INF/views/auth/logout.jsp")
                .forward(request, response);
    }
}