package com.sipserve.controller.customer;

import java.io.IOException;

import com.sipserve.dao.UserDAO;
import com.sipserve.model.User;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

@WebServlet("/profile")
public class ProfileServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request,
                         HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();

        String email =
                (String) session.getAttribute("email");

        UserDAO dao = new UserDAO();

        User user = dao.getUserByEmail(email);

        request.setAttribute("user", user);

        request.getRequestDispatcher(
                "/WEB-INF/views/customer/profile.jsp"
        ).forward(request, response);
    }
}