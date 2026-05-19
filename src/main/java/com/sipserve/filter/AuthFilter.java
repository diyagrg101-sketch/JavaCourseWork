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

        //Convert request/response to HTTP object
        HttpServletRequest req = (HttpServletRequest) request;
        HttpServletResponse res = (HttpServletResponse) response;

        //Gets requested URL
        String uri = req.getRequestURI();
        String contextPath = req.getContextPath();

        //Gets existing session does not create new one
        HttpSession session = req.getSession(false);

        //Checks if user is logged in
        boolean loggedIn = (session != null && session.getAttribute("user") != null);

        //Redirect root URL to home page
        if (uri.equals(contextPath) || uri.equals(contextPath + "/")) {
            res.sendRedirect(contextPath + "/home");
            return;
        }

        //Check if requested page is public
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

        if (publicPage) { //Allows access to public pages without authentication
            chain.doFilter(request, response);
            return;
        }


        if (!loggedIn) { //Redirect to login if user is not logged in
            res.sendRedirect(contextPath + "/login");
            return;
        }

        //Get user role from session
        String role = (session != null) ? (String) session.getAttribute("role") : null;

        //Restrict admin pages to only ADMIN role
        if (uri.contains("/admin")) {
            if (!"ADMIN".equalsIgnoreCase(role)) {
                res.sendRedirect(contextPath + "/home");
                return;
            }
        }
        //Allows request to continue if all checks pass
        chain.doFilter(request, response);
    }
}