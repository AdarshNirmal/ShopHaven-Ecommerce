<%@page import="ShopHavenmodelDao.OrderDuo"%>
<%@page import="ShopHavenmodelDao.cart"%>
<%@page import="ShopHavenconnection.DBconnection"%>
<%@page import="ShopHavenmodel.*"%>
<%@page import="java.util.*"%>
<%@page import="java.text.DecimalFormat"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
	DecimalFormat dcf = new DecimalFormat("#.##");
	request.setAttribute("dcf", dcf);
	User auth =  (User)request.getSession().getAttribute("auth");
	List<Order> orders = null;

	if (auth != null) {
		request.setAttribute("auth", auth);
		orders = new OrderDuo(DBconnection.getConnection()).userOrders(auth.getId());
	} else {
		response.sendRedirect("log-in.jsp");
	}

	ArrayList<cart> cart_List = (ArrayList<cart>) session.getAttribute("cart-list");
	if (cart_List != null) {
		request.setAttribute("cart_list", cart_List);
	}
%>
<!DOCTYPE html>
<html>
<head>
	<%@include file="/includes/head.jsp"%>
	<title>E-Commerce Cart</title>
	<style>
		/* Small Cancel Order Button */
		.cancel-btn {
			position: relative;
			display: flex;
			align-items: center;
			justify-content: center;
			gap: 3px;
			padding: 8px 12px;
			background-color: #212121;
			border: none;
			font: inherit;
			color: #e8e8e8;
			font-size: 14px;
			font-weight: 500;
			border-radius: 50px;
			cursor: pointer;
			overflow: hidden;
			transition: all 0.3s ease cubic-bezier(0.23, 1, 0.320, 1);
			text-decoration: none;
		}

		.cancel-btn span {
			position: relative;
			z-index: 2;
			display: flex;
			align-items: center;
		}

		.cancel-btn::before {
			position: absolute;
			content: '';
			width: 100%;
			height: 100%;
			translate: 0 105%;
			background-color: #F53844;
			transition: all 0.3s cubic-bezier(0.23, 1, 0.320, 1);
		}

		.cancel-btn svg {
			width: 16px;
			height: 16px;
			fill: #F53844;
			transition: all 0.3s cubic-bezier(0.23, 1, 0.320, 1);
		}

		.cancel-btn:hover {
			animation: shake 0.2s linear 1;
		}

		.cancel-btn:hover::before {
			translate: 0 0;
		}

		.cancel-btn:hover svg {
			fill: #e8e8e8;
		}

		@keyframes shake {
			0% {
				rotate: 0deg;
			}
			33% {
				rotate: 5deg;
			}
			66% {
				rotate: -5deg;
			}
			100% {
				rotate: 5deg;
			}
		}
	</style>
</head>
<body>
	<%@include file="/includes/navbar.jsp"%>

	<div class="container">
		<div class="card-header my-3">All Orders</div>
		<table class="table table-light">
			<thead>
				<tr>
					<th scope="col">Date</th>
					<th scope="col">Name</th>
					<th scope="col">Category</th>
					<th scope="col">Quantity</th>
					<th scope="col">Price</th>
					<th scope="col">Cancel</th>
				</tr>
			</thead>
			<tbody>
			<%
				if (orders != null) {
					for (Order o : orders) {
			%>
				<tr>
					<td><%= o.getDate() %></td>
					<td><%= o.getName() %></td>
					<td><%= o.getCategory() %></td>
					<td><%= o.getQuantity() %></td>
					<td><%= dcf.format(o.getPrice()) %></td>
					<td><a class="cancel-btn" href="cancel-order?id=<%= o.getOrderId() %>">
						<span>Cancel</span>
						<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24">
							<path d="M19,4H15.5L14.5,3H9.5L8.5,4H5V6H19M6,19A2,2 0 0,0 8,21H16A2,2 0 0,0 18,19V7H6V19Z"/>
						</svg>
					</a></td>
				</tr>
			<%
					}
				}
			%>
			</tbody>
		</table>
	</div>

	<%@include file="/includes/footer.jsp"%>
</body>
</html>