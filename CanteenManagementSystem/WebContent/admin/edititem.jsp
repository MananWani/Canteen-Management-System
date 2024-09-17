<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ page import="java.util.List,com.crimsonlogic.cms.model.MenuItem"%>
<%@ page import="java.math.BigDecimal"%>

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
<title>Edit Item</title>
<style>
body {
	font-family: 'Rubik', cursive;
}

.full-height {
	min-height: 100vh;
}

.centered-content {
	display: flex;
	justify-content: center;
	align-items: center;
}

.form-container {
	width: 100%;
	max-width: 600px; /* Adjust this width as needed */
}
</style>
<title>Edit Item</title>
</head>
<body>
	<!--Navbar -->
	<nav class="navbar navbar-expand-lg" style="height: 70px !important;">
	<div class="container">
		<p class="navbar-brand" style="margin-top: 14px">
			<img src="../images/ramen.png" alt="Logo" class="logo"
				style="width: 40px; height: 40px; margin-right: 5px; margin-bottom: 10px;">
			Canteen
		</p>
		<div class="collapse navbar-collapse" id="navbarScroll">
			<ul class="navbar-nav m-auto my-2 my-lg-0">
				<li class="nav-item"><a class="nav-link active"
					href="../adminhome/adminhome.jsp">Home</a></li>
				<li class="nav-item"><a class="nav-link" href="../MenuServlet">
						Menu</a></li>
				<li class="nav-item"><a class="nav-link" href="../OrderServlet">
						Orders</a></li>
				<li class="nav-item"><a class="nav-link"
					href="../PaymentServlet"> Payments</a></li>
				<li class="nav-item"><a class="nav-link"
					href="../ProfileServlet">Profile</a></li>
			</ul>
			<a class="btn0" href="../LogoutServlet">Logout</a>
		</div>
	</div>
	</nav>
	<!--End Of Navbar -->
	<%
		String itemId = request.getParameter("itemId");
		String itemName = request.getParameter("itemName");
		BigDecimal itemPrice = new BigDecimal(request.getParameter("itemPrice"));
		Integer itemInStock = Integer.parseInt(request.getParameter("itemInStock"));
	%>
	<div class="container full-height centered-content">
		<div class="form-container py-3">
			<h1 class="text-center mb-4">Edit Item</h1>
			<form action="../EditItemServlet" method="post">
				<div class="row gy-2">
				<div class="col-12">
						<div class=" form-floating mb-3">
							<input type="text" class="form-control" name="itemId"
								id="itemId" value="<%=itemId%>"
								readonly> <label for="itemName"
								class="form-label">Item ID</label>
						</div>
					</div>

					<div class="col-12">
						<div class="form-floating mb-3">
							<input type="text" class="form-control" name="itemName"
								id="itemName" value="<%=itemName%>"
								oninput="validateItemName()"> <label for="itemName"
								class="form-label">Item Name (Same as image name)</label>
						</div>
						<div id="itemNameError" class="text-danger"></div>
					</div>
					<div class="col-12">
						<div class="form-floating mb-3">
							<input type="number" class="form-control" name="itemPrice"
								id="itemPrice" value="<%=itemPrice%>"
								oninput="validateItemPrice()"> <label for="itemPrice"
								class="form-label">Item Price</label>
						</div>
						<div id="itemPriceError" class="text-danger"></div>
					</div>
					<div class="col-12">
						<div class="form-floating mb-3">
							<select class="form-select" name="itemCategory" id="itemCategory"
								required>
								<option value="" disabled selected>Select Category</option>
								<option value="breakfast">Breakfast</option>
								<option value="lunch">Lunch</option>
								<option value="dinner">Dinner</option>
							</select> <label for="itemCategory" class="form-label">Item
								Category</label>
						</div>
						<div id="itemCategoryError" class="text-danger"></div>
					</div>
					<div class="col-12">
						<div class="form-floating mb-3">
							<input type="number" class="form-control" name="itemInStock"
								id="itemInStock" value="<%=itemInStock%>"
								oninput="validateItemInStock()"> <label
								for="itemInStock" class="form-label">Can Serve</label>
						</div>
						<div id="itemInStockError" class="text-danger"></div>

					</div>
					<div class="col-12">
						<div class="form-floating mb-3">
							<select class="form-select" name="itemType" id="itemType"
								required>
								<option value="" disabled selected>Select Category</option>
								<option value="veg">Veg</option>
								<option value="non-veg">Non-Veg</option>
							</select> <label for="itemType" class="form-label">Item Type</label>
						</div>
						<div id="itemTypeError" class="text-danger"></div>
					</div>


					<div class="col-12">
						<div class="d-grid my-3">
							<button class="btn0"
								style="background-color: crimson; border-color: crimson; color: white; margin-left: 240px;"
								type="submit">Update</button>
						</div>
					</div>
				</div>
			</form>
		</div>
	</div>
	<script>
	
	document.addEventListener('DOMContentLoaded', function() {
		let isItemNameValid = false;
		let isItemPriceValid = false;
		let isItemInStockValid = false;

		function validateItemName() {
			const itemName = document.getElementById('itemName').value;
			const itemNameError = document.getElementById('itemNameError');
			if (itemName.length < 3 || itemName.length > 20) {
				itemNameError.textContent = 'Name can have letters between 3-20';
				itemNameError.classList.add('show');
				isItemNameValid = false;
			} else {
				itemNameError.textContent = '';
				itemNameError.classList.remove('show');
				isItemNameValid = true;
			}
		}

		function validateItemPrice() {
			const itemPrice = document.getElementById('itemPrice').value;
			const itemPriceError = document.getElementById('itemPriceError');
			if (itemPrice < 1 || itemPrice > 5000) {
				itemPriceError.textContent = 'Please enter a valid price';
				itemPriceError.classList.add('show');
				isItemPriceValid = false;
			} else {
				itemPriceError.textContent = '';
				itemPriceError.classList.remove('show');
				isItemPriceValid = true;
			}
		}

		

		function validateItemInStock() {
			const itemInStock = document.getElementById('itemInStock').value;
			const itemInStockError = document.getElementById('itemInStockError');
			if (itemInStock < 1 || itemInStock > 50) {
				itemInStockError.textContent = 'Please enter a valid stock number';
				itemInStockError.classList.add('show');
				isItemInStockValid = false;
			} else {
				itemInStockError.textContent = '';
				itemInStockError.classList.remove('show');
				isItemInStockValid = true;
			}
		}

		

		

		document.getElementById('itemName').addEventListener('input', validateItemName);
		document.getElementById('itemPrice').addEventListener('input', validateItemPrice);
		document.getElementById('itemInStock').addEventListener('input', validateItemInStock);
	});
</script>

	<%@ include file="../footer/footer.jsp"%>
</body>
</html>