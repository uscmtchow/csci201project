package CSCI201Quiz;

public class Answer {
//	private int id;
	private int question_id;
	private String answer_description;
	private int answer_value;
	
	public Answer(int question_id, String answer_description, int answer_value) {
		this.question_id = question_id;
		this.answer_description = answer_description;
		this.answer_value = answer_value;
	}

	public int getQuestion_id() {
		return question_id;
	}

	public void setQuestion_id(int question_id) {
		this.question_id = question_id;
	}

	public String getAnswer_description() {
		return answer_description;
	}

	public void setAnswer_description(String answer_description) {
		this.answer_description = answer_description;
	}

	public int getAnswer_value() {
		return answer_value;
	}

	public void setAnswer_value(int answer_value) {
		this.answer_value = answer_value;
	}

	@Override
	public String toString() {
		return "Answer [question_id=" + question_id + ", answer_description=" + answer_description + ", answer_value="
				+ answer_value + "]";
	}
	
	
}
