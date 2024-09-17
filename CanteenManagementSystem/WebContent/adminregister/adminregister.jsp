<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Register</title>
<link rel="icon" type="image/png" href="../images/ramen.png">

<link rel="stylesheet"
	href="https://unpkg.com/bootstrap@5.3.3/dist/css/bootstrap.min.css">
<script src="../js/register.js"type="text/javascript"></script>
<style>
body {
	font-family: 'Rubik', cursive;
}
.card {
	max-width: 480px;
	margin: 0 auto;
}
.logo {
    display: block;
    margin: 20px auto; 
    width: 120px; 
    height: 100px;	 
}
</style>
</head>
<body>
	<section class="bg-light py-3 py-md-5">
		<div class="container">
			<div class="row justify-content-center">
				<div class="col-12">
					<div class="card border border-light-subtle rounded-3 shadow-sm">
						<div class="card-body p-3 p-md-4 p-xl-5">
							<div class="text-center mb-3">
								<img src="../images/ramen.png" alt="Logo" class="logo">
							</div>
							<h1 class="fs-6 fw-normal text-center text-secondary mb-4" style="color: black !important;">Register</h1>
							<!-- Error message display -->
							<c:if test="${param.error == 'emailExists'}">
								<div class="alert alert-danger" role="alert">Email already
									exists.</div>
							</c:if>
							<c:if test="${param.error == 'usernameExists'}">
								<div class="alert alert-danger" role="alert">Username
									already exists.</div>
							</c:if>
							<c:if test="${param.error == 'failed'}">
								<div class="alert alert-danger" role="alert">Registration
									failed. Please try again</div>
							</c:if>
							<c:if test="${param.error == 'db'}">
								<div class="alert alert-danger" role="alert">Server down.
									Please try later.</div>
							</c:if>
							<form action="../AdminRegisterServlet" method="post"
								onsubmit="return validateRegistration();">
								<div class="row gy-2 overflow-hidden">
									<div class="col-12">
										<div class="form-floating mb-3">
											<input type="text" class="form-control" name="name" id="name">
											<label for="name" class="form-label" style="color: black !important;">Name</label>
											<div id="nameError" class="text-danger"></div>
										</div>
									</div>
									<div class="col-12">
										<div class="form-floating mb-3">
											<input type="email" class="form-control" name="email"
												id="email"> <label for="email" class="form-label" style="color: black !important;">Email</label>
											<div id="emailError" class="text-danger"></div>
										</div>
									</div>
									<div class="col-12">
										<div class="form-floating mb-3">
											<input type="password" class="form-control" name="password"
												id="password"> <label for="password"
												class="form-label" style="color: black !important;">Password</label>
											<div id="passwordError" class="text-danger"></div>
										</div>
									</div>
									<div class="col-12">
										<div class="form-floating mb-3">
											<input type="password" class="form-control"
												name="confirmPassword" id="confirmPassword"> <label
												for="confirmPassword" class="form-label" style="color: black !important;">Confirm
												Password</label>
											<div id="confirmPasswordError" class="text-danger"></div>
										</div>
									</div>
									<div class="col-12">
										<div class="d-grid my-3">
											<button class="btn btn-primary btn-lg"
												style="background-color: crimson; border-color: crimson; color: white;"
												type="submit">Register</button>
										</div>
									</div>
									
								</div>
							</form>
						</div>
					</div>
				</div>
			</div>
		</div>
	</section>
	
		<script src="https://unpkg.com/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
	
</body>
</html>