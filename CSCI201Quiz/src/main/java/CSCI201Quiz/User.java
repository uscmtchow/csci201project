package CSCI201Quiz;

import java.io.Serializable;

public class User implements Serializable{
	private int id;
	private String username;
	private String password;
	private String email;
	private double balance;
	
	public User(String username, String password, String email) {
		this.username = username;
		this.password = password;
		this.email = email;
		this.balance = 3000.00;
		// TODO Auto-generated constructor stub
	}
	public User(String username, String password, String email, double balance) {
		this(username, password, email);
		this.balance = balance;
		// TODO Auto-generated constructor stub
	}
	public User(int id, String username, String password, String email, double balance) {
		this(username, password, email);
		this.id = id;
		this.balance = balance;
		// TODO Auto-generated constructor stub
	}
	
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public String getUsername() {
		return username;
	}
	public void setUsername(String username) {
		this.username = username;
	}
	public String getPassword() {
		return password;
	}
	public void setPassword(String password) {
		this.password = password;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public double getBalance() {
		return balance;
	}
	public void setBalance(double balance) {
		this.balance = balance;
	}
	@Override
	public String toString() {
		return "User [id=" + id + ", username=" + username + ", password=" + password + ", email=" + email
				+ ", balance=" + balance + "]";
	}
	
}
