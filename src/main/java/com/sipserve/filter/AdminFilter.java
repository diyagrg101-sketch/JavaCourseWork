package com.sipserve.filter;

import java.io.IOException;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.*;

@WebFilter("/admin/*")
public class AdminFilter implements Filter {

    @Override
    public void doFilter(
            ServletRequest request,
            ServletResponse response,
            FilterChain chain
    ) throws IOException, ServletException {

        // Converts request/response into HTTP object
        HttpServletRequest req = (HttpServletRequest) request;
        HttpServletResponse res = (HttpServletResponse) response;
        HttpSession session = req.getSession(false); //Gets the current session

        // If session is null or role is not set user is not logged in
        if(session == null ||
                session.getAttribute("role") == null) {

            res.sendRedirect(
                    req.getContextPath() + "/login"
            );

            return;
        }

        String role = session.getAttribute("role").toString(); //Gets user role from session

        if(!role.equalsIgnoreCase("ADMIN")) { // If role is not admin block access
            res.sendRedirect(
                    req.getContextPath() + "/home"
            );

            return;
        }

        chain.doFilter(request, response); //If role is admin continue
    }
}