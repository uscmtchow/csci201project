package CSCI201Quiz;

import java.util.LinkedList;
import java.util.List;
import java.util.PriorityQueue;

public class Question {
	private int id = -1;
	private int quiz_id;
	private int question_no;
	private String description;
	private String image_location;
	private LinkedList<Answer> answerList;
	
	
	public Question(int quiz_id, int question_no, String description, String image_location) {
		this.quiz_id = quiz_id;
		this.question_no = question_no;
		this.description = description;
		this.image_location = image_location;
	}
	public Question(int id, int quiz_id, int question_no, String description, String image_location) {
		this(quiz_id, question_no, description, image_location);
		this.id = id;
	}

	
	public Question(int id, int quiz_id, int question_no, String description, String image_location,
			LinkedList<Answer> answerList) {
		this(quiz_id, question_no, description, image_location);
		this.answerList= answerList;
	}
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public int getQuiz_id() {
		return quiz_id;
	}

	public void setQuiz_id(int quiz_id) {
		this.quiz_id = quiz_id;
	}

	public int getQuestion_no() {
		return question_no;
	}

	public void setQuestion_no(int question_no) {
		this.question_no = question_no;
	}

	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

	public String getImage_location() {
		return image_location;
	}

	public void setImage_location(String image_location) {
		this.image_location = image_location;
	}
//	public PriorityQueue<Answer> getAnswerQueue() {
//		return answerQueue;
//	}
//	public void setAnswerQueue(PriorityQueue<Answer> answerQueue) {
//		this.answerQueue = answerQueue;
//	}
//	@Override
//	public String toString() {
//		return "Question [id=" + id + ", quiz_id=" + quiz_id + ", question_no=" + question_no + ", description="
//				+ description + ", image_location=" + image_location + ", answerQueue=" + answerQueue + "]";
//	}
	public LinkedList<Answer> getAnswerList() {
		return answerList;
	}
	public void setAnswerList(LinkedList<Answer> answerList) {
		this.answerList = answerList;
	}
	@Override
	public String toString() {
		return "Question [id=" + id + ", quiz_id=" + quiz_id + ", question_no=" + question_no + ", description="
				+ description + ", image_location=" + image_location + ", answerList=" + answerList + "]";
	}
	
	
	

	
	
}
