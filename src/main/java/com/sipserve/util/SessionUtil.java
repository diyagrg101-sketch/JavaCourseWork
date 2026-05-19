package com.sipserve.util;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;

public class SessionUtil {

    // Gets current session
    public static HttpSession getSession(HttpServletRequest request) {
        return request.getSession(false);
    }

    // Gets logged-in user email
    public static String getUserEmail(HttpServletRequest request
    ) {
        HttpSession session = getSession(request);
        if(session != null) {
            return (String)
                    session.getAttribute("email");
        }
        return null;
    }

    // Logout User
    public static void logout(HttpServletRequest request
    ) {
        HttpSession session = request.getSession(false);
        if(session != null) {
            session.invalidate();
        }
    }
}