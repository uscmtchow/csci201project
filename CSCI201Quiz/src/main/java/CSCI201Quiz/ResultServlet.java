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
 * Servlet implementation class ResultServlet
 */
@WebServlet("/result")
public class ResultServlet extends HttpServlet {

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// body should contain quiz id and the accumulated score of the user
		// read the body using gson to an object
		PrintWriter out = response.getWriter();
		response.setContentType("application/json");
		response.setCharacterEncoding("UTF-8");
		response.addHeader("Access-Control-Allow-Origin", "*");
		//Cookie[] ck = request.getCookies();
		//String username = ck[0].getValue();
		
		Gson gson = new Gson();
		
		int score = Integer.parseInt(request.getParameter("score"));
		int quiz_id = Integer.parseInt(request.getParameter("quiz_id"));
		String username = request.getParameter("username");
		
		// pass in the score and quiz ID to JDBC function -> returns the result object
		Result r = JDBCConnector.getResult(score, quiz_id, username);
		
		if(r != null) {
			response.setStatus(HttpServletResponse.SC_OK);
			out.write(gson.toJson(r));
			out.flush();
		}
		else {
			response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
			out.write("no result found");
			out.flush();
		}
		out.close();
		
	}

}
