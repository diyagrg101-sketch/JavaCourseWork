package com.sipserve.controller.customer;

import com.sipserve.dao.ProductDAO;
import com.sipserve.model.Product;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.Optional;

@WebServlet("/product-details")
public class ProductDetailServlet extends HttpServlet {

    private final ProductDAO productDAO = new ProductDAO();

    @Override
    protected void doGet(HttpServletRequest request,
                         HttpServletResponse response)
            throws ServletException, IOException {

        // 1. Read and validate ?id=
        String idParam = request.getParameter("id");
        if (idParam == null || idParam.isBlank()) {
            response.sendRedirect(request.getContextPath() + "/dashboard");
            return;
        }

        int productId;
        try {
            productId = Integer.parseInt(idParam.trim());
        } catch (NumberFormatException e) {
            response.sendRedirect(request.getContextPath() + "/dashboard");
            return;
        }

        // 2. Fetch from DB using your existing findById
        Optional<Product> result = productDAO.findById(productId);
        if (result.isEmpty()) {
            response.sendRedirect(request.getContextPath() + "/dashboard");
            return;
        }

        Product product = result.get();

        // 3. Resolve category series label for display
        String categoryLabel = switch (product.getCategoryId()) {
            case 1 -> "☕ PREMIUM COFFEE SERIES";
            case 2 -> "🎂 BAKERY & DESSERTS";
            case 3 -> "🥪 SNACKS & BITES";
            case 4 -> "🍵 TEA & BEVERAGES";
            default -> "🍽️ MENU";
        };

        // 4. Set attributes and forward to JSP
        request.setAttribute("product", product);
        request.setAttribute("categoryLabel", categoryLabel);
        request.getRequestDispatcher(
                "/WEB-INF/views/customer/product-details.jsp"
        ).forward(request, response);
    }
}