package ShopHavenmodelDao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.*;
import ShopHavenmodel.*;


public class productdao {
		private Connection connection;
		private String query;
		private PreparedStatement pst;
		 private ResultSet rs;
		public productdao(Connection connection) {
			super();
			this.connection = connection;
		}
		 
		 public List<Product>getAllProducts(){
			List<Product>product=new ArrayList<Product>();
			
			try {
				query="select * from products";
				pst = this.connection.prepareStatement(query);
				rs=pst.executeQuery();
				while(rs.next()) {
				Product row=new Product();
				row.setId(rs.getInt("id"));
				row.setName(rs.getString("name"));
				row.setCategory(rs.getString("category"));
				row.setPrice(rs.getDouble("price"));
				row.setImage(rs.getString("image"));
				
				product.add(row);
				
				}
			}catch (Exception e) {
				e.printStackTrace();
				
				 
			}
			return product;
			}
		 
		 
		 public List<cart> getCartProduct(ArrayList<cart>cartlList){
		 List<cart>products=new ArrayList<cart>();
		 try {
			 if(cartlList.size() > 0) {
				 for(cart item:cartlList) {
					 query="select * from products where id=?";
					 pst=this.connection.prepareStatement(query);
					 pst.setInt(1,item.getId());
					 rs=pst.executeQuery();
					 while(rs.next()) {
						 cart row=new cart();
						 row.setId(rs.getInt("id"));
						 row.setName(rs.getString("name"));
						 row.setCategory(rs.getString("category"));
						 row.setPrice(rs.getDouble("price")*item.getQuantity());
						 row.setQuantity(item.getQuantity());
						 products.add(row);
						 
			 }
			 }
			 }
		 }catch (Exception e) {
			 System.out.println(e.getMessage());
			// e.printStackTrace();
			
		}
		 return products;
		 
		 }   
		 
		 public Product getSingleProduct(int id) {
			 Product row = null;
		        try {
		            query = "select * from products where id=? ";

		            pst = this.connection.prepareStatement(query);
		            pst.setInt(1, id);
		            ResultSet rs = pst.executeQuery();

		            while (rs.next()) {
		            	row = new Product();
		                row.setId(rs.getInt("id"));
		                row.setName(rs.getString("name"));
		                row.setCategory(rs.getString("category"));
		                row.setPrice(rs.getDouble("price"));
		                row.setImage(rs.getString("image"));
		            }
		        } catch (Exception e) {
		            e.printStackTrace();
		            System.out.println(e.getMessage());
		        }

		        return row;
		    }
		 
		 
		 
		 
		 public double getTotalCartPrice(ArrayList<cart>cartlList) {
			 double sum=0;
			 
			 try {
				 if(cartlList.size()>0) {
					 for(cart item:cartlList) {
						 query="select price from products where id=?";
						 pst=this.connection.prepareStatement(query);
						 pst.setInt(1,item.getId());
						 rs=pst.executeQuery();
						 
						 while(rs.next()) {
							 sum+=rs.getDouble("price")*item.getQuantity();
						 }
					 }
				 }
				
			 }catch (Exception e) {
                e.printStackTrace();
			 }
			 
			 return sum;
		 }
		 
		 
		 
		 
		 
		   }	 
		 

 







         