package CSCI201Quiz;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.PrintWriter;
import java.util.stream.Collectors;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;

@WebServlet("/login")
public class LoginServlet extends HttpServlet{

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException{
		
	
	}
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException{
//		BufferedReader br = new BufferedReader(new InputStreamReader(request.getInputStream()));

		
		
		PrintWriter pw = response.getWriter();
		response.setContentType("application/json");
		response.setCharacterEncoding("UTF-8");
		
//		System.out.println(br.lines().collect(Collectors.joining("\n")));
		
		Gson gson = new Gson();
		User user = gson.fromJson(request.getReader(), User.class);
		
		if(user.getUsername() == null || user.getUsername().isBlank() || 
			user.getPassword() == null || user.getPassword().isBlank()) {
			response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
			
			Util.printJsonMsg("User info missing", pw);
			
		}
//		System.out.println(user.toString());
		
		
		User loginUser = JDBCConnector.loginUser(user.getUsername(), user.getPassword());
		
		if(loginUser != null) {
//			System.out.println(loginUser.getEmail());
			Cookie userCookie = new Cookie("username", loginUser.getUsername());
//			userCookie.setDomain("http://localhost:8081/assignmentWeb4");
//			userCookie.setPath("/");
//			userCookie.setMaxAge(-1);
			response.setStatus(HttpServletResponse.SC_OK);
			response.addCookie(userCookie);
			Util.printJsonMsg("success", pw);
		}
		else {
			response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
			Util.printJsonMsg("Invalid Username/Password.", pw);
		}
//		
//		try {
//			int userID = Integer.parseInt(result);
//			response.setStatus(HttpServletResponse.SC_OK);
//			Util.printErrorMsg(userID + "", pw);
//		} catch (Exception e) {
//			// TODO: handle exception
//			response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
//			Util.printErrorMsg(result, pw);
//		}
	}
}
