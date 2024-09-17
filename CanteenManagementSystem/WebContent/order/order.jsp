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
						href="../home/home.jsp">Home</a></li>
					<li class="nav-item"><a class="nav-link active"
					href="../MenuServlet">Menu</a></li>
					<li class="nav-item"><a class="nav-link active"
						href="../OrderServlet">Orders</a></li>
					<li class="nav-item"><a class="nav-link"
						href="../CartServlet"> Cart</a></li>

					<li class="nav-item"><a class="nav-link"
						href="../ProfileServlet">Profile</a></li>
				</ul>
				<a class="btn0" href="../LogoutServlet">Logout</a>
			</div>
		</div>
	</nav>
	<!-- End Of Navbar -->
	<c:if test="${param.error == 'notFound'}">
		<div class="alert alert-danger" role="alert" style="color: black;">Please try again.</div>
	</c:if>
	<c:if test="${param.error == 'db'}">
		<div class="alert alert-danger" role="alert" style="color: black;">Please try again.</div>
	</c:if>
	<c:if test="${param.success == 'orderSuccess'}">
		<div class="alert alert-success mt-3 text-center">Order Placed Successfully</div>
	</c:if>
	<!-- Main -->
<section class="orders" id="orders">
    <div class="container py-4">
        <h2 class="text-center mb-4">Your Orders</h2>
       <c:if test="${not empty orderList}">
    <div class="row">
        <div class="col-lg-10 mx-auto">
            <div class="card">
                <div class="card-body">
                    <!-- Table to display orders -->
                    <table class="table table-bordered">
                        <thead>
                            <tr>
                                <th>Date</th>
                                <th style="width: 180px;">Total Amount Paid</th> <!-- Increased width -->
                                <th>Order Status</th>
                                <th>Items</th>
                                <th style="width: 200px;">Description</th> <!-- Decreased width -->
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="order" items="${orderList}">
                                <tr>
                                    <td>${order.orderDate}</td>
                                    <td style="width: 180px;">Rs. ${order.orderTotalAmount}</td> <!-- Increased width -->
                                    <td>${order.orderStatus}</td>
                                    <td>
                                        <!-- Start nested table for OrderItems -->
                                        <table class="table table-sm table-bordered">
                                            <thead>
                                                <tr>
                                                    <th>Item Name</th>
                                                    <th>Quantity</th>
                                                </tr>
                                            </thead>
                                            <tbody>
                                                <c:forEach var="item" items="${order.orderItem}">
                                                    <tr>
                                                        <td>${item.orderItemName}</td>
                                                        <td>${item.orderItemQuantity}</td>
                                                    </tr>
                                                </c:forEach>
                                            </tbody>
                                        </table>
                                    </td>
                                    <td style="width: 200px;">${order.orderDescription}</td> <!-- Decreased width -->
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



	<%@ include file="../footer/footer.jsp"%>

	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
