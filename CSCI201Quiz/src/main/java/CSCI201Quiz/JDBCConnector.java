package CSCI201Quiz;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.SQLIntegrityConstraintViolationException;
import java.sql.Statement;
import java.text.DecimalFormat;
import java.util.ArrayList;
import java.util.List;

public class JDBCConnector {
	static final String DB_URL = "jdbc:mysql://localhost:3306/CSCI201Quiz";
	static final String USER = "root";
	static final String PASS = "password";
	private static final DecimalFormat df = new DecimalFormat("0.00");
	
	
//	static String QUERY = "SELECT ClassName FROM Grades ORDER BY ClassName ASC";
	public static ResultSet executeToDatabase(String QUERY, String executeType) {
		try {
			Class.forName("com.mysql.jdbc.Driver");
		} catch (ClassNotFoundException e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
		}
		try{
			
			System.out.println(QUERY);
			executeType = executeType.toUpperCase();
			Connection conn = DriverManager.getConnection(DB_URL, USER, PASS);
			Statement stmt = conn.createStatement();
			
			if(executeType.equals("GET")) {
				ResultSet rs = stmt.executeQuery(QUERY);
				return rs;
			}
			else if(executeType.equals("POST")){
				stmt.executeUpdate(QUERY);
				return null;
			}
			else {
				System.out.println("Invalid execute Type");
				return null;
			}
		}
		catch (SQLIntegrityConstraintViolationException  e) {
			// TODO: handle exception
			e.printStackTrace();
	//		System.out.println (e.getMessage());
			
	//		return (e.getMessage());
			return null;
		}
		catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
	//		return (e.getMessage());
			return null;
		}
	}
	
	public static int getUserIdFromUsername(String username) {
		String QUERY = "SELECT u.id FROM User u"
				+ " WHERE u.username='" + username + "';";
		int id = -1;
//		QUERY += "VALUES('" + username + "','" + password + ");";
		try {
			Class.forName("com.mysql.jdbc.Driver");
		} catch (ClassNotFoundException e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
		}
		
		try{
			
			ResultSet rs = executeToDatabase(QUERY, "GET");
			if (rs.next()) {
			    id = rs.getInt("id");
			    System.out.println(id);
				
			    //should be unique usernames for each user
			    if(!rs.next()) {
					return id;
				}
				
			    System.out.println("Error getting id from username");
				return -1;
				
//			    System.out.println("Found username -" + foundUsername); // display inserted record
			    
			}
			else {
				System.out.println("Error getting id from username");
				return -1;
			}
		}
		catch (SQLIntegrityConstraintViolationException  e) {
			// TODO: handle exception
			e.printStackTrace();
//			System.out.println (e.getMessage());
			
//			return (e.getMessage());
			return -1;
		}
		catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
//			return (e.getMessage());
			return -1;
		}
	}
	public static List<Question> getQuizQuestionsAnswers(int quizId) {
		List<Question> questionList = getQuizQuestions(quizId);
		String QUERY = "";
		for(Question question : questionList) {
			QUERY = "SELECT * FROM Answer a "
					+" WHERE question_id=" + question.getId() +";";
			ResultSet rs = executeToDatabase(QUERY, "GET");
			
			List<Answer> answerList = new ArrayList<>();
			try {
				while(rs.next()) {
					Answer answer = new Answer(rs.getInt("question_id"), rs.getString("answer_description"), rs.getInt("answer_value"));
					System.out.println(answer.toString());
					answerList.add(answer);
				}
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			if(answerList.size() != 4) {
				System.err.println("Error: getQuizQuestionsAnswers(). Question doesn't have 4 answers");
				return null;
			}
			question.setAnswerList(answerList);
		}
		
		
		return questionList;
		
		
		
		
		
	}
	public static List<Question> getQuizQuestions(int quizId) {
		String QUERY = "SELECT * FROM Question q "
				+" WHERE quiz_id=" + quizId +
				" ORDER BY question_no ASC"+";";
		
		ResultSet rs = executeToDatabase(QUERY, "GET");
		if(rs == null) {
			return null;
		}
		else {
			try {
				List<Question> questionList = new ArrayList<>();
				while (rs.next()) {
					Question question = new Question(rs.getInt("id"), rs.getInt("quiz_id"), rs.getInt("question_no"), rs.getString("description"), rs.getString("image_location"));
					System.out.println(question.toString());
					questionList.add(question);
				}
				return questionList;
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
				return null;
			}
		}
		
		
		
	}
	public static List<Quiz> getQuizzesByCategory(String categoryName) {
		
		
		String QUERY = "SELECT * FROM Quiz q ";
		categoryName = categoryName.toLowerCase();
		if(categoryName.equals("")){
			QUERY += ";";
		}
		else {
			int categoryId = getCategoryIdFromName(categoryName);
			QUERY += " WHERE category_id=" + categoryId + ";";
		}
		
		
		ResultSet rs = executeToDatabase(QUERY, "GET");
		if(rs == null) {
			return null;
		}
		else {
			try {
				List<Quiz> quizList = new ArrayList<>();
				while (rs.next()) {
					Quiz quiz = new Quiz(rs.getString("name"), rs.getString("description"), rs.getString("image_location"), rs.getInt("category_id"));
					System.out.println(quiz.toString());
					quizList.add(quiz);
				}
				return quizList;
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
				return null;
			}
		}
	}
	
	public static int getCategoryIdFromName(String categoryName) {
		String QUERY = "SELECT * FROM Category c "
				+ " WHERE name='" + categoryName + "';";
		ResultSet rs = executeToDatabase(QUERY, "GET");
		
		try {
			if(rs.next()) {
				int id = rs.getInt("id");
				if(rs.next()) {
					System.out.println("getCategoryId error: non-unique category name");
					return -1;
				}
				return id;
			}
			return -1;
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			return -1;
		}
		
	}
	
	public static List<Category> getAllCategories() {
		try {
			Class.forName("com.mysql.jdbc.Driver");
		} catch (ClassNotFoundException e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
		}
		
		String QUERY = "SELECT * FROM Category c;";
		
		ResultSet rs = executeToDatabase(QUERY, "GET");
		
		List<Category> categoryList = new ArrayList<>();
		if(rs == null) {
			return null;
		}
		else {
			try {
				while(rs.next()) {
					Category category =new Category(rs.getString("name"), rs.getString("description") );
					System.out.println(category.toString());
					categoryList.add(category);
				}
				return categoryList;
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
				return null;
			}
		}
	}
	
	
	
	
	
	
	
	public static User loginUser(String username, String password) {
		String QUERY = "SELECT * FROM User u"
				+ " WHERE u.username='" + username + "' AND u.password='" + password + "';";
//		QUERY += "VALUES('" + username + "','" + password + ");";
		try {
			Class.forName("com.mysql.jdbc.Driver");
		} catch (ClassNotFoundException e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
		}

		try{

			ResultSet rs = executeToDatabase(QUERY, "GET");
			
			
			if (rs.next()) {
			    String foundUsername = rs.getString("username");
//			    System.out.println("Found username -" + foundUsername); // display inserted record
			    User user = new User(rs.getInt("id"), rs.getString("username"), rs.getString("password"), rs.getString("email"), rs.getInt("balance"));
			    System.out.println(user.toString()); // display inserted record
			    
			    if(rs.next()) {
			    	System.out.println("Error: Multiple usernames -" + foundUsername); // display inserted record
			    	return null;
			    }
			    
			    return(user);
			}
			else {
				return (null);
			}
			
		}
		catch (SQLIntegrityConstraintViolationException  e) {
			// TODO: handle exception
			e.printStackTrace();
//			System.out.println (e.getMessage());
			
//			return (e.getMessage());
			return null;
		}
		catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
//			return (e.getMessage());
			return null;
		}
		
	}
	public static User registerUser(User user) {
		String QUERY = "INSERT INTO User(username, password, email, balance)";
		QUERY += "VALUES('" + user.getUsername() + "','" + user.getPassword() + "','" + user.getEmail() + "'," + user.getBalance() + ");";
		
        try {
			Class.forName("com.mysql.jdbc.Driver");
		} catch (ClassNotFoundException e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
		}

		try{
			Connection conn = DriverManager.getConnection(DB_URL, USER, PASS);
			Statement stmt = conn.createStatement();
			stmt.executeUpdate(QUERY, Statement.RETURN_GENERATED_KEYS);
			ResultSet rs = stmt.getGeneratedKeys();

			if (rs.next()) {
			    user.setId((int)rs.getLong(1)); 
//			    System.out.println("Inserted ID -" + id); // display inserted record
			    return user;
			}
			
			user.setId(0);
			return (user);
			
		}
		catch (SQLIntegrityConstraintViolationException  e) {
			// TODO: handle exception
			e.printStackTrace();
//			System.out.println (e.getMessage());
			if(e.getMessage().contains("user.email")) {
				user.setId(-1);
				return (user);
			}
			else if(e.getMessage().contains("user.username")) {
				user.setId(-2);
				return (user);
			}
			
			user.setId(0);
			return (user);
		}
		catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			user.setId(0);
			return (user);
		}
		
//				return 1;
	}
}
