package ShopHaventutorial;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;

import ShopHavenmodelDao.cart;


@WebServlet("/remove-from-cart")
public class RemoveFromCartServelet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
   protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.setContentType("Text/html;charset=UTF-8");
		try (PrintWriter out = response.getWriter()){
			String id = request.getParameter("id");
			if(id!=null) {
				ArrayList<cart> cart_List =(ArrayList<cart>)request.getSession().getAttribute("cart-list");
				if(cart_List != null) {
					for(cart c:cart_List) {
						if(c.getId()==Integer.parseInt(id)) {
							cart_List.remove(cart_List.indexOf(c));
							break;
						}
						
					}
					response.sendRedirect("cart.jsp");
				}
				
			}else {
				response.sendRedirect("cart.jsp");
			}
			

		}
	}

}
