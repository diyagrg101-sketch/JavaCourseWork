package com.sipserve.controller.auth;

import java.io.IOException;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import com.sipserve.util.SessionUtil;

@WebServlet("/logout")
public class LogoutServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request,
                         HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");

        //If user clicks confirm logout session will be destroyed
        if ("confirm".equals(action)) {

            // Use SessionUtil to destroy session
            SessionUtil.logout(request);

            // Redirect user to home page after logout
            response.sendRedirect(request.getContextPath() + "/home");
            return;
        }

        request.getRequestDispatcher(
                "/WEB-INF/views/auth/logout.jsp"
        ).forward(request, response);
    }
}