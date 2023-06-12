package vo;

public class Membership {

	private int no;
	private String cat;
	private String type;
	private String name;
	private String description;
	private int price;
	private double discountedRate;
	private int numOfUseDay;
	private int numOfUseWeek;
	private int numOfPause;
	private String duration;
	private int count;
	private Gym gym;
	
	public Membership() {}

	public int getNo() {
		return no;
	}

	public void setNo(int no) {
		this.no = no;
	}

	public String getCat() {
		return cat;
	}

	public void setCat(String cat) {
		this.cat = cat;
	}

	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
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

	public int getPrice() {
		return price;
	}

	public void setPrice(int price) {
		this.price = price;
	}

	public double getDiscountedRate() {
		return discountedRate;
	}

	public void setDiscountedRate(double discountedRate) {
		this.discountedRate = discountedRate;
	}

	public int getNumOfUseDay() {
		return numOfUseDay;
	}

	public void setNumOfUseDay(int numOfUseDay) {
		this.numOfUseDay = numOfUseDay;
	}

	public int getNumOfUseWeek() {
		return numOfUseWeek;
	}

	public void setNumOfUseWeek(int numOfUseWeek) {
		this.numOfUseWeek = numOfUseWeek;
	}

	public int getNumOfPause() {
		return numOfPause;
	}

	public void setNumOfPause(int numOfPause) {
		this.numOfPause = numOfPause;
	}

	public String getDuration() {
		return duration;
	}

	public void setDuration(String duration) {
		this.duration = duration;
	}

	public int getCount() {
		return count;
	}

	public void setCount(int count) {
		this.count = count;
	}

	public Gym getGym() {
		return gym;
	}

	public void setGym(Gym gym) {
		this.gym = gym;
	}

	public int getDiscountedPrice() {
		return (int)((1 - getDiscountedRate())*getPrice());
	}
	
}
