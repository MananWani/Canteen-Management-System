<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ page import="java.util.List,com.crimsonlogic.cms.model.MenuItem"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
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
<title>Menu</title>
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
				<li class="nav-item"><a class="nav-link"
					href="../PaymentServlet">Payments</a></li>
				<li class="nav-item"><a class="nav-link"
					href="../ProfileServlet">Profile</a></li>
			</ul>
			<a class="btn0" href="../LogoutServlet">Logout</a>
		</div>
	</div>
	</nav>
	<!-- End Of Navbar -->



	<!--<c:out value="${menuItems}" />-->
	<!-- Menu Items Section -->
	<%
		HttpSession sess = request.getSession();
		List<MenuItem> menuItems = (List<MenuItem>) sess.getAttribute("menuItems");
	%>

	<c:if test="${param.error == 'notUpdated'}">
		<div class="alert alert-danger" role="alert" style="color: black;">Please
			try again.</div>
	</c:if>
	<c:if test="${param.success == 'updated'}">
		<div class="alert alert-success mt-3 text-center">Item updated!</div>
	</c:if>
	<c:if test="${param.success == 'deleted'}">
		<div class="alert alert-success mt-3 text-center">Item deleted!</div>
	</c:if> 
	<c:choose>
		<c:when test="${not empty sessionScope.menuItems}">
			<section class="menu-items" >
			<div class="container">
				<div class="row text-center">
					

					<!-- Breakfast Category -->
					<div class="col-12" id="breakfastSection">
						<h2 >Breakfast</h2>
						<!-- Add Dish Button -->
					<div class="col-12 mb-4">
						<a href="../admin/additem.jsp" class="btn0">Add Item</a>
					</div>
					</div>
					<c:forEach var="item" items="${sessionScope.menuItems}">
						<c:if
							test="${item.itemCategory == 'breakfast'}">

							<div class="col-lg-4 col-md-6 mb-4">
								<img src="../images/${item.itemName}.jpg" class="img-fluid"
									alt="${item.itemName}">
								<h5>${item.itemName}</h5>
								<p>Rs.${item.itemPrice}</p>
								<p>Can Serve: ${item.itemInStock}</p>
								<form action="../admin/edititem.jsp" method="post"
									class="d-inline">
									<input type="hidden" name="itemId" value="${item.itemId}">
									<input type="hidden" name="itemName" value="${item.itemName}">
									<input type="hidden" name="itemPrice" value="${item.itemPrice}">
									<input type="hidden" name="itemType" value="${item.itemType}">
									<input type="hidden" name="itemInStock"
										value="${item.itemInStock}">
									<button type="submit" class="btn0">Edit</button>
								</form>
<!-- 								<form action="../DeleteItemServlet" method="post" -->
<!-- 									class="d-inline"> -->
<%-- 									<input type="hidden" name="itemId" value="${item.itemId}"> --%>
<!-- 									<button type="submit" class="btn0">Remove</button> -->
<!-- 								</form> -->
							</div>
						</c:if>
					</c:forEach>

					
					<!-- Lunch Category -->
					<div class="col-12 mt-4" id="lunchSection">
						<h2 id="lunch">Lunch</h2>
						<div class="col-12 mb-4">
						<a href="../admin/additem.jsp" class="btn0">Add Item</a>
					</div>
					</div>
					<c:forEach var="item" items="${sessionScope.menuItems}">
						<c:if
							test="${item.itemCategory == 'lunch'}">
							<div class="col-lg-4 col-md-6 mb-4">
								<img src="../images/${item.itemName}.jpg" class="img-fluid"
									alt="${item.itemName}">
								<h5>${item.itemName}</h5>
								<p>Rs.${item.itemPrice}</p>
								<p>Can Serve: ${item.itemInStock}</p>

								<form action="../admin/edititem.jsp" method="post"
									class="d-inline">
									<input type="hidden" name="itemId" value="${item.itemId}">
									<input type="hidden" name="itemName" value="${item.itemName}">
									<input type="hidden" name="itemPrice" value="${item.itemPrice}">
									<input type="hidden" name="itemInStock"
										value="${item.itemInStock}">
									<button type="submit" class="btn0">Edit</button>
								</form>
<!-- 								<form action="../DeleteItemServlet" method="post" -->
<!-- 									class="d-inline"> -->
<%-- 									<input type="hidden" name="itemId" value="${item.itemId}"> --%>
<!-- 									<button type="submit" class="btn0">Remove</button> -->
<!-- 								</form> -->
							</div>
						</c:if>
					</c:forEach>
					
					<!-- Dinner Category -->
					<div class="col-12 mt-4" id="dinnerSection">
						<h2 id="dinner">Dinner</h2>
						<div class="col-12 mb-4">
						<a href="../admin/additem.jsp" class="btn0">Add Item</a>
					</div>
					</div>
					<c:forEach var="item" items="${sessionScope.menuItems}">
						<c:if
							test="${item.itemCategory == 'dinner'}">
							<div class="col-lg-4 col-md-6 mb-4">
								<img src="../images/${item.itemName}.jpg" class="img-fluid"
									alt="${item.itemName}">
								<h5>${item.itemName}</h5>
								<p>Rs.${item.itemPrice}</p>
								<p>Can Serve: ${item.itemInStock}</p>

								<form action="../admin/edititem.jsp" method="post"
									class="d-inline">
									<input type="hidden" name="itemId" value="${item.itemId}">
									<input type="hidden" name="itemName" value="${item.itemName}">
									<input type="hidden" name="itemPrice" value="${item.itemPrice}">
									<input type="hidden" name="itemInStock"
										value="${item.itemInStock}">
									<button type="submit" class="btn0">Edit</button>
								</form>
<!-- 								<form action="../DeleteItemServlet" method="post" -->
<!-- 									class="d-inline"> -->
<%-- 									<input type="hidden" name="itemId" value="${item.itemId}"> --%>
<!-- 									<button type="submit" class="btn0">Remove</button> -->
<!-- 								</form> -->
							</div>
						</c:if>
					</c:forEach>
				</div>
			</div>
			</section>
		</c:when>
		<c:otherwise>
			<h2>Empty Menu</h2>
		</c:otherwise>
	</c:choose>
	<!-- End Of Menu Items Section -->



	<%@ include file="../footer/footer.jsp"%>
</body>
</html>