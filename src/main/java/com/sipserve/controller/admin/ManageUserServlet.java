package com.sipserve.controller.admin;

import java.io.IOException;
import java.util.List;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import com.sipserve.dao.UserDAO;
import com.sipserve.model.User;

@WebServlet("/manageUser")
public class ManageUserServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request,
                         HttpServletResponse response)
            throws ServletException, IOException {

        UserDAO dao = new UserDAO();

        List<User> users = dao.getAllUsers();

        request.setAttribute("users", users);

        request.setAttribute("totalUsers", dao.getTotalUsers());
        request.setAttribute("totalCustomers", dao.getTotalCustomers());
        request.setAttribute("totalAdmins", dao.getTotalAdmins());

        request.getRequestDispatcher(
                "/WEB-INF/views/admin/manage-users.jsp"
        ).forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request,
                          HttpServletResponse response)
            throws ServletException, IOException {

        UserDAO dao = new UserDAO();

        String action = request.getParameter("action");

        // ========================
        // DELETE USER
        // ========================
        if ("delete".equals(action)) {

            int id = Integer.parseInt(request.getParameter("id"));

            dao.deleteUser(id);

            response.sendRedirect(request.getContextPath() + "/manageUser");
        }
    }
}