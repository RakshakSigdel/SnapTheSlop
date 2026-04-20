package com.snaptheslop.snaptheslop.security;

import java.io.IOException;
import java.util.HashMap;
import java.util.Map;
import java.util.Set;

import com.snaptheslop.snaptheslop.user.model.UserDTO;

import jakarta.servlet.Filter;
import jakarta.servlet.FilterChain;
import jakarta.servlet.FilterConfig;
import jakarta.servlet.ServletException;
import jakarta.servlet.ServletRequest;
import jakarta.servlet.ServletResponse;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebFilter("/*")
public class AuthFilter implements Filter {

    private static final String SESSION_LOGGED_IN_USER = "loggedInUser";
    private static final String ROLE_ADMIN = "ADMIN";
    private static final String ROLE_CITIZEN = "CITIZEN";
    private static final String ROLE_MUNICIPAL_HEAD = "MUNICIPAL_HEAD";

    private final Map<String, Set<String>> roleRoutePrefixes = new HashMap<>();

    @Override
    public void init(FilterConfig filterConfig) {
        roleRoutePrefixes.put(ROLE_ADMIN, Set.of("/admin/"));
        roleRoutePrefixes.put(ROLE_MUNICIPAL_HEAD, Set.of("/municipality/"));
        roleRoutePrefixes.put(ROLE_CITIZEN, Set.of("/citizen/", "/profile"));
    }

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {
        HttpServletRequest req = (HttpServletRequest) request;
        HttpServletResponse res = (HttpServletResponse) response;

        String contextPath = req.getContextPath();
        String path = req.getRequestURI().substring(contextPath.length());

        if (isPublicPath(path) || isStaticResource(path)) {
            chain.doFilter(request, response);
            return;
        }

        HttpSession session = req.getSession(false);
        Object sessionUser = session == null ? null : session.getAttribute(SESSION_LOGGED_IN_USER);

        if (!(sessionUser instanceof UserDTO userDTO)) {
            res.sendRedirect(contextPath + "/login");
            return;
        }

        String role = normalizeRole(userDTO.getRole());
        if (role == null) {
            res.sendError(HttpServletResponse.SC_FORBIDDEN, "Unauthorized role.");
            return;
        }

        if (isInactiveAccount(userDTO)) {
            res.sendError(HttpServletResponse.SC_FORBIDDEN, "Your account is inactive. Please contact admin.");
            return;
        }

        if (!isAuthorized(role, path, req.getMethod())) {
            res.sendError(HttpServletResponse.SC_FORBIDDEN, "You are not allowed to access this resource.");
            return;
        }

        chain.doFilter(request, response);
    }

    private boolean isPublicPath(String path) {
        return "/".equals(path) || "/index.jsp".equals(path) || "/login".equals(path)
                || "/register".equals(path) || path.startsWith("/error");
    }

    private boolean isStaticResource(String path) {
        return path.startsWith("/assets/") || path.startsWith("/css/") || path.startsWith("/js/")
                || path.startsWith("/images/") || path.startsWith("/favicon")
                || path.endsWith(".css") || path.endsWith(".js") || path.endsWith(".png")
                || path.endsWith(".jpg") || path.endsWith(".jpeg") || path.endsWith(".gif")
                || path.endsWith(".svg") || path.endsWith(".ico");
    }

    private String normalizeRole(String roleValue) {
        if (roleValue == null) {
            return null;
        }
        String normalized = roleValue.trim().toUpperCase();
        if ("SUPER ADMIN".equals(normalized) || "ADMIN".equals(normalized)) {
            return ROLE_ADMIN;
        }
        if ("REGISTERED CITIZEN".equals(normalized) || "CITIZEN".equals(normalized)) {
            return ROLE_CITIZEN;
        }
        if ("MUNICIPAL HEAD".equals(normalized) || "MUNICIPAL_HEAD".equals(normalized)) {
            return ROLE_MUNICIPAL_HEAD;
        }
        return null;
    }

    private boolean isAuthorized(String role, String path, String method) {
        // Citizens can read wards for dropdowns
        if ("/municipality/wards".equals(path) && "GET".equalsIgnoreCase(method)) {
            return ROLE_CITIZEN.equals(role) || ROLE_MUNICIPAL_HEAD.equals(role) || ROLE_ADMIN.equals(role);
        }

        for (Map.Entry<String, Set<String>> entry : roleRoutePrefixes.entrySet()) {
            for (String routePrefix : entry.getValue()) {
                if (path.startsWith(routePrefix)) {
                    return entry.getKey().equals(role);
                }
            }
        }
        return true;
    }

    private boolean isInactiveAccount(UserDTO userDTO) {
        if (userDTO == null || userDTO.getAccountStatus() == null) {
            return false;
        }

        String status = userDTO.getAccountStatus().trim().toLowerCase();
        return "inactive".equals(status) || "suspended".equals(status) || "disabled".equals(status);
    }

    @Override
    public void destroy() {
    }
}
