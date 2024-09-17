<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="en">
<head>
<link rel="icon" type="image/png" href="../images/ramen.png">
<meta charset="ISO-8859-1">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>Login</title>
<link
	href="https://fonts.googleapis.com/css2?family=Lobster&family=Rubik&display=swap"
	rel="stylesheet">
<link rel="stylesheet"
	href="https://unpkg.com/bootstrap@5.3.3/dist/css/bootstrap.min.css">
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
<link href="../css/login.css" rel="stylesheet" />
</head>
<body>
<body>
	<nav class="navbar navbar-expand-lg" style="height: 70px !important;">
		<div class="container">
			<div class="navbar-content">

				<p class="navbar-brand"
					style="margin-top: 20px; margin-left: 480px;">
					<img src="../images/ramen.png" alt="Logo"
						style="width: 40px; height: 40px; margin-right: 5px; margin-bottom: 10px;">
					Canteen
				</p>


			</div>
		</div>

	</nav>
	<!-- End Of Navbar -->
	<section class=" py-3 py-md-5" style="background: url('../images/bg.jpg') no-repeat center center; background-size: cover;">
		<div class="container" >
			<div class="row justify-content-center">
				<div class="col-12 col-sm-10 col-md-8 col-lg-6 col-xl-5 col-xxl-4">
					<div class="card border border-light-subtle rounded-3 shadow-sm">
						<div class="card-body p-3 p-md-4 p-xl-5">
							<div class="text-center mb-3">
								<img src="../images/ramen.png" alt="Logo" class="logo">
							</div>
							<h1 class="fs-6 fw-normal text-center"
								style="color: black; margin-bottom: 10px;">Sign In</h1>
							<!-- Error message display -->
							<c:if test="${param.error == 'invalidUser'}">
								<div class="alert alert-danger" role="alert"
									style="color: black;">Invalid username or password.</div>
							</c:if>
							<c:if test="${param.error == 'db'}">
								<div class="alert alert-danger" role="alert"
									style="color: black;">Server down. Please try later.</div>
							</c:if>
							<c:if test="${param.success == 'userAdded'}">
								<div class="alert alert-success mt-3 text-center">User
									Added, Please login!</div>
							</c:if>
							<form action="../LoginServlet" method="post">
								<div class="row gy-2 overflow-hidden">
									<div class="col-12">
										<div class="form-floating mb-3">
											<input type="text" class="form-control" name="username"
												id="username" style="color: black;"> <label
												for="username" class="form-label" style="color: black;">Username</label>
										</div>

									</div>
									<div class="col-12">
										<div class="form-floating mb-3 password-container">
											<input type="password" class="form-control" name="password"
												id="password" style="color: black;"> <label
												for="password" class="form-label" style="color: black;">Password</label>
											<i class="fas fa-eye eye-icon" id="togglePassword"></i>
										</div>
									</div>

									<div class="col-12">
										<div class="d-grid my-3">
											<button class="btn btn-primary btn-lg" type="submit"
												id="loginButton"
												style="background-color: crimson; border-color: crimson; color: white;">Login</button>
										</div>
									</div>
									<div class="col-12">
										<p class="m-0 text-center" style="color: black;">
											Don't have an account? <a href="../register/register.jsp"
												class="link-primary text-decoration-none"
												style="color: crimson !important;">Sign up</a>
										</p>
									</div>
								</div>
							</form>
						</div>
					</div>
				</div>
			</div>
		</div>
	</section>
	<footer class="footer bg-crimson py-4">
		<div class="container text-center">
			<div class="row justify-content-center">
				<!-- Contact Information -->
				<div class="col-md-5 mb-3 mb-md-0">
					<h5>Contact Us</h5>
					<p>
						Address: MG Road, Bengaluru, Karnataka, 560103<br> Phone:
						(+91) 8384761254<br> Email: <a href="mailto:info@canteen.com">info@canteen.com</a>
					</p>
				</div>
				<!-- About Us -->
				<div class="col-md-5 mb-3 mb-md-0">
					<h5>About Us</h5>
					<p>We are committed to serving delicious food and providing
						excellent service. Our canteen offers a variety of meals to suit
						your taste and dietary needs.</p>
				</div>
			</div>
			<div class="mt-3">
				<p class="mb-0 text-white">&copy; 2024 Canteen. All rights
					reserved.</p>
			</div>
		</div>
	</footer>
	<script>
    document.addEventListener('DOMContentLoaded', function() {
        const username = document.getElementById('username');
        const password = document.getElementById('password');
        const loginButton = document.getElementById('loginButton');
        const passwordField = document.getElementById('password');
        const eyeIcon = document.getElementById('togglePassword');
        const passwordContainer = document.querySelector('.password-container');

        function validateUsername() {
            if (username.value.trim() === '') {
                return false;
            } else if (username.value.length < 3 || username.value.length > 10) {
                return false;
            } else {
                return true;
            }
        }

        function validatePassword() {
            if (password.value.trim() === '') {
                return false;
            } else if (password.value.length < 8) {
                return false;
            } else {
                return true;
            }
        }

        function updateButtonState() {
            if (validateUsername() && validatePassword()) {
                loginButton.classList.add('show');
            } else {
                loginButton.classList.remove('show');
            }
        }

        function toggleEyeIconVisibility() {
            if (passwordField.value) {
                passwordContainer.classList.add('show-eye');
            } else {
                passwordContainer.classList.remove('show-eye');
            }
        }

        function togglePasswordVisibility() {
            if (passwordField.type === 'password') {
                passwordField.type = 'text';
                eyeIcon.classList.remove('fa-eye');
                eyeIcon.classList.add('fa-eye-slash');
            } else {
                passwordField.type = 'password';
                eyeIcon.classList.remove('fa-eye-slash');
                eyeIcon.classList.add('fa-eye');
            }
        }

        username.addEventListener('input', updateButtonState);
        password.addEventListener('input', function() {
            updateButtonState();
            toggleEyeIconVisibility();
        });

        eyeIcon.addEventListener('click', togglePasswordVisibility);

        toggleEyeIconVisibility();
    });
</script>
	<script
		src="https://unpkg.com/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
			
		
</body>
</html>
