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
<title>Menu</title>
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

	<c:if test="${param.success == 'addedtocart'}">
		<div class="alert alert-success mt-3 text-center">Added To Cart
			Successfully</div>
	</c:if>

	<!-- Menu Items Section -->
	<%-- Retrieve the list of menu items from the session --%>
	<%
    HttpSession sess = request.getSession();
    List<MenuItem> menuItems = (List<MenuItem>) sess.getAttribute("menuItems");
%>

	<c:choose>
    <c:when test="${not empty sessionScope.menuItems}">
        <section class="menu-items">
        <div class="container">
            <div class="row text-center">
                <!-- Search Form -->
                <div class="row mb-4">
    <!-- Search Input -->
    <div class="col-md-6 mb-3">
        <div class="form-floating">
            <input type="text" class="form-control" id="search"  oninput="filterItems()">
            <label for="search" class="form-label">Search Items</label>
        </div>
    </div>

    <!-- Dropdown Form -->
    <div class="col-md-6 mb-3">
        <form action="../MenuServlet" method="get">
            <div class="form-floating">
                <select class="form-select" name="itemtype" id="itemType" onchange="this.form.submit()">
                    <option value=" "  ${param.itemtype == '' ? 'selected' : ''}>Select Category</option>
                    <option value="both" ${param.itemtype == 'both' ? 'selected' : ''}>Both</option>
                    <option value="veg" ${param.itemtype == 'veg' ? 'selected' : ''}>Veg</option>
                    <option value="non-veg" ${param.itemtype == 'non-veg' ? 'selected' : ''}>Non-Veg</option>
                </select>
                <label for="itemType" class="form-label">Item Category</label>
            </div>
        </form>
    </div>
</div>


                <!-- Menu Items Display -->
                <div id="menuItemsContainer" class="row text-center">
                    <!-- Breakfast Category -->
                    <div class="col-12" id="breakfastSection">
                        <h2>Breakfast</h2>
                    </div>
                    <c:forEach var="item" items="${sessionScope.menuItems}">
                        <c:if test="${item.itemCategory == 'breakfast' && item.itemInStock > 4}">
                            <div class="col-lg-4 col-md-6 mb-4 menu-item" data-name="${item.itemName.toLowerCase()}">
                                <img src="../images/${item.itemName}.jpg" class="img-fluid" alt="${item.itemName}">
                                <h5>${item.itemName}</h5>
                                <p>Rs.${item.itemPrice}</p>
                                <form action="../CartServlet" method="post">
                                    <input type="hidden" name="itemName" value="${item.itemName}">
                                    <input type="hidden" name="itemPrice" value="${item.itemPrice}">
                                    <input type="hidden" name="itemId" value="${item.itemId}">
                                    <div class="form-group">
                                        <label for="quantity-${item.itemId}">Quantity</label>
                                        <input type="number" id="quantity-${item.itemId}" name="itemQuantity" value="1" min="1" max="5" class="form-control" required>
                                    </div>
                                    <button type="submit" class="btn0" style="margin-top: 10px;">Add to Cart</button>
                                </form>
                            </div>
                        </c:if>
                    </c:forEach>

                    <!-- Lunch Category -->
                    <div class="col-12 mt-4" id="lunchSection">
                        <h2>Lunch</h2>
                    </div>
                    <c:forEach var="item" items="${sessionScope.menuItems}">
                        <c:if test="${item.itemCategory == 'lunch' && item.itemInStock > 4}">
                            <div class="col-lg-4 col-md-6 mb-4 menu-item" data-name="${item.itemName.toLowerCase()}">
                                <img src="../images/${item.itemName}.jpg" class="img-fluid" alt="${item.itemName}">
                                <h5>${item.itemName}</h5>
                                <p>Rs.${item.itemPrice}</p>
                                <form action="../CartServlet" method="post">
                                    <input type="hidden" name="itemName" value="${item.itemName}">
                                    <input type="hidden" name="itemPrice" value="${item.itemPrice}">
                                    <input type="hidden" name="itemId" value="${item.itemId}">
                                    <div class="form-group">
                                        <label for="quantity-${item.itemId}">Quantity</label>
                                        <input type="number" id="quantity-${item.itemId}" name="itemQuantity" value="1" min="1" max="5" class="form-control" required>
                                    </div>
                                    <button type="submit" class="btn0" style="margin-top: 10px;">Add to Cart</button>
                                </form>
                            </div>
                        </c:if>
                    </c:forEach>

                    <!-- Dinner Category -->
                    <div class="col-12 mt-4" id="dinnerSection">
                        <h2>Dinner</h2>
                    </div>
                    <c:forEach var="item" items="${sessionScope.menuItems}">
                        <c:if test="${item.itemCategory == 'dinner' && item.itemInStock > 4}">
                            <div class="col-lg-4 col-md-6 mb-4 menu-item" data-name="${item.itemName.toLowerCase()}">
                                <img src="../images/${item.itemName}.jpg" class="img-fluid" alt="${item.itemName}">
                                <h5>${item.itemName}</h5>
                                <p>Rs.${item.itemPrice}</p>
                                <form action="../CartServlet" method="post">
                                    <input type="hidden" name="itemName" value="${item.itemName}">
                                    <input type="hidden" name="itemPrice" value="${item.itemPrice}">
                                    <input type="hidden" name="itemId" value="${item.itemId}">
                                    <div class="form-group">
                                        <label for="quantity-${item.itemId}">Quantity</label>
                                        <input type="number" id="quantity-${item.itemId}" name="itemQuantity" value="1" min="1" max="5" class="form-control" required>
                                    </div>
                                    <button type="submit" class="btn0" style="margin-top: 10px;">Add to Cart</button>
                                </form>
                            </div>
                        </c:if>
                    </c:forEach>
                </div>
            </div>
        </div>
        </section>
    </c:when>
    <c:otherwise>
        <h2>Empty Menu</h2>
    </c:otherwise>
</c:choose>

	<!-- JavaScript for Filtering -->
	<script>
        function filterItems() {
            var searchInput = document.getElementById('search').value.toLowerCase();
            var items = document.querySelectorAll('.menu-item');
            
            items.forEach(function(item) {
                var name = item.getAttribute('data-name');
                if (name.includes(searchInput)) {
                    item.style.display = 'block';
                } else {
                    item.style.display = 'none';
                }
            });
        }
    </script>

	<%@ include file="../footer/footer.jsp"%>
</body>
</html>
