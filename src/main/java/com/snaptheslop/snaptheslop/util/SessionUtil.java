package com.snaptheslop.snaptheslop.util;

import com.snaptheslop.snaptheslop.user.model.UserDTO;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;

/**
 * Helpers for reading the logged-in user from the HTTP session.
 * Sprint 5: Ensures citizens only access their own private issue actions.
 */
public class SessionUtil {

    private static final String SESSION_KEY = "loggedInUser";

    /** Returns the logged-in UserDTO, or null if not authenticated. */
    public static UserDTO getLoggedInUser(HttpServletRequest request) {
        HttpSession session = request.getSession(false);
        if (session == null) return null;
        Object user = session.getAttribute(SESSION_KEY);
        return (user instanceof UserDTO) ? (UserDTO) user : null;
    }

    /** Returns the DB numeric id (users.id) for the logged-in user via a JOIN-safe lookup.
     *  Note: UserDTO.userId is a String (e.g. "USR-001"); the issues table uses the
     *  integer users.id as a foreign key, so we store the int separately in session
     *  or obtain it via UserDAO.  This helper returns -1 if not set. */
    public static int getLoggedInUserDbId(HttpServletRequest request) {
        HttpSession session = request.getSession(false);
        if (session == null) return -1;
        Object id = session.getAttribute("loggedInUserDbId");
        return (id instanceof Integer) ? (Integer) id : -1;
    }

    /** Store the numeric DB id alongside the UserDTO in session after login. */
    public static void setLoggedInUserDbId(HttpServletRequest request, int dbId) {
        request.getSession(true).setAttribute("loggedInUserDbId", dbId);
    }

    /** Returns true if the session has an authenticated user. */
    public static boolean isLoggedIn(HttpServletRequest request) {
        return getLoggedInUser(request) != null;
    }

    /** Convenience: role check. Normalises the stored role string. */
    public static boolean isCitizen(HttpServletRequest request) {
        UserDTO user = getLoggedInUser(request);
        if (user == null || user.getRole() == null) return false;
        String r = user.getRole().trim().toUpperCase();
        return r.contains("CITIZEN");
    }

    public static boolean isMunicipalHead(HttpServletRequest request) {
        UserDTO user = getLoggedInUser(request);
        if (user == null || user.getRole() == null) return false;
        String r = user.getRole().trim().toUpperCase();
        return r.contains("MUNICIPAL");
    }
}
