<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="ISO-8859-1">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="icon" type="image/png" href="../images/ramen.png">
<title>Register</title>
<link
	href="https://fonts.googleapis.com/css2?family=Lobster&family=Rubik&display=swap"
	rel="stylesheet">
<link rel="stylesheet"
	href="https://unpkg.com/bootstrap@5.3.3/dist/css/bootstrap.min.css">
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
<link rel="stylesheet" href="../css/register.css">
</head>
<nav class="navbar navbar-expand-lg" style="height: 70px !important;">
	<div class="container">
		<div class="navbar-content">

			<p class="navbar-brand" style="margin-top: 20px; margin-left: 480px;">
				<img src="../images/ramen.png" alt="Logo"
					style="width: 40px; height: 40px; margin-right: 5px; margin-bottom: 10px;">
				Canteen
			</p>


		</div>
	</div>

</nav>
<!-- End Of Navbar -->
<section class="py-3 py-md-5"
	style="background: url('../images/bg.jpg') no-repeat center center; background-size: cover;">
	<div class="container">
		<div class="row justify-content-center">
			<div class="col-12 col-sm-10 col-md-8 col-lg-6 col-xl-5 col-xxl-4">
				<div class="card border border-light-subtle rounded-3 shadow-sm">
					<div class="card-body p-3 p-md-4 p-xl-5">
						<div class="text-center mb-3">
							<img src="../images/ramen.png" alt="Logo" class="logo">
						</div>
						<h1 class="fs-6 fw-normal text-center"
							style="color: black; margin-bottom: 10px;">Register</h1>
						<!-- Error message display -->
						<c:if test="${param.error == 'emailExists'}">
							<div class="alert alert-danger" role="alert"
								style="color: black;">Email already exists.</div>
						</c:if>
						<c:if test="${param.error == 'usernameExists'}">
							<div class="alert alert-danger" role="alert"
								style="color: black;">Username already exists.</div>
						</c:if>
						<c:if test="${param.error == 'mobileExists'}">
							<div class="alert alert-danger" role="alert"
								style="color: black;">Mobile number already exists.</div>
						</c:if>
						<c:if test="${param.error == 'failed'}">
							<div class="alert alert-danger" role="alert"
								style="color: black;">Registration failed. Please try
								again.</div>
						</c:if>
						<c:if test="${param.error == 'db'}">
							<div class="alert alert-danger" role="alert"
								style="color: black;">Server down. Please try later.</div>
						</c:if>
						<form id="registerForm" action="../RegisterServlet" method="post">
							<div class="row gy-2 overflow-hidden">
								<div class="col-12">
									<div class="form-floating mb-3">
										<input type="text" class="form-control" name="name" id="name"
											style="color: black;" oninput="validateUsername()"> <label
											for="name" class="form-label" style="color: black;">Username</label>
									</div>
									<div id="nameError" class="text-danger"></div>
								</div>
								<div class="col-12">
									<div class="form-floating mb-3">
										<input type="email" class="form-control" name="email"
											id="email" style="color: black;" oninput="validateEmail()">
										<label for="email" class="form-label" style="color: black;">Email</label>
									</div>
									<div id="emailError" class="text-danger"></div>
								</div>
								<div class="col-12">
									<div class="form-floating mb-3">
										<input type="text" class="form-control" name="mobile"
											id="mobile" style="color: black;" oninput="validateMobile()">
										<label for="mobile" class="form-label" style="color: black;">Mobile
											Number</label>
									</div>
									<div id="mobileError" class="text-danger"></div>
								</div>
								<div class="col-12">
									<div class="form-floating mb-3 password-container"
										id="passwordContainer">
										<input type="password" class="form-control" name="password"
											id="password" style="color: black;"
											oninput="validatePassword()"> <label for="password"
											class="form-label" style="color: black;">Password</label> <i
											class="fas fa-eye eye-icon" id="togglePassword"></i>
									</div>
									<div id="passwordError" class="text-danger"
										style="margin-top: 2px;"></div>
								</div>
								<div class="col-12">
									<div class="form-floating mb-3 password-container"
										id="confirmPasswordContainer">
										<input type="password" class="form-control"
											name="confirmPassword" id="confirmPassword"
											style="color: black;" oninput="validateConfirmPassword()">
										<label for="confirmPassword" class="form-label"
											style="color: black;">Confirm Password</label> <i
											class="fas fa-eye eye-icon" id="toggleConfirmPassword"></i>
									</div>
									<div id="confirmPasswordError" class="text-danger"></div>
								</div>
								<div class="col-12">
									<div class="d-grid my-3">
										<button class="btn btn-primary btn-lg" type="submit"
											id="registerButton"
											style="background-color: crimson; border-color: crimson; color: white;">Register</button>
									</div>
								</div>
								<div class="col-12">
									<p class="m-0 text-center" style="color: black;">
										Already have an account? <a href="../login/login.jsp"
											class="link-primary text-decoration-none"
											style="color: crimson !important;">Sign in</a>
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

<script
	src="https://unpkg.com/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
