package gozon_CSCI201_FinalProject;

public class Result {
	private String loc;
	private String description;
	private int lower;
	private int upper;
	private int result_id;
	private int quiz_id;
	
	
	
	public Result(String loc, String desc, int lower, int upper, int quiz_id, int result_id) {
		this.result_id = result_id;
		this.loc = loc;
		this.description = desc;
		this.lower = lower;
		this.upper = upper;
		this.quiz_id = quiz_id;
	}
	public String getLoc() {
		return loc;
	}
	public void setLoc(String loc) {
		this.loc = loc;
	}
	public String getDesc() {
		return description;
	}
	public void setDesc(String desc) {
		this.description = desc;
	}
	public int getLower() {
		return lower;
	}
	public void setLower(int lower) {
		this.lower = lower;
	}
	public int getUpper() {
		return upper;
	}
	public void setUpper(int upper) {
		this.upper = upper;
	}
	public int getResult_id() {
		return result_id;
	}
	public void setResult_id(int result_id) {
		this.result_id = result_id;
	}
	public int getQuiz_id() {
		return quiz_id;
	}
	public void setQuiz_id(int quiz_id) {
		this.quiz_id = quiz_id;
	}
	
}
