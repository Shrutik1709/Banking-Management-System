package com.demo;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@SuppressWarnings("serial")
@WebServlet("/updateDetails")
public class ChangeAccountDetailsServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        String phone = (String) session.getAttribute("phone");
        
        // Retrieve new user details from the form
        String newPassword = request.getParameter("newPassword");
        String newPhone = request.getParameter("newPhone");
        String newFirstname = request.getParameter("newFirstname");
        String newLastname = request.getParameter("newLastname");

        // Validate the new password
        if (newPassword != null && !newPassword.isEmpty() && !validatePassword(newPassword)) {
            response.sendRedirect("ChangeAccDetails.jsp?errorMessage=Password must contain at least one uppercase letter, one special character, and one number");
            return;
        }

        // Update user details in the database
        boolean success = updateUserDetails(phone, newPassword, newPhone, newFirstname, newLastname);

        if (success) {
            // Update session with new details only if the update operation is for the currently logged-in user
            if (newPassword != null && !newPassword.isEmpty()) {
                session.setAttribute("password", newPassword);
            }
            if (newPhone != null && !newPhone.isEmpty()) {
                session.setAttribute("phone", newPhone);
            }
            // Check if the update operation is for the currently logged-in user
            if (phone.equals(session.getAttribute("phone"))) {
                if (newFirstname != null && !newFirstname.isEmpty()) {
                    session.setAttribute("firstname", newFirstname);
                }
                if (newLastname != null && !newLastname.isEmpty()) {
                    session.setAttribute("lastname", newLastname);
                }
            }
            // Fetch the latest user details from the database and update session attributes
            updateSessionWithLatestDetails(session, phone);
            response.sendRedirect("ChangeAccDetails.jsp?successMessage=Details updated successfully");
        } else {
            response.sendRedirect("ChangeAccDetails.jsp?errorMessage=Failed to update details");
        }
    }

    private boolean updateUserDetails(String phone, String newPassword, String newPhone, String newFirstname, String newLastname) {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            String url = "jdbc:mysql://localhost:3306/sadaband_bank";
            String username = "root";
            String password = "shrutik@17";

            Connection con = DriverManager.getConnection(url, username, password);
            StringBuilder queryBuilder = new StringBuilder("UPDATE userinfo SET");
            boolean needComma = false;

            if (newPassword != null && !newPassword.isEmpty()) {
                queryBuilder.append(" password = ?");
                needComma = true;
            }
            if (newPhone != null && !newPhone.isEmpty()) {
                if (needComma) {
                    queryBuilder.append(",");
                }
                queryBuilder.append(" phone = ?");
                needComma = true;
            }
            if (newFirstname != null && !newFirstname.isEmpty()) {
                if (needComma) {
                    queryBuilder.append(",");
                }
                queryBuilder.append(" Firstname = ?");
                needComma = true;
            }
            if (newLastname != null && !newLastname.isEmpty()) {
                if (needComma) {
                    queryBuilder.append(",");
                }
                queryBuilder.append(" Lastname = ?");
            }

            // Set parameters based on the number of fields updated
            PreparedStatement pstmt = con.prepareStatement(queryBuilder.toString() + " WHERE phone = ?");
            int parameterIndex = 1;
            if (newPassword != null && !newPassword.isEmpty()) {
                pstmt.setString(parameterIndex++, newPassword);
            }
            if (newPhone != null && !newPhone.isEmpty()) {
                pstmt.setString(parameterIndex++, newPhone);
            }
            if (newFirstname != null && !newFirstname.isEmpty()) {
                pstmt.setString(parameterIndex++, newFirstname);
            }
            if (newLastname != null && !newLastname.isEmpty()) {
                pstmt.setString(parameterIndex++, newLastname);
            }
            pstmt.setString(parameterIndex, phone);

            int rowsUpdated = pstmt.executeUpdate();
            pstmt.close();
            con.close();

            return rowsUpdated > 0;
        } catch (ClassNotFoundException | SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
 
    private void updateSessionWithLatestDetails(HttpSession session, String phone) {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            String url = "jdbc:mysql://localhost:3306/sadaband_bank";
            String username = "root";
            String password = "shrutik@17";

            Connection con = DriverManager.getConnection(url, username, password);
            String query = "SELECT * FROM userinfo WHERE phone = ?";
            PreparedStatement pstmt = con.prepareStatement(query);
            pstmt.setString(1, phone);
            ResultSet rs = pstmt.executeQuery();
            if (rs.next()) {
                session.setAttribute("firstName", rs.getString("Firstname"));
                session.setAttribute("lastName", rs.getString("Lastname"));
                session.setAttribute("phone", rs.getString("phone"));
                session.setAttribute("password", rs.getString("password"));
                session.setAttribute("", rs);
                // You can add more attributes as needed
            }
            rs.close();
            pstmt.close();
            con.close();
        } catch (ClassNotFoundException | SQLException e) {
            e.printStackTrace();
        }
    }

    // Method to validate password
    private boolean validatePassword(String password) {
        // Define patterns for uppercase letter, special character, and number
        String uppercasePattern = ".*[A-Z].*";
        String specialCharPattern = ".*[^A-Za-z0-9].*";
        String numberPattern = ".*\\d.*";

        // Check if the password matches all three patterns
        return password.matches(uppercasePattern) && password.matches(specialCharPattern) && password.matches(numberPattern);
    }
}
