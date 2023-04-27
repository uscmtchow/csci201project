package CSCI201Quiz;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.Vector;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;

/**
 * Servlet implementation class RecordServlet
 */
@WebServlet("/quizrecord")
public class QuizRecordServlet extends HttpServlet {

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		PrintWriter out = response.getWriter();
		response.setContentType("application/json");
		response.setCharacterEncoding("UTF-8");
		response.addHeader("Access-Control-Allow-Origin", "*");
		String username = request.getParameter("username");
		//Cookie[] ck = request.getCookies();
		//String username = ck[0].getValue();
		
		Vector<Record> v = JDBCConnector.getRecords(username);
		Gson gson = new Gson();
		if(v != null) {
			response.setStatus(HttpServletResponse.SC_OK);
			out.write(gson.toJson(v));
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
