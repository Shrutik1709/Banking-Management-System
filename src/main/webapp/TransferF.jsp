<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Transfer Funds</title>
    <link rel="stylesheet" href="./css/style.css">
    <link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Anta&family=Madimi+One&family=Montserrat+Alternates:ital,wght@0,100;0,200;0,300;0,400;0,500;0,600;0,700;0,800;0,900;1,100;1,200;1,300;1,400;1,500;1,600;1,700;1,800;1,900&family=Platypi:ital,wght@0,300..800;1,300..800&display=swap" rel="stylesheet">
    
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-rbsA2VBKQhggwzxH7pPCaAqO46MgnOM80zW1RWuH61DGLwZJEdK2Kadq2F9CUG65" crossorigin="anonymous">
    <style>
  button {
  background: royalblue;
  color: white;
  padding: 0.7em 1em;
  padding-left: 0.9em;
  display: flex;
  align-items: center;
  border: none;
  border-radius: 16px;
  overflow: hidden;
  transition: all 0.2s;
  cursor: pointer;
}

button span {
  display: block;
  margin-left: 0.3em;
  transition: all 0.3s ease-in-out;
}

button svg {
  display: block;
  transform-origin: center center;
  transition: transform 0.3s ease-in-out;
}

button:hover .svg-wrapper {
  animation: fly-1 0.6s ease-in-out infinite alternate;
}

button:hover svg {
  transform: translateX(1.9em) rotate(45deg) scale(1.1);
}

button:hover span {
  transform: translateX(6em);
}

button:active {
  transform: scale(0.95);
}

@keyframes fly-1 {
  from {
    transform: translateY(0.1em);
  }

  to {
    transform: translateY(-0.1em);
  }
}
  
    .wrapper{
  position: absolute;
  top: 100%;
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
</head>
<body>

<div class="modal fade" id="errorModal" tabindex="-1" aria-labelledby="errorModalLabel" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title fs-4" id="errorModalLabel ">Error</h5>
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
                    <h5 class="modal-title" id="successModalLabel">Success</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body" id="successMessageContainer">
                    <!-- Success message will be displayed here -->
                </div>
            </div>
        </div>
   </div>
<div class="container-fluid p-0 g-0" id="Tfunds">
    <div class="container-fluid text-white" >
        <div class="row">
            <div class="col-12 text-center my-5">
                <h1 class="headingfont fs-1">SadaBand Bank</h1>
                <h3 class="headingfont">Extra Ordinary Services</h3>
            </div>
            <div class="row justify-content-center">
            <div class="col-12 col-md-10 col-lg-6">
                <form action="transferFunds" method="post" class="text-center px-lg-5 TransF" id="TransferF">
                    <h2 class="py-3 formheading">Transfer Funds</h2>
                    <div class="py-2  d-md-flex align-items-center ">
                        <label for="account_number" class="px-3 formfont">Account Number:</label>
                        <input type="text" class="form-control mt-2 me-5  bg-transparent" id="account_number" name="account_number" required>
                    </div>
                    <div class="py-2  d-md-flex align-items-center  ">
                        <label for="username" class="px-3 formfont">User Name:</label>
                        <input type="text" class="form-control mt-2 me-5  bg-transparent" id="account_number" name="Firstname" required>
                    </div>

                    <div class="py-2  d-md-flex align-items-center  ">
                        <label for="receiver_account" class="px-3 formfont">Receiver's Account Number:</label>
                        <input type="text" class="form-control mt-2 me-5  bg-transparent"  name="receiver_account" required>
                    </div>
                    <div class="py-2  d-md-flex align-items-center  ">
                        <label for="amount" class="px-3 formfont">Amount:</label>
                        <input type="text" class="form-control mt-2 me-5  bg-transparent" id="amount" name="amount" required>
                    </div>
                    <div class="py-2   d-md-flex align-items-center ">
                        <label for="Password" class="px-3 formfont">Enter your Password:</label>
                        <input type="password" class="form-control mt-2 me-5  bg-transparent" name="password" required>
                    </div>
                    <div class="py-3 d-flex justify-content-center ">
                        <!-- <button type="submit" class="btn btn-primary">Proceed</button> -->
                        <button class="buttonfont">
						  <div class="svg-wrapper-1">
						    <div class="svg-wrapper">
						      <svg
						        xmlns="http://www.w3.org/2000/svg"
						        viewBox="0 0 24 24"
						        width="24"
						        height="24">
						        <path fill="none" d="M0 0h24v24H0z"></path>
						        <path
						          fill="currentColor"
						          d="M1.946 9.315c-.522-.174-.527-.455.01-.634l19.087-6.362c.529-.176.832.12.684.638l-5.454 19.086c-.15.529-.455.547-.679.045L12 14l6-8-8 6-8.054-2.685z"></path>
						      </svg>
						    </div>
						  </div>
						  <span class="">TRANSFER</span>
							</button>
                  		  </div>
               			 </form>
		               <div class="wrapper">
							  <div class="link_wrapper">
							    <a href="Home.jsp" class="buttonfont">Back to Home</a>
							    <div class="icon">
							      <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 268.832 268.832">
							        <path d="M265.17 125.577l-80-80c-4.88-4.88-12.796-4.88-17.677 0-4.882 4.882-4.882 12.796 0 17.678l58.66 58.66H12.5c-6.903 0-12.5 5.598-12.5 12.5 0 6.903 5.597 12.5 12.5 12.5h213.654l-58.66 58.662c-4.88 4.882-4.88 12.796 0 17.678 2.44 2.44 5.64 3.66 8.84 3.66s6.398-1.22 8.84-3.66l79.997-80c4.883-4.882 4.883-12.796 0-17.678z"/>
							      </svg>
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

        // Fetch the form element
        const form = document.getElementById('TransferF');

        // Add event listener for form submission
        form.addEventListener('submit', (event) => {
            // Check if form is valid
            if (!form.checkValidity()) {
                event.preventDefault();
                event.stopPropagation();
            }

            // Add Bootstrap validation classes
            form.classList.add('was-validated');
        });
    })();
</script>
  <script>
(() => {
    'use strict';

    const urlParams = new URLSearchParams(window.location.search);
    const errorMessage = urlParams.get('errorMessage');
    const successMessage = urlParams.get('successMessage');

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
