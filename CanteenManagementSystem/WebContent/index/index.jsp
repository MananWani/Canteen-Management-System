<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!doctype html>
<html lang="en">
<head>
<link rel="icon" type="image/png" href="../images/ramen.png">

<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="preconnect" href="https://fonts.gstatic.com">
<link
	href="https://fonts.googleapis.com/css2?family=Lobster&family=Rubik&display=swap"
	rel="stylesheet">
<link rel="stylesheet"
	href="https://unpkg.com/bootstrap@5.3.3/dist/css/bootstrap.min.css">
<link rel="stylesheet" href="../css/index.css">

<title>Welcome</title>
</head>
<body>

	<!-- Navbar -->
	<nav class="navbar navbar-expand-lg" style="height: 70px !important;">
		<div class="container">
			<div class="navbar-content">
				<a class="btn0" style="margin-top: 13px;"
					href="../register/register.jsp">Register</a>
				<p class="navbar-brand" style="margin-top: 6px">
					<img src="../images/ramen.png" alt="Logo" class="logo"
						style="width: 40px; height: 40px; margin-right: 5px; margin-bottom: 10px;">
					Canteen
				</p>
				<div class="navbar-buttons">
					<a class="btn0" style="margin-top: 13px;" href="../login/login.jsp">Login</a>

				</div>
			</div>
		</div>
	</nav>
	<!-- End Of Navbar -->
	<c:if test="${param.success == 'loggedOut'}">
		<div class="alert alert-success mt-3 text-center">Logged out successfully,
			Thank you for using Canteen!</div>
	</c:if>
	<!--Main -->
	<section class="main" id="main">
		<div class="container">
			<div class="row">
				<div class="col-lg-12 pt-7 text-center">
					<h1>
						Eat good,<br>Feel good !
					</h1>
				</div>
			</div>
		</div>
	</section>
	<!--End Of Main -->


	<%@ include file="../footer/footer.jsp"%>

</body>
</html>