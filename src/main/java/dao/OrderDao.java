package dao;

import java.time.LocalDate;

import util.DaoHelper;
import vo.MyMembership;
import vo.Order;
import vo.Membership;

public class OrderDao {

	private OrderDao() {}
	
	public static OrderDao instance = new OrderDao();
	public static OrderDao getinstance() {
		return instance;
	}

	

	public int insertOrder(Order order) {
		DaoHelper.update("OrderDao.insertOrder", order.getNo(),
												 order.getMembership().getNo(),
												 order.getDiscountedPrice(),
												 order.getUsedPoint(),
												 order.getTotalCreditPrice(),
												 order.getStatus(),
												 order.getPaymentMethod(),
												 order.getUser().getId()); 
		
		int generatedOrderNo = getGeneratedOrderNo();
		return generatedOrderNo;
		
	}
	
	public int getGeneratedOrderNo() {
		return DaoHelper.selectOne("OrderDao.getGeneratedOrderNo", (rs) -> rs.getInt(1));
	}

	
	
	public MyMembership getmyOrderDetail(String userId, int orderNo) {
		return DaoHelper.selectOne("OrderDao.getMyOrder", rs -> {
			MyMembership myMembership = new MyMembership();
			
			Order order = new Order();
			order.setNo(rs.getInt("order_no"));
			order.setTotalCreditPrice(rs.getInt("order_total_credit_price"));
			order.setPaymentMethod(rs.getString("order_payment_method"));
			myMembership.setOrder(order);
			
			Membership membership = new Membership();
			membership.setName(rs.getString("membership_name"));
			membership.setPrice(rs.getInt("membership_price"));
			myMembership.setMembership(membership);
			
			myMembership.setStartDate(rs.getDate("my_membership_start_date"));
			java.sql.Date expirationDateSql = rs.getDate("my_membership_expiration_date");
			LocalDate expirationDate = expirationDateSql.toLocalDate();
			myMembership.setExpirationDate(expirationDate);
			
			
			return myMembership;
		},userId, orderNo);
	}
	
	
}
