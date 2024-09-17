<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
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
<title>Orders</title>
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
						href="../adminhome/adminhome.jsp">Home</a></li>
					<li class="nav-item"><a class="nav-link" href="../MenuServlet">Menu</a></li>

					<li class="nav-item"><a class="nav-link active"
						href="../OrderServlet">Orders</a></li>
					<li class="nav-item"><a class="nav-link active"
						href="../PaymentServlet">Payments</a></li>
					<li class="nav-item"><a class="nav-link"
						href="../ProfileServlet">Profile</a></li>
				</ul>
				<a class="btn0" href="../LogoutServlet">Logout</a>
			</div>
		</div>
	</nav>
	<!-- End Of Navbar -->
	<c:if test="${param.success == 'success'}">
		<div class="alert alert-success mt-3 text-center">Status changed
			successfully!</div>
	</c:if>
	<!-- Main -->
	<section class="orders" id="orders">
		<div class="container py-3">
			<h2 class="text-center mb-4">Orders</h2>
			<c:if test="${not empty orderList}">
				<div class="row">
					<div class="col-lg-10 mx-auto">
						<div class="card">
							<div class="card-body">
								<table class="table table-bordered">
									<thead>
										<tr>
											<!-- 											<th>Order ID</th> -->
											<th>Date</th>
											<th>Total Amount Paid</th>
											<th>Order Status</th>
											<th>Order Made By</th>
											<th>Actions</th>
										</tr>
									</thead>
									<tbody>
										<c:forEach var="order" items="${orderList}">
											<tr>
												<%-- 												<td>${order.orderId}</td> --%>
												<td>${order.orderDate}</td>
												<td>Rs. ${order.orderTotalAmount}</td>
												<td>${order.orderStatus}</td>
												<td>${order.orderMadeBy}</td>
												<td><c:if test="${order.orderStatus == 'In Progress'}">
														<form action="../UpdateOrderStatusServlet" method="post">
															<input type="hidden" name="orderId"
																value="${order.orderId}"> <select
																name="orderStatus" class="form-control"
																onchange="this.form.submit()">
																<option value="In Progress"
																	${order.orderStatus == 'In Progress' ? 'selected' : ''}>In Progress</option>
																<option value="Completed"
																	${order.orderStatus == 'Completed' ? 'selected' : ''}>Completed</option>
																<option value="Rejected"
																	${order.orderStatus == 'Rejected' ? 'selected' : ''}>Rejected</option>
															</select>
														</form>
													</c:if> <c:if
														test="${order.orderStatus == 'Rejected' || order.orderStatus == 'Completed'}">
                    No action available
                </c:if></td>
											</tr>
										</c:forEach>
									</tbody>

								</table>
							</div>
						</div>
					</div>
				</div>
			</c:if>
			<c:if test="${empty orderList}">
				<p class="text-center">No orders found.</p>
			</c:if>
		</div>
	</section>
	<!-- End Of Main -->


	<%@ include file="../footer/footer.jsp"%>

	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>