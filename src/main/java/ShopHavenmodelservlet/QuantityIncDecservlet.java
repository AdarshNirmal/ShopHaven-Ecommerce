package ShopHavenmodelservlet;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;

import ShopHavenmodelDao.cart;

/**
 * Servlet implementation class QuantityIncDecservlet
 */
@WebServlet("/quantity-inc-dec")
public class QuantityIncDecservlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {  // Fixed syntax error here
            String action = request.getParameter("action");
            int id = Integer.parseInt(request.getParameter("id"));

            ArrayList<cart> cart_List = (ArrayList<cart>) request.getSession().getAttribute("cart-list");

            if (action != null && id >= 1) {
                if (action.equals("inc")) {
                    for (cart c : cart_List) {
                        if (c.getId() == id) {
                            int quantity = c.getQuantity();
                            quantity++;
                            c.setQuantity(quantity);
                            response.sendRedirect("cart.jsp");
                            return;  
                        }
                    }
                }
                if (action.equals("dec")) {  
                    for (cart c : cart_List) {
                        if (c.getId() == id && c.getQuantity() > 1) {
                            int quantity = c.getQuantity();
                            quantity--;
                            c.setQuantity(quantity);
                            break;
                        }
                    }
                    response.sendRedirect("cart.jsp");
                }
            } else {
                response.sendRedirect("cart.jsp");
            }
        }
    }
}
