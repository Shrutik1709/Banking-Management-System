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
import jakarta.servlet.http.HttpSession;

@SuppressWarnings("serial")
@WebServlet("/transferFunds")
public class TransferFundsServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Retrieve form data
        String senderAccountNo = request.getParameter("account_number");
        String receiverAccountNo = request.getParameter("receiver_account");
        double amount = Double.parseDouble(request.getParameter("amount"));
        String password = request.getParameter("password");
        HttpSession session = request.getSession();
        String senderphone = (String) session.getAttribute("phone");
        // Debugging: Print retrieved values
        System.out.println("Sender Account Number: " + senderAccountNo);
        System.out.println("Password: " + password);

        // Verify sender's password and account number
        if (!isValidSender(request,senderAccountNo, password)) {
            // Redirect to TransferF.jsp with error message in URL
            response.sendRedirect("TransferF.jsp?errorMessage=Invalid sender credentials");
            return;
        }
        if (!isReceiverAccountValid(receiverAccountNo)) {
            // Redirect to TransferF.jsp with error message in URL
            response.sendRedirect("TransferF.jsp?errorMessage=Invalid receiver account");
            return;
        }

        
        if (!hasSufficientBalance(senderAccountNo, amount)) {
            // Redirect to TransferF.jsp with error message in URL
            response.sendRedirect("TransferF.jsp?errorMessage=Insufficient balance");
            return;
        }

        // Transfer funds from sender to receiver
        if (transferFunds(senderAccountNo, receiverAccountNo, amount, senderphone)) {
            // Redirect to TransferF.jsp with success message in URL
            response.sendRedirect("TransferF.jsp?successMessage=Funds successfully transferred");
        } else {
            // Redirect to TransferF.jsp with error message in URL
            response.sendRedirect("TransferF.jsp?errorMessage=Failed to transfer funds");
        }
    }

    // Method to verify sender's password and account number
    private boolean isValidSender(HttpServletRequest request,String senderAccountNo, String password) {

    	String sessionAccountNo=(String) request.getSession().getAttribute("accountNo");
    	String sessionpassword=(String) request.getSession().getAttribute("password");
        if (sessionAccountNo != null && sessionpassword != null &&
                senderAccountNo != null && password != null &&
                sessionAccountNo.equals(senderAccountNo) && sessionpassword.equals(password)) {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
        }
        String url = "jdbc:mysql://localhost:3306/sadaband_bank";
        String username = "root";
        String dbPassword = "shrutik@17";
        String query = "SELECT * FROM userinfo WHERE AccountNo = ? AND password = ?";

        try (Connection con = DriverManager.getConnection(url, username, dbPassword);
             PreparedStatement pstmt = con.prepareStatement(query)) {
            pstmt.setString(1, senderAccountNo);
            pstmt.setString(2, password);
            try (ResultSet resultSet = pstmt.executeQuery()) {
                return resultSet.next(); // Returns true if a matching record is found
            
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        }
            return false;
        
    }
    
    
    private boolean isReceiverAccountValid(String receiverAccountNo) {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
        }
        String url = "jdbc:mysql://localhost:3306/sadaband_bank";
        String username = "root";
        String dbPassword = "shrutik@17";
        String query = "SELECT * FROM userinfo WHERE AccountNo = ?";

        try (Connection con = DriverManager.getConnection(url, username, dbPassword);
             PreparedStatement pstmt = con.prepareStatement(query)) {
            pstmt.setString(1, receiverAccountNo);
            try (ResultSet resultSet = pstmt.executeQuery()) {
                return resultSet.next(); // Returns true if a matching record is found
            }
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
   //method to check balance
    private boolean hasSufficientBalance(String senderAccountNo, double amount) {
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
            pstmt.setString(1, senderAccountNo);
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


    // Method to transfer funds from sender to receiver
    private boolean transferFunds(String senderAccountNo, String receiverAccountNo, double amount,String senderphone) {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
        }
        String url = "jdbc:mysql://localhost:3306/sadaband_bank";
        String username = "root";
        String dbPassword = "shrutik@17";
        String senderQuery = "UPDATE userinfo SET balance = balance - ? WHERE AccountNo = ?";
        String receiverQuery = "UPDATE userinfo SET balance = balance + ? WHERE AccountNo = ?";

        try (Connection con = DriverManager.getConnection(url, username, dbPassword);
             PreparedStatement senderPstmt = con.prepareStatement(senderQuery);
             PreparedStatement receiverPstmt = con.prepareStatement(receiverQuery)) {

            con.setAutoCommit(false); // Start transaction

            // Deduct amount from sender's account
            senderPstmt.setDouble(1, amount);
            senderPstmt.setString(2, senderAccountNo);
            senderPstmt.executeUpdate();

            // Add amount to receiver's account
            receiverPstmt.setDouble(1, amount);
            receiverPstmt.setString(2, receiverAccountNo);
            receiverPstmt.executeUpdate();
            
            insertTransactionRecord(con, senderAccountNo, "Debit", amount, "Funds transferred to " + receiverAccountNo);
            insertTransactionRecordforReceiver(con, receiverAccountNo, "Credit", amount, "Received from " + senderphone);
                  
            con.commit(); // Commit transaction

            return true;

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
    
    
    private void insertTransactionRecordforReceiver(Connection con, String receiverAccountNo, String type, double amount, String description) throws SQLException {
        String query = "INSERT INTO transactions (user_id, date, type, amount, description) VALUES (?, ?, ?, ?, ?)";
        try (PreparedStatement pstmt = con.prepareStatement(query)) {
            pstmt.setString(1, receiverAccountNo);
            pstmt.setTimestamp(2, new Timestamp(System.currentTimeMillis()));
            pstmt.setString(3, type);
            pstmt.setDouble(4, amount);
            pstmt.setString(5, description);
            pstmt.executeUpdate();
        }
    }

}

