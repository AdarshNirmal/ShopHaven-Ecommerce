package ShopHavenmodelDao;

import ShopHavenmodel.Product;

public class cart extends Product{
	private int quantity;
	public cart() {}
	
	public int getQuantity() {
		return quantity;
	}
	public void setQuantity(int quantity) {
		this.quantity = quantity;
	}

}
