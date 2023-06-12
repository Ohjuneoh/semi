package dao;

import java.util.List;

import util.DaoHelper;
import vo.Board;
import vo.Comment;
import vo.User;

public class CommentDao {

	private static CommentDao commentDao = new CommentDao();
	private CommentDao() {}
	public static CommentDao getInstance() {
		return commentDao;
	}
	
	public int getCommentCnt(int boardNo) {
		return DaoHelper.selectOne("commentDao.getCommentCnt", 
				rs -> {
					return rs.getInt("commentCnt");
				}, boardNo);
	}
	
	public List<Comment> getComments(int boardNo) {
		return DaoHelper.selectList("commentDao.getComments", rs -> {
			Comment comment = new Comment();
			comment.setNo(rs.getInt("com_no"));
			comment.setBoard(new Board(rs.getInt("board_no")));
			comment.setContent(rs.getString("com_content"));
			comment.setUser(new User(rs.getString("user_id")));
			
			return comment;
		}, boardNo);
	}
	
	public void insertComment(Comment comment) {
		DaoHelper.update("commentDao.insertComment", 
				comment.getBoard().getNo(),
				comment.getContent(),
				comment.getUser().getId());
	}
	
	public Comment getCommentByNo(int comNo) {
		return DaoHelper.selectOne("commentDao.getCommentByNo", 
				rs -> {
					Comment comment = new Comment();
					comment.setNo(rs.getInt("com_no"));
					comment.setContent(rs.getString("com_content"));
					comment.setBoard(new Board(rs.getInt("board_no")));
					comment.setUser(new User(rs.getString("user_id")));
					
					return comment;
				}, comNo);
	}
	
	public void deleteCommentByNo(int comNo) {
		DaoHelper.update("commentDao.deleteCommentByNo", comNo);
	}
}
