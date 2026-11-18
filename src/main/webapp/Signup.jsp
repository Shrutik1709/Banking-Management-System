<%@ page import="java.io.*,java.util.*" %>
<%-- <%@ page import="javax.servlet.*"%> --%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">


<meta name="viewport" content="width=device-width, initial-scale=1">
<title>Sign-up Page</title>
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Anta&family=Madimi+One&family=Montserrat+Alternates:ital,wght@0,100;0,200;0,300;0,400;0,500;0,600;0,700;0,800;0,900;1,100;1,200;1,300;1,400;1,500;1,600;1,700;1,800;1,900&family=Platypi:ital,wght@0,300..800;1,300..800&display=swap" rel="stylesheet">
<link rel="stylesheet" href="./css/style.css">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-rbsA2VBKQhggwzxH7pPCaAqO46MgnOM80zW1RWuH61DGLwZJEdK2Kadq2F9CUG65" crossorigin="anonymous">
 
<style>
 .button {
  width: 140px;
  height: 45px;
  font-family: 'Roboto', sans-serif;
  font-size: 11px;
  text-transform: uppercase;
  letter-spacing: 2.5px;
  font-weight: 500;
  color: #000;
  background-color: #fff;
  border: none;
  border-radius: 45px;
  box-shadow: 0px 8px 15px rgba(0, 0, 0, 0.1);
  transition: all 0.3s ease 0s;
  cursor: pointer;
  outline: none;
  }

.button:hover {
  background-color: #2EE59D;
  box-shadow: 0px 15px 20px rgba(46, 229, 157, 0.4);
  color: #fff;
  transform: translateY(-7px);
}
 .btn {
  --color:#001C68;
  position: relative;
  display: flex;
  justify-content: center;
  align-items: center;
  transition: all .5s;
  border: none;
  background-color: transparent;
}

.btn div {
  letter-spacing: 2px;
  font-weight: bold;
  background: var(--color);
  border-radius: 2rem;
  color: white;
  padding: 7px;
}

.btn::before {
  content: '';
  z-index: -1;
  background-color: var(--color);
  border: 2px solid white;
  border-radius: 2rem;
  width: 110%;
  height: 100%;
  position: absolute;
  transform: rotate(10deg);
  transition: .5s;
  opacity: 0.2;
}

.btn:hover {
  cursor: pointer;
  filter: brightness(1.2);
  transform: scale(1.1);
}

.btn:hover::before {
  transform: rotate(0deg);
  opacity: 1;
}



.btn:active {
  filter: brightness(1.4);
}
</style>
  
