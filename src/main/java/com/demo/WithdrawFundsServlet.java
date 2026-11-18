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
@WebServlet("/withdrawFunds")
public class WithdrawFundsServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String AccountNo = request.getParameter("account_number");
        String username = request.getParameter("Username");
        String password = request.getParameter("password");
        double amount = Double.parseDouble(request.getParameter("amount"));
        
        
        if (!hasSufficientBalance(AccountNo, amount)) {
            // Redirect to TransferF.jsp with error message in URL
            response.sendRedirect("WithdrawF.jsp?errorMessage=Insufficient balance");
            return;
        }
        if (isValidUser(request, password,AccountNo)) {
            if (withdrawFunds(AccountNo, amount)) {
                insertTransactionRecord(AccountNo, "Debit", amount, "Funds withdrawn");
                response.sendRedirect("WithdrawF.jsp?successMessage=Funds successfully withdrawn");
            } else {
                response.sendRedirect("WithdrawF.jsp?errorMessage=Database error occurred");
            }
        } else {
            response.sendRedirect("WithdrawF.jsp?errorMessage=Invalid account details");
        }
    }

    private boolean isValidUser(HttpServletRequest request, String password,String AccountNo) {
    	String sessionAccountNo=(String) request.getSession().getAttribute("accountNo");
    	String sessionpassword=(String) request.getSession().getAttribute("password");
    	
    	if(sessionAccountNo!=null && sessionpassword!=null &&
                AccountNo != null && password != null &&
                sessionAccountNo.equals(AccountNo) && sessionpassword.equals(password)) {
        String url = "jdbc:mysql://localhost:3306/sadaband_bank";
        String dbUsername = "root";
        String dbPassword = "shrutik@17";
        String query = "SELECT * FROM userinfo WHERE AccountNo = ? AND password = ?";

        try (Connection con = DriverManager.getConnection(url, dbUsername, dbPassword);
             PreparedStatement pstmt = con.prepareStatement(query)) {
            pstmt.setString(1, AccountNo);
            pstmt.setString(2, password);
            return pstmt.executeQuery().next();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    	}
            return false;
        
    	
    }
    
    //method to check balance
    private boolean hasSufficientBalance(String AccountNo, double amount) {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
        }
        String url = "jdbc:mysql://localhost:3306/sadaband_bank";
        String username = "root";
        String dbPassword = "shrutik@17";
        String query = "SELECT balance FROM userinfo WHERE AccountNo = ?";

        try (Connection con = DriverManager.getConnection(url, username, dbPassword);
             PreparedStatement pstmt = con.prepareStatement(query)) {
            pstmt.setString(1, AccountNo);
            try (ResultSet resultSet = pstmt.executeQuery()) {
                if (resultSet.next()) {
                    double balance = resultSet.getDouble("balance");
                    return balance >= amount; // Returns true if balance is sufficient
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    private boolean withdrawFunds(String AccountNo, double amount) {
        String url = "jdbc:mysql://localhost:3306/sadaband_bank";
        String dbUsername = "root";
        String dbPassword = "shrutik@17";
        String query = "UPDATE userinfo SET balance = balance - ? WHERE AccountNo = ?";

        try (Connection con = DriverManager.getConnection(url, dbUsername, dbPassword);
             PreparedStatement pstmt = con.prepareStatement(query)) {
            pstmt.setDouble(1, amount);
            pstmt.setString(2, AccountNo);
            int rowsAffected = pstmt.executeUpdate();
            return rowsAffected > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    private void insertTransactionRecord(String AccountNo, String type, double amount, String description) {
        String url = "jdbc:mysql://localhost:3306/sadaband_bank";
        String dbUsername = "root";
        String dbPassword = "shrutik@17";
        String query = "INSERT INTO transactions (user_id, date, type, amount, description) VALUES (?, ?, ?, ?, ?)";

        try (Connection con = DriverManager.getConnection(url, dbUsername, dbPassword);
             PreparedStatement pstmt = con.prepareStatement(query)) {
            pstmt.setString(1, AccountNo);
            pstmt.setTimestamp(2, new Timestamp(System.currentTimeMillis()));
            pstmt.setString(3, type);
            pstmt.setDouble(4, amount);
            pstmt.setString(5, description);
            pstmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
}
