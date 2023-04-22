package gozon_CSCI201_FinalProject;

import java.sql.SQLException;
import java.sql.SQLIntegrityConstraintViolationException;
import java.util.HashMap;
import java.util.Map;
import java.util.Vector;
import java.sql.*;

public class JDBCConnector {
	static final String url = "jdbc:mysql://localhost:3306/users";
	static final String user = "root";
	static final String pass = "password";
	static final Map<String, Integer> userMap = new HashMap<String, Integer>();
	
	public static ResultSet executeToDatabase(String QUERY, String executeType) {
		
		try {
            // The newInstance() call is a work around for some
            // broken Java implementations
            Class.forName("com.mysql.cj.jdbc.Driver");
        } catch (Exception ex) {
            // handle the error
        	ex.printStackTrace();
        }
		
		try{	
			//System.out.println(QUERY);
			//System.out.println("hello");
			executeType = executeType.toUpperCase();
			Connection conn = DriverManager.getConnection(url, user, pass);
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
			e.printStackTrace();
			return null;
		}
		catch (SQLException e) {
			e.printStackTrace();
			return null;
		}
	}
	
	// returns a user 
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
			Connection conn = DriverManager.getConnection(url, user, pass);
			Statement stmt = conn.createStatement();
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
		
		// retrieve the user_id when given the user name
		Map<String, Integer> m = getUserIdFromUsername(username);
		
		int id = m.get(username);
		
		// make the query getting the record objects for the user
		String QUERY = "SELECT urq.*, r.* FROM UserQuizRecord urq, Result r"
				+ " WHERE urq.user_id=" + id + " AND r.id = urq.quiz_result_id;";
		
		// retrieve the result description from the record's quiz_result_id and then get the result's description
        
		try{
			ResultSet rs = executeToDatabase(QUERY, "GET");
			
			while (rs.next()) {
				try {
					v.add(new Record(rs.getInt("id"), id, rs.getInt("quiz_id"), rs.getString("description")));
					System.out.println(v.get(0).toString());
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
	
}






