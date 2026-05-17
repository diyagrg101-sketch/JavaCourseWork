package com.sipserve.controller.auth;

import java.io.IOException;

import com.sipserve.dao.UserDAO;
import com.sipserve.model.User;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

@WebServlet("/editProfile")
public class EditProfileServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request,
                         HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        String email = (String) session.getAttribute("email");
        UserDAO dao = new UserDAO();
        User user = dao.getUserByEmail(email);
        request.setAttribute("user", user);
        request.getRequestDispatcher(
                        "/WEB-INF/views/customer/edit-profile.jsp")
                .forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request,
                          HttpServletResponse response)
            throws ServletException, IOException {


        int id = Integer.parseInt(request.getParameter("id"));
        String fullName = request.getParameter("fullName");
        String email = request.getParameter("email");
        String address = request.getParameter("address");
        UserDAO dao = new UserDAO();
        dao.updateUser(id, fullName, email,address);
        HttpSession session = request.getSession();
        session.setAttribute("email", email);
        session.setAttribute("user", fullName);


        response.sendRedirect(
                request.getContextPath() + "/profile"
        );
    }
}