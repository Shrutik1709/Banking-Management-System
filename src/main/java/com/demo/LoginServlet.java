package com.demo;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Random;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/loginform")
@SuppressWarnings("serial")
public class LoginServlet extends HttpServlet {

	protected void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
	    String phone = req.getParameter("phone");
	    String enteredOTP = req.getParameter("otp"); // Added line

	    if (req.getParameter("getOTP") != null) { // Check if "Get OTP" button was clicked
	    	 try {
	             if (!phoneNumberExistsInDatabase(phone)) {
	                 res.sendRedirect("Login.html?error=Phone number does not exist. Please sign up first.");
	                 return; // Return from the method if phone number doesn't exist
	             }
	         } catch (SQLException e) {
	             e.printStackTrace();
	             res.sendRedirect("Login.html?error=database_error");
	             return; // Return from the method if there is a database error
	         }
	    	
	        String otp = generateOTP();
	        // Store phone number and OTP in session to validate later
	        System.out.println(otp);
	        HttpSession session = req.getSession();
	        session.setAttribute("phone", phone);
	        session.setAttribute("otp", otp);

	        // Send OTP via Fast2SMS API
	        try {
	            if (phoneNumberExistsInDatabase(phone)) {
	                sendOTP(phone, otp, res); // Call sendOTP method
	            } else {
	                res.sendRedirect("Login.html?error=Contact No. Doesn't Exist. You need to sign-up first");
	            }
	        } catch (Exception e) {
	            e.printStackTrace();
	            res.sendRedirect("Login.html?error=Failed to send OTP");
	        }
	    } else { // If "Get OTP" button was not clicked, process login
	        try {
	            Class.forName("com.mysql.cj.jdbc.Driver");
	        } catch (ClassNotFoundException e) {
	            e.printStackTrace();
	        }

	        String url = "jdbc:mysql://localhost:3306/sadaband_bank";
	        String username = "root";
	        String password = "shrutik@17";

	        String query = "SELECT * FROM userinfo WHERE phone = ?";
	        try (Connection con = DriverManager.getConnection(url, username, password);
	             PreparedStatement pstmt = con.prepareStatement(query)) {
	            pstmt.setString(1, phone);
	            try (ResultSet resultSet = pstmt.executeQuery()) {
	                if (resultSet.next()) {
	                    // Retrieve user information from the database
	                    String storedOTP = (String) req.getSession().getAttribute("otp");

	                    // Verify OTP
	                    if (enteredOTP.equals(storedOTP)) {
	                        // OTP verification successful, proceed with login
	                        // Store user information in session
	                        String firstName = resultSet.getString("Firstname");
	                        String lastName = resultSet.getString("Lastname");
	                        String address = resultSet.getString("Address");
	                        String city = resultSet.getString("City");
	                        String state = resultSet.getString("State");
	                        String zip = resultSet.getString("Zip");
	                        String country = resultSet.getString("Country");
	                        String maritalStatus = resultSet.getString("MaritalStatus");
	                        String occupation = resultSet.getString("Occupation");
	                        String accountNo = resultSet.getString("AccountNo");
	                        String userpassword = resultSet.getString("password");
	                        String balance = resultSet.getString("balance");

	                        HttpSession session = req.getSession();
	                        session.setAttribute("balance", balance);
	                        session.setAttribute("phone", phone);
	                        session.setAttribute("accountNo", accountNo);
	                        session.setAttribute("firstName", firstName);
	                        session.setAttribute("lastName", lastName);
	                        session.setAttribute("password", userpassword);
	                        session.setAttribute("address", address);
	                        session.setAttribute("city", city);
	                        session.setAttribute("state", state);
	                        session.setAttribute("zip", zip);
	                        session.setAttribute("country", country);
	                        session.setAttribute("maritalStatus", maritalStatus);
	                        session.setAttribute("occupation", occupation);

	                        // Redirect user to the appropriate page after successful login
	                        res.sendRedirect("Home.jsp?success=Logged in Successfully");
	                    } else {
	                        // OTP verification failed, redirect user back to login page with an error message
	                        res.sendRedirect("Login.html?error=OTP verification failed");
	                    }
	                } else {
	                    // No user found with the provided phone number, redirect user back to login page with an error message
	                    res.sendRedirect("Login.html?error=Contact No. Doesn't Exist. You need to sign-up first");
	                }
	            }
	        } catch (SQLException e) {
	            e.printStackTrace();
	            res.sendRedirect("Login.html?error=database_error");
	        }
	    }
	}


    private String generateOTP() {
        Random random = new Random();
        int otpNumber = 100000 + random.nextInt(900000);
        System.out.println(otpNumber);
        return String.valueOf(otpNumber);
    }

    private void sendOTP(String phoneNumber, String otp, HttpServletResponse res) throws IOException, SQLException {
    	String apiKey = System.getenv("FAST2SMS_API_KEY");
        String route = "otp";
        String numbers = phoneNumber;
        String flash = "0"; // Optional: 0 for normal SMS, 1 for flash SMS

        // Construct the API request URL with the required parameters
        String urlString = "https://www.fast2sms.com/dev/bulkV2?authorization=" + apiKey +
                "&variables_values=" + otp +
                "&route=" + route +
                "&numbers=" + numbers +
                "&flash=" + flash;

        // Make the HTTP request to send the OTP SMS
        try {
            URL url = new URL(urlString);
            HttpURLConnection conn = (HttpURLConnection) url.openConnection();
            conn.setRequestMethod("GET");
            conn.setRequestProperty("Accept", "application/json");

            // Process the response
            BufferedReader rd = new BufferedReader(new InputStreamReader(conn.getInputStream()));
            StringBuilder sb = new StringBuilder();
            String line;
            while ((line = rd.readLine()) != null) {
                sb.append(line);
            }
            rd.close();

            // Log or handle the response as needed
            System.out.println(sb.toString());

            conn.disconnect();

            // Send success message after OTP is sent successfully
            res.getWriter().write("OTP sent successfully");
        } catch (IOException e) {
            e.printStackTrace();
            // If an error occurs while sending the OTP, redirect with an error message
            res.getWriter().write("Failed to send OTP");
        
        }
    }
    private boolean phoneNumberExistsInDatabase(String phoneNumber) throws SQLException {
        boolean exists = false;
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
        }

        String url = "jdbc:mysql://localhost:3306/sadaband_bank";
        String username = "root";
        String password = "shrutik@17";

        String query = "SELECT COUNT(*) FROM userinfo WHERE phone = ?";
        try (Connection con = DriverManager.getConnection(url, username, password);
             PreparedStatement pstmt = con.prepareStatement(query)) {
            pstmt.setString(1, phoneNumber);
            try (ResultSet resultSet = pstmt.executeQuery()) {
                if (resultSet.next()) {
                    int count = resultSet.getInt(1);
                    if (count > 0) {
                        exists = true;
                    }
                }
            }
        }

        return exists;
    }
}
