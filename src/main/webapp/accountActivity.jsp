<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Account Activity</title>
     <style>
     
     
    .wrapper{
  position: absolute;
  top: 13%; 
  left: 80%; 
  transform: translate(-50%, -50%);
}

.link_wrapper{
  position: relative;
}

.anchor1{
  display: block;
  width: 250px;
  height: 50px;
  line-height: 50px;
  font-weight: bold;
  text-decoration: none;
  background: rgb(3,22,29);
  text-align: center;
  color: white;
  font-size:20px;
  text-transform: uppercase;
  letter-spacing: 1px;
  border: 3px solid rgb(3,22,29);
  transition: all .35s;
}

.icon{
  width: 50px;
  height: 50px;
  border: 3px solid transparent;
  position: absolute;
  transform: rotate(45deg);
  right: 0;
  top: 0;
  z-index: -1;
  transition: all .35s;
}

.icon svg{
  width: 30px;
  position: absolute;
  top: calc(50% - 15px);
  left: calc(50% - 15px);
  transform: rotate(-45deg);
  fill: black;
  transition: all .35s;
}

a:hover{
  width: 200px;
  border: 3px solid black;
  background: transparent;
  color: black;
  font-size:20px;
}

a:hover + .icon{
  border: 3px solid black;
  right: -25%;
}
    </style>
     <link rel="stylesheet" href="./css/style.css">
     
    <link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Sigmar&family=Young+Serif&family=Anta&family=Madimi+One&family=Montserrat+Alternates:ital,wght@0,100;0,200;0,300;0,400;0,500;0,600;0,700;0,800;0,900;1,100;1,200;1,300;1,400;1,500;1,600;1,700;1,800;1,900&family=Platypi:ital,wght@0,300..800;1,300..800&display=swap" rel="stylesheet">
    
     <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-rbsA2VBKQhggwzxH7pPCaAqO46MgnOM80zW1RWuH61DGLwZJEdK2Kadq2F9CUG65" crossorigin="anonymous">
    
    <style>
        /* Add your CSS styles here */
        /* For simplicity, I'm using inline styles in this example */
        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
            
        }
        th, td {
            border: 2px solid #c1c0c0;
            text-align: left;
            padding: 8px;
        }
        th,.main {
           background-color: #e2e2e2; 
 
        }
    </style>
</head>
<body>
   
    <div class="container-fluid text-dark main">
    	<div class="container-fluid ">
    		<div class="row">
    		<div class="col-12 mt-5"> <h1 class="text-center text-dark display-3 headingfont ">Account Activity</h1></div>
    		<div class="col-12 pb-5">
    			 <table class="table table-hover">
        <thead>
            <tr>
                <th class="tableheading fs-5">Date</th>
                <th class="tableheading fs-5">Type of Transaction</th>
                <th class="tableheading fs-5">Amount</th>
                <th class="tableheading fs-5">Particulars</th>
            </tr>
        </thead>
        <tbody>
            <% 
                String accountNo = (String) session.getAttribute("accountNo"); // Assuming you store phone number in session
                if (accountNo != null) {
                    try {
                        String url = "jdbc:mysql://localhost:3306/sadaband_bank";
                        String username = "root";
                        String password = "shrutik@17";
                        Class.forName("com.mysql.cj.jdbc.Driver");
                        Connection con = DriverManager.getConnection(url, username, password);
                        String query = "SELECT * FROM transactions WHERE user_id = ?";
                        PreparedStatement pstmt = con.prepareStatement(query);
                        pstmt.setString(1, accountNo);
                        ResultSet rs = pstmt.executeQuery();
                        while (rs.next()) {
            %>
            <tr>
                <td class="formfont fs-5"><%= rs.getString("date") %></td>
                <td class="formfont fs-5"><%= rs.getString("type") %></td>
                <td class="formfont fs-5"><%= rs.getDouble("amount") %></td>
                <td class="formfont fs-5"><%= rs.getString("description") %></td>
            </tr>
            <% 
                        }
                        rs.close();
                        pstmt.close();
                        con.close();
                    } catch (ClassNotFoundException | SQLException e) {
                        e.printStackTrace();
                    }
                } else {
                    // Handle case when phone is not set in the session
                    out.println("Phone number not found in session.");
                }
            %>
        </tbody>
    </table>
    		
    		</div>
    		</div>
    </div>
    <div class="wrapper">
					  <div class="link_wrapper">
					    <a href="Home.jsp" class="buttonfont anchor1 text-white  text-decoration-none">Back to Home</a>
					    <div class="icon">
					      <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 268.832 268.832">
					        <path d="M265.17 125.577l-80-80c-4.88-4.88-12.796-4.88-17.677 0-4.882 4.882-4.882 12.796 0 17.678l58.66 58.66H12.5c-6.903 0-12.5 5.598-12.5 12.5 0 6.903 5.597 12.5 12.5 12.5h213.654l-58.66 58.662c-4.88 4.882-4.88 12.796 0 17.678 2.44 2.44 5.64 3.66 8.84 3.66s6.398-1.22 8.84-3.66l79.997-80c4.883-4.882 4.883-12.796 0-17.678z"/>
					      </svg>
					    </div>
					  </div>
					  
				</div>
    </div><!-- end of main container -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-kenU1KFdBIe4zVF0s0G1M5b4hcpxyD9F7jL+jjXkk+Q2h455rYXK/7HAuoJl+0I4" crossorigin="anonymous"></script>
</body>
</html>
