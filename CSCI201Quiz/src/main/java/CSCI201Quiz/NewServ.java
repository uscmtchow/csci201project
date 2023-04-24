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

@WebServlet("/newserv")
public class NewServ extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public NewServ() {
        super();
    }

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		 response.setContentType("application/json");  
		 PrintWriter out = response.getWriter();  
		 System.out.println("post request");
		 Gson gson = new Gson();
		 
		 User user = gson.fromJson(request.getReader(), User.class);
			
			if(user.getUserName() == null || user.getUserName().isBlank() || 
				user.getPassword() == null || user.getPassword().isBlank()) {
				response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
				
				out.write(gson.toJson("User shma missing"));
				out.flush();
			}
			
			
			User loginUser = JDBCConnector.loginUser(user.getUserName(), user.getPassword());
			
			if(loginUser != null) {
				Cookie userCookie = new Cookie("username", loginUser.getUserName());
				userCookie.setHttpOnly(true);
				response.setStatus(HttpServletResponse.SC_OK);
				response.addCookie(userCookie);
				out.write(gson.toJson("success"));
				out.flush();
			}
			else {
				response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
				out.write(gson.toJson("Invalid username/password"));
				out.flush();
			}
		 
		 
		
	}
	
}
