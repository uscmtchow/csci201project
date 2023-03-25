package com.example.demo;

public class User {
	private long id;
	private String username;
	private String email;
	private String password;

	public User( String username, String email, String password) {
		// TODO Auto-generated constructor stub
		this.username= username ;
		this.email = email;
		this.password = password;
	}
	
	public User(long id, String username, String email, String password) {
		// TODO Auto-generated constructor stub
		this(username, email, password);
		this.id = id;
		
	}
	public String getUsername() {
		return username;
	}
	
	public String getEmail() {
		return email;
	}
	
	public String getPassword() {
		return password;
	}
	
	@Override
	  public String toString() {
	    return String.format(
	        "User[id=%d, username='%s', email='%s, password='%s' ]", id, username, email, password);
	  }
}
