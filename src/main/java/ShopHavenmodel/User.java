package ShopHavenmodel;

public class User {
	private int id;
	private String name;
	private String email;
	private String passwordString;
	
	
	
	public User() {
	}



	public User(int id, String name, String email, String passwordString) {
		this.id = id;
		this.name = name;
		this.email = email;
		this.passwordString = passwordString;
	}



	public int getId() {
		return id;
	}



	public void setId(int id) {
		this.id = id;
	}



	public String getName() {
		return name;
	}



	public void setName(String name) {
		this.name = name;
	}



	public String getEmail() {
		return email;
	}



	public void setEmail(String email) {
		this.email = email;
	}



	public String getPasswordString() {
		return passwordString;
	}



	public void setPasswordString(String passwordString) {
		this.passwordString = passwordString;
	}



	@Override
	public String toString() {
		return "User [id=" + id + ", name=" + name + ", email=" + email + ", passwordString=" + passwordString + "]";
	}
	

	

}
