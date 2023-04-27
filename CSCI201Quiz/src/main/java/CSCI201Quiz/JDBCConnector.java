package CSCI201Quiz;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.SQLIntegrityConstraintViolationException;
import java.sql.Statement;
import java.text.DecimalFormat;
import java.util.ArrayList;
import java.util.Comparator;
import java.util.HashMap;
import java.util.LinkedList;
import java.util.List;
import java.util.Map;
import java.util.PriorityQueue;
import java.util.Queue;
import java.util.Vector;

import com.mysql.cj.exceptions.DataReadException;

public class JDBCConnector {
	static final String DB_URL = "jdbc:mysql://localhost:3306/trivially_trojan";
	static final String USER = "root";
	static final String PASS = "password";
	static final Map<String, Integer> userMap = new HashMap<String, Integer>();
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
	
	
	public static PriorityQueue<Question> getQuizQuestionsAnswers(int quizId) {
		PriorityQueue<Question> questionList = getQuizQuestions(quizId);
		String QUERY = "";
		for(Question question : questionList) {
			QUERY = "SELECT * FROM Answer a "
					+" WHERE question_id=" + question.getId() +" ;";
			ResultSet rs = executeToDatabase(QUERY, "GET");
			
			LinkedList<Answer> answerQueue = new LinkedList<>();
//			List<Answer> answerList = new ArrayList<>();
			try {
				while(rs.next()) {
					Answer answer = new Answer(rs.getInt("question_id"), rs.getString("description"), rs.getInt("answer_value"));
					System.out.println(answer.toString());
					answerQueue.add(answer);
				}
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			if(answerQueue.size() != 4) {
				System.err.println("Error: getQuizQuestionsAnswers(). Question doesn't have exactly 4 answers");
				return null;
			}
			question.setAnswerList(answerQueue);
		}
		
		
		return questionList;
		
		
		
		
		
	}
	public static PriorityQueue<Question> getQuizQuestions(int quizId) {
		String QUERY = "SELECT * FROM Question q "
				+" WHERE quiz_id=" + quizId +
				" ORDER BY question_no ASC"+";";
		
		ResultSet rs = executeToDatabase(QUERY, "GET");
		if(rs == null) {
			return null;
		}
		else {
			try {
				int maxQuestions = 20;//max number of Questions should be 10 anyway
//				PriorityQueue<Question> questionList = new PriorityQueue<Question>(maxQuestions,Comparator.comparing(Question.getQuestion_no()));

				PriorityQueue<Question> questionList = new PriorityQueue<>(maxQuestions,new Comparator<Question>() {
				    public int compare(Question q1, Question q2) {
				        // compare n1 and n2
				    	if(q1.getQuestion_no()>q2.getQuestion_no()) {
				    		return 1;
				    	}
				    		  
				    	else if(q1.getQuestion_no()<q2.getQuestion_no()) {
				    		return-1;
				    	}
				    	return 0;  
				    }});

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
					Quiz quiz = new Quiz(rs.getInt("id"),rs.getString("name"), rs.getString("description"), rs.getString("image_location"), rs.getInt("category_id"));
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
	public static Quiz getQuizById(int quiz_id) {
		String QUERY = "SELECT * FROM Quiz q"
				+ " WHERE q.id=" + quiz_id + ";";
		
		ResultSet rs = executeToDatabase(QUERY, "GET");
		if(rs == null) {
			return null;
		}
		else {
			try {
//				List<Quiz> quizList = new ArrayList<>();
				
				if (rs.next()) {
					Quiz quiz = new Quiz(rs.getInt("id"), rs.getString("name"), rs.getString("description"), rs.getString("image_location"), rs.getInt("category_id"));
					System.out.println(quiz.toString());
					return quiz;
				}
				return null;
//				return quizList;
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
		

		try{

			ResultSet rs = executeToDatabase(QUERY, "GET");
			//System.out.println("hello");
			if (rs.next()) {
				
			    User user = new User(rs.getInt("id"), rs.getString("username"), rs.getString("password"), rs.getString("email"));
			    //System.out.println(user.toString()); // display inserted record  
			    return(user);
			}
			else {
				return (null);
			}
			
		}
		catch (SQLIntegrityConstraintViolationException  e) {
			e.printStackTrace();
			return null;
		}
		catch (SQLException e) {
			e.printStackTrace();
			return null;
		}	
	}
	
	// to register user 
	public static User registerUser(User u) {
		String QUERY = "INSERT INTO User(username, password, email)";
		QUERY += "VALUES('" + u.getUserName() + "','" + u.getPassword() + "','" + u.getEmail() + "');";
		
		try {
            // The newInstance() call is a work around for some
            // broken Java implementations
            Class.forName("com.mysql.cj.jdbc.Driver");
        } catch (Exception ex) {
            // handle the error
        }
        
		try{
//			String url = "jdbc:mysql://localhost:3306/CSCI201Quiz";
//			String user = "root";
//			String pass= "password";
			Connection conn = DriverManager.getConnection(DB_URL, USER, PASS);
			Statement stmt = conn.createStatement();
			
			System.out.println(QUERY);
			stmt.executeUpdate(QUERY, Statement.RETURN_GENERATED_KEYS);
			ResultSet rs = stmt.getGeneratedKeys();

			if (rs.next()) {
			    u.setID((int)rs.getLong(1)); 
			    userMap.put(u.getUserName(), (int)rs.getLong(1));
			    return u;
			} 
			
			u.setID(0);
			return (u);
			
		}
		catch (SQLIntegrityConstraintViolationException  e) {
			e.printStackTrace();
			if(e.getMessage().contains(u.getEmail())) {
				u.setID(-1);
				return (u);
			}
			else if(e.getMessage().contains(u.getUserName())) {
				u.setID(-2);
				return (u);
			}
			//System.out.println("user id: " + u.getID());
			u.setID(0);
			return (u);
		}
		catch (SQLException e) {
			e.printStackTrace();
			u.setID(0);
			return (u);
		}
	}
	
	// to get the result of the quiz based on score
	public static Result getResult(int score, int quiz_id, String username) {
		
		String QUERY = "SELECT * FROM Result r"
				+ " WHERE r.quiz_id='" + quiz_id + "' AND r.lower_bound <=" + score + " AND r.upper_bound >=" + score + ";";
		
		
		//System.out.println(QUERY);
		try{

			ResultSet rs = executeToDatabase(QUERY, "GET");

			if (rs.next()) {
			    Result r = new Result(rs.getString("image_location"), rs.getString("description"), 
			    		(int)rs.getInt("lower_bound"), (int)rs.getInt("upper_bound"), (int)rs.getInt("quiz_id"), 
			    		(int)rs.getInt("id")); 
			    //System.out.println(user.toString()); // display inserted record  
			    if(username != "") {
			    	updateRecords(username, quiz_id, rs.getInt("id"));
			    }
			    
			    return(r);
			}
			else {
				return (null);
			}
			
			// update the users records with a new score
		}
		catch (SQLIntegrityConstraintViolationException  e) {
			e.printStackTrace();
			return null;
		}
		catch (SQLException e) {
			e.printStackTrace();
			return null;
		}	
		
	}
	
	public static void updateRecords(String username, int quiz_id, int quiz_result_id) {
		
		Map<String, Integer> m = getUserIdFromUsername(username);
		
		int user_id = m.get(username);
		
		String q = "SELECT * FROM UserQuizRecord WHERE user_id=" + user_id + " AND quiz_id=" + quiz_id + ";";
		
		ResultSet r = executeToDatabase(q, "GET");
		
		try {
			if(r.next()) {
				String nq = "UPDATE UserQuizRecord SET quiz_result_id =" + quiz_result_id
						+ " WHERE user_id=" + user_id + " AND quiz_id=" + quiz_id + ";";
				ResultSet nrs = executeToDatabase(nq, "POST");
			} else {
				String QUERY = "INSERT INTO UserQuizRecord(user_id, quiz_id, quiz_result_id)";
				QUERY += "VALUES(" + user_id + "," + quiz_id + "," + quiz_result_id + ");";
		        
				ResultSet rs = executeToDatabase(QUERY, "POST");
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}

	}
	
	private static Map<String, Integer> getUserIdFromUsername (String username ) {
		String QUERY = "SELECT * FROM User u"
				+ " WHERE u.username='" + username + "';";

		Map<String, Integer> map = new HashMap<String, Integer>();
		try{

			ResultSet rs = executeToDatabase(QUERY, "GET");

			if (rs.next()) {
			    map.put(username, rs.getInt("id"));
			}
			else {
				return null;
			}
			
		} catch (SQLException e) {
			e.printStackTrace();
			return null;
		}	
		return map;
	}
	
	// returns a vector of records to 
	public static Vector<Record> getRecords(String username) {
		Vector<Record> v = new Vector<Record>();//creating vector  
		
		if(username == "") {
			return null;
		}
		
		// retrieve the user_id when given the user name
		Map<String, Integer> m = getUserIdFromUsername(username);
		
		int id = m.get(username);
		
		// make the query getting the record objects for the user
		String QUERY = "SELECT urq.*, r.*, q.* FROM UserQuizRecord urq, Result r, Quiz q"
				+ " WHERE urq.user_id=" + id + " AND r.id = urq.quiz_result_id AND q.id = urq.quiz_id;";
		
		// retrieve the result description from the record's quiz_result_id and then get the result's description
        
		try{
			ResultSet rs = executeToDatabase(QUERY, "GET");
			
			while (rs.next()) {
				try {
					v.add(new Record(id, rs.getInt("quiz_id"), rs.getString("name"), rs.getString("description"), rs.getString("image_location")));
//					v.add(new Record(rs.getInt("id"), id, rs.getInt("quiz_id"), rs.getString("description"), rs.getString("image_location")));
					//System.out.println(v.get(0).toString());
				} catch (SQLException e) {
					e.printStackTrace();
				}
				
			}
			return v;
			
		} catch (SQLException e) {
			e.printStackTrace();
			return null;
		}	
		
	}
	
	
	
	
//	public static User loginUser(String username, String password) {
//		String QUERY = "SELECT * FROM User u"
//				+ " WHERE u.username='" + username + "' AND u.password='" + password + "';";
////		QUERY += "VALUES('" + username + "','" + password + ");";
//		try {
//			Class.forName("com.mysql.jdbc.Driver");
//		} catch (ClassNotFoundException e1) {
//			// TODO Auto-generated catch block
//			e1.printStackTrace();
//		}
//
//		try{
//
//			ResultSet rs = executeToDatabase(QUERY, "GET");
//			
//			
//			if (rs.next()) {
//			    String foundUsername = rs.getString("username");
////			    System.out.println("Found username -" + foundUsername); // display inserted record
//			    User user = new User(rs.getInt("id"), rs.getString("username"), rs.getString("password"), rs.getString("email"), rs.getInt("balance"));
//			    System.out.println(user.toString()); // display inserted record
//			    
//			    if(rs.next()) {
//			    	System.out.println("Error: Multiple usernames -" + foundUsername); // display inserted record
//			    	return null;
//			    }
//			    
//			    return(user);
//			}
//			else {
//				return (null);
//			}
//			
//		}
//		catch (SQLIntegrityConstraintViolationException  e) {
//			// TODO: handle exception
//			e.printStackTrace();
////			System.out.println (e.getMessage());
//			
////			return (e.getMessage());
//			return null;
//		}
//		catch (SQLException e) {
//			// TODO Auto-generated catch block
//			e.printStackTrace();
////			return (e.getMessage());
//			return null;
//		}
//		
//	}
//	public static User registerUser(User user) {
//		String QUERY = "INSERT INTO User(username, password, email, balance)";
//		QUERY += "VALUES('" + user.getUsername() + "','" + user.getPassword() + "','" + user.getEmail() + "'," + user.getBalance() + ");";
//		
//        try {
//			Class.forName("com.mysql.jdbc.Driver");
//		} catch (ClassNotFoundException e1) {
//			// TODO Auto-generated catch block
//			e1.printStackTrace();
//		}
//
//		try{
//			Connection conn = DriverManager.getConnection(DB_URL, USER, PASS);
//			Statement stmt = conn.createStatement();
//			stmt.executeUpdate(QUERY, Statement.RETURN_GENERATED_KEYS);
//			ResultSet rs = stmt.getGeneratedKeys();
//
//			if (rs.next()) {
//			    user.setId((int)rs.getLong(1)); 
////			    System.out.println("Inserted ID -" + id); // display inserted record
//			    return user;
//			}
//			
//			user.setId(0);
//			return (user);
//			
//		}
//		catch (SQLIntegrityConstraintViolationException  e) {
//			// TODO: handle exception
//			e.printStackTrace();
////			System.out.println (e.getMessage());
//			if(e.getMessage().contains("user.email")) {
//				user.setId(-1);
//				return (user);
//			}
//			else if(e.getMessage().contains("user.username")) {
//				user.setId(-2);
//				return (user);
//			}
//			
//			user.setId(0);
//			return (user);
//		}
//		catch (SQLException e) {
//			// TODO Auto-generated catch block
//			e.printStackTrace();
//			user.setId(0);
//			return (user);
//		}
//		
////				return 1;
//	}
}
