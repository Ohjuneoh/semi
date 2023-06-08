package vo;

public class Trainer {

	public User user;
	public Membership membership;
	public int salary;
	public int commissionPct;
	public String position;
	
	
	public User getUser() {
		return user;
	}
	public void setUser(User user) {
		this.user = user;
	}
	public Membership getMembership() {
		return membership;
	}
	public void setMembership(Membership membership) {
		this.membership = membership;
	}
	public int getSalary() {
		return salary;
	}
	public void setSalary(int salary) {
		this.salary = salary;
	}
	public int getCommissionPct() {
		return commissionPct;
	}
	public void setCommissionPct(int commissionPct) {
		this.commissionPct = commissionPct;
	}
	public String getPosition() {
		return position;
	}
	public void setPosition(String position) {
		this.position = position;
	}
	
	
}
