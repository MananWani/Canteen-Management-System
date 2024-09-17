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
      <title>Home</title>
   </head>
   <body>
      <nav class="navbar navbar-expand-lg" style="height: 70px !important;">
		<div class="container">
			<p class="navbar-brand" style="margin-top: 14px">
				<img src="../images/ramen.png" alt="Logo" class="logo"
					style="width: 40px; height: 40px; margin-right: 5px; margin-bottom: 10px;">
				Canteen
			</p>

        <div class="collapse navbar-collapse" id="navbarScroll">
            <ul class="navbar-nav m-auto my-2 my-lg-0">
                <li class="nav-item"><a class="nav-link active" href="#main">Home</a></li>
                <li class="nav-item"><a class="nav-link" href="#menu">Menu</a></li>
                <li class="nav-item"><a class="nav-link" href="../OrderServlet">Orders</a></li>
                <li class="nav-item"><a class="nav-link" href="../PaymentServlet">Payments</a></li>
                <li class="nav-item"><a class="nav-link" href="../ProfileServlet">Profile</a></li>
<!--                 <li class="nav-item"><a class="nav-link" href="../adminregister/adminregister.jsp">Add Vendor</a></li> -->
            </ul>
            <a class="btn0" href="../LogoutServlet">Logout</a>
        </div>
    </div>
</nav>
<!--End Of Navbar -->

      
      <c:if test="${param.success == 'adminAdded'}">
		<div class="alert alert-success mt-3 text-center">Admin Added!</div>
	</c:if>
	<c:if test="${param.success == 'inserted'}">
		<div class="alert alert-success mt-3 text-center">Item added!</div>
	</c:if> 
	
      <!--Main -->
      <section class="main" id="main">
         <div class="container">
            <div class="row">
               <div class="col-lg-12 pt-7 text-center">
                  <h1>
                     Eat good,<br>Feel good !
                  </h1>
               </div>
            </div>
         </div>
      </section>
      <!--End Of Main -->
      <!-- Menu -->
<section class="menu" id="menu">
    <div class="container py-5">
        <div class="row pt-5 justify-content-center">
            <div class="col-lg-8">
                <div class="row text-center">
                    <div class="col-lg-4 col-md-4 mb-5">
                        <a href="../MenuServlet#breakfastSection">
                            <img src="../images/breakfast.png" class="img-fluid" alt="Breakfast" />
                        </a>
                        <h6>Breakfast</h6>
                    </div>
                    <div class="col-lg-4 col-md-4 mb-5">
                        <a href="../MenuServlet#lunchSection">
                            <img src="../images/lunch.png" class="img-fluid" alt="Lunch" />
                        </a>
                        <h6>Lunch</h6>
                    </div>
                    <div class="col-lg-4 col-md-4 mb-5">
                        <a href="../MenuServlet#dinnerSection">
                            <img src="../images/dinner.png" class="img-fluid" alt="Dinner" />
                        </a>
                        <h6>Dinner</h6>
                    </div>
                </div>
            </div>
        </div>
    </div>
</section>
<!-- End Of Menu -->


      
      <%@ include file="../footer/footer.jsp" %>
   </body>
</html>