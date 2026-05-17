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

        String email = (String) session.getAttribute("email");

        String currentPassword =
                request.getParameter("currentPassword");

        String newPassword =
                request.getParameter("newPassword");

        String confirmPassword =
                request.getParameter("confirmPassword");

        UserDAO dao = new UserDAO();

        // confirm password mismatch
        if(!newPassword.equals(confirmPassword)) {

            session.setAttribute(
                    "cp_error",
                    "Passwords do not match."
            );

            response.sendRedirect(
                    request.getContextPath() + "/changePassword"
            );

            return;
        }

        // current password wrong
        boolean validCurrent =
                dao.checkCurrentPassword(email, currentPassword);

        if(!validCurrent) {

            session.setAttribute(
                    "cp_error",
                    "Current password is incorrect."
            );

            response.sendRedirect(
                    request.getContextPath() + "/changePassword"
            );

            return;
        }

        // update password
        boolean updated =
                dao.updatePassword(email, newPassword);

        if(updated) {

            session.setAttribute(
                    "cp_success",
                    "Password updated successfully."
            );

        } else {

            session.setAttribute(
                    "cp_error",
                    "Failed to update password."
            );
        }

        response.sendRedirect(
                request.getContextPath() + "/changePassword"
        );
    }
}