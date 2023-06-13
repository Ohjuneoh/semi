package dao;

import java.util.List;

import util.DaoHelper;
import vo.Board;
import vo.User;

public class BoardDao {
	
	private static BoardDao boardDao = new BoardDao();
	private BoardDao() {}
	public static BoardDao getInstance() {
		return boardDao;
	}

	public List<Board> getBoards(int begin, int end) {
		return DaoHelper.selectList("boardDao.getBoards", 
				rs -> {
					Board board = new Board();
					board.setNo(rs.getInt("board_no"));
					board.setTitle(rs.getString("board_title"));
					User user = new User();
					user.setId(rs.getString("user_id"));
					board.setUser(user);
					board.setCreateDate(rs.getDate("board_create_date"));
					
					return board;
				}, begin, end);
	}
	
	public List<Board> getReportBoards(int begin, int end) {
		return DaoHelper.selectList("boardDao.getReportBoards", 
				rs -> {
					Board board = new Board();
					board.setNo(rs.getInt("board_no"));
					board.setTitle(rs.getString("board_title"));
					User user = new User();
					user.setId(rs.getString("user_id"));
					board.setUser(user);
					board.setCreateDate(rs.getDate("board_create_date"));
					
					return board;
				}, begin, end);
	}
	
	public List<Board> getNotices() {
		return DaoHelper.selectList("boardDao.getNotices", 
				rs -> {
					Board board = new Board();
					board.setNo(rs.getInt("board_no"));
					board.setTitle(rs.getString("board_title"));
					User user = new User();
					user.setId(rs.getString("user_id"));
					board.setUser(user);
					board.setCreateDate(rs.getDate("board_create_date"));
					
					return board;
				});
	}

	public List<Board> getBoardsByCat(String cat, int begin, int end) {
		return DaoHelper.selectList("boardDao.getBoardsByCat", 
				rs -> {
					Board board = new Board();
					board.setNo(rs.getInt("board_no"));
					board.setTitle(rs.getString("board_title"));
					User user = new User();
					user.setId(rs.getString("user_id"));
					board.setUser(user);
					board.setCreateDate(rs.getDate("board_create_date"));
					
					return board;
				}, cat, begin, end);
	}
	
	public List<Board> getNoticesByCat(String cat) {
		return DaoHelper.selectList("boardDao.getNoticesByCat", 
				rs -> {
					Board board = new Board();
					board.setNo(rs.getInt("board_no"));
					board.setTitle(rs.getString("board_title"));
					User user = new User();
					user.setId(rs.getString("user_id"));
					board.setUser(user);
					board.setCreateDate(rs.getDate("board_create_date"));
					
					return board;
				}, cat);
	}
	
	public int totalPage() {
		return DaoHelper.selectOne("boardDao.totalPage", 
				rs -> {
					return rs.getInt("totalPage");
				});
	}
	
	public int totalPageByCat(String cat) {
		return DaoHelper.selectOne("boardDao.totalPageByCat", 
				rs -> {
					return rs.getInt("totalPage");
				}, cat);
	}
	
	public void insertBoard(Board board) {
		DaoHelper.update("boardDao.insertBoard", 
				board.getCategory(),
				board.getTitle(),
				board.getContent(),
				board.getUser().getId(),
				board.getType());
	}
	
	public Board getBoardByNo(int boardNo) {
		return DaoHelper.selectOne("boardDao.getBoardByNo", 
				rs -> {
					Board board = new Board();
					board.setNo(rs.getInt("board_no"));
					board.setCategory(rs.getString("board_cat"));
					board.setTitle(rs.getString("board_title"));
					board.setContent(rs.getString("board_content"));
					board.setViewCnt(rs.getInt("board_view_cnt"));
					board.setDeleted(rs.getString("board_deleted"));
					board.setUser(new User(rs.getString("user_id")));
					board.setUpdateDate(rs.getDate("board_update_date"));
					board.setCreateDate(rs.getDate("board_create_date"));
					board.setLike(rs.getInt("board_like"));
					board.setType(rs.getString("board_type"));
					board.setDislike(rs.getInt("board_dislike"));
					
					return board;
				}, boardNo);
	}

	public void updateBoard(Board board) {
		DaoHelper.update("boardDao.updateBoard", 
				board.getCategory(),
				board.getTitle(),
				board.getContent(),
				board.getViewCnt(),
				board.getDeleted(),
				board.getLike(),
				board.getDislike(),
				board.getNo());
	}
	
}