</head>
<body>
 <div class="modal fade" id="errorModal" tabindex="-1" aria-labelledby="errorModalLabel" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="errorModalLabel">Account Creation Error: Please Try Again</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body" id="errorMessageContainer">
                    <!-- Error message will be displayed here -->
                </div>
                
            </div>
        </div>
    </div>
    <div class="modal fade" id="successModal" tabindex="-1" aria-labelledby="successModalLabel" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="successModalLabel">Great News! You're All Set Up with Your New Account</h5>
                     <!-- <button class="btn  p-1"><a href="Login.html" class="btn-login text-decoration-none">Login Now</a></button> -->
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body" id="successMessageContainer">
                    <!-- Success message will be displayed here -->

                    
                </div>
            </div>
        </div>
    </div>
   
  

			 <div class="container-fluid text-white" id="bg-1">
			 <div class=" container">
			        <div class="row justify-content-center" id="" >
			        <div class="col-12 pt-3">
			        <h1 class="text-center headingfont">Welcome to SadaBand Bank</h1>
			        </div>
            <div class="col-12 col-md-10 col-lg-9 form-container my-5">
            
                <form class="needs-validation fw-bold py-5 px-md-3 signupdf" novalidate action="signup" method="post">
                 <h3 class="text-center formheading pb-4">Bank Account Registration Form</h3>
                    <div class="row mb-4">
                        <div class="col-md-6 d-flex pb-1  ">
                            <label for="validationCustom01" class="form-label align-self-center formfont">Firstname:</label>
                            <input type="text" class="form-control bg-transparent align-self-center ms-2 " id="validationCustom01"  name="Firstname" required>
                            <div class="valid-feedback">
                                Looks good!
                            </div>
                        </div>
                        <div class="col-md-6 d-flex pt-1  ">
                            <label for="validationCustom02" class="form-label align-self-center formfont">Lastname:</label>
                            <input type="text" class="form-control bg-transparent ms-2 align-self-center " id="validationCustom02" required name="Lastname">
                            <div class="valid-feedback">
                                Looks good!
                            </div>
                        </div>
                    </div>
                    <div class="row mb-4">
                        <div class="col-md-6  d-flex ">
                          <label for="validationCustom03" class="form-label align-self-center formfont">Street/Apt name:</label>
                          <input type="text" class="form-control  bg-transparent align-self-center ms-2" id="validationCustom03" required name="Address">
                      </div>
                        
                        <div class="col-md-6 d-flex ">
                            <label for="validationCustomUsername" class="form-label align-self-center formfont">Contact:</label>
                            <input type="tel" class="form-control bg-transparent align-self-center ms-2 " id="validationCustomUsername" name="Contact"
                                aria-describedby="inputGroupPrepend" required>
                        </div>
                    </div>
                    
                   
                    <div class="row mb-4">
                       <div class="col-md-6 d-flex pb-1">
							    <label for="state" class="form-label align-self-center formfont">State:</label>
							    <input list="stateList" class="form-control bg-transparent align-self-center ms-2" id="stateInput" required name="State">
							    <datalist id="stateList">
							       <!--  <option value="Choose..."></option> -->
							        <%-- Read states from CSV file and populate the datalist --%>
							        <% 
							            String statesFilePath = application.getRealPath("WEB-INF/data/states_data1.csv");
							            int lineNumber = 0;
							            try (Scanner scanner = new Scanner(new File(statesFilePath))) {
							                while (scanner.hasNextLine()) {
							                    String line = scanner.nextLine().trim();
							                    lineNumber++; // Increment line number
							                    if (lineNumber == 1) {
							                        continue; // Skip the first line
							                    }
							                    // Split the line by commas
							                    String[] parts = line.split(",");
							                    // Print each part as an option in the datalist
							                    for (String part : parts) {
							                        // Trim any leading or trailing whitespace
							                        part = part.trim();
							                        // Print the option tag for each part
							                        out.println("<option value=\"" + part + "\">");
							                    }
							                }
							            } catch (FileNotFoundException e) {
							                e.printStackTrace();
							            }
							        %>
							    </datalist>
							    <div class="invalid-feedback">
							        Please select a valid state.
							    </div>
							</div>
	                       <div class="col-md-6 d-flex pt-1 ">
								    <label for="city" class="form-label align-self-center formfont">City:</label>
								    <input list="cityList" class="form-control bg-transparent align-self-center ms-2" id="cityInput" required name="City">
								    <datalist id="cityList">
								    <!--     <option value="Choose..."></option> -->
								        <%-- Read cities from CSV file and populate the datalist --%>
								        <% 
								            String citiesFilePath = application.getRealPath("WEB-INF/data/cities_final.csv");
								            try (Scanner scanner = new Scanner(new File(citiesFilePath))) {
								                int lineNo = 0;
								                while (scanner.hasNextLine()) {
								                    String line = scanner.nextLine().trim();
								                    lineNo++; // Increment line number
								                    if (lineNo == 1) {
								                        continue; // Skip the first line
								                    }
								                    // Split the line by commas
								                    String[] parts = line.split(",");
								                    // Print each part as an option in the datalist
								                    for (String part : parts) {
								                        // Trim any leading or trailing whitespace
								                        part = part.trim();
								                        // Print the option tag for each part
								                        out.println("<option value=\"" + part + "\">");
								                    }
								                }
								            } catch (FileNotFoundException e) {
								                e.printStackTrace();
								            }
								        %>
								    </datalist>
								    <div class="invalid-feedback">
								        Please select a valid city.
								    </div>
								</div>

                    </div>
                    <div class="row mb-4">
                        <div class="col-md-6 d-flex pb-1">
                            <label for="validationCustom05" class="form-label align-self-center formfont">Zip:</label>
                            <input type="text" class="form-control bg-transparent align-self-center ms-2" id="validationCustom05" required name="Zip">
                            <div class="invalid-feedback">
                                Please provide a valid zip.
                            </div>
                        </div>
                        <div class="col-md-6 d-flex pt-1">
                            <label for="validationCustom04" class="form-label align-self-center formfont">Country:</label>
                            <select class="form-select bg-transparent align-self-center ms-2" id="validationCustom04" required name="Country">
                                <option selected disabled value="">Choose...</option>
                                <option class="formfont">INDIA</option>
                            </select>
                        </div>
                    </div>
                    <div class="row mb-4">
                        <div class="col-md-6 d-flex pb-1">
                            <label for="validationCustom04" class="form-label align-self-center formfont">Marital Status:</label>
                            <select class="form-select bg-transparent align-self-center ms-2" id="validationCustom04" required name="Mstatus">
                                <option selected disabled value="">Choose...</option>
                                <option class="formfont">Single</option>
                                <option class="formfont">Married</option>
                                <option class="formfont">Divorced</option>
                                <option class="formfont">Widow</option>
                                <option class="formfont">Separated</option>
                            </select>
                        </div>
                        <div class="col-md-6 d-flex pt-1">
                            <label for="validationCustom04" class="form-label align-self-center formfont">Occupation:</label>
                            <select class="form-select bg-transparent align-self-center ms-2" id="validationCustom04" required name="Occupation">
                                <option selected disabled value="">Choose...</option>
                                <option class="formfont">Service</option>
                                <option class="formfont">Business</option>
                            </select>
                        </div>
                    </div>
                    <div class="row mb-4">
                       <div class="col-md-6 d-flex">
                            <label for="validationCustomerUsername" class="form-label align-self-center formfont">Password:</label>
                            <input type="password" class="form-control bg-transparent align-self-center ms-2" id="validationCustomerUsername"  name="password"
                                aria-describedby="inputGroupPrepend" pattern="^(?=.*[A-Z])(?=.*\d)(?=.*[!@#$%^&*()])[A-Za-z\d!@#$%^&*()]{8,}$" required> 
                              
                        </div>
                        

                        <div class="col-md-6 d-flex">
                          <label for="confirmPassword" class="form-label align-self-center formfont">Confirm Password:</label>
                          <input type="password" class="form-control bg-transparent align-self-center ms-2" id="confirmPassword"  name="Cpassword"
                              aria-describedby="inputGroupPrepend" required> 
                      </div>
                    </div>
                    <div class="col-6 ">
                    
                    <div id="passwordRequirements"  style="display: none;" class="border border-1"></div> 
                    </div>
                    <div class="form-check mb-4 d-flex justify-content-center ">
                        <input class="form-check-input   bg-transparent border border-1 mt-2" type="checkbox" value="" id="invalidCheck" required>
                        <label class="form-check-label formfont px-2 fs-5  " for="invalidCheck">
                        
                            Agree to terms and conditions
                        </label>
                        <div class="invalid-feedback">
                            You must agree before submitting.
                        </div>
                    </div>
                    <div class="text-center">
                        <button class="  button mb-3 buttonfont " type="submit">Sign Up</button>
                    </div>
                </form>
                    <h4 class="py-3 formfont text-center">Already have an account? Login Now!</h4>
                <div class="mb-3 d-flex justify-content-center">
                                    <button class="btn p-2  ">
                                    <a href="Login.html" class="text-white buttonfont stretched-link"></a>
									  <div class="buttonfont p-2" >Login</div>
								</button>
								</div>
                    
            </div>
        </div>
        </div>
    </div><!--end of main container-->
 <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-kenU1KFdBIe4zVF0s0G1M5b4hcpxyD9F7jL+jjXkk+Q2h455rYXK/7HAuoJl+0I4" crossorigin="anonymous"></script>
