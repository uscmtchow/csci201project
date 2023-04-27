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

/**
 * Servlet implementation class RegistrationServlet
 */
@WebServlet("/signup")
public class SignupServlet extends HttpServlet {

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		PrintWriter out = response.getWriter();
		response.setContentType("application/json");
		response.setCharacterEncoding("UTF-8");

		response.addHeader("Access-Control-Allow-Origin", "*");
//		System.out.println("register servlet");
		Gson gson = new Gson();
		User user = gson.fromJson(request.getReader(), User.class); 
		
		if(user.getUserName() == null || user.getUserName().isBlank() || 
			user.getPassword() == null || user.getPassword().isBlank() ||
			user.getEmail() == null || user.getEmail().isBlank()) {
			response.setStatus(HttpServletResponse.SC_BAD_REQUEST);

			out.write(gson.toJson("User info missing"));
			out.flush();
			
			return;
		}
		
		User signUpUser = JDBCConnector.registerUser(user);
		//System.out.println(signUpUser.toString());
		if(signUpUser.getID() > 0) {
			Cookie userCookie = new Cookie("username", signUpUser.getUserName());
			
			response.addCookie(userCookie);
			response.setStatus(HttpServletResponse.SC_OK);
			out.write(gson.toJson("success"));
			out.flush();
		}
		else if(signUpUser.getID() == -1) {
			response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
			out.write(gson.toJson("Email already in use"));
			out.flush();
		}
		else if(signUpUser.getID() == -2) {
			response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
			out.write(gson.toJson("Username already in use"));
			out.flush();
		}
		else {
			response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
			out.write(gson.toJson("Error registering user"));
			out.flush();
		}

	}
}
