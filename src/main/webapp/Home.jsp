<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!doctype html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Home Page</title>
    
    <link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Agbalumo&family=Anta&family=Madimi+One&family=Montserrat+Alternates:ital,wght@0,100;0,200;0,300;0,400;0,500;0,600;0,700;0,800;0,900;1,100;1,200;1,300;1,400;1,500;1,600;1,700;1,800;1,900&family=Platypi:ital,wght@0,300..800;1,300..800&display=swap" rel="stylesheet">
 
    <link rel="stylesheet" href="./css/style.css">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-rbsA2VBKQhggwzxH7pPCaAqO46MgnOM80zW1RWuH61DGLwZJEdK2Kadq2F9CUG65" crossorigin="anonymous">
    <style>
    
    .Btn {
  display: flex;
  align-items: center;
  justify-content: flex-start;
  width: 45px;
  height: 45px;
  border: none;
  border-radius: 50%;
  cursor: pointer;
  position: relative;
  overflow: hidden;
  transition-duration: .3s;
  box-shadow: 2px 2px 10px rgba(0, 0, 0, 0.199);
  background-color: #293A5D;
}

/* plus sign */
.sign {
  width: 100%;
  transition-duration: .3s;
  display: flex;
  align-items: center;
  justify-content: center;
}

.sign svg {
  width: 17px;
}

.sign svg path {
  fill: white;
}
/* text */
.text {
  position: absolute;
  right: 0%;
  width: 0%;
  opacity: 0;
  color: white;
  font-size: 1.2em;
  font-weight: 600;
  transition-duration: .3s;
}
/* hover effect on button width */
.Btn:hover {
  width: 125px;
  border-radius: 40px;
  transition-duration: .3s;
}

.Btn:hover .sign {
  width: 30%;
  transition-duration: .3s;
  padding-left: 20px;
}
/* hover effect button's text */
.Btn:hover .text {
  opacity: 1;
  width: 70%;
  transition-duration: .3s;
  padding-right: 10px;
}
/* button click effect*/
.Btn:active {
  transform: translate(2px ,2px);
}
     	.button {
     	
    --offset: 10px;
    --border-size: 2px;
    display: block;
    position: relative;
    padding: 0.75em 1.5em;
    border: 0;
    background: transparent;
    color: rgba(238, 130, 238,0.4);
    text-transform: uppercase;
    letter-spacing: 0.25em;
    outline: none;
    cursor: pointer;
    font-weight: bold;
    border-radius: 0;
    box-shadow: inset 0 0 0 var(--border-size) currentcolor;
    transition: background 0.8s ease;
  }
  .button:hover {
    background: rgba(100, 0, 0, 0.03);
  }
  .button__horizontal, .button__vertical {
    position: absolute;
    top: var(--horizontal-offset, 0);
    right: var(--vertical-offset, 0);
    bottom: var(--horizontal-offset, 0);
    left: var(--vertical-offset, 0);
    transition: transform 0.8s ease;
    will-change: transform;
  }
  .button__horizontal::before, .button__vertical::before {
    content: "";
    position: absolute;
    border: inherit;
  }
  .button__horizontal {
    --vertical-offset: calc(var(--offset) * -1);
    border-top: var(--border-size) solid currentcolor;
    border-bottom: var(--border-size) solid currentcolor;
  }
  .button__horizontal::before {
    top: calc(var(--vertical-offset) - var(--border-size));
    bottom: calc(var(--vertical-offset) - var(--border-size));
    left: calc(var(--vertical-offset) * -1);
    right: calc(var(--vertical-offset) * -1);
  }
  .button:hover .button__horizontal {
    transform: scaleX(0);
  }
  .button__vertical {
    --horizontal-offset: calc(var(--offset) * -1);
    border-left: var(--border-size) solid currentcolor;
    border-right: var(--border-size) solid currentcolor;
  }
  .button__vertical::before {
    top: calc(var(--horizontal-offset) * -1);
    bottom: calc(var(--horizontal-offset) * -1);
    left: calc(var(--horizontal-offset) - var(--border-size));
    right: calc(var(--horizontal-offset) - var(--border-size));
  }
  .button:hover .button__vertical {
    transform: scaleY(0);
  }
    </style>
