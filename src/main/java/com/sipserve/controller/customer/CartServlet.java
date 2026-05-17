package com.sipserve.controller.customer;

import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.ArrayList;
import jakarta.servlet.http.HttpSession;

@WebServlet("/cart")
public class CartServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);

        // ── BADGE COUNT ENDPOINT ──
        if ("count".equals(request.getParameter("action"))) {
            int count = 0;
            if (session != null && session.getAttribute("cart") != null) {
                ArrayList<String[]> cartItems =
                        (ArrayList<String[]>) session.getAttribute("cart");
                for (String[] item : cartItems) {
                    count += Integer.parseInt(item[3]); // sum all quantities
                }
            }
            response.setContentType("application/json");
            response.getWriter().write("{\"count\":" + count + "}");
            return;
        }

        // ── LOAD CART PAGE ──
        if (session == null || session.getAttribute("cart") == null) {
            request.setAttribute("cart", new ArrayList<>());
        } else {
            request.setAttribute("cart", session.getAttribute("cart"));
        }
        request.getRequestDispatcher("/WEB-INF/views/customer/cart.jsp")
                .forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // ── LOGIN CHECK ──
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect(request.getContextPath() + "/login?message=login_required");
            return;
        }

        String action = request.getParameter("action");
        String name   = request.getParameter("name");

        ArrayList<String[]> cart =
                (ArrayList<String[]>) session.getAttribute("cart");
        if (cart == null) {
            cart = new ArrayList<>();
        }

        // ── ADD ──
        if (action == null || action.equals("add")) {
            String price = request.getParameter("price");
            String image = request.getParameter("image");

            if (name != null && price != null && image != null
                    && !name.isEmpty() && !price.isEmpty() && !image.isEmpty()) {

                boolean found = false;
                for (String[] item : cart) {
                    if (item[0].equals(name)) {
                        item[3] = String.valueOf(Integer.parseInt(item[3]) + 1);
                        found = true;
                        break;
                    }
                }
                if (!found) {
                    cart.add(new String[]{name, price, image, "1"});
                }
            }

            // ── INCREASE ──
        } else if (action.equals("increase") && name != null) {
            for (String[] item : cart) {
                if (item[0].equals(name)) {
                    item[3] = String.valueOf(Integer.parseInt(item[3]) + 1);
                    break;
                }
            }

            // ── DECREASE ──
        } else if (action.equals("decrease") && name != null) {
            for (int i = 0; i < cart.size(); i++) {
                if (cart.get(i)[0].equals(name)) {
                    int qty = Integer.parseInt(cart.get(i)[3]) - 1;
                    if (qty <= 0) {
                        cart.remove(i);
                    } else {
                        cart.get(i)[3] = String.valueOf(qty);
                    }
                    break;
                }
            }

            // ── DELETE ──
        } else if (action.equals("delete") && name != null) {
            cart.removeIf(item -> item[0].equals(name));
        }

        // ── SAVE & REDIRECT ──
        session.setAttribute("cart", cart);
        response.sendRedirect(request.getContextPath() + "/cart");
    }
}