package com.sipserve.controller.auth;

import java.io.IOException;

import com.sipserve.dao.UserDAO;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

@WebServlet("/changePassword")
public class ChangePasswordServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request,
                         HttpServletResponse response)
            throws ServletException, IOException {

        request.getRequestDispatcher(
                "/WEB-INF/views/customer/change-password.jsp"
        ).forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request,
                          HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();

        String email =
                (String) session.getAttribute("email");

        String currentPassword =
                request.getParameter("currentPassword");

        String newPassword =
                request.getParameter("newPassword");

        String confirmPassword =
                request.getParameter("confirmPassword");

        // confirm check
        if(!newPassword.equals(confirmPassword)) {

            request.setAttribute(
                    "error",
                    "Passwords do not match"
            );

            request.getRequestDispatcher(
                    "/WEB-INF/views/customer/change-password.jsp"
            ).forward(request, response);

            return;
        }

        UserDAO dao = new UserDAO();

        // old password verify
        boolean valid =
                dao.checkOldPassword(email, currentPassword);

        if(!valid) {

            request.setAttribute(
                    "error",
                    "Current password incorrect"
            );

            request.getRequestDispatcher(
                    "/WEB-INF/views/customer/change-password.jsp"
            ).forward(request, response);

            return;
        }

        // update password
        dao.updatePassword(email, newPassword);

        response.sendRedirect(
                request.getContextPath() + "/profile"
        );
    }
}