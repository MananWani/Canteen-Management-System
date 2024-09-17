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
<title>Add New Item</title>
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
	max-width: 600px;
}

.btn1 {
	height: 40px;
	width: 100px;
	text-align: center;
	line-height: 40px; /* Vertically centers text within the height */
	text-decoration: none;
	outline: none;
	border: none;
	background: crimson;
	color: white;
	border-radius: 60px;
	font-family: 'Rubik', cursive;
}

.btn1.show {
	display: block;
}

.btn1 {
	display: none;
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
	<c:if test="${param.error == 'maxSize'}">
								<div class="alert alert-danger text-center" role="alert"
									style="color: black;">Image size should be less than 30kb</div>
							</c:if>
	<c:if test="${param.success == 'imageAdded'}">
		<div class="alert alert-success mt-3 text-center">Image added
			successfully!</div>
	</c:if>
	<c:if test="${param.error == 'itemnameExists'}">
							<div class="alert alert-danger text-center" role="alert"
								style="color: black;">Item name already exists.</div>
						</c:if>
	<div class="container full-height centered-content">
		<div class="form-container py-3">
			<h1 class="text-center mb-4 ">Add New Item</h1>
			<div class="col-12">
				<div class="form-floating mb-3">
					<form action="../AddImageServlet" method="post"
						enctype="multipart/form-data">
						<input class="form-control" type="file" name="image" required>
						<input class="btn0" style="margin-top: 15px;" type="submit"
							value="Add Image">
					</form>
				</div>
			</div>
			<form action="../AddNewItemServlet" method="post">
				<div class="row gy-2">

					<div class="col-12">
						<div class="form-floating mb-3">
							<input type="text" class="form-control" name="itemName"
								id="itemName" oninput="validateItemName()"> <label
								for="itemName" class="form-label">Item Name (Same as image name)</label>
						</div>
						<div id="itemNameError" class="text-danger"></div>
					</div>
					<div class="col-12">
						<div class="form-floating mb-3">
							<input type="number" class="form-control" 
								name="itemPrice" id="itemPrice" oninput="validateItemPrice()">
							<label for="itemPrice" class="form-label">Item Price</label>
						</div>
						<div id="itemPriceError" class="text-danger"></div>
					</div>
					<div class="col-12">
						<div class="form-floating mb-3">
							<select class="form-select" name="itemCategory" id="itemCategory"
								onchange="validateItemCategory()">
								<option value="" selected>Select Category</option>
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
								id="itemInStock" oninput="validateItemInStock()"> <label
								for="itemInStock" class="form-label">Can Serve</label>
						</div>
						<div id="itemInStockError" class="text-danger"></div>

					</div>
					<div class="col-12">
						<div class="form-floating mb-3">
							<select class="form-select" name="itemType" id="itemType"
								onchange="validateItemType()">
								<option value="" selected>Select Category</option>
								<option value="veg">Veg</option>
								<option value="non-veg">Non-Veg</option>
							</select> <label for="itemType" class="form-label">Item Type</label>
						</div>
						<div id="itemTypeError" class="text-danger"></div>
					</div>

					<div class="col-12">
						<div class="d-grid my-1">
							<button class="btn1 "
								style="background-color: crimson; border-color: crimson; color: white; margin-left: 240px;"
								type="submit" id="addButton">Add</button>
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
		let isItemCategoryValid = false;
		let isItemInStockValid = false;
		let isItemTypeValid = false;

		function validateItemName() {
			const itemName = document.getElementById('itemName').value;
			const itemNameError = document.getElementById('itemNameError');
			if (itemName.length < 3 || itemName.length > 20) {
				itemNameError.textContent = 'Item name can have letters between 3-20';
				itemNameError.classList.add('show');
				isItemNameValid = false;
			} else {
				itemNameError.textContent = '';
				itemNameError.classList.remove('show');
				isItemNameValid = true;
			}
			checkAllValidations();
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
			checkAllValidations();
		}

		function validateItemCategory() {
			const itemCategory = document.getElementById('itemCategory').value;
			const itemCategoryError = document.getElementById('itemCategoryError');
			if (itemCategory === '') {
				itemCategoryError.textContent = 'Please select a category';
				itemCategoryError.classList.add('show');
				isItemCategoryValid = false;
			} else {
				itemCategoryError.textContent = '';
				itemCategoryError.classList.remove('show');
				isItemCategoryValid = true;
			}
			checkAllValidations();
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
			checkAllValidations();
		}

		function validateItemType() {
			const itemType = document.getElementById('itemType').value;
			const itemTypeError = document.getElementById('itemTypeError');
			if (itemType === '') {
				itemTypeError.textContent = 'Please select an item type';
				itemTypeError.classList.add('show');
				isItemTypeValid = false;
			} else {
				itemTypeError.textContent = '';
				itemTypeError.classList.remove('show');
				isItemTypeValid = true;
			}
			checkAllValidations();
		}

		function checkAllValidations() {
			const addButton = document.getElementById('addButton');
			if (isItemNameValid && isItemPriceValid && isItemCategoryValid && isItemInStockValid && isItemTypeValid) {
				addButton.classList.add('show');
			} else {
				addButton.classList.remove('show');
			}
		}

		document.getElementById('itemName').addEventListener('input', validateItemName);
		document.getElementById('itemPrice').addEventListener('input', validateItemPrice);
		document.getElementById('itemCategory').addEventListener('change', validateItemCategory);
		document.getElementById('itemInStock').addEventListener('input', validateItemInStock);
		document.getElementById('itemType').addEventListener('change', validateItemType);
	});
</script>

		

	<%@ include file="../footer/footer.jsp"%>
</body>
</html>