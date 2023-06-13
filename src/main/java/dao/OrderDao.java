package dao;

import util.DaoHelper;
import vo.Order;

public class OrderDao {

	private OrderDao() {}
	
	public static OrderDao instance = new OrderDao();
	public static OrderDao getinstance() {
		return instance;
	}

	
	public void insertOrder(Order order) {
		DaoHelper.update("OrderDao.insertOrder", order.getMembership().getNo(),
												 order.getDiscountedPrice(),
												 order.getUsedPoint(),
												 order.getTotalCreditPrice(),
												 order.getStatus(),
												 order.getPaymentMethod(),
												 order.getUser().getId());
		
	}
	
	
}
