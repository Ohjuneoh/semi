package vo;

import java.util.Date;

public class MyMembership {

	private Users user;
	private Membership membership;
	private Orders order;
	private String status;
	private Date startDate;
	private Date expirationDate;
	private Date restartDate;
	private Date pauseDate;
	
	public MyMembership() {}

	public Users getUser() {
		return user;
	}

	public void setUser(Users user) {
		this.user = user;
	}

	public Membership getMembership() {
		return membership;
	}

	public void setMembership(Membership membership) {
		this.membership = membership;
	}

	public Orders getOrder() {
		return order;
	}

	public void setOrder(Orders order) {
		this.order = order;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	public Date getStartDate() {
		return startDate;
	}

	public void setStartDate(Date startDate) {
		this.startDate = startDate;
	}

	public Date getExpirationDate() {
		return expirationDate;
	}

	public void setExpirationDate(Date expirationDate) {
		this.expirationDate = expirationDate;
	}

	public Date getRestartDate() {
		return restartDate;
	}

	public void setRestartDate(Date restartDate) {
		this.restartDate = restartDate;
	}

	public Date getPauseDate() {
		return pauseDate;
	}

	public void setPauseDate(Date pauseDate) {
		this.pauseDate = pauseDate;
	}
	
	
}
