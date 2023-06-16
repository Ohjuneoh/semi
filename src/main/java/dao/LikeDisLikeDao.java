package dao;

import util.DaoHelper;
import vo.Board;
import vo.LikeDisLike;
import vo.User;

public class LikeDisLikeDao {

	private static LikeDisLikeDao likedisLikeDao = new LikeDisLikeDao();
	private LikeDisLikeDao() {}
	public static LikeDisLikeDao getInstance() {
		return likedisLikeDao;
	}
	
	public int totalLike(int boardNo) {
		return DaoHelper.selectOne("likeDisLikeDao.totalLike", 
				rs -> {
					return rs.getInt("totalLike");
				}, boardNo);
	}

	public int totalDisLike(int boardNo) {
		return DaoHelper.selectOne("likeDisLikeDao.totalDisLike", 
				rs -> {
					return rs.getInt("totalDisLike");
				}, boardNo);
	}
	
	public void insertLikeDisLike(LikeDisLike likeDisLike) {
		DaoHelper.update("likeDisLikeDao.insertLikeDisLike",
				likeDisLike.getBoard().getNo(),
				likeDisLike.getUser().getId(),
				likeDisLike.getType());
	}
	
	public LikeDisLike getLikeDisLikeByNoId(int boardNo, String loginId) {
		return DaoHelper.selectOne("likeDisLikeDao.getLikeDisLikeByNoId", 
				rs -> {
					LikeDisLike likeDislike = new LikeDisLike();
					likeDislike.setNo(rs.getInt("likedislike_no"));
					likeDislike.setBoard(new Board(rs.getInt("board_no")));
					likeDislike.setUser(new User(rs.getString("user_id")));
					likeDislike.setType(rs.getString("likedislike_type"));
					
					return likeDislike;
				}, boardNo, loginId);
	}
	
	public void deleteLikeDisLikeByNOId(int boardNo, String loginId) {
		DaoHelper.update("likeDisLikeDao.deleteLikeDisLikeByNOId", boardNo, loginId);
	}
}
