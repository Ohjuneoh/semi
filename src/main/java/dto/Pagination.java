package dto;

public class Pagination {

	private int page;	// 요청한 페이지 번호
	private int rows = 10;	// 한 화면에 표시할 행의 갯수
	private int pages = 5;	// 한 화면에 표시할 페이지번호 갯수
	private int totalRows;	// 전체 데이터 갯수
	
	public Pagination(int page, int totalRows) {
		this.page = page;
		this.totalRows = totalRows;
	}
	
	public int getBegin() {
		return (page - 1)* rows + 1;
	}
	public int getEnd() {
		return page*rows;
	}
	
	public int getTotalPages() {
		
		return (int) Math.ceil((double) totalRows/rows);
	}
	public int getTotalBlocks() {
		
		return (int) Math.ceil((double) getTotalPages() /pages);
	}
	public int getCurrentBlock() {
		
		return (int) Math.ceil((double) page/pages);
	}
	public int getBeginPage() {
		return (getCurrentBlock() -1)*pages +1;
	}
	public int getEndPage() {
		if(getCurrentBlock() == getTotalBlocks()) {
			return getTotalPages();
		}
		return getCurrentBlock() * pages;
	}
}
