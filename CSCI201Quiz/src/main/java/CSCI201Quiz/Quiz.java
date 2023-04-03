package CSCI201Quiz;

public class Quiz {
	private String name;
	private String description;
	private String image_location;
	private int category_id;
	public Quiz(String name, String description, String image_location, int category_id) {
		super();
		this.name = name;
		this.description = description;
		this.image_location = image_location;
		this.category_id = category_id;
	}
	
	
	public String getName() {
		return name;
	}


	public void setName(String name) {
		this.name = name;
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


	public int getCategory_id() {
		return category_id;
	}


	public void setCategory_id(int category_id) {
		this.category_id = category_id;
	}


	@Override
	public String toString() {
		return "Quiz [name=" + name + ", description=" + description + ", image_location=" + image_location
				+ ", category_id=" + category_id + "]";
	}
	
	
}
