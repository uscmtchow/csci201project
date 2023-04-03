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

@WebServlet("/category")
public class CategoryServlet extends HttpServlet{
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException{
		PrintWriter pw = response.getWriter();
		response.setContentType("application/json");
		response.setCharacterEncoding("UTF-8");
		response.addHeader("Access-Control-Allow-Origin", "*");
//		if (request.getParameterMap().containsKey("eventId")) {
//			
//		}
		Gson gson = new Gson();
		List<Category> categoryList = JDBCConnector.getAllCategories();
		if(categoryList == null || categoryList.size() <= 0) {
			response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
			Util.printJsonMsg("error: Category Servlet", pw);
		}
		else {
			response.setStatus(HttpServletResponse.SC_OK);
			Util.printJsonMsg(gson.toJson(categoryList), pw);
		}
	}
}
