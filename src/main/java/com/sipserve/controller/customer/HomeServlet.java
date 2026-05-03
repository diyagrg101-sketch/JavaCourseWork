package com.sipserve.controller.customer;

import com.sipserve.dao.ProductDAO;
import com.sipserve.model.Product;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.Collections;
import java.util.List;

@WebServlet(name = "HomeServlet", urlPatterns = { "/home" })
public class HomeServlet extends HttpServlet {

    private final ProductDAO productDAO = new ProductDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        List<Product> signatures;
        try {
            signatures = productDAO.findSignatures();
        } catch (RuntimeException ex) {
            getServletContext().log("Failed to load signature products", ex);
            signatures = Collections.emptyList();
            req.setAttribute("dbError",
                "Unable to load menu right now. Please try again shortly.");
        }

        req.setAttribute("signatureProducts", signatures);
        req.getRequestDispatcher("/WEB-INF/views/customer/home.jsp")
           .forward(req, resp);
    }
}
