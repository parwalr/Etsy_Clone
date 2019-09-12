<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %> 
<%@ taglib prefix = "fmt" uri = "http://java.sun.com/jsp/jstl/fmt" %>
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
    <title>Add Product</title>
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
    <div class="newshop">
      <h1>Add a new Product</h1>
      <h4>Let's get started!</h4>
      <form:form method="POST" action="/addproduct" modelAttribute="productobj">
        <div class="form-group row">
          <form:label path="name" class="col-sm-2 col-form-label">Name:</form:label>
          <div class="col-sm-10">
            <form:input
              type="text"
              path="name"
              class="form-control"
              placeholder="product name"
            />
          </div>
        </div>
        <div class="form-group row">
          <form:label path="description" class="col-sm-2 col-form-label">Description:</form:label>
          <div class="col-sm-10">
            <form:input
              type="text"
              path="description"
              class="form-control"
              placeholder="product description"
            />
          </div>
        </div>
        <div class="form-group row">
          <form:label path="price" class="col-sm-2 col-form-label">Price:</form:label>
          <div class="col-sm-10">
            <form:input
              type="number"
              path="price"
              class="form-control"
              placeholder="product price"
            />
          </div>
        </div>
        <div class="form-group row">
          <form:label path="category" class="col-sm-2 col-form-label">Category:</form:label>
          <div class="col-sm-10">
            <form:select path="category" class="form-control" id="exampleFormControlSelect1">
              <option>Jewelry</option>
              <option>Clothing</option>
              <option>Home</option>
              <option>Wedding</option>
              <option>Entertainment</option>
              <option>Arts</option>
              <option>Vintage</option>
            </form:select>
          </div>
        </div>
        <div class="form-group row">
          <form:label path="store" class="col-sm-2 col-form-label">Store:</form:label>
          <div class="col-sm-10">
            <form:select path="store" class="form-control" id="exampleFormControlSelect1">
            	<c:forEach items="${stores}" var="store">
					<form:option value="${store}"><c:out value="${store.name}"/></form:option>
				</c:forEach>
            </form:select>
          </div>
        </div>
        <div class="form-group row">
          <form:label path="image" class="col-sm-2 col-form-label">Image:</form:label>
          <div class="col-sm-10">
            <form:input
              type="text"
              path="image" 
              class="form-control"
              placeholder="product image"
            />
          </div>
        </div>
        <div class="form-group row">
          <div class="col-sm-10">
            <button type="submit" class="btn btn-secondary btn-lg btn-block">
              Add product!
            </button>
          </div>
        </div>
      </form:form>
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