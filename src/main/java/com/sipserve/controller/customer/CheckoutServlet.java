package com.sipserve.controller.customer;

import java.io.IOException;
import java.util.ArrayList;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/checkout")
public class CheckoutServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request,
                         HttpServletResponse response)
            throws ServletException, IOException {

        // ── LOGIN CHECK ──
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect(request.getContextPath() + "/login?message=login_required");
            return;
        }

        // ── EMPTY CART CHECK ──
        ArrayList<String[]> cart =
                (ArrayList<String[]>) session.getAttribute("cart");
        if (cart == null || cart.isEmpty()) {
            response.sendRedirect(request.getContextPath() + "/cart");
            return;
        }

        // ── CALCULATE TOTALS ──
        double subtotal = 0;
        int totalItems  = 0;
        for (String[] item : cart) {
            double price = Double.parseDouble(item[1]);
            int qty      = Integer.parseInt(item[3]);
            subtotal    += price * qty;
            totalItems  += qty;
        }

        double vat     = subtotal * 0.13;
        double service = subtotal * 0.10;
        double total   = subtotal + vat + service;

        // ── PASS TO JSP ──
        request.setAttribute("cart",       cart);
        request.setAttribute("totalItems", totalItems);
        request.setAttribute("subtotal",   subtotal);
        request.setAttribute("vat",        vat);
        request.setAttribute("service",    service);
        request.setAttribute("total",      total);

        request.getRequestDispatcher(
                        "/WEB-INF/views/customer/checkout.jsp")
                .forward(request, response);
    }
}