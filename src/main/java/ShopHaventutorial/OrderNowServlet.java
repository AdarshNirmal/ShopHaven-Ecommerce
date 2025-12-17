package ShopHaventutorial;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.io.PrintWriter;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.Formatter;

import ShopHavenconnection.DBconnection;
import ShopHavenmodel.User;
import ShopHavenmodelDao.OrderDuo;
import ShopHavenmodelDao.cart;
import ShopHavenmodel.Order;
import ShopHavenmodel.Product;


/**
 * Servlet implementation class OrderNowServlet
 */
@WebServlet("/order-now")
public class OrderNowServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
   
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		try (PrintWriter out = response.getWriter()) {  
			
			SimpleDateFormat formatter = new SimpleDateFormat("YYYY-MM-DD");
			Date date = new Date();
			
			
			User auth = (User) request.getSession().getAttribute("auth");
		if(auth !=null) {
          
			String productid = request.getParameter("id");
			int productQuantity = Integer.parseInt(request.getParameter("Quantity"));
		if (productQuantity <=0) {
			productQuantity= 1;
			}
		Order OrderModel = new Order();
		OrderModel.setId(Integer.parseInt(productid));
		OrderModel.setUid(auth.getId());
		OrderModel.setQuantity(productQuantity);
		OrderModel.setDate(formatter.format(date));
		
		OrderDuo orderDuo = new OrderDuo(DBconnection.getConnection());
		boolean result = orderDuo.insertOrder(OrderModel);
		
		if(result)	{
			ArrayList<cart> cart_List =(ArrayList<cart>)request.getSession().getAttribute("cart-list");
			if(cart_List != null) {
				for(cart c:cart_List) {
					if(c.getId()==Integer.parseInt(productid)) {
						cart_List.remove(cart_List.indexOf(c));
						break;
					}
					
				}
			
			}
			
			response.sendRedirect("order.jsp");
		}else {
			out.print("order failed");
		}
		
		}else {
			response.sendRedirect("login.jsp");
		}
	}catch (Exception e) {
		e.printStackTrace();
	}
	
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}