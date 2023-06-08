package vo;

import java.util.Date;

public class Attendance {

	private int no;
	private User user;
	private Date in;
	private Date out;
	
	public Attendance() {}

	public int getNo() {
		return no;
	}

	public void setNo(int no) {
		this.no = no;
	}

	public User getUser() {
		return user;
	}

	public void setUser(User user) {
		this.user = user;
	}

	public Date getIn() {
		return in;
	}

	public void setIn(Date in) {
		this.in = in;
	}

	public Date getOut() {
		return out;
	}

	public void setOut(Date out) {
		this.out = out;
	}
	
	
	
}
