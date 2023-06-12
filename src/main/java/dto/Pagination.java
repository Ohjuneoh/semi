package dto;

public class Pagination {

	private int page;			// 요청한 페이지 번호
	private int rows = 10;		// 한 화면에 표시할 행의 개수
	private int pages = 5;		// 한 화면에 표시할 페이지 번호 개수
	private int totalRows;		// 전체 데이터 개수
	
	
	public Pagination(int page, int totalRows) {
		this.page = page;
		this.totalRows = totalRows;
	}
	
		public int getBegin() {			// 요청한 페이지 번호에서 첫번째 데이터 번호
		return (page - 1)*rows + 1;		// (요청한 페이지 번호 - 1)*한 화면에 표시할 행의 개수 + 1
	}
	
	public int getEnd() {				// 요청한 페이지 번호에서 마지막 데이터 번호
		return page*rows;				// 요청한 페이지 번호*한화면에 표시할 행의 개수
	}
	
	public int getTotalPages() {									// 전체 페이지 수
		return (int) Math.ceil((double) totalRows/rows);			// 전체 데이터 개수/한 화면에 표시할 행의 개수
	}	
	
	public int getTotalBlocks() {								  	// 페이지 블럭 개수
		return (int) Math.ceil((double) getTotalPages()/pages);	  	// 전체 페이지 수/한 화면에 표시할 페이지 번호 개수
	}
	
	public int getCurrentBlock() {							// 요청한 페이지가 속한 블럭의 번호
		return (int) Math.ceil((double) page/pages);		// 요청한 페이지 번호/한 화면에 표시할 페이지 번호 개수
	}

	public int getBeginPage() {						// 현재 속한 블럭의 첫 페이지 번호
		return (getCurrentBlock() - 1)*pages + 1;	// (요청한 페이지가 속한 블럭 - 1)*한 화면에 표시할 페이지 번호 개수 + 1
	}
	
	public int getEndPage() {								// 현재 속한 블럭의 마지막 페이지 번호
		if(getCurrentBlock() == getTotalBlocks()) {			// 만약 요청한 페이지가 속한 블럭의 번호가 페이지 블럭 개수랑 같다면
			return getTotalPages();							// 전체 페이지 수를 반환한다.		
		}
		return getCurrentBlock()*pages;		// 요청한 페이지가 속한 블럭의 번호*한 화면에 표시할 페이지 번호 개수를 반환한다.
	}
}
