package com.sipserve.filter;

import java.io.IOException;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.*;

@WebFilter("/*")
public class AuthFilter implements Filter {

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {

        HttpServletRequest req = (HttpServletRequest) request;
        HttpServletResponse res = (HttpServletResponse) response;

        String uri = req.getRequestURI();
        String contextPath = req.getContextPath();

        HttpSession session = req.getSession(false);

        boolean loggedIn = (session != null && session.getAttribute("user") != null);

        if (uri.equals(contextPath) || uri.equals(contextPath + "/")) {
            res.sendRedirect(contextPath + "/home");
            return;
        }


        boolean publicPage =
                uri.contains("/login") ||
                        uri.contains("/register") ||
                        uri.contains("/forgetPassword") ||
                        uri.contains("/home") ||
                        uri.contains("/menu") ||
                        uri.contains("/about") ||
                        uri.contains("/contact") ||
                        uri.contains("/logout") ||
                        uri.contains("/assets/") ||
                        uri.endsWith(".css") ||
                        uri.endsWith(".js") ||
                        uri.endsWith(".png") ||
                        uri.endsWith(".jpg") ||
                        uri.endsWith(".jpeg") ||
                        uri.endsWith(".svg");

        if (publicPage) {
            chain.doFilter(request, response);
            return;
        }


        if (!loggedIn) {
            res.sendRedirect(contextPath + "/login");
            return;
        }


        String role = (session != null) ? (String) session.getAttribute("role") : null;


        if (uri.contains("/admin")) {
            if (!"ADMIN".equalsIgnoreCase(role)) {
                res.sendRedirect(contextPath + "/home");
                return;
            }
        }

        chain.doFilter(request, response);
    }
}