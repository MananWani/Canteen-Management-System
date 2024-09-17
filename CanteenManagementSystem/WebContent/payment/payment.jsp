<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" isELIgnored="false" session="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="java.util.Map, java.math.BigDecimal,com.crimsonlogic.cms.model.OrderItem"%>
<%@ page import="javax.servlet.http.HttpSession"%>
<!doctype html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="preconnect" href="https://fonts.gstatic.com">
    <link rel="icon" type="image/png" href="../images/ramen.png">
    
    <link href="https://fonts.googleapis.com/css2?family=Lobster&family=Rubik&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://unpkg.com/bootstrap@5.3.3/dist/css/bootstrap.min.css">
    <link href="../css/home.css" rel="stylesheet" />
    <title>Payment</title>
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
                    <li class="nav-item"><a class="nav-link" href="../home/home.jsp">Home</a></li>
                    <li class="nav-item"><a class="nav-link" href="../OrderServlet">Orders</a></li>
                    <li class="nav-item"><a class="nav-link active" href="../CartServlet">Cart</a></li>
                    <li class="nav-item"><a class="nav-link" href="../ProfileServlet">Profile</a></li>
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
    <section class="payment">
    <div class="container py-4">
        <h2 class="row justify-content-center">Payment</h2><br>
        <%
            HttpSession sess = request.getSession();
            Map<String, OrderItem> cart = (Map<String, OrderItem>) sess.getAttribute("cart");
            BigDecimal total = BigDecimal.ZERO;
            BigDecimal walletBalance = (BigDecimal) sess.getAttribute("currentBalance");

            if (cart != null) {
                for (OrderItem item : cart.values()) {
                    BigDecimal itemTotalPrice = item.getOrderItemPrice().multiply(BigDecimal.valueOf(item.getOrderItemQuantity()));
                    total = total.add(itemTotalPrice);
                }
            }

            if (walletBalance == null) {
                walletBalance = BigDecimal.ZERO;
            }
        %>
       
        <div class="container" style="margin-left: 180px">
            <div class="row mb-4">
                <div class="col-md-6">
                    <h4>Total Amount:</h4>
                    <p>Rs.<%= total %></p>
                </div>
                <div class="col-md-6">
                    <h4>Wallet Balance:</h4>
                    <p>Rs.<%= walletBalance%></p>
                </div>
            </div>
            
            <!-- Payment Form -->
        <%
        boolean hasSufficientBalance = walletBalance.compareTo(total) >= 0;
    if (hasSufficientBalance) {
%>
        <form action="../ProcessPaymentServlet" method="post">
            <input type="hidden" name="totalAmount" value="<%= total %>"/>
            <input type="hidden" name="walletBalance" value="<%= walletBalance %>"/>
            <button type="submit" style="margin-left: 315px" class="btn0">Pay</button>
        </form>
<%
    } else {
%>
        <h4 style="color: red; margin-left:50px; bold;">Insufficient balance. Please add money to your wallet.</h4>
<%
    }
%>

        </div>
    </div>
</section>


    <%@ include file="../footer/footer.jsp" %>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
