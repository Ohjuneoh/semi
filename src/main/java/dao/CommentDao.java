package dao;

import util.DaoHelper;

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
}
