package com.demo;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.sql.SQLIntegrityConstraintViolationException;
import java.util.logging.Level;
import java.util.logging.Logger;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@SuppressWarnings("serial")
@WebServlet("/signup")
public class Userdata extends HttpServlet {

    private static final Logger logger = Logger.getLogger(Userdata.class.getName());

    protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    	 try {
			Class.forName("com.mysql.cj.jdbc.Driver");
		} catch (ClassNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
         System.out.println("Driver is Running Properly");
        String url = "jdbc:mysql://localhost:3306/sadaband_bank";
        String username = "root";
        String password = "shrutik@17";

        // Retrieve user information from request parameters
        String firstname = request.getParameter("Firstname");
        String lastname = request.getParameter("Lastname");
        String userpassword = request.getParameter("password");
        String phone = request.getParameter("Contact");
        String address = request.getParameter("Address");
        String city = request.getParameter("City");
        String state = request.getParameter("State");
        String zip = request.getParameter("Zip");
        String country = request.getParameter("Country");
        String maritalStatus = request.getParameter("Mstatus");
        String occupation = request.getParameter("Occupation");

        // Store user data in session attributes
        HttpSession session = request.getSession();
        session.setAttribute("firstname", firstname);
        session.setAttribute("lastname", lastname);
        session.setAttribute("password", userpassword);
        session.setAttribute("phone", phone);
        session.setAttribute("address", address);
        session.setAttribute("city", city);
        session.setAttribute("state", state);
        session.setAttribute("zip", zip);
        session.setAttribute("country", country);
        session.setAttribute("maritalStatus", maritalStatus);
        session.setAttribute("occupation", occupation);
       
        	
        if (!validatePassword(userpassword)) {
            response.sendRedirect("Signup.jsp?error=Password must contain at least one uppercase letter, one special character, and one number");
            return;
        }
        
        
        try {
            Connection con = DriverManager.getConnection(url, username, password);

            String query = "INSERT INTO userinfo (Firstname, Lastname, password, phone, Address, City, State, Zip, Country, MaritalStatus, Occupation,IFSC_Code) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
            PreparedStatement pstmt = con.prepareStatement(query);
            pstmt.setString(1, firstname);
            pstmt.setString(2, lastname);
            pstmt.setString(3, userpassword);
            pstmt.setString(4, phone);
            pstmt.setString(5, address);
            pstmt.setString(6, city);
            pstmt.setString(7, state);
            pstmt.setString(8, zip);
            pstmt.setString(9, country);
            pstmt.setString(10, maritalStatus);
            pstmt.setString(11, occupation);
            String IFSC_Code = generateIFSCCode(city);
            pstmt.setString(12, IFSC_Code);
            int rowsAffected = pstmt.executeUpdate();

            pstmt.close();
            con.close();
            if (rowsAffected > 0) {
                // Redirect with success message
                response.sendRedirect("Signup.jsp?success=Account created successfully!! Login Now");
            } else {
                // Redirect with error message
                response.sendRedirect("Signup.jsp?error=Failed to create account, please try again");
            }
        } catch (SQLIntegrityConstraintViolationException e) {
            String errorMessage = "Error occurred while signing up.";
            // Extracting the constraint name or the column causing the violation from the exception message
            String exceptionMessage = e.getMessage();
            boolean hasPhoneDuplicate = exceptionMessage.contains("Duplicate entry") && exceptionMessage.contains("for key 'userinfo.phone'");
            boolean hasPasswordDuplicate = exceptionMessage.contains("Duplicate entry") && exceptionMessage.contains("for key 'userinfo.password'");
            
            // Constructing the error message based on the detected violations
            if (hasPhoneDuplicate && hasPasswordDuplicate) {
                errorMessage = "Phone number and password already exist.";
            } else if (hasPhoneDuplicate) {
                errorMessage = "Phone number already exists.";
            } else if (hasPasswordDuplicate) {
                errorMessage = "Password already exists.";
            }
            
            logger.log(Level.SEVERE, errorMessage, e);
            response.sendRedirect("Signup.jsp?error=" + errorMessage);
        }
        	catch (SQLException e) {
            logger.log(Level.SEVERE, "SQL error", e);
            response.sendRedirect("Signup.jsp?error=An error occurred, please try again");
       
//            request.setAttribute("errorMessage", "An error occurred, please try again");
//            request.getRequestDispatcher("Signup.jsp").forward(request, response);

        } catch (Exception e) {
            logger.log(Level.SEVERE, "General error", e);
            response.sendRedirect("Signup.jsp?error=An unexpected error occurred, please try again");
        
//            request.setAttribute("errorMessage", "An error occurred, please try again");
//            request.getRequestDispatcher("Signup.jsp").forward(request, response);

        }
    }
    private boolean validatePassword(String password) {
        // Define patterns for uppercase letter, special character, and number
        String uppercasePattern = ".*[A-Z].*";
        String specialCharPattern = ".*[^A-Za-z0-9].*";
        String numberPattern = ".*\\d.*";

        // Check if the password matches all three patterns
        return password.matches(uppercasePattern) && password.matches(specialCharPattern) && password.matches(numberPattern);
    }
    private String generateIFSCCode(String city) {
        // Generate a unique IFSC code based on the provided city
        // For simplicity, we'll use "SBBK" + 3-digit random number + first three letters of the city
        String randomDigits = String.format("%03d", (int) (Math.random() * 1000));
        String cityLetters = city.substring(0, Math.min(city.length(), 3)).toUpperCase();
        return "SBBK" + randomDigits + cityLetters;
    }

}
