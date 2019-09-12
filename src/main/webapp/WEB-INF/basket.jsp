<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %> 
<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <meta http-equiv="X-UA-Compatible" content="ie=edge" />
    <link rel="stylesheet" href="/css/main.css" />
    <link
      rel="stylesheet"
      href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css"
      integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T"
      crossorigin="anonymous"
    />
    <link
      rel="stylesheet"
      href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css"
    />
    <title>Cart</title>
  </head>
  <body>
    <nav>
      <div class="menu">
        <ul>
          <li>
            <a href="/home" class="menu-item"
              ><i class="fa fa-shopping-bag"></i
            ></a>
          </li>
          <li><a href="#" class="menu-item">Welcome, <c:out value="${user.firstName}"/></a></li>
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
    <h1 style="font-family: Poppins, sans-serif;">Your Cart:</h1>
<c:out value="${emptyMessage }"/>
<c:choose>
	<c:when test="${clientOrder!=null && clientOrder.getOrderProducts().size()>0 }">

			<c:set var="totalPrice" value="0"/>
			<c:set var="totalQuantity" value="0"/>
		<c:forEach var="i" items="${clientOrder.getOrderProducts() }">
			<div class="whole">
				<div class="basketleft d-inline-block">
					<img src="${i.getProduct().getImage() }"/>
				</div>	
				<div class="basketright d-inline-block">
					<h4><c:out value="${i.getProduct().getName() }"/></h4>
					<h5><c:out value="${i.getProduct().getDescription() }"/></h5>
					<h5>Quantity: <c:out value="${i.getQuantity() }"/></h5>
					<h5>$<c:out value="${i.getProduct().getPrice() }"/></h5>
					<a href="/removeFromBasket/${i.getId()}"><i class="fa fa-times" aria-hidden="true"></i>Remove from cart</a>
				</div>
				<c:set var="totalPrice" value="${totalPrice+i.getProduct().getPrice() }"/> 
				<c:set var="totalQuantity" value="${totalQuantity+1 }"/> 
			</div>
		</c:forEach>
		<div class="whole1">
      		<a href="/checkoutBasket"
        		><button type="button" class="btn btn-secondary btn-lg btn-block">
          		Checkout
        	</button></a
      		>
    	</div>
		
		
	</c:when>
	<c:otherwise>
    <div class="empty">
      <i class="fa fa-shopping-cart" aria-hidden="true"></i>
      <h3>Cart is currently empty.</h3>
      <a href="/products" class="d-block">Explore Products</a>
    </div>
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