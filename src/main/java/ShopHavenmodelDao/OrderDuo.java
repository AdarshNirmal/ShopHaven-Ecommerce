package ShopHavenmodelDao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;
import java.util.function.IntBinaryOperator;

import javax.swing.plaf.basic.BasicBorders;
import ShopHavenmodel.Order;
import ShopHavenmodel.Product;


public class OrderDuo {
	private Connection connection;
	private String query;
	private PreparedStatement pst;
	 private ResultSet rs;
	 
public OrderDuo (Connection connection) {
	this.connection=connection;
	
}


public boolean insertOrder(Order Model ){
	 boolean result = false;
	 
	 try {
		 query = "INSERT INTO orders (P_id, u_id,o_quantity,o_date) VALUES (?,?,?,?)";
		 pst = this.connection.prepareStatement(query);
		 pst.setInt(1, Model.getId());  
         pst.setInt(2, Model.getUid());  
         pst.setInt(3, Model.getQuantity());  
         pst.setString(4, Model.getDate()); 
		 pst.execute();
		 result=true;
		 
		 
		 
		 
	 }catch (Exception e) {
		e.printStackTrace();
	}
	 

return result;
}
public List<Order>userOrders(int id){
	List<Order>list = new ArrayList<>();
	try {
		query = "select * from orders where u_id=? order by orders.o_id desc";
		pst = this.connection.prepareStatement(query);
		pst.setInt(1, id);
		rs = pst.executeQuery();
		
		while(rs.next()) {
			Order Order = new Order();
			productdao productdao = new productdao(this.connection);
			int pId = rs.getInt("p_id");
			
			Product product = productdao.getSingleProduct(pId);
			Order.setOrderId(rs.getInt("o_id"));
			Order.setId(pId);
            Order.setName(product.getName());
            Order.setCategory(product.getCategory());
            Order.setPrice(product.getPrice()*rs.getInt("o_quantity"));
            Order.setQuantity(rs.getInt("o_quantity"));
            Order.setDate(rs.getString("o_date"));
            list.add(Order);
		}
		
		
		
	}catch (Exception e) {
		// TODO: handle exception
		e.printStackTrace();
	}
	return list;
	
}


public void cancelOrder(int id) {
    //boolean result = false;
    try {
        query = "delete from orders where o_id=?";
        pst = this.connection.prepareStatement(query);
        pst.setInt(1, id);
        pst.execute();
        //result = true;
    } catch (Exception e) {
        e.printStackTrace();
        System.out.print(e.getMessage());
    }
    //return result;
}

}	 
 


