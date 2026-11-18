package com.demo;

import java.io.*;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/AdminLoginServlet")
@SuppressWarnings("serial")
	public class AdminLoginServlet extends HttpServlet {
    private static final String ADMIN_USERNAME = "admin";
    private static final String ADMIN_PASSWORD = "admin123";

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String username = request.getParameter("username");
        String password = request.getParameter("password");

        if (ADMIN_USERNAME.equals(username) && ADMIN_PASSWORD.equals(password)) {
            // Set session attribute for admin login
            HttpSession session = request.getSession();
            session.setAttribute("isAdminLoggedIn", true);

            // Redirect to the admin page
            response.sendRedirect("AdminHome.jsp");
        } else {
            // Redirect back to the login page with an error message
            response.sendRedirect("AdminLogin.jsp?error=Invalid credentials");
        }
    }
}

