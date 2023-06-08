package vo;

import java.util.Date;

public class Attendance {

	private int no;
	private User id;
	private Date in;
	private Date out;
	
	public Attendance() {}

	public int getNo() {
		return no;
	}

	public void setNo(int no) {
		this.no = no;
	}

	public User getId() {
		return id;
	}

	public void setId(User id) {
		this.id = id;
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
