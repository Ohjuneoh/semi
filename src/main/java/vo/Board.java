package vo;

import java.util.Date;

public class Board {

	private int no;
	private String authority;
	private String category;
	private String title;
	private String content;
	private int viewCnt;
	private int commentCnt;
	private String deleted;
	private User id;
	private Date updateDate;
	private Date createDate;
	private int reportCnt;
	private int like;
	private int dislike;
	
	public Board() {}

	public int getNo() {
		return no;
	}

	public void setNo(int no) {
		this.no = no;
	}

	public String getAuthority() {
		return authority;
	}

	public void setAuthority(String authority) {
		this.authority = authority;
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

	public int getCommentCnt() {
		return commentCnt;
	}

	public void setCommentCnt(int commentCnt) {
		this.commentCnt = commentCnt;
	}

	public String getDeleted() {
		return deleted;
	}

	public void setDeleted(String deleted) {
		this.deleted = deleted;
	}

	public User getId() {
		return id;
	}

	public void setId(User id) {
		this.id = id;
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

	public int getReportCnt() {
		return reportCnt;
	}

	public void setReportCnt(int reportCnt) {
		this.reportCnt = reportCnt;
	}
	
	
}
