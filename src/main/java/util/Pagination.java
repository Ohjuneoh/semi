package util;

public class Pagination {

	private int pageNo;
	private int rows = 10;
	private int pages = 5;
	private int totalRows;
	
	public Pagination(int pageNo, int totalRows) {
		this.pageNo = pageNo;
		this.totalRows = totalRows;
	}
	
	public int getPageNo() {
		return pageNo;
	}
	
	public int getTotalRows() {
		return totalRows;
	}
	
	public int getTotalPages() {
		return (int) Math.ceil((double) totalRows/rows);
	}
	
	public int getTotalBlocks() {
		return (int) Math.ceil((double) getTotalPages()/pages);
	}
	
	public int getCurrentBlock() {
		if (totalRows == 0) {
			return 0;
		}
		return (int) Math.ceil((double) pageNo/pages);
	}
	
	public int getBegin() {
		return (pageNo - 1)*rows + 1;
	}
	
	public int getEnd() {
		return pageNo*rows;
	}
	
	public int getBeginPage() {
		if (getCurrentBlock() == 0) {
			return 0;
		}
		return (getCurrentBlock() - 1)*pages + 1;
	}
	
	public int getEndPage() {
		if (getCurrentBlock() == getTotalBlocks()) {
			return getTotalPages();
		}
		return getCurrentBlock()*pages;
	}
	
	public boolean isFirstPage() {
		return pageNo <= 1;
	}
	
	public boolean isLastPage() {
		return pageNo >= getTotalPages();
	}
}
