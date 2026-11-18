package com.demo;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@SuppressWarnings("serial")
@WebServlet("/addFunds")
public class AddFundsServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        double amount = Double.parseDouble(request.getParameter("amount"));
        String password = request.getParameter("password");
        String AccountNo = request.getParameter("account_number");
        
        if (isValidUser(request,AccountNo,password)) {
            if (depositFunds(AccountNo, amount)) {
                response.sendRedirect("Addfunds.jsp?successMessage=Funds successfully deposited");
            } else {
                response.sendRedirect("Addfunds.jsp?errorMessage=Database error occurred");
            }
        } else {
            response.sendRedirect("Addfunds.jsp?errorMessage=Invalid account number or password");
        }
    }

    // Method to validate user account and password
    private boolean isValidUser(HttpServletRequest request,String accountNo, String password) {
    	String sessionAccountNo=(String) request.getSession().getAttribute("accountNo");
    	String sessionpassword=(String) request.getSession().getAttribute("password");
    	if(sessionAccountNo!=null && sessionpassword!=null &&
                accountNo != null && password != null &&
                sessionAccountNo.equals(accountNo) && sessionpassword.equals(password)) {
        String url = "jdbc:mysql://localhost:3306/sadaband_bank";
        String dbUsername = "root";
        String dbPassword = "shrutik@17";
        String query = "SELECT * FROM userinfo WHERE AccountNo = ?  AND password = ?";

        try (Connection con = DriverManager.getConnection(url, dbUsername, dbPassword);
             PreparedStatement pstmt = con.prepareStatement(query)) {
            pstmt.setString(1, sessionAccountNo);
            pstmt.setString(2, sessionpassword);
            try (ResultSet resultSet = pstmt.executeQuery()) {
                return resultSet.next(); // Returns true if the user is valid
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
    	}
        return false; // Returns false if an error occurred or user is invalid
    }

    // Method to update database with deposited funds
    private boolean depositFunds(String AccountNo, double amount) {
        String url = "jdbc:mysql://localhost:3306/sadaband_bank";
        String dbUsername = "root";
        String dbPassword = "shrutik@17";
        String query = "UPDATE userinfo SET balance = balance + ? WHERE AccountNo = ?";

        try (Connection con = DriverManager.getConnection(url, dbUsername, dbPassword);
             PreparedStatement pstmt = con.prepareStatement(query)) {
            pstmt.setDouble(1, amount);
            pstmt.setString(2, AccountNo);
            int rowsAffected = pstmt.executeUpdate();
            if (rowsAffected > 0) {
            	insertTransactionRecord(con, AccountNo, "Credit", amount, "Funds deposited");
                return true;
            }
            else {
                return false;
            }       

        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
    private void insertTransactionRecord(Connection con, String AccountNo, String type, double amount, String description) throws SQLException {
        String query = "INSERT INTO transactions (user_id, date, type, amount, description) VALUES (?, ?, ?, ?, ?)";
        try (PreparedStatement pstmt = con.prepareStatement(query)) {
            pstmt.setString(1, AccountNo);
            pstmt.setTimestamp(2, new Timestamp(System.currentTimeMillis()));
            pstmt.setString(3, type);
            pstmt.setDouble(4, amount);
            pstmt.setString(5, description);
            pstmt.executeUpdate();
        }
    }

}
