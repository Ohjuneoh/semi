package vo;

import java.util.Date;

public class Order {

	private int no;
	private int discounteRate;
	private int totalCreditPrice;
	private String status;
	private Date createDate;
	private String paymentMethod;
	private User user;
	private Memvership memvership;
	private Coupon coupon;
	
	Order(){}

	public int getNo() {
		return no;
	}

	public void setNo(int no) {
		this.no = no;
	}

	public int getDiscounteRate() {
		return discounteRate;
	}

	public void setDiscounteRate(int discounteRate) {
		this.discounteRate = discounteRate;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	public User getUser() {
		return user;
	}

	public void setUser(User user) {
		this.user = user;
	}

	public Memvership getMemvership() {
		return memvership;
	}

	public void setMemvership(Memvership memvership) {
		this.memvership = memvership;
	}

	public Coupon getCoupon() {
		return coupon;
	}

	public void setCoupon(Coupon coupon) {
		this.coupon = coupon;
	}
}
