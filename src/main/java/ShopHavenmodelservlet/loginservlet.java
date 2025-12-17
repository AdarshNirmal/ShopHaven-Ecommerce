 package ShopHavenmodelservlet;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;

import ShopHavenconnection.DBconnection;
import ShopHavenmodel.User;
import ShopHavenmodelDao.userdao;

/**
 * Servlet implementation class loginservlet
 */
@WebServlet(name = "loginservlet", urlPatterns = { "/user-login" })
public class loginservlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
 
    
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.sendRedirect("log-in.jsp");
	}

	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.setContentType("text/html; charset=UTF-8");
		try (PrintWriter out=response.getWriter()){
			String email=request.getParameter("login-email");
			String password=request.getParameter("login-password");
			
			try {
			userdao udao=new userdao(DBconnection.getConnection());
			User user=udao.userlogin(email,password);
			
			if(user !=null)
			{ 
			request.getSession().setAttribute("auth", user);
			response.sendRedirect("index.jsp");
			
			
			
			}
			else {
				out.print("user login failed");
			}
			
		} catch (ClassNotFoundException | SQLException e) {
			
			e.printStackTrace();
		}
	}
 
}}
