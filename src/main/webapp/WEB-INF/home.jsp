<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
    <title>Welcome</title>
  </head>
  <body>
    <nav>
      <div class="menu">
        <ul>
          <li>
            <a href="/" class="menu-item"><i class="fa fa-shopping-bag"></i></a>
          </li>
          <li><a href="/registration" class="menu-item">Register</a></li>
          <li><a href="/login" class="menu-item">Sign in</a></li>
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
        <div class="search-form" >
          <form action="/search" method="post">
            <input type="text" name="product" placeholder="Search for items" />
          </form>
        </div>
        <a class="close"><i class="fa fa-times"></i></a>
      </div>
    </nav>
            <div class="categories">
      <ul>
        <li><a href="/products/category/jewelry">Jewelry</a></li>
        <li><a href="/products/category/clothing">Clothing</a></li>
        <li><a href="/products/category/home">Home</a></li>
        <li><a href="/products/category/wedding">Wedding</a></li>
        <li><a href="/products/category/entertainment">Entertainment</a></li>
        <li><a href="/products/category/arts">Arts</a></li>
        <li><a href="/products/category/vintage">Vintage</a></li>
      </ul>
    </div>
    <header>
      <div id="myCarousel" class="carousel slide" data-ride="carousel">
        <!-- Indicators -->
        <ol class="carousel-indicators">
          <li data-target="#myCarousel" data-slide-to="0" class="active"></li>
          <li data-target="#myCarousel" data-slide-to="1"></li>
          <li data-target="#myCarousel" data-slide-to="2"></li>
        </ol>

        <!-- Wrapper for slides -->
        <div class="carousel-inner">
          <div class="item active">
            <img
              src="/img/jacek-dylag-FXXfE5RqkqY-unsplash.jpg"
              alt="Jewelry"
            />
            <div class="carousel-caption">
              <h1>Welcome!</h1>
              <h3>
                Your source for all things handcrafted, custom, and unique.
              </h3>
            </div>
          </div>

          <div class="item">
            <img
              src="/img/nordwood-themes-Nv4QHkTVEaI-unsplash.jpg"
              alt="Clothing"
            />
            <div class="carousel-caption">
              <h1>Welcome!</h1>
              <h3>
                Your source for all things handcrafted, custom, and unique.
              </h3>
            </div>
          </div>

          <div class="item">
            <img
              src="/img/manja-vitolic-7tOV35hnkao-unsplash.jpg"
              alt="Home Decor"
            />
            <div class="carousel-caption">
              <h1>Welcome!</h1>
              <h3>
                Your source for all things handcrafted, custom, and unique.
              </h3>
            </div>
          </div>
        </div>

        <!-- Left and right controls -->
        <a class="left carousel-control" href="#myCarousel" data-slide="prev">
          <span class="glyphicon glyphicon-chevron-left"></span>
          <span class="sr-only">Previous</span>
        </a>
        <a class="right carousel-control" href="#myCarousel" data-slide="next">
          <span class="glyphicon glyphicon-chevron-right"></span>
          <span class="sr-only">Next</span>
        </a>
      </div>
    </header>
    <div class="center">
      <h2>Popular Categories</h2>
      <div class="row">
        <div class="col-sm-4">
          <img
            src="/img/sweet-ice-cream-photography-ootMB9iANOc-unsplash.jpg"
          />
          <div class="text-center">Jewelry</div>
        </div>
        <div class="col-sm-4">
          <img src="/img/jonny-caspari-KuudDjBHIlA-unsplash.jpg" />
          <div class="text-center">Home Decor</div>
        </div>
        <div class="col-sm-4">
          <img src="/img/duy-hoang-ojZ4wJNUM5w-unsplash.jpg" />
          <div class="text-center">Clothing</div>
        </div>
      </div>
    </div>
    <div class="bottom">
      <h2>What is Etsy?</h2>
      <div class="row">
        <div class="col-sm-4">
          <h4>A one-of-a-kind community</h4>
          <p>
            Etsy is a global online marketplace, where people come together to
            make, sell, buy, and collect unique items.
          </p>
        </div>
        <div class="col-sm-4">
          <h4>Support independent creators</h4>
          <p>
            There’s no Etsy warehouse – just millions of people selling the
            things they love. We make the whole process easy, helping you
            connect directly with makers to find something extraordinary.
          </p>
        </div>
        <div class="col-sm-4">
          <h4>Peace of mind</h4>
          <p>
            Your privacy is the highest priority of our dedicated team. And if
            you ever need assistance, we are always ready to step in for
            support.
          </p>
        </div>
      </div>
    </div>
    <div class="footer">
      
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