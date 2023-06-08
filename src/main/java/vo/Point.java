package vo;

public class Point {

	private int depositPoint;
	private int currentPoint;
	private User user;
	private Order order;
	
	Point() {}

	public int getDepositPoint() {
		return depositPoint;
	}

	public void setDepositPoint(int depositPoint) {
		this.depositPoint = depositPoint;
	}

	public int getCurrentPoint() {
		return currentPoint;
	}

	public void setCurrentPoint(int currentPoint) {
		this.currentPoint = currentPoint;
	}

	public User getUser() {
		return user;
	}

	public void setUser(User user) {
		this.user = user;
	}

	public Order getOrder() {
		return order;
	}

	public void setOrder(Order order) {
		this.order = order;
	}
}
