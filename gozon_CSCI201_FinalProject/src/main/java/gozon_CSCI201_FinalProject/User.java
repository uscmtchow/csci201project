package gozon_CSCI201_FinalProject;

public class User {
	private int id;
	private String username;
	private String password;
	private String email;
	
	public User(String u, String p) {
		//this.id = num;
		this.username = u;
		this.password = p;
	}
	public User(String u, String e, String p) {
		this(u, p);
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
		return this.username;
	}
	public void setUserName(String username) {
		this.username = username;
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
		return "User [id=" + id + ", username=" + username + ", password=" + password + ", email=" + email + "]";
	}
}