<script>
	document
			.addEventListener(
					'DOMContentLoaded',
					function() {

						let isEmailValid = false;
						let isUsernameValid = false;
						let isMobileValid = false;
						let isPasswordValid = false;
						let isConfirmPasswordValid = false;

						const emailRegex = /^[^\s@]+@[^\s@]+\.(com|in)$/;
						const usernameRegex = /^[A-Za-z]{3,10}$/;
						const passwordRegex = /^(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,15}$/;
						const mobileRegex = /^[6789]\d{9}$/;

						function validateEmail() {
							const email = document.getElementById('email').value;
							const emailError = document
									.getElementById('emailError');
							if (!emailRegex.test(email)) {
								emailError.textContent = 'Invalid email';
								emailError.classList.add('show');
								isEmailValid = false;
							} else {
								emailError.textContent = '';
								emailError.classList.remove('show');
								isEmailValid = true;
							}
							checkAllValidations();
						}

						function validateUsername() {
							const username = document.getElementById('name').value;
							const nameError = document
									.getElementById('nameError');
							if (!usernameRegex.test(username)) {
								nameError.textContent = 'Username must be between 3 and 10 letters';
								nameError.classList.add('show');
								isUsernameValid = false;
							} else {
								nameError.textContent = '';
								nameError.classList.remove('show');
								isUsernameValid = true;
							}
							checkAllValidations();
						}

						function validateMobile() {
							const mobile = document.getElementById('mobile').value;
							const mobileError = document
									.getElementById('mobileError');
							if (!mobileRegex.test(mobile)) {
								mobileError.textContent = 'Please enter a valid Indian number';
								mobileError.classList.add('show');
								isMobileValid = false;
							} else {
								mobileError.textContent = '';
								mobileError.classList.remove('show');
								isMobileValid = true;
							}
							checkAllValidations();
						}

						function validatePassword() {
							const password = document
									.getElementById('password').value;
							const passwordError = document
									.getElementById('passwordError');
							if (!passwordRegex.test(password)) {
								passwordError.textContent = 'Password must be 8-15 characters long, contain at least one uppercase letter, one digit, and one special character';
								passwordError.classList.add('show');
								isPasswordValid = false;
							} else {
								passwordError.textContent = '';
								passwordError.classList.remove('show');
								isPasswordValid = true;
							}
							validateConfirmPassword();
						}

						function validateConfirmPassword() {
							const password = document
									.getElementById('password').value;
							const confirmPassword = document
									.getElementById('confirmPassword').value;
							const confirmPasswordError = document
									.getElementById('confirmPasswordError');
							if (password !== confirmPassword) {
								confirmPasswordError.textContent = 'Passwords do not match';
								confirmPasswordError.classList.add('show');
								isConfirmPasswordValid = false;
							} else {
								confirmPasswordError.textContent = '';
								confirmPasswordError.classList.remove('show');
								isConfirmPasswordValid = true;
							}
							checkAllValidations();
						}

						function checkAllValidations() {
							const registerButton = document
									.getElementById('registerButton');
							if (isEmailValid && isUsernameValid
									&& isPasswordValid
									&& isConfirmPasswordValid && isMobileValid) {
								registerButton.classList.add('show');
							} else {
								registerButton.classList.remove('show');
							}
						}

						function toggleEyeIconVisibility() {
							const passwordField = document
									.getElementById('password');
							const confirmPasswordField = document
									.getElementById('confirmPassword');
							const passwordContainer = document
									.getElementById('passwordContainer');
							const confirmPasswordContainer = document
									.getElementById('confirmPasswordContainer');

							if (passwordField.value) {
								passwordContainer.classList.add('show-eye');
							} else {
								passwordContainer.classList.remove('show-eye');
							}
							if (confirmPasswordField.value) {
								confirmPasswordContainer.classList
										.add('show-eye');
							} else {
								confirmPasswordContainer.classList
										.remove('show-eye');
							}
						}

						function togglePasswordVisibility() {
							const passwordField = document
									.getElementById('password');
							const eyeIcon = document
									.getElementById('togglePassword');

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
						function toggleConfirmPasswordVisibility() {
							const confirmPasswordField = document
									.getElementById('confirmPassword');
							const eyeIconCP = document
									.getElementById('toggleConfirmPassword');
							if (confirmPasswordField.type === 'password') {
								confirmPasswordField.type = 'text';
								eyeIconCP.classList.remove('fa-eye');
								eyeIconCP.classList.add('fa-eye-slash');
							} else {
								confirmPasswordField.type = 'password';
								eyeIconCP.classList.remove('fa-eye-slash');
								eyeIconCP.classList.add('fa-eye');
							}
						}

						document.getElementById('email').addEventListener(
								'input', validateEmail);
						document.getElementById('mobile').addEventListener(
								'input', validateMobile);
						document.getElementById('name').addEventListener(
								'input', validateUsername);
						document.getElementById('password').addEventListener(
								'input', function() {
									validatePassword();
									toggleEyeIconVisibility();
								});
						document.getElementById('confirmPassword')
								.addEventListener('input', function() {
									validateConfirmPassword();
									toggleEyeIconVisibility();
								});
						document.getElementById('togglePassword')
								.addEventListener('click',
										togglePasswordVisibility);
						document.getElementById('toggleConfirmPassword')
								.addEventListener('click',
										toggleConfirmPasswordVisibility);

						toggleEyeIconVisibility();
					});
</script>
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

</body>
</html>