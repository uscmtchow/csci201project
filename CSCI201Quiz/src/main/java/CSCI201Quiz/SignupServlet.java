package CSCI201Quiz;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;
import com.google.gson.JsonObject;



@WebServlet("/signup")
public class SignupServlet extends HttpServlet{
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException{
		PrintWriter pw = response.getWriter();
		response.setContentType("application/json");
		response.setCharacterEncoding("UTF-8");
		
//		response.getHeaderNames().add(getServletInfo());
		response.addHeader("Access-Control-Allow-Origin", "*");
//		response.getHeaders().add("Access-Control-Allow-Origin", "*");
//		response.getHeaders().add("Access-Control-Allow-Headers", "Origin, X-Requested-With, Content-Type, Accept, Authorization");
//		response.getHeaders().add("Access-Control-Allow-Credentials", "true");
//		response.getHeaders().add("Access-Control-Allow-Methods", "GET,POST,PUT,DELETE,OPTIONS,HEAD");
		
		Gson gson = new Gson();
		User user = gson.fromJson(request.getReader(), User.class); 
		user.setBalance(3000);
		
//		System.out.println(user.toString());
		
		if(user.getUsername() == null || user.getUsername().isBlank() || 
			user.getPassword() == null || user.getPassword().isBlank() ||
			user.getEmail() == null || user.getEmail().isBlank()) {
			response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
//			Gson gson = new Gson();
//			pw.write(gson.toJson("User info missing"));
//			pw.flush();
			Util.printJsonMsg("User info missing", pw);
			
			return;
		}
		
//		System.out.println(JDBCConnector.registerUser(user.getUsername(), user.getPassword(), user.getEmail()));
		User signUpUser = JDBCConnector.registerUser(user);
		System.out.println(signUpUser.toString());
		if(signUpUser.getId() > 0) {
			Cookie userCookie = new Cookie("username", signUpUser.getUsername());
			
			response.addCookie(userCookie);
			response.setStatus(HttpServletResponse.SC_OK);
			Util.printJsonMsg("Success", pw);
		}
		else if(signUpUser.getId() == -1) {
			response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
			Util.printJsonMsg("Email already in use", pw);
		}
		else if(signUpUser.getId() == -2) {
			response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
			Util.printJsonMsg("Username already in use", pw);
		}
		else {
			response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
			Util.printJsonMsg("Error signing up user", pw);
		}
		
//		if(userID == -2) {
//			response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
//			Util.printJsonErrorMsg("Username is taken", pw);
//		}
//		else if(userID == -1) {
//			response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
//			Util.printJsonErrorMsg("Email is already registered", pw);
//		}
//		else {
//			response.setStatus(HttpServletResponse.SC_OK);
//			Util.printJsonErrorMsg(userID + "", pw);
//		}
	}
}
