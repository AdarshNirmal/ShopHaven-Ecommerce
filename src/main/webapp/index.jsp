<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="ShopHavenmodel.*" %>
<%@ page import="ShopHavenmodelDao.cart" %>

<%
    User auth = (User) session.getAttribute("auth");
    ArrayList<cart> cart_List = (ArrayList<cart>) session.getAttribute("cart-list");

    if (auth != null && cart_List != null) {
        request.setAttribute("cart_list", cart_List);
    }
%>
<!DOCTYPE html>
<html>
<head>
    <title>Welcome to ShopHaven!</title>
    <meta charset="UTF-8">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.0.0/dist/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.7.2/css/all.min.css">
    
    <style>
    * {
      margin: 0;
      padding: 0;
      box-sizing: border-box;
    }

    body {
      font-family: 'Segoe UI', sans-serif;
      background-color: #f5f5f5;
      color: #333;
    }

    /* Navbar Styles */
    .navbar {
      background: linear-gradient(135deg, #2c3e50, #4a6491);
      color: white;
      padding: 1rem 2rem;
      box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
      position: relative;
      z-index: 1000;
      border-bottom: 3px solid transparent;
      border-image: linear-gradient(90deg, #ff8a00, #e52e71, #ff8a00);
      border-image-slice: 1;
      animation: borderGlow 3s linear infinite;
    }

    @keyframes borderGlow {
      0% { border-image-source: linear-gradient(90deg, #ff8a00, #e52e71, #ff8a00); }
      50% { border-image-source: linear-gradient(90deg, #e52e71, #ff8a00, #e52e71); }
      100% { border-image-source: linear-gradient(90deg, #ff8a00, #e52e71, #ff8a00); }
    }

    .navbar-brand {
      font-family: 'Poppins', sans-serif;
      font-weight: 700;
      font-size: 2rem;
      background: linear-gradient(90deg, #ff8a00, #e52e71, #ff8a00);
      background-size: 200% auto;
      color: transparent;
      background-clip: text;
      -webkit-background-clip: text;
      text-fill-color: transparent;
      -webkit-text-fill-color: transparent;
      animation: shine 3s linear infinite;
      position: relative;
      text-decoration: none;
      text-shadow: 0 2px 4px rgba(0,0,0,0.2);
      display: flex;
      align-items: center;
    }

    .navbar-brand i {
      margin-right: 100px;
      animation: bounce 2s infinite;
    }

    @keyframes bounce {
      0%, 100% { transform: translateY(0); }
      50% { transform: translateY(-5px); }
    }

    @keyframes shine {
      to { background-position: 200% center; }
    }

    .nav-links {
      list-style: none;
      display: flex;
      gap: 1.5rem;
    }

    .nav-links a {
      color: white;
      text-decoration: none;
      position: relative;
      padding: 0.5rem 0;
      font-weight: 500;
      transition: all 0.3s ease;
    }

    .nav-links a::after {
      content: '';
      position: absolute;
      bottom: 0;
      left: 0;
      width: 0;
      height: 2px;
      background: linear-gradient(90deg, #ff8a00, #e52e71);
      transition: width 0.3s ease;
    }

    .nav-links a:hover::after { width: 100%; }
    .nav-links a:hover { transform: translateY(-2px); }

    .badge {
      position: relative;
      top: -5px;
      animation: pulse 1.5s infinite;
    }

    @keyframes pulse {
      0% { transform: scale(1); }
      50% { transform: scale(1.1); }
      100% { transform: scale(1); }
    }

    /* Product Grid Styles */
    .container {
      max-width: 1200px;
      margin: 2rem auto;
      padding: 0 2rem;
    }

    .card-header {
      font-size: 1.5rem;
      font-weight: bold;
      margin-bottom: 1.5rem;
      text-align: center;
      padding: 1rem;
      background: linear-gradient(135deg, #f5f5f5, #e0e0e0);
      border-radius: 8px;
      box-shadow: 0 2px 4px rgba(0,0,0,0.1);
    }

    .product-grid {
      display: grid;
      grid-template-columns: repeat(auto-fill, minmax(300px, 1fr));
      gap: 2rem;
      animation: fadeIn 1s ease-in;
    }

    @keyframes fadeIn {
      0% { opacity: 0; transform: translateY(20px); }
      100% { opacity: 1; transform: translateY(0); }
    }

    .product-card {
      background: white;
      border-radius: 8px;
      box-shadow: 0 2px 8px rgba(0,0,0,0.1);
      overflow: hidden;
      display: flex;
      flex-direction: column;
      transition: all 0.3s ease;
      animation: floatCard 3s ease-in-out infinite, fadeInCard 1s ease forwards;
    }

    .card-img-top {
      width: 100%;
      height: 200px;
      object-fit: cover;
      transition: transform 0.3s ease;
    }

    .product-card:hover .card-img-top { transform: scale(1.03); }

    .card-body {
      padding: 1.5rem;
      flex: 1;
      display: flex;
      flex-direction: column;
      justify-content: space-between;
    }

    .card-title {
      font-size: 1.1rem;
      font-weight: 600;
      margin-bottom: 0.5rem;
      color: #333;
    }

    .price, .category {
      font-size: 0.9rem;
      margin: 0.25rem 0;
      color: #666;
    }

    .price {
      font-weight: bold;
      color: #e52e71;
    }

    .btn-group {
      margin-top: 1rem;
      display: flex;
      justify-content: space-between;
    }

    .btn {
      padding: 0.5rem 1rem;
      border: none;
      border-radius: 4px;
      color: white;
      text-decoration: none;
      font-size: 0.9rem;
      cursor: pointer;
      text-align: center;
      transition: all 0.3s ease;
      flex: 1;
      margin: 0 0.25rem;
    }

    .btn-dark { background-color: #333; }
    .btn-primary { background-color: #007bff; }
    .btn:hover {
      transform: translateY(-2px);
      box-shadow: 0 4px 8px rgba(0,0,0,0.1);
    }

    @keyframes floatCard {
      0% {
        transform: translateY(0px);
        box-shadow: 0 2px 8px rgba(0,0,0,0.1);
      }
      50% {
        transform: translateY(-5px);
        box-shadow: 0 6px 12px rgba(0,0,0,0.2);
      }
      100% {
        transform: translateY(0px);
        box-shadow: 0 2px 8px rgba(0,0,0,0.1);
      }
    }

    @keyframes fadeInCard {
      from { opacity: 0; transform: translateY(10px); }
      to { opacity: 1; transform: translateY(0); }
    }

    .add-to-cart-btn, .buy-now-btn {
      position: relative;
      overflow: hidden;
      z-index: 1;
      transition: all 0.4s cubic-bezier(0.175, 0.885, 0.32, 1.275);
    }

    .add-to-cart-btn::before, .buy-now-btn::before {
      content: '';
      position: absolute;
      top: 0;
      left: -100%;
      width: 100%;
      height: 100%;
      background: linear-gradient(90deg, transparent, rgba(255,255,255,0.2), transparent);
      transition: all 0.5s;
      z-index: -1;
    }

    .add-to-cart-btn:hover::before { left: 100%; }
    .buy-now-btn:hover::before { width: 100%; }

    .add-to-cart-btn:hover, .buy-now-btn:hover {
      transform: translateY(-3px) scale(1.05);
      box-shadow: 0 5px 15px rgba(0,0,0,0.3);
    }

    @keyframes buttonClick {
      0% { transform: scale(1); }
      50% { transform: scale(0.95); }
      100% { transform: scale(1); }
    }

    .btn-animate:active { animation: buttonClick 0.3s ease; }

    /* Footer Styles */
    .footer {
      background: linear-gradient(135deg, #2c3e50, #4a6491);
      color: white;
      text-align: center;
      padding: 2rem;
      font-family: 'Poppins', sans-serif;
      position: relative;
      overflow: hidden;
      box-shadow: 0 -5px 15px rgba(0, 0, 0, 0.1);
      border-top: 3px solid transparent;
      border-image: linear-gradient(90deg, #ff8a00, #e52e71, #ff8a00);
      border-image-slice: 1;
    }

    .footer-content {
      position: relative;
      z-index: 1;
      max-width: 1200px;
      margin: 0 auto;
      display: flex;
      flex-direction: column;
      align-items: center;
    }

    .footer-logo {
      font-size: 2rem;
      font-weight: 700;
      margin-bottom: 1rem;
      background: linear-gradient(90deg, #ff8a00, #e52e71, #ff8a00);
      background-size: 200% auto;
      color: transparent;
      background-clip: text;
      -webkit-background-clip: text;
      animation: shine 3s linear infinite;
    }

    .footer-links {
      display: flex;
      gap: 2rem;
      margin-bottom: 1.5rem;
      flex-wrap: wrap;
      justify-content: center;
    }

    .footer-links a {
      color: white;
      text-decoration: none;
      transition: all 0.3s ease;
      position: relative;
      padding: 0.5rem 0;
    }

    .footer-links a::after {
      content: '';
      position: absolute;
      bottom: 0;
      left: 0;
      width: 0;
      height: 2px;
      background: white;
      transition: width 0.3s ease;
    }

    .footer-links a:hover::after { width: 100%; }

    .footer-social {
      display: flex;
      gap: 1.5rem;
      margin-bottom: 1.5rem;
    }

    .footer-social a {
      color: white;
      font-size: 1.5rem;
      transition: transform 0.3s ease;
    }

    .footer-social a:hover { transform: translateY(-5px) scale(1.1); }

    .footer-copyright {
      font-size: 0.9rem;
      opacity: 0.8;
    }

    .footer-heart {
      color: #e52e71;
      animation: heartbeat 1.5s infinite;
      display: inline-block;
    }

    @keyframes heartbeat {
      0%, 100% { transform: scale(1); }
      50% { transform: scale(1.3); }
    }
    </style>
</head>

<body>

<nav class="navbar navbar-expand-lg navbar-light">
  <div class="container">
    <a class="navbar-brand" href="index.jsp">
      <i class="fas fa-shopping-bag"></i>
      ShopHaven
    </a>
    <button class="navbar-toggler" type="button" data-toggle="collapse"
      data-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false"
      aria-label="Toggle navigation">
      <span class="navbar-toggler-icon"></span>
    </button>

    <div class="collapse navbar-collapse" id="navbarSupportedContent">
      <ul class="navbar-nav ml-auto">
        <li class="nav-item active">
          <a class="nav-link" href="index.jsp"><i class="fa-solid fa-house"></i> Home</a>
        </li>
        <li class="nav-item">
          <a class="nav-link" href="cart.jsp">
            <i class="fa-solid fa-cart-shopping"></i> Cart
            <span class="badge bg-danger px-1.8"><%= (cart_List != null) ? cart_List.size() : 0 %></span>
          </a>
        </li>
        <li class="nav-item">
          <a class="nav-link" href="log-in.jsp"><i class="fa-solid fa-right-to-bracket"></i> Log-in</a>
        </li>
      </ul>
    </div>
  </div>
</nav>

<div class="container">
    <div class="card-header my-3">All Products</div>
    <div class="product-grid">
        <%-- Products data can be generated from a database or array for cleaner code --%>
        <%
        // Sample product data - in production this would come from a database
        String[][] products = {
            {"1", "New Arrival Female Shoes", "120.0", "Female Shoes", "img1.jpg"},
            {"2", "Sporty Sneakers", "85.0", "Unisex Shoes", "img2.jpg"},
            {"3", "Men's Classic Shoes", "99.0", "Male Shoes", "img3.jpg"},
            {"4", "Casual Loafers", "75.0", "Casual", "img4.jpg"},
            {"5", "Stylish Heels", "110.0", "Female Heels", "img5.jpg"},
            {"6", "Elegant Sandals", "65.0", "Sandals", "img6.jpg"},
            {"4", "Casual Loafers", "75.0", "Casual", "img4.jpg"},
            {"4", "Casual Loafers", "75.0", "Casual", "img4.jpg"},
            {"5", "Stylish Heels", "110.0", "Female Heels", "img5.jpg"}
        };
        
        for(String[] product : products) {
        %>
            <div class="product-card">
                <img class="card-img-top" src="product-images/<%= product[4] %>" alt="<%= product[1] %>">
                <div class="card-body">
                    <h5 class="card-title"><%= product[1] %></h5>
                    <h6 class="price">Price: $<%= product[2] %></h6>
                    <h6 class="category">Category: <%= product[3] %></h6>
                    <div class="mt-3 d-flex justify-content-between">
                        <a href="add-to-cart?id=<%= product[0] %>" class="btn btn-dark btn-animate action-btn add-to-cart-btn">
                            <span>Add to cart</span>
                        </a>
                        <a href="order-now?quantity=1&id=<%= product[0] %>" class="btn btn-primary btn-animate action-btn buy-now-btn">
                            <span>Buy Now</span>
                        </a>
                    </div>
                </div>
            </div>
        <% } %>
    </div>
</div>

<footer class="footer">
  <div class="footer-content">
    <div class="footer-logo">ShopHaven</div>
    <div class="footer-links">
      <a href="index.jsp">Home</a>
      <a href="about.jsp">About Us</a>
      <a href="contact.jsp">Contact</a>
      <a href="privacy.jsp">Privacy Policy</a>
      <a href="terms.jsp">Terms of Service</a>
    </div>
    <div class="footer-social">
      <a href="#"><i class="fab fa-facebook-f"></i></a>
      <a href="#"><i class="fab fa-twitter"></i></a>
      <a href="#"><i class="fab fa-instagram"></i></a>
      <a href="#"><i class="fab fa-pinterest"></i></a>
      <a href="#"><i class="fab fa-youtube"></i></a>
    </div>
    <div class="footer-copyright">
      &copy; 2025 ShopHaven. All rights reserved. Made with <span class="footer-heart">❤️</span> for fashion lovers
    </div>
  </div>
</footer>

<script src="https://code.jquery.com/jquery-3.2.1.slim.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.12.9/dist/umd/popper.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.0.0/dist/js/bootstrap.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.7.2/js/all.min.js"></script>

<script>
// Enhanced button click effects
document.querySelectorAll('.add-to-cart-btn, .buy-now-btn').forEach(button => {
    button.addEventListener('click', function(e) {
        // Add ripple effect
        const ripple = document.createElement('span');
        ripple.classList.add('ripple-effect');
        this.appendChild(ripple);
        
        // Get click position
        const rect = this.getBoundingClientRect();
        const x = e.clientX - rect.left;
        const y = e.clientY - rect.top;
        
        // Position ripple
        ripple.style.left = `${x}px`;
        ripple.style.top = `${y}px`;
        
        // Remove ripple after animation
        setTimeout(() => {
            ripple.remove();
        }, 600);
    });
});
</script>

</body>
</html>