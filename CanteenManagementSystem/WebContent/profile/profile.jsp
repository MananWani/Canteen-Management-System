<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" isELIgnored="false"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!doctype html>
<html lang="en">
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="preconnect" href="https://fonts.gstatic.com">
<link rel="icon" type="image/png" href="../images/ramen.png">

<link
	href="https://fonts.googleapis.com/css2?family=Lobster&family=Rubik&display=swap"
	rel="stylesheet">
<link rel="stylesheet"
	href="https://unpkg.com/bootstrap@5.3.3/dist/css/bootstrap.min.css">
<link href="../css/home.css" rel="stylesheet" />
<style>
body {
	font-family: 'Rubik', cursive;
}
</style>
<script src="../js/changepassword.js" type="text/javascript"></script>
<title>Profile</title>
</head>
<body>

	<!-- Navbar -->
	<nav class="navbar navbar-expand-lg" style="height: 70px !important;">
		<div class="container">
			<p class="navbar-brand" style="margin-top: 14px">
				<img src="../images/ramen.png" alt="Logo" class="logo"
					style="width: 40px; height: 40px; margin-right: 5px; margin-bottom: 10px;">
				Canteen
			</p>
			<div class="collapse navbar-collapse" id="navbarScroll">
				<ul class="navbar-nav m-auto my-2 my-lg-0">
					<li class="nav-item"><a class="nav-link"
						href="../home/home.jsp">Home</a></li>
					<li class="nav-item"><a class="nav-link active"
						href="../MenuServlet">Menu</a></li>
					<li class="nav-item"><a class="nav-link"
						href="../OrderServlet">Orders</a></li>
					<li class="nav-item"><a class="nav-link" href="../CartServlet">
							Cart</a></li>
					<li class="nav-item"><a class="nav-link active"
						href="../ProfileServlet">Profile</a></li>
				</ul>
				<a href="../LogoutServlet" class="btn btn-primary">Logout</a>
			</div>
		</div>
	</nav>
	<!-- End Of Navbar -->

	<c:if test="${param.error == 'notFound'}">
		<div class="alert alert-danger text-center" role="alert"
			style="color: black;">Record not found, Please try later.</div>
	</c:if>
	<c:if test="${param.error == 'db'}">
		<div class="alert alert-danger text-center" role="alert"
			style="color: black;">Server down. Please try later.</div>
	</c:if>
	<c:if test="${param.error == 'incorrectCurrentPassword'}">
		<div class="alert alert-danger text-center" role="alert"
			style="color: black;">Current password is incorrect.</div>
	</c:if>
	<c:if test="${param.success == 'changed'}">
		<div class="alert alert-success mt-3 text-center">Password
			changed successfully!</div>
	</c:if>
	<c:if test="${param.error == 'updateFailed'}">
		<div class="alert alert-danger text-center" role="alert"
			style="color: black;">Amount not added, Please try again.</div>
	</c:if>
	<c:if test="${param.success == 'balanceUpdated'}">
		<div class="alert alert-success mt-3 text-center">Amount added
			successfully!</div>
	</c:if>
	<!-- Main -->
	<section class="profile" id="profile">
		<div class="container py-4">
			<div class="row">
				<div class="col-lg-8 mx-auto">
					<h2 class="text-center mb-4">User Profile</h2>
					<div class="card">
						<div class="card-body">
							<!-- Wallet Balance Section -->
							<div class="row">
								<div class="col-md-6 mb-3">
									<h4>Wallet Balance:</h4>
									<p>Rs. ${currentBalance}</p>
									<form action="../WalletHistoryServlet" method="post"
										class="d-inline">
										<button type="submit" class="btn0" style="width: 150px;">Wallet
											History</button>
									</form>
								</div>

								<div class="col-md-5 mb-3">
									<h4>Add Money to Wallet:</h4>
									<form action="../AddMoneyServlet" method="post"
										class="d-flex flex-column">
										<div class="mb-3">
											<label for="amountToAdd" class="form-label">Amount</label> <input
												type="number" id="amountToAdd" name="amountToAdd"
												class="form-control" min="100" max="2000" required />
										</div>
										<button type="submit" class="btn0" style="width: 280px;">Add
											Money</button>
									</form>
								</div>
							</div>
							<!-- End Wallet Balance Section -->

							<!-- Change Password Section -->
							<form method="post" action="../ProfileServlet"
								onsubmit="return validate();">
								<div class="mb-3">
									<label for="username" class="form-label">Username</label> <input
										type="text" class="form-control" id="username"
										value="${username}" readonly />
								</div>
								<div class="mb-3">
									<label for="email" class="form-label">Email address</label> <input
										type="email" class="form-control" id="email" value="${mail}"
										readonly />
								</div>
								<div class="mb-3">
									<label for="mobile" class="form-label">Mobile number</label> <input
										type="text" class="form-control" id="mobile" value="${mobile}"
										readonly />
								</div>
								<div class="mb-3">
									<label for="current-password" class="form-label">Current
										Password</label> <input type="password" class="form-control"
										id="current-password" name="current-password"
										placeholder="Enter your current password" />
									<div id="currentPasswordError" class="text-danger"></div>
								</div>
								<div class="mb-3">
									<label for="new-password" class="form-label">New
										Password</label> <input type="password" class="form-control"
										id="new-password" name="new-password"
										placeholder="Enter new password" />
									<div id="newPasswordError" class="text-danger"></div>
								</div>
								<div class="mb-3">
									<label for="confirm-password" class="form-label">Confirm
										New Password</label> <input type="password" class="form-control"
										id="confirm-password" name="confirm-password"
										placeholder="Confirm new password" />
									<div id="confirmPasswordError" class="text-danger"></div>
								</div>
								<button type="submit" class="btn btn-primary">Change
									Password</button>
							</form>
							<!-- End Change Password Section -->
						</div>
					</div>
				</div>
			</div>
		</div>
	</section>
	<!-- End Of Main -->


	<%@ include file="../footer/footer.jsp"%>

	<script
		src="https://unpkg.com/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
