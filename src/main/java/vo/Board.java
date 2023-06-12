package vo;

import java.util.Date;

public class Board {

	private int no;
	private String category;
	private String title;
	private String content;
	private int viewCnt;
	private String deleted;
	private User user;
	private Date updateDate;
	private Date createDate;
	private int like;
	private int dislike;
	private String type;
	
	public Board() {}
	
	public Board(int no) {
		this.no = no;
	}
	
	public User getUser() {
		return user;
	}
	public void setUser(User user) {
		this.user = user;
	}
	public String getType() {
		return type;
	}
	public void setType(String type) {
		this.type = type;
	}
	public int getNo() {
		return no;
	}

	public void setNo(int no) {
		this.no = no;
	}

	public String getCategory() {
		return category;
	}

	public void setCategory(String category) {
		this.category = category;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public int getViewCnt() {
		return viewCnt;
	}

	public void setViewCnt(int viewCnt) {
		this.viewCnt = viewCnt;
	}

	public String getDeleted() {
		return deleted;
	}

	public void setDeleted(String deleted) {
		this.deleted = deleted;
	}
	
	public Date getUpdateDate() {
		return updateDate;
	}
	
	public void setUpdateDate(Date updateDate) {
		this.updateDate = updateDate;
	}
	
	public Date getCreateDate() {
		return createDate;
	}
	
	public int getLike() {
		return like;
	}
	
	public void setLike(int like) {
		this.like = like;
	}
	
	public int getDislike() {
		return dislike;
	}
	
	public void setDislike(int dislike) {
		this.dislike = dislike;
	}
	
	public void setCreateDate(Date createDate) {
		this.createDate = createDate;
	}
}
