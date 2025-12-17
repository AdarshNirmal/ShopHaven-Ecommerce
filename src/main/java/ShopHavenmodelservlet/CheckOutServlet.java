package ShopHavenmodelservlet;


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
import ShopHavenmodel.Order;
import ShopHavenmodel.User;
import ShopHavenmodelDao.OrderDuo;
import ShopHavenmodelDao.cart;

/**
 * Servlet implementation class CheckOutServlet
 */
@WebServlet("/cart-check-out")
public class CheckOutServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
   
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	
		try(PrintWriter outPrintWriter = response.getWriter()){
			
			SimpleDateFormat formatter = new SimpleDateFormat("YYYY-MM-DD");
			Date date = new Date();
 
		


			ArrayList<cart> cart_List =(ArrayList<cart>)request.getSession().getAttribute("cart-list");
			User auth = (User) request.getSession().getAttribute("auth");

			if (cart_List !=null && auth !=null) {
				for(cart c: cart_List) {
					Order order = new Order();
			        order.setId(c.getId());
			        order.setUid(auth.getId());
			        order.setQuantity(c.getQuantity());
			        order.setDate(formatter.format(date));
			        
			        OrderDuo orderDuo=new OrderDuo(DBconnection.getConnection());
			      Boolean result =  orderDuo.insertOrder(order);
			      if(!result)break;
				}
				
				cart_List.clear();
				response.sendRedirect("orders.jsp");
				
				
			}else {
				if (auth == null) response.sendRedirect("log-in.jsp");
				response.sendRedirect("cart.jsp");
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
