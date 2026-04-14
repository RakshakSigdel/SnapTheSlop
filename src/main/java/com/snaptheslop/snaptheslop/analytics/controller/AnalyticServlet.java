package com.snaptheslop.snaptheslop.analytics.controller;

import java.io.IOException;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;

@WebServlet(name = "analyticServlet", urlPatterns = {"/sidebar", "/footer", "/navbar", "/error"})
public class AnalyticServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws IOException, ServletException {

        String path = request.getServletPath();

        try {

            if ("/sidebar".equals(path)) {

                request.setAttribute("activePage", "sidebar");
                request.getRequestDispatcher("/WEB-INF/views/common/admin-sidebar.jsp")
                        .forward(request, response);

            } else if ("/footer".equals(path)) {

                request.setAttribute("activePage", "footer");
                request.getRequestDispatcher("/WEB-INF/views/common/footer.jsp")
                        .forward(request, response);

            } else if ("/navbar".equals(path)) {

                request.setAttribute("activePage", "navbar");
                request.getRequestDispatcher("/WEB-INF/views/common/navbar.jsp")
                        .forward(request, response);

            } else if ("/error".equals(path)) {

                request.getRequestDispatcher("/WEB-INF/views/error.jsp")
                        .forward(request, response);
            }

        } catch (Exception e) {

            // Send error details to JSP
            request.setAttribute("errorMessage", e.getMessage());

            request.getRequestDispatcher("/WEB-INF/views/error.jsp")
                    .forward(request, response);
        }
    }
}