package gozon_CSCI201_FinalProject;

public class Record {
	private int record_id;
	private int user_id;
	private int quiz_id;
	private String quiz_result;
	
	
	public Record(int record_id, int user_id, int quiz_id, String quiz_result) {
		this.record_id = record_id;
		this.user_id = user_id;
		this.quiz_id = quiz_id;
		this.quiz_result = quiz_result;
	}
	
	@Override
	public String toString() {
		return "Record [record_id=" + record_id + ", user_id=" + user_id + ", quiz_id=" + quiz_id + ", quiz_result="
				+ quiz_result + "]";
	}

	public int getRecord_id() {
		return record_id;
	}
	public void setRecord_id(int record_id) {
		this.record_id = record_id;
	}
	public int getUser_id() {
		return user_id;
	}
	public void setUser_id(int user_id) {
		this.user_id = user_id;
	}
	public int getQuiz_id() {
		return quiz_id;
	}
	public void setQuiz_id(int quiz_id) {
		this.quiz_id = quiz_id;
	}
	public String getQuiz_result() {
		return quiz_result;
	}
	public void setQuiz_result(String quiz_result) {
		this.quiz_result = quiz_result;
	}
}
