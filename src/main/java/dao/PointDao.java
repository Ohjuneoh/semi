package dao;


import util.DaoHelper;
import vo.Order;
import vo.Point;
import vo.User;

public class PointDao {
	
	private PointDao() {}
	
	public static PointDao instance = new PointDao();
	public static PointDao getinstance() {
		return instance;
	}
	
	public Point getPointById(String id) {
		return DaoHelper.selectOne("pointDao.getPointById", rs ->{
			Point point = new Point();
			point.setDepositPoint(rs.getInt("deposit_point"));
			point.setCurrentPoint(rs.getInt("current_point"));
			point.setNo(rs.getInt("point_no"));
			
			Order order = new Order();
			order.setNo(rs.getInt("order_no"));
			User user = new User();
			user.setId(rs.getString("user_id"));
			return point;
			
		}, id);
		
	
	
	

	}
}
