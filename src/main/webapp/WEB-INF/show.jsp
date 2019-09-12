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
    <title>Order</title>
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
	<h1 style="font-family: Poppins, sans-serif;">Order Number: <c:out value="${clientOrder.getId() }"/></h1>
	<table class="table">
		<thead class="thead-dark">
		<tr>
			<th scope="col">Products</th>
			<th scope="col">Quantity</th>
			<th scope="col">Price</th>
		</tr>
		</thead>
		<tbody>
			<c:set var="totalPrice" value="0"/>
			<c:set var="totalQuantity" value="0"/>
		<c:forEach var="j" items="${clientOrder.getOrderProducts() }">
		<tr>
				<td><c:out value="${j.getProduct().getName() }"/></td>
				<td><c:out value="${j.getQuantity()}"/></td>
				<td>$<c:out value="${j.getProduct().getPrice() }"/></td>
				<c:set var="totalPrice" value="${totalPrice+j.getProduct().getPrice() }"/> 
				<c:set var="totalQuantity" value="${totalQuantity+1 }"/> 
		</tr>
		</c:forEach>
		</tbody>
	</table>
	
	

		<div class="">
			<h4 style="font-family: Poppins, sans-serif;">
			Total Price: $<c:out value="${totalPrice }"/>
			</h4>
		</div>
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