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

        int totalUsers = dao.getTotalUsers();
        int totalCustomers = dao.getTotalCustomers();
        int totalAdmins = dao.getTotalAdmins();

        request.setAttribute("totalUsers", totalUsers);
        request.setAttribute("totalCustomers", totalCustomers);
        request.setAttribute("totalAdmins", totalAdmins);

        request.setAttribute("users", users);

        request.getRequestDispatcher(
                        "/WEB-INF/views/admin/manage-users.jsp")
                .forward(request, response);


    }
}