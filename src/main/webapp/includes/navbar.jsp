<style>
	.navbar-nav .nav-link {
		position: relative;
		display: inline-block;
		color: #333;
		font-weight: 500;
		transition: color 0.3s ease;
	}

	.navbar-nav .nav-link::after {
		content: "";
		position: absolute;
		left: 50%;
		bottom: 0;
		transform: translateX(-50%) scaleX(0);
		transform-origin: center;
		width: 80%;
		height: 2px;
		background-color: #007bff;
		transition: transform 0.3s ease;
	}

	.navbar-nav .nav-link:hover {
		color: #007bff;
	}

	.navbar-nav .nav-link:hover::after {
		transform: translateX(-50%) scaleX(1);
	}

	.navbar-toggler {
		border: none;
	}

	.navbar-toggler-icon {
		background-image: url("data:image/svg+xml,..."); /* use Bootstrap default or custom */
	}
</style>

<nav class="navbar navbar-expand-lg navbar-light bg-light">
	<div class="container">
		<a class="navbar-brand" href="index.jsp">ShopHaven</a>
		<button class="navbar-toggler" type="button" data-toggle="collapse"
			data-target="#navbarSupportedContent"
			aria-controls="navbarSupportedContent" aria-expanded="false"
			aria-label="Toggle navigation">
			<span class="navbar-toggler-icon"></span>
		</button>

		<div class="collapse navbar-collapse" id="navbarSupportedContent">
			<ul class="navbar-nav ml-auto">
				<li class="nav-item active">
					<a class="nav-link" href="index.jsp"><i class="fa-solid fa-house"></i></a>
				</li>
				<li class="nav-item">
					<a class="nav-link" href="cart.jsp">
						cart <span class="badge bg-danger px-1.8">${cart_list.size()}</span>
					</a>
				</li>
				<% if(auth != null) { %>
					<li class="nav-item">
						<a class="nav-link" href="orders.jsp">Orders</a>
					</li>
					<li class="nav-item">
						<a class="nav-link" href="log-out">Log-out</a>
					</li>
				<% } else { %>
					<li class="nav-item">
						<a class="nav-link" href="log-in.jsp">Log-in</a>
					</li>
				<% } %>
			</ul>
		</div>
	</div>
</nav>
