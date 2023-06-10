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

	public List<Board> getBoards() {
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
				});
	}

	public List<Board> getBoardsByType(String type) {
		return DaoHelper.selectList("boardDao.getBoardsByType", 
				rs -> {
					Board board = new Board();
					board.setNo(rs.getInt("board_no"));
					board.setTitle(rs.getString("board_title"));
					User user = new User();
					user.setId(rs.getString("user_id"));
					board.setUser(user);
					board.setCreateDate(rs.getDate("board_create_date"));
					
					return board;
				}, type);
	}
}