</head>
<body>
 <div class="modal fade" id="successModal" tabindex="-1" aria-labelledby="successModalLabel" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="successModalLabel">Success</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body" id="successMessageContainer">
                    <!-- Success message will be displayed here -->
                </div>
            </div>
        </div>
    </div>
    <div class="container-fluid p-0 g-0">
        <div class="container-fluid">
            <div class="row">
                <div class="col-12 p-0 shadow">
                    <nav class="navbar" style="background:linear-gradient(to top,rgb(29, 48, 85),rgba(30, 49, 85, 0.8));">
                        <div class="container">
                           
                            <h1 class="headingfont" id="checking">SadaBand Bank</h1>
                            <button class="Btn">
							  
							  <div class="sign"><svg viewBox="0 0 512 512"><path d="M377.9 105.9L500.7 228.7c7.2 7.2 11.3 17.1 11.3 27.3s-4.1 20.1-11.3 27.3L377.9 406.1c-6.4 6.4-15 9.9-24 9.9c-18.7 0-33.9-15.2-33.9-33.9l0-62.1-128 0c-17.7 0-32-14.3-32-32l0-64c0-17.7 14.3-32 32-32l128 0 0-62.1c0-18.7 15.2-33.9 33.9-33.9c9 0 17.6 3.6 24 9.9zM160 96L96 96c-17.7 0-32 14.3-32 32l0 256c0 17.7 14.3 32 32 32l64 0c17.7 0 32 14.3 32 32s-14.3 32-32 32l-64 0c-53 0-96-43-96-96L0 128C0 75 43 32 96 32l64 0c17.7 0 32 14.3 32 32s-14.3 32-32 32z"></path></svg></div>
							  <a href="Login.html" class="stretched-link text-decoration-none text-white ps-1 text buttonfont">LOGOUT</a>
							  
							  <div class=""></div>
							</button>  
                        </div>
                    </nav>
                </div>
                <div class="col-12 " id="kotak">
                    <div class="row" id="Services">
                        <div class="col-12"><h2 class="mt-5 text-center text-bolder display-3 text-white headingfont">Our Services</h2></div>
                        <div class="col-12 d-md-flex justify-content-evenly text-center">
                         <button class="button my-5  "><a class="text-decoration-none text-white  stretched-link homebutton" href="Addfunds.jsp">Deposit Funds</a>
						     <div class="button__horizontal"></div>
                                <div class="button__vertical"></div>
                     </button> 
                     		  <button class="button my-5 "><a class="text-decoration-none text-white  stretched-link homebutton" href="WithdrawF.jsp">Withdraw Funds</a>
						     <div class="button__horizontal"></div>
                                <div class="button__vertical"></div>
                     </button> 
                     <button class="button my-5"><a class="text-decoration-none text-white  stretched-link homebutton" href="TransferF.jsp">Transfer Funds</a>
						     <div class="button__horizontal"></div>
                                <div class="button__vertical"></div>
                     </button> 
                      <button class="button my-5 "><a class="text-decoration-none text-white  stretched-link homebutton" href="accountActivity.jsp">Account Activity</a>
						     <div class="button__horizontal"></div>
                                <div class="button__vertical"></div>
                     </button> 
                     
                        </div>
                      <!-- <div class="col-12 col-md-3 py-3 pt-md-5   ">
                      
                   
                    </div>
                    <div class="col-12 col-md-3 py-3 pt-md-5 ">
                      
                   
                    </div>
                     <div class="col-12 col-md-3 py-3 pt-md-5 ">
                       
                   
                    </div>
                      <div class="col-12 col-md-3 py-3 pt-md-5  ">
                      
                   
                    </div> -->
                    
                    <div class="row" id="Info">
                        <div class="col-12 mt-5">
                            <h2 class="text-center text-bolder display-3 text-white headingfont">Personal Information</h2>
                        </div>
                        <div class="col-12 col-md-6 py-3 pt-md-5 d-lg-flex justify-content-evenly  ">
                    <button class="button "><a class="text-decoration-none text-white  stretched-link homebutton" href="ChangeAccDetails.jsp">Change Account Details</a>
						     <div class="button__horizontal"></div>
                                <div class="button__vertical"></div>
                     </button>    
                   
                    </div>
                         <div class="col-12 col-md-6 py-3 pt-md-5 d-lg-flex justify-content-evenly  ">
                    <button class="button "><a class="text-decoration-none text-white  stretched-link homebutton" href="Personaldetails.jsp">View Account Details</a>
						     <div class="button__horizontal"></div>
                                <div class="button__vertical"></div>
                     </button>    
                   
                    </div>
                    </div>
                    <div class="col-12  pt-5  d-md-flex justify-content-center    ">
                        <!-- Button to check balance -->
                         <button  class="button homebutton" data-bs-toggle="modal" data-bs-target="#balanceModal">View Account Balance
                         <div class="button__horizontal"></div>
                           <div class="button__vertical"></div>
                           </button>
                    </div>
                    <!-- Modal -->
				<div class="modal fade" id="balanceModal" tabindex="-1" aria-labelledby="balanceModalLabel" aria-hidden="true">
			    <div class="modal-dialog modal-dialog-centered">
			        <div class="modal-content">
			            <div class="modal-header">
			                <h5 class="modal-title" id="balanceModalLabel">View Balance</h5>
			                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
           					 </div>
            				<div class="modal-body">
                <%
                    // Establish database connection
                    String url = "jdbc:mysql://localhost:3306/sadaband_bank";
                    String username = "root";
                    String password = "shrutik@17";
                    String phone = (String) session.getAttribute("phone");
                    String accountNo = (String) session.getAttribute("accountNo");
                    String query = "SELECT balance  FROM userinfo WHERE phone = ?";
                    double balance = 0.0;
                    
                

                    try (Connection con = DriverManager.getConnection(url, username, password);
                        PreparedStatement pstmt = con.prepareStatement(query)) {
                        pstmt.setString(1, phone);
                        try (ResultSet rs = pstmt.executeQuery()) {
                            if (rs.next()) {
                                balance = rs.getDouble("balance");
                           
                            }
                        }
                    } catch (SQLException e) {
                        e.printStackTrace();
                    }
                %>
                <p>Your Saving A/c <%= accountNo  %> is: <%= balance %></p>
            	</div>
    		    </div>
    			</div>
				</div>

                    </div>
                </div>
            </div>
       </div>
    </div><!--end of main-->
  
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-kenU1KFdBIe4zVF0s0G1M5b4hcpxyD9F7jL+jjXkk+Q2h455rYXK/7HAuoJl+0I4" crossorigin="anonymous"></script>
    <script>
(() => {
    'use strict';

    const urlParams = new URLSearchParams(window.location.search);
    const errorMessage = urlParams.get('error');
    const successMessage = urlParams.get('success');

    if (errorMessage) {
        showErrorModal(errorMessage);
    } else if (successMessage) {
        showSuccessModal(successMessage);
    }

    function showErrorModal(message) {
        const errorMessageContainer = document.getElementById('errorMessageContainer');
        errorMessageContainer.innerHTML = '<div class="alert alert-danger" role="alert">' + message + '</div>';
        const errorModal = new bootstrap.Modal(document.getElementById('errorModal'));
        errorModal.show();
    }

    function showSuccessModal(message) {
        const successMessageContainer = document.getElementById('successMessageContainer');
        successMessageContainer.innerHTML = '<div class="alert alert-success" role="alert">' + message + '</div>';
        const successModal = new bootstrap.Modal(document.getElementById('successModal'));
        successModal.show();
    }
})();
</script> 
</body>
</html>
