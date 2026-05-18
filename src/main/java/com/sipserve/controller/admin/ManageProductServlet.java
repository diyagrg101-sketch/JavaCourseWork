package com.sipserve.controller.admin;

import com.sipserve.dao.ProductDAO;
import com.sipserve.model.Product;

import java.io.IOException;
import java.util.List;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/manageProduct")
public class ManageProductServlet extends HttpServlet {

    // ProductDAO instance — replaces the undefined productService
    private final ProductDAO productDAO = new ProductDAO();

    @Override
    protected void doGet(HttpServletRequest request,
                         HttpServletResponse response)
            throws ServletException, IOException {

        // Set attributes BEFORE forwarding
        request.setAttribute("totalProducts", productDAO.countAll());
        request.setAttribute("activeCount",   productDAO.countActive());
        request.setAttribute("outOfStock",    productDAO.countOutOfStock());
        request.setAttribute("hiddenCount",   productDAO.countHidden());

        String search = request.getParameter("search");

        List<Product> products;

        if (search != null && !search.trim().isEmpty()) {
            products = productDAO.searchProducts(search);
        } else {
            products = productDAO.findAll();
        }
        request.setAttribute("products", products);

        // Forward LAST — only once
        request.getRequestDispatcher("/WEB-INF/views/admin/manage-products.jsp")
                .forward(request, response);
    }
}