<script>
(() => {
	  'use strict'

	  // Fetch all the forms we want to apply custom Bootstrap validation styles to
	  const forms = document.querySelectorAll('.needs-validation')

	  // Loop over them and prevent submission
	  Array.from(forms).forEach(form => {
	    form.addEventListener('submit', event => {
        const passwordInput = form.querySelector('#validationCustomerUsername');
            const confirmPasswordInput = form.querySelector('#confirmPassword');
            const password = passwordInput.value;
            const confirmPassword = confirmPasswordInput.value;
            // Check if passwords match
            if (password !== confirmPassword) {
                confirmPasswordInput.setCustomValidity("Passwords do not match");
            } else {
                confirmPasswordInput.setCustomValidity('');
            }
	      if (!form.checkValidity()) {
	        event.preventDefault()
	        event.stopPropagation()
	      }

	      form.classList.add('was-validated')
	    }, false)
	  })
	})()
</script>




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
<script>
//Function to show password requirements message
function showPasswordRequirements() {
  var requirementsDiv = document.getElementById('passwordRequirements');
  requirementsDiv.textContent = "Password must contain at least one uppercase letter, one number, and one special character.";
  requirementsDiv.style.display = 'block';
}

// Function to hide password requirements message
function hidePasswordRequirements() {
  var requirementsDiv = document.getElementById('passwordRequirements');
  requirementsDiv.style.display = 'none';
}

// Event listener to show password requirements message on focus
document.getElementById('validationCustomerUsername').addEventListener('focus', function() {
  showPasswordRequirements();
});

// Event listener to hide password requirements message on blur
document.getElementById('validationCustomerUsername').addEventListener('blur', function() {
  hidePasswordRequirements();
});

</script>



   
    
</body>
</html>
