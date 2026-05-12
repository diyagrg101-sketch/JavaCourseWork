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
        // Get existing session without creating a new one
        HttpSession session = request.getSession(false);

        // Check if session exists and cart is available
        if (session == null || session.getAttribute("cart") == null) {

            // If no cart exists, send an empty list to JSP
            request.setAttribute("cart", new ArrayList<>());
        } else {
            // If cart exists in session, pass it to JSP
            request.setAttribute("cart", session.getAttribute("cart"));
        }
        // Forward request to cart.jsp page for display
        request.getRequestDispatcher("/WEB-INF/views/customer/cart.jsp")
                .forward(request, response);
    }
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // ================= LOGIN CHECK =================
        HttpSession session = request.getSession(false);

        // if session is null OR user not logged in
        if (session == null || session.getAttribute("user") == null) {

            // redirect to login page with message
            response.sendRedirect(request.getContextPath() + "/login?message=login_required");
            return;
        }

        // ================= GET FORM DATA =================
        String name = request.getParameter("name");
        String price = request.getParameter("price");
        String image = request.getParameter("image");

        // get existing session (safe because user is logged in)
        HttpSession userSession = request.getSession();

        // get cart
        ArrayList<String[]> cart =
                (ArrayList<String[]>) userSession.getAttribute("cart");

        if (cart == null) {
            cart = new ArrayList<>();
        }

        //Add item to cart
        if (name != null && price != null && image != null
                && !name.isEmpty()
                && !price.isEmpty()
                && !image.isEmpty()) {
            // Item format: {name, price, image, quantity}
            String[] item = {
                    name,
                    price,
                    image,
                    "1" // default quantity
            };

            // add item to cart
            cart.add(item);
        }

        // save back to session
        userSession.setAttribute("cart", cart);

        // redirect to cart page
        response.sendRedirect(request.getContextPath() + "/cart");
    }
}