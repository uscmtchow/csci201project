package CSCI201Quiz;

public class User {
	private int id;
	private String userName;
	private String password;
	private String email;
	
	public User(String u, String e, String p) {
		//this.id = num;
		this.userName = u;
		this.email = e;
		this.password = p;
	}
	public User(int id, String username, String password, String email) {
		this(username, password, email);
		this.id = id;
	}
	
	public int getID() {
		return this.id;
	}
	public void setID(int id) {
		this.id = id;
	}
	
	public String getUserName() {
		return this.userName;
	}
	public void setUserName(String userName) {
		this.userName = userName;
	}
	
	public String getPassword() {
		return this.password;
	}
	public void setPassword(String password) {
		this.password = password;
	}
	
	public String getEmail() {
		return this.email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	@Override
	public String toString() {
		return "User [id=" + id + ", userName=" + userName + ", password=" + password + ", email=" + email + "]";
	}
}
