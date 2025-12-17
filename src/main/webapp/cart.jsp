<%@page import="java.text.DecimalFormat"%>
<%@page import="ShopHavenmodelDao.productdao"%>
<%@page import="java.util.*"%>
<%@page import="java.util.ArrayList"%>
<%@page import="ShopHavenmodelDao.cart"%>
<%@page import="ShopHavenconnection.DBconnection"%>
<%@page import="ShopHavenmodel.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%
DecimalFormat dcf = new DecimalFormat("#.##");
request.setAttribute("def", dcf);
User auth = (User) request.getSession().getAttribute("auth");
if (auth != null) {
	request.setAttribute("auth", auth);
}

ArrayList<cart> cart_List = (ArrayList<cart>) session.getAttribute("cart-list");
List<cart> cartProduct = null;
double total = 0.0;  

if (cart_List != null) {
	productdao pDao = new productdao(DBconnection.getConnection());
	cartProduct = pDao.getCartProduct(cart_List);
	total = pDao.getTotalCartPrice(cart_List); 
	request.setAttribute("cart_list", cart_List);
}
%>

<!DOCTYPE html>
<html>
<head>
<title>Cart Page</title>
<%@include file="includes/head.jsp"%>
<style type="text/css">
.table tbody td {
    vertical-align: middle;
    transition: all 0.3s ease;
}

/* Quantity Controls Styling */
.quantity-controls {
    display: flex;
    align-items: center;
    justify-content: space-between;
    width: 120px;
    margin-right: 10px;
}

.quantity-input {
    width: 50px;
    text-align: center;
    margin: 0 5px;
    font-weight: bold;
}

.btn-quantity {
    width: 30px;
    height: 30px;
    display: flex;
    align-items: center;
    justify-content: center;
    padding: 0;
    border-radius: 50%;
    transition: all 0.2s ease;
}

.btn-decre {
    order: 1; /* Positions minus button on the left */
}

.quantity-input {
    order: 2; /* Positions input in the middle */
}

.btn-incre {
    order: 3; /* Positions plus button on the right */
}

.btn-quantity:hover {
    transform: scale(1.1);
    box-shadow: 0 2px 5px rgba(0,0,0,0.1);
}

.btn-quantity:active {
    transform: scale(0.95);
}

/* Uiverse.io-style checkout button (adapted to small size) */
.checkout-button {
  padding: 0.4em 1.2em;
  border: none;
  border-radius: 5px;
  font-weight: bold;
  letter-spacing: 2px;
  text-transform: uppercase;
  cursor: pointer;
  color: #2c9caf;
  transition: all 0.3s ease, background-color 0.3s ease;
  font-size: 0.9rem;
  position: relative;
  overflow: hidden;
  outline: 2px solid #2c9caf;
  background: none;
  box-shadow: 0 2px 5px rgba(0,0,0,0.1);
}

.checkout-button:hover {
  color: #ffffff;
  transform: scale(1.05);
  outline: 2px solid #70bdca;
  box-shadow: 4px 5px 17px -4px #268391;
}

.checkout-button::before {
  content: "";
  position: absolute;
  left: -50px;
  top: 0;
  width: 0;
  height: 100%;
  background-color: #2c9caf;
  transform: skewX(45deg);
  z-index: -1;
  transition: width 0.5s ease;
}

.checkout-button:hover::before {
  width: 250%;
}

