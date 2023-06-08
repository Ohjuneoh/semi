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
	private Membership membership;
	private Coupon coupon;
	
	public Order(){}

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

	public int getTotalCreditPrice() {
		return totalCreditPrice;
	}

	public void setTotalCreditPrice(int totalCreditPrice) {
		this.totalCreditPrice = totalCreditPrice;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	public Date getCreateDate() {
		return createDate;
	}

	public void setCreateDate(Date createDate) {
		this.createDate = createDate;
	}

	public String getPaymentMethod() {
		return paymentMethod;
	}

	public void setPaymentMethod(String paymentMethod) {
		this.paymentMethod = paymentMethod;
	}

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

	public Coupon getCoupon() {
		return coupon;
	}

	public void setCoupon(Coupon coupon) {
		this.coupon = coupon;
	}

	
	
	
}
