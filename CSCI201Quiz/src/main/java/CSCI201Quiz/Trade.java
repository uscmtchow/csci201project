package CSCI201Quiz;

import java.io.Serializable;

public class Trade implements Serializable{
	//given data from https://us-west2-csci201-376723.cloudfunctions.net/explore-events/eventDetail/{ id}
	private String eventId;
	
	//extra data passed from front end
	private int quantity;

	
	
	
	public Trade(String eventId, int quantity) {
		this.eventId = eventId;
		this.quantity = quantity;
	}

	

	

	


	public String getEventId() {
		return eventId;
	}

	public void setEventId(String eventId) {
		this.eventId = eventId;
	}

	public int getQuantity() {
		return quantity;
	}

	public void setQuantity(int quantity) {
		this.quantity = quantity;
	}

	@Override
	public String toString() {
		return "Trade [eventId=" + eventId + ", quantity=" + quantity + "]";
	}
	
	
}