/* Enhanced Buy Now Button */
.btn-buy-now {
    position: relative;
    overflow: hidden;
    transition: all 0.3s ease;
    background: linear-gradient(135deg, #4facfe 0%, #00f2fe 100%);
    border: none;
    color: white;
    box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
    border-radius: 8px;
    padding: 0.375rem 0.75rem;
    z-index: 1;
}

.btn-buy-now:hover {
    transform: translateY(-2px);
    box-shadow: 0 7px 14px rgba(0, 0, 0, 0.15);
}

.btn-buy-now::before {
    content: '';
    position: absolute;
    top: 0;
    left: 0;
    width: 100%;
    height: 100%;
    background: linear-gradient(135deg, #00f2fe 0%, #4facfe 100%);
    opacity: 0;
    transition: opacity 0.3s ease;
    z-index: -1;
}

.btn-buy-now:hover::before {
    opacity: 1;
}

.btn-buy-now:active {
    transform: translateY(1px);
}

/* Enhanced Remove Button with "Shake" Effect */
.btn-remove {
    transition: all 0.3s ease;
    background-color: #ff6b6b;
    color: white;
    border: none;
    border-radius: 8px;
    padding: 0.375rem 0.75rem;
    box-shadow: 0 4px 6px rgba(255, 107, 107, 0.2);
    position: relative;
    overflow: hidden;
}

.btn-remove:hover {
    animation: shake 0.5s ease-in-out;
    background-color: #ff5252;
    box-shadow: 0 7px 14px rgba(255, 107, 107, 0.3);
}

.btn-remove::before {
    content: '';
    position: absolute;
    top: 50%;
    left: 50%;
    width: 5px;
    height: 5px;
    background: rgba(255, 255, 255, 0.5);
    opacity: 0;
    border-radius: 100%;
    transform: scale(1, 1) translate(-50%, -50%);
    transform-origin: 50% 50%;
}

.btn-remove:focus:not(:active)::before {
    animation: ripple 0.6s ease-out;
}

@keyframes shake {
    0%, 100% { transform: translateX(0); }
    20%, 60% { transform: translateX(-3px); }
    40%, 80% { transform: translateX(3px); }
}

@keyframes ripple {
    0% {
        transform: scale(0, 0);
        opacity: 0.5;
    }
    100% {
        transform: scale(20, 20);
        opacity: 0;
    }
}

.ripple-effect {
    position: absolute;
    border-radius: 50%;
    background-color: rgba(255, 255, 255, 0.4);
    transform: scale(0);
    animation: ripple 0.6s linear;
    pointer-events: none;
}

@keyframes ripple {
    to {
        transform: scale(2.5);
        opacity: 0;
    }
}

/* Responsive adjustments */
@media (max-width: 768px) {
    .quantity-controls {
        width: 100px;
    }
    .quantity-input {
        width: 30px;
    }
}
</style>
</head>
<body>
	<%@include file="includes/navbar.jsp"%>

	<div class="container">
		<div class="d-flex py-3">
			<h3>Total price : $ <%= total > 0 ? dcf.format(total) : "0.00" %></h3>  
			<a class="mx-3 checkout-button" href="cart-check-out">
    <i class="fas fa-shopping-cart"></i> Check Out
</a>

		</div>
		<table class="table table-light">
			<thead>
				<tr>
					<th scope="col">Name</th>
					<th scope="col">Category</th>
					<th scope="col">Price</th>
					<th scope="col">Quantity</th>
					<th scope="col">Actions</th>
				</tr>
			</thead>
			<tbody>
			<%
			if (cart_List != null && cartProduct != null) {
				for (cart c : cartProduct) {
			%>
					<tr>
						<td><%= c.getName() %></td>
						<td><%= c.getCategory() %></td>
						<td>$<%= dcf.format(c.getPrice()) %></td> 
						<td>
							<div class="d-flex align-items-center">
                                <div class="quantity-controls">
                                    <a class="btn btn-outline-secondary btn-quantity btn-decre" href="quantity-inc-dec?action=dec&id=<%= c.getId() %>">
                                        <i class="fas fa-minus"></i>
                                    </a>
                                    <input type="text" class="form-control quantity-input" value="<%= c.getQuantity() %>" readonly>
                                    <a class="btn btn-outline-secondary btn-quantity btn-incre" href="quantity-inc-dec?action=inc&id=<%= c.getId() %>">
                                        <i class="fas fa-plus"></i>
                                    </a>
                                </div>
                                <button type="submit" class="btn btn-primary btn-buy-now">
                                    <i class="fas fa-bolt"></i> Buy
                                </button>
                            </div>
						</td>
						<td>
							<a class="btn btn-outline-danger btn-remove" href="remove-from-cart?id=<%= c.getId() %>">
								<i class="fas fa-trash-alt"></i> Remove
							</a>
						</td>
					</tr>
			<%
				}
			} else {
			%>
				<tr>
					<td colspan="5" class="text-center">
						<h4 class="text-muted py-4">Your cart is empty</h4>
						<a href="index.jsp" class="btn btn-primary">
							<i class="fas fa-shopping-bag"></i> Continue Shopping
						</a>
					</td>
				</tr>
			<%
			}
			%>
			</tbody>
		</table>
	</div>

	<%@include file="includes/footer.jsp"%>
	
	<script>
	// Add smooth animations for quantity buttons
	document.querySelectorAll('.btn-quantity').forEach(button => {
	    button.addEventListener('click', function(e) {
	        // Add click effect
	        this.style.transform = 'scale(0.95)';
	        setTimeout(() => {
	            this.style.transform = 'scale(1)';
	        }, 150);
	    });
	});
	
	// Enhanced Buy Now button effect
	document.querySelectorAll('.btn-buy-now').forEach(button => {
	    button.addEventListener('click', function(e) {
	        e.preventDefault();
	        
	        // Create ripple effect
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
	        
	        // Add animation class
	        ripple.style.animation = 'ripple 0.6s linear';
	        
	        // Remove ripple after animation
	        setTimeout(() => {
	            ripple.remove();
	        }, 600);
	        
	        // Add temporary click effect
	        this.style.transform = 'scale(0.95)';
	        setTimeout(() => {
	            this.style.transform = 'scale(1)';
	            // Here you would normally redirect or process the buy action
	            alert('Proceeding to checkout for this item!');
	        }, 150);
	    });
	});

	// Enhanced Remove button effect
	document.querySelectorAll('.btn-remove').forEach(button => {
	    button.addEventListener('mouseenter', function() {
	        this.style.transform = 'scale(1.05)';
	    });
	    
	    button.addEventListener('mouseleave', function() {
	        this.style.transform = 'scale(1)';
	    });
	    
	    button.addEventListener('click', function(e) {
	        e.preventDefault();
	        
	        // Add click effect
	        this.style.transform = 'scale(0.95)';
	        
	        // Create confirmation effect
	        if (!confirm('Are you sure you want to remove this item?')) {
	            this.style.transform = 'scale(1)';
	            return;
	        }
	        
	        // Proceed with removal
	        let row = this.closest('tr');
	        row.style.transition = 'all 0.4s ease';
	        row.style.opacity = '0';
	        row.style.transform = 'translateX(100px) rotate(5deg)';
	        
	        setTimeout(() => {
	            window.location.href = this.getAttribute('href');
	        }, 400);
	    });
	});
	</script>
</body>
</html>