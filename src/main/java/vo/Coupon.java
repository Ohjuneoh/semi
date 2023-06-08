package vo;

import java.util.Date;

public class Coupon {

	private int no;
	private String name;
	private String description;
	private double discountRate;
	private Date startDate;
	private Date expirationDate;
	private Membership no;
	
	public Coupon() {}

	public int getNo() {
		return no;
	}

	public void setNo(int no) {
		this.no = no;
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

	public double getDiscountRate() {
		return discountRate;
	}

	public void setDiscountRate(double discountRate) {
		this.discountRate = discountRate;
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

	public Membership getNo() {
		return no;
	}

	public void setNo(Membership no) {
		this.no = no;
	}
	
	
}
