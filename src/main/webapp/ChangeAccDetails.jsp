<!-- <%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%> -->
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Change Account Details</title>
    <link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Agbalumo&family=Anta&family=Madimi+One&family=Montserrat+Alternates:ital,wght@0,100;0,200;0,300;0,400;0,500;0,600;0,700;0,800;0,900;1,100;1,200;1,300;1,400;1,500;1,600;1,700;1,800;1,900&family=Platypi:ital,wght@0,300..800;1,300..800&display=swap" rel="stylesheet">
 
     <link rel="stylesheet" href="./css/style.css">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-rbsA2VBKQhggwzxH7pPCaAqO46MgnOM80zW1RWuH61DGLwZJEdK2Kadq2F9CUG65" crossorigin="anonymous">
   <style>
      .Btn {
  width: 130px;
  height: 40px;
  display: flex;
  align-items: center;
  justify-content: center;
  background-color: rgb(15, 15, 15);
  border: none;
  color: white;
  font-weight: 600;
  gap: 8px;
  cursor: pointer;
  box-shadow: 5px 5px 10px rgba(0, 0, 0, 0.103);
  position: relative;
  overflow: hidden;
  transition-duration: .3s;
}

.svgIcon {
  width: 16px;
}

.svgIcon path {
  fill: white;
}

.Btn::before {
  width: 130px;
  height: 130px;
  position: absolute;
  content: "";
  background-color: white;
  border-radius: 50%;
  left: -100%;
  top: 0;
  transition-duration: .3s;
  mix-blend-mode: difference;
}

.Btn:hover::before {
  transition-duration: .3s;
  transform: translate(100%,-50%);
  border-radius: 0;
}

.Btn:active {
  transform: translate(5px,5px);
  transition-duration: .3s;
}
    
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

    <div class="container-fluid p-0 g-0 ">
        <div class="container-fluid changDImg" >
            <div class="row">
                <div class="col-12 text-center pt-5 text-white headingfont">
                  <h1 class="">SadaBand Bank</h1>
                <h3>Extra Ordinary Services</h3>
                </div>
                <div class="row pe-0 justify-content-center my-5">
                <div class="col-12 col-md-10 col-lg-8 col-xxl-7">
                    <form action="updateDetails" method="post" class="text-white text-center px-lg-5  changeDBF  ">
                     <h2 class=" py-3 formheading">Change Account Details</h2>
                      <div class="py-2 d-md-flex align-items-center">
                        <label for="newPassword " class="formfont" >New Password:</label>
                        <input type="password" class="ms- mt-2 form-control  bg-transparent me-5 " id="newPassword" name="newPassword">
                      </div>
                      <div class="py-2 d-md-flex align-items-center">
                        <label for="newPhone" class="formfont">New Phone:</label>
                        <input type="text" class="bg-transparent form-control ms- mt-2 me-5 " id="newPhone" name="newPhone">
                    </div>
                    <div class="py-2 d-md-flex align-items-center">
                        <label for="newFirstname" class="formfont">New First Name:</label>
                        <input type="text" class="bg-transparent form-control ms- mt-2 me-5 " id="newFirstname" name="newFirstname">
                      </div>
                      <div class="py-2 d-md-flex align-items-center">
                        <label for="newLastname " class="formfont">New Last Name:</label>
                        <input type="text" class="bg-transparent form-control ms- mt-2 me-5 " id="newLastname" name="newLastname">
                      </div>
                     <div class="py-3 d-flex justify-content-center">
		                 <button class="Btn" type="submit">
							  Proceed
							  <svg class="svgIcon" viewBox="0 0 576 512"><path d="M512 80c8.8 0 16 7.2 16 16v32H48V96c0-8.8 7.2-16 16-16H512zm16 144V416c0 8.8-7.2 16-16 16H64c-8.8 0-16-7.2-16-16V224H528zM64 32C28.7 32 0 60.7 0 96V416c0 35.3 28.7 64 64 64H512c35.3 0 64-28.7 64-64V96c0-35.3-28.7-64-64-64H64zm56 304c-13.3 0-24 10.7-24 24s10.7 24 24 24h48c13.3 0 24-10.7 24-24s-10.7-24-24-24H120zm128 0c-13.3 0-24 10.7-24 24s10.7 24 24 24H360c13.3 0 24-10.7 24-24s-10.7-24-24-24H248z"></path></svg>
							</button>
                     
                    </div>
                       
                    </form>
                     <div class="wrapper">
                  <div class="link_wrapper">
                    <a href="Login.html" class="buttonfont">Re-Login Now</a>
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
    </div><!-- end of main -->
</body>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-kenU1KFdBIe4zVF0s0G1M5b4hcpxyD9F7jL+jjXkk+Q2h455rYXK/7HAuoJl+0I4" crossorigin="anonymous"></script>
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
</html>
