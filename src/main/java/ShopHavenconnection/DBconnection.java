package ShopHavenconnection;

import java.sql.Connection;

import java.sql.Driver;
import java.sql.DriverManager;
import java.sql.SQLException;

import com.mysql.cj.exceptions.StatementIsClosedException;

public class DBconnection {
	
	private static Connection connection = null;
	
	public static Connection getConnection() throws ClassNotFoundException,SQLException{
		if (connection==null) {
			Class.forName("com.mysql.cj.jdbc.Driver");
			connection = DriverManager.getConnection("jdbc:mysql://localhost:3306/ShopHaven","root","0099");
					System.out.print("connected");
		}
		return connection;
	}
	

}
