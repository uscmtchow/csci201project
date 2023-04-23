package CSCI201Quiz;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;
import java.util.PriorityQueue;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;

@WebServlet("/question")
public class QuestionServlet extends HttpServlet{
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException{
		PrintWriter pw = response.getWriter();
		response.setContentType("application/json");
		response.setCharacterEncoding("UTF-8");
		response.addHeader("Access-Control-Allow-Origin", "*");
//		if (request.getParameterMap().containsKey("eventId")) {
//			
//		}
		Gson gson = new Gson();
		
		int quizId = Integer.parseInt(request.getParameter("quizId"));
		
//		boolean categoryUsed = false;
//		String category = "";
//		if (request.getParameterMap().containsKey("quizId")) {
//			category = request.getParameter("category");
////			categoryUsed = true;
//		}
		
		PriorityQueue<Question> questionList = JDBCConnector.getQuizQuestionsAnswers(quizId);
//		List<Quiz> quizList = JDBCConnector.getQuizzesByCategory(category);
		if(questionList == null || questionList.size() <= 0) {
			response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
			Util.printJsonMsg("error: Question Servlet", pw);
		}
//		else if (questionList.size() <= 0) {
//			response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
//			Util.printJsonMsg("error: Question Servlet", pw);
//		}
		else {
			response.setStatus(HttpServletResponse.SC_OK);
			Util.printJsonMsg(gson.toJson(questionList), pw);
		}
	}
}
