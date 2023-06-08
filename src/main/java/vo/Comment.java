package vo;

public class Comment {

	private int no;
	private Board no;
	private String content;
	private User id;
	
	public Comment() {}

	public int getNo() {
		return no;
	}

	public void setNo(int no) {
		this.no = no;
	}

	public Board getNo() {
		return no;
	}

	public void setNo(Board no) {
		this.no = no;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public User getId() {
		return id;
	}

	public void setId(User id) {
		this.id = id;
	}
	
	
}
