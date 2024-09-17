<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" isELIgnored="false" session="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page
	import="java.util.Map, java.math.BigDecimal,com.crimsonlogic.cms.model.OrderItem"%>
<%@ page import="javax.servlet.http.HttpSession"%>
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
					<li class="nav-item"><a class="nav-link" href="../CartServlet">Cart</a></li>
					<li class="nav-item"><a class="nav-link"
						href="../ProfileServlet">Profile</a></li>
				</ul>
				<a class="btn0" href="../LogoutServlet">Logout</a>
			</div>
		</div>
	</nav>
	<!-- End Of Navbar -->
	<c:if test="${param.success == 'orderSuccess'}">
		<div class="alert alert-success mt-3 text-center">Order Placed Successfully</div>
	</c:if>
	<section class="cart" id="cart">
		<div class="container py-3">
			<h2 class="row justify-content-center">Your Cart</h2>
			<%  
            HttpSession sess = request.getSession();
            Map<String, OrderItem> cart = (Map<String, OrderItem>) sess.getAttribute("cart");
            BigDecimal total = BigDecimal.ZERO;

            if (cart != null && !cart.isEmpty()) {
        %>
			<div class="container">
				<table class="table">
					<thead>
						<tr>
							<th>Item Name</th>
							<th>Quantity</th>
							<th>Price</th>
							<th>Action</th>
						</tr>
					</thead>
					<tbody>
						<% 
                        for (Map.Entry<String, OrderItem> entry : cart.entrySet()) {
                            String itemName = entry.getKey();
                            OrderItem item = entry.getValue();
                            BigDecimal itemPrice = item.getOrderItemPrice();
                            int quantity = item.getOrderItemQuantity();
                            BigDecimal itemTotalPrice = itemPrice.multiply(BigDecimal.valueOf(quantity));
                            total = total.add(itemTotalPrice);
                    %>
						<tr>
							<td><%= itemName %></td>
							<td><%= quantity %></td>
							<td>Rs.<%= itemTotalPrice %></td>
							<td>
								<!-- Form to remove an item from the cart -->
								<form action="../RemoveFromCartServlet" method="post"
									style="display: inline;">
									<input type="hidden" name="itemName" value="<%= itemName %>" />
									<button type="submit" class="btn btn-danger">Remove</button>
								</form>
							</td>
						</tr>
						<% 
                        } // End of for loop
                    %>
					</tbody>
				</table>
				<h3>
					Total: Rs.<%= total %></h3>
				<% if (total.compareTo(BigDecimal.ZERO) > 0) { %>
				<form action="../payment/payment.jsp" method="post">
					<input type="hidden" name="totalAmount" value="<%= total %>" />
					<button type="submit" class="btn0">Pay</button>
				</form>
				<% } %>
			</div>
			<% 
            } else {
        %>
			<h5 class="row justify-content-center" style="margin-top: 10px">Your cart is empty.</h5>
			<% 
            } 
        %>
		</div>
	</section>


	<%@ include file="../footer/footer.jsp"%>
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
