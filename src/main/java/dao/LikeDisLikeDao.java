package dao;

import util.DaoHelper;
import vo.LikeDisLike;

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
				likeDisLike.getNo(),
				likeDisLike.getBoard().getNo(),
				likeDisLike.getUser().getId(),
				likeDisLike.getType());
	}
}
