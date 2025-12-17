package ShopHavenmodelservlet;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;

import ShopHavenmodelDao.cart;
/**
 * Servlet implementation class AddToCartServlet
 */
@WebServlet("/add-to-cart")
public class AddToCartServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		response.setContentType("text/html;charset=UTF-8");
		try (PrintWriter out = response.getWriter()) {
			ArrayList<cart>cartlist=new ArrayList<>();
			
			int id =Integer.parseInt(request.getParameter("id"));
			cart cmCart=new cart();
			cmCart.setId(id);
			cmCart.setQuantity(1);
			
			
			
			HttpSession session=request.getSession();
			ArrayList<cart>cart_list=(ArrayList<cart>) session.getAttribute("cart-list");
			
			
			if(cart_list==null) {
				cartlist.add(cmCart);
				session.setAttribute("cart-list",cartlist);
				out.print("session created and added the list");
			}else {
				cartlist=cart_list;
				boolean exist=false;
				
				
				for(cart c:cart_list) {
					
					if (c.getId()==id) {
						exist=true;
						out.println("<h3 style='color:crimson;text-align:center'>Item already exist in cart.<a href='cart.jsp'>Go to cart page</a></h3>");
				}
				}
					if(!exist) {
						cartlist.add(cmCart);
						response.sendRedirect("index.jsp");
						
						
				}
				
			}
	    }
	}
}

	