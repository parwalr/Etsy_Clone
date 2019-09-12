<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %> 
<!DOCTYPE html>
<html>
  <head>
    <link rel="stylesheet" href="/css/main.css" />
    <link
      rel="stylesheet"
      href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css"
    />
    <link
      rel="stylesheet"
      href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/css/bootstrap.min.css"
    />
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/js/bootstrap.min.js"></script>
    <meta charset="UTF-8" />
    <title>Orders</title>
  </head>
<body>
    <nav>
      <div class="menu">
        <ul>
          <li>
            <a href="/home" class="menu-item"><i class="fa fa-shopping-bag"></i></a>
          </li>
          <li><a href="#" class="menu-item">Welcome, <c:out value="${user.firstName}" /></a></li>
          <li><a href="/store/new" class="menu-item">Sell on Etsy</a></li>
          <li><a href="/products" class="menu-item">Explore</a></li>
          			<li><a href="/allOrders" class="menu-item">Orders</a></li>
			<li><a href="/logout" class="menu-item">Logout</a></li>

          <li>
            <a href="#" id="search" class="menu-item"
              ><i class="fa fa-search"></i
            ></a>
          </li>
          <li>
            <a href="/basket" class="menu-item"
              ><i class="fa fa-shopping-cart"></i
            ></a>
          </li>
        </ul>
        <div class="search-form">
          <form action="/search" method="post">
            <input type="text" name="product" placeholder="Search for items" />
          </form>
        </div>
        <a class="close"><i class="fa fa-times"></i></a>
      </div>
    </nav>
<h1 style="font-family: Poppins, sans-serif;">Your Orders:</h1>
<c:choose>
	<c:when test="${clientOrders.size()>0}">
		<c:forEach var="i" items="${clientOrders }">
		<c:if test="${i.isCheckedOut() }">
			<div class="whole">
				<p>
					Order Number: <a href="clientOrder/${i.getId() }"><c:out value="${i.getId() }"/></a>
				</p>
				<p>
					Date ordered: <c:out value="${i.getCreatedAt() }"/>
				</p>
				<p><strong>Items Ordered:</strong></p>
					<c:forEach var="j" items="${i.getOrderProducts() }">
						<p>				
							<c:out value="${j.getProduct().getName() }"/>
						</p>		
						
					</c:forEach>
			</div>
		</c:if>
		</c:forEach>
	</c:when>
	<c:otherwise>
		<p>
			No orders yet.
		</p>
	</c:otherwise>
</c:choose>
    <script
      src="https://code.jquery.com/jquery-3.4.1.js"
      integrity="sha256-WpOohJOqMqqyKL9FccASB9O0KwACQJpFTUBLTYOVvVU="
      crossorigin="anonymous"
    ></script>
    <script type="text/javascript">
      $(document).ready(function() {
        $("#search").click(function() {
          $(".menu-item").addClass("hide-item");
          $(".search-form").addClass("active");
          $(".close").addClass("active");
          $("#search").hide();
        });
        $(".close").click(function() {
          $(".menu-item").removeClass("hide-item");
          $(".search-form").removeClass("active");
          $(".close").removeClass("active");
          $("#search").show();
        });
      });
    </script>
</body>
</html>