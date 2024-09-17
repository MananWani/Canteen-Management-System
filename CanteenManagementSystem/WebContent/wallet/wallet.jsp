<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" isELIgnored="false" session="true"%>
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
<title>Wallet History</title>
<style>
body {
	font-family: 'Rubik', cursive;
}
</style>

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
					<li class="nav-item"><a class="nav-link active"
						href="../OrderServlet">Orders</a></li>

					<li class="nav-item"><a class="nav-link"
						href="../ProfileServlet">Profile</a></li>
				</ul>
				<a class="btn0" href="../LogoutServlet">Logout</a>
			</div>
		</div>
	</nav>
	<!-- End Of Navbar -->
	
	<!-- Main -->
	<section class="wallet" id="wallet">
		<div class="container py-4">
			<h2 class="text-center mb-4">Your Wallet History</h2>
			<c:if test="${not empty walletList}">
				<div class="row">
					<div class="col-lg-10 mx-auto">
						<div class="card">
							<div class="card-body">
								<!-- Table to display orders -->
								<table class="table table-bordered">
									<thead>
										<tr>
											<th>Date</th>
											<th>Previous Amount</th>
											<th>Updated Amount</th>
											<th>Action</th>
										</tr>
									</thead>
									<tbody>
										<c:forEach var="wallet" items="${walletList}">
											<tr>
												<td>${wallet.changeDate}</td>
												<td>Rs. ${wallet.oldWallet}</td>
												<td>Rs. ${wallet.newWallet}</td>
												<td>${wallet.action}</td>
											</tr>
										</c:forEach>
									</tbody>
								</table>
							</div>
						</div>
					</div>
				</div>
			</c:if>
			<c:if test="${empty walletList}">
				<p class="text-center">No history found.</p>
			</c:if>
		</div>
	</section>



	<%@ include file="../footer/footer.jsp"%>

	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
