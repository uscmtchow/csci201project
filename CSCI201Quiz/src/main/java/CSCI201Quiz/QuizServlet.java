package CSCI201Quiz;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;

@WebServlet("/quiz")
public class QuizServlet extends HttpServlet{
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException{
		PrintWriter pw = response.getWriter();
		response.setContentType("application/json");
		response.setCharacterEncoding("UTF-8");
		response.addHeader("Access-Control-Allow-Origin", "*");
//		if (request.getParameterMap().containsKey("eventId")) {
//			
//		}
		Gson gson = new Gson();
		
//		boolean categoryUsed = false;
		String category = "";
		int quiz_id;
		if (request.getParameterMap().containsKey("category")) {
			category = request.getParameter("category");
//			categoryUsed = true;
			List<Quiz> quizList = JDBCConnector.getQuizzesByCategory(category);
			if(quizList == null || quizList.size() <= 0) {
				response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
				Util.printJsonMsg("error: Quiz Servlet", pw);
			}
			else {
				response.setStatus(HttpServletResponse.SC_OK);
				Util.printJsonMsg(gson.toJson(quizList), pw);
			}
		}
		else if (request.getParameterMap().containsKey("quiz_id")) {
			quiz_id = Integer.parseInt(request.getParameter("quiz_id"));
//			categoryUsed = true;
			Quiz quiz = JDBCConnector.getQuizById(quiz_id);
			if(quiz == null) {
				response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
				Util.printJsonMsg("error: Quiz Servlet", pw);
			}
			else {
				response.setStatus(HttpServletResponse.SC_OK);
				Util.printJsonMsg(gson.toJson(quiz), pw);
			}
		}
		
		
		
	}
}
