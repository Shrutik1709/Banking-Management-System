<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Personal Details</title>
    <style>
    .wrapper{
  position: absolute;
  top: 90%; 
  left: 50%; 
  transform: translate(-50%, -50%);
}

.link_wrapper{
  position: relative;
}

a{
  display: block;
  width: 250px;
  height: 50px;
  line-height: 50px;
  font-weight: bold;
  text-decoration: none;
  background: rgb(3,22,29);
  text-align: center;
  color: #fff;
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
  fill: #0D496C;
  transition: all .35s;
}

a:hover{
  width: 200px;
  border: 3px solid #0D496C;
  background: transparent;
  color: #0D496C;
  font-size:20px;
}

a:hover + .icon{
  border: 3px solid #0D496C;
  right: -25%;
}
    </style>
       <link rel="stylesheet" href="./css/style.css">
     <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.15.4/css/all.css" integrity="sha384-DyZ88mC6Up2uqS4h/KRgHuoeGwBcD4Ng9SiP4dIRy0EXTlnuz47vAwmeGwVChigm" crossorigin="anonymous">
    <link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Playball&family=Homemade+Apple&family=Young+Serif&family=Anta&family=Madimi+One&family=Montserrat+Alternates:ital,wght@0,100;0,200;0,300;0,400;0,500;0,600;0,700;0,800;0,900;1,100;1,200;1,300;1,400;1,500;1,600;1,700;1,800;1,900&family=Platypi:ital,wght@0,300..800;1,300..800&display=swap" rel="stylesheet">
    
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
<div class="container-fluid text-white" id="Pdetails">
    <div class="row align-items-center">
        <div class="col-12 text-center py-3">
        	
            <h1 class="headingfont display-3">Personal Details</h1>
        </div>
        <div class="col-12 col-md-6  col-lg-8 col-xxl-7 py-5 PersWork  ps-md-2 ps-xxl-4   ">
            <%
                String phone = (String) session.getAttribute("phone");
                String url = "jdbc:mysql://localhost:3306/sadaband_bank";
                String username = "root";
                String password = "shrutik@17";
                String query = "SELECT * FROM userinfo WHERE phone = ?";
                
                System.out.println(phone);

                try (Connection con = DriverManager.getConnection(url, username, password);
                     PreparedStatement pstmt = con.prepareStatement(query)) {
                    pstmt.setString(1, phone);
                    try (ResultSet rs = pstmt.executeQuery()) {
                        if (rs.next()) {
            %>
            <div class="row mb-3">
                <div class="col-12 d-md-flex">
                <p class="px-3 fs-4 fs-lg-4 PDfont ">First Name: <%= rs.getString("firstName") %></p>
                <p class="px-3 fs-4  PDfont">Last Name: <%= rs.getString("lastName") %></p>
                <p class="px-3 fs-4  PDfont">Contact: <%= phone %></p>
                </div>
                </div>
                
                <div class="row mb-3 align-items-center">
                <div class="col-12 d-md-flex">
                	<p class="px-3 fs-5  PDfont">Account No: <%= rs.getString("accountNo") %></p>
                	 <p class="px-3 fs-5  PDfont">IFSC Code: <%= rs.getString("IFSC_Code") %></p>
               		<p class="px-3 fs-4 d-lg-flex PDfont ">
				    Password: 
				    <input type="password" readonly class="form-control-sm bg-transparent border border-0 fs-5  text-white px-3 py-0 PDfont " id="password" value="<%= rs.getString("password") %>">
				    <i class="fa fa-eye eye-icon" onclick="togglePasswordVisibility()"></i>
				</p>

                      
                     
                   
                      
                    </div>
                </div>
                     <div class="row mb-3">
                <div class="col-12 d-md-flex">
                <p class="px-3 fs-4  PDfont">Address: <%= rs.getString("address") %></p>
                <p class="px-3 fs-4  PDfont">Zip: <%= rs.getString("zip") %></p>
                <p class="px-3 fs-4  PDfont">City: <%= rs.getString("city") %></p>
                </div>
                </div>
                
                <div class="row mb-3">
                <div class="col-12 d-md-flex">
                <p class="px-3 fs-4  PDfont">State: <%= rs.getString("state") %></p>
                <p class="px-3 fs-4  PDfont">Country: <%= rs.getString("country") %></p>
                <p class="px-3 fs-4  m-0 pb-3 PDfont" >Occupation: <%= rs.getString("occupation") %></p>
                </div>
                </div>
            <%             
                        }
                    }
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            %>
        </div>
			<div class="col-12  col-md-6 col-lg-4 col-xxl-5">
			 <%
               
                String url1 = "jdbc:mysql://localhost:3306/sadaband_bank";
                String username1 = "root";
                String password1 = "shrutik@17";
                String query1 = "SELECT * FROM userinfo WHERE phone = ?";
                
                System.out.println(phone);

                try (Connection con = DriverManager.getConnection(url1, username1, password1);
                     PreparedStatement pstmt = con.prepareStatement(query1)) {
                    pstmt.setString(1, phone);
                    try (ResultSet rs = pstmt.executeQuery()) {
                        if (rs.next()) {
            %>
        <div class="card bg-transparent text-white PersWork  ">
          <div class="card-body ">
            <div class="row ">
              <div class="col-2">
                <img src="./Images/Arrow1.png" height="40px"  width="60px" alt="" srcset="" class="fa-rotate-90">
              </div>
              <div class="col-10 px-4 px-xxl-0 mt-1 d-flex align-items-center">
                <h5 class="card-title fs-3  pb-2 headingfont ">SADABAND BANK</h5>
              </div>
            </div>
            
            
           
             <div class="row align-items-center">
              <div class="col-6 "><img src="./Images/chip.png" height="35px" width="40px" alt="" srcset=""></div>
              <div class="col-6 d-flex justify-content-end fs-1 platinum ">Platinum</div>
             </div>
            <p class="card-text pt-2 text-center fs-3 formfont">1234<span class="px-2">9353</span><span class="px-2">2496</span><span class="px-2">1709</span></p>
           <div class="row">
            <div class="col-4 col-xxl-5 text-end formfont"><h6 class="">valid <br>upto</h6>
            </div>
            <div class="col-8 col-xxl-7 formfont  ">
              <h6>Month/Year</h6>
              <h5>08/26</h5>
            </div>
           </div>
           <div class="row align-items-center">
            <div class="col-6">
              <p class="mt-2 fs-3 signature"><%= rs.getString("firstName") %> <%= rs.getString("lastName") %></p>
            </div>
            <div class="col-6 ps-4 d-flex justify-content-end ">
              <img src="./Images/arrow.png" alt="" height="30px" width="30px" srcset="">
            <h4 class="ps-3 platinum">VISA CARD</h4>
            </div>
           </div>
          </div>
        </div>
         <%             
                        }
                    }
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            %>
      </div>

    </div>
     <div class="wrapper">
					  <div class="link_wrapper">
					    <a href="Home.jsp" class="buttonfont text-white text-decoration-none ">Back to Home</a>
					    <div class="icon">
					      <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 268.832 268.832">
					        <path d="M265.17 125.577l-80-80c-4.88-4.88-12.796-4.88-17.677 0-4.882 4.882-4.882 12.796 0 17.678l58.66 58.66H12.5c-6.903 0-12.5 5.598-12.5 12.5 0 6.903 5.597 12.5 12.5 12.5h213.654l-58.66 58.662c-4.88 4.882-4.88 12.796 0 17.678 2.44 2.44 5.64 3.66 8.84 3.66s6.398-1.22 8.84-3.66l79.997-80c4.883-4.882 4.883-12.796 0-17.678z"/>
					      </svg>
					    </div>
					  </div>
					  
				</div>
</div>
<script>
function togglePasswordVisibility() {
    var passwordField = document.getElementById("password");
    var eyeIcon = document.querySelector(".eye-icon");

    if (passwordField.type === "password") {
        passwordField.type = "text";
        eyeIcon.classList.add("fa-eye-slash");
    } else {
        passwordField.type = "password";
        eyeIcon.classList.remove("fa-eye-slash");
        eyeIcon.classList.add("fa-eye");
    }
}
</script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
