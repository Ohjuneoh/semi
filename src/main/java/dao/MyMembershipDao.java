package dao;

import java.util.List;

import util.DaoHelper;
import vo.Membership;
import vo.MyMembership;
import vo.User;
import vo.Order;
import vo.Gym;
import java.sql.SQLException;
import java.time.LocalDate;


public class MyMembershipDao {
	
	private static MyMembershipDao instance = new MyMembershipDao();
	private MyMembershipDao() {}
	public static MyMembershipDao getInstance() {
		return instance;
	}
	
	public void insertMyMembership(MyMembership myMembership){
		DaoHelper.update("MyMembershipDao.insertMyMembership", myMembership.getUser().getId(),
															   myMembership.getMembership().getNo(),
															   myMembership.getOrder().getNo(),
															   myMembership.getStatus(),
															   myMembership.getStartDate(),
															   java.sql.Date.valueOf(myMembership.getExpirationDate()),
															   myMembership.getCount());
	}

	public List<MyMembership> getAllMyMembership(String userId, int begin, int end){
		return DaoHelper.selectList("MyMembershipDao.getAllMyMembership", rs -> {
			MyMembership myMembership = new MyMembership();
			myMembership.setNo(rs.getInt("my_membership_no"));
			
			User user = new User();
			user.setId(rs.getString("user_id"));
			myMembership.setUser(user);
			
			Order order = new Order();
			order.setNo(rs.getInt("order_no"));
			myMembership.setOrder(order);
			
			myMembership.setCount(rs.getInt("my_membership_cnt"));
			myMembership.setStatus(rs.getString("my_membership_status"));
			myMembership.setStartDate(rs.getDate("my_membership_start_date"));
			
			java.sql.Date expirationDateSql = rs.getDate("my_membership_expiration_date");
			LocalDate expirationDate = expirationDateSql.toLocalDate();
			myMembership.setExpirationDate(expirationDate);
			
			Membership membership = new Membership();
			membership.setNo(rs.getInt("membership_no"));
			membership.setName(rs.getString("membership_name"));
			membership.setType(rs.getString("membership_type"));
			membership.setCat(rs.getString("membership_cat"));
			membership.setDescription(rs.getString("membership_description"));
			membership.setPrice(rs.getInt("membership_price"));
			membership.setNumOfUseDay(rs.getInt("membership_num_of_use_day"));
			membership.setNumOfUseWeek(rs.getInt("membership_num_of_use_week"));
			membership.setNumOfPause(rs.getInt("membership_num_of_pause"));
			membership.setDuration(rs.getString("membership_duration"));
			membership.setCount(rs.getInt("membership_cnt"));
			membership.setDiscountedRate(rs.getDouble("membership_discounted_rate"));
			
			Gym gym = new Gym();
			gym.setNo(rs.getInt("gym_no"));
			gym.setName(rs.getString("gym_name"));
			membership.setGym(gym);
			
			myMembership.setMembership(membership);
			
			return myMembership; 
		}, userId, begin, end);
	}
	
	
	public MyMembership getMyMembershipDetail(String userId, int myMembershipNo) {
		return DaoHelper.selectOne("MyMembershipDao.getMyMembershipDetail", rs -> {
			MyMembership myMembership = new MyMembership();
			myMembership.setNo(rs.getInt("my_membership_no"));
			
			User user = new User();
			user.setId(rs.getString("user_id"));
			myMembership.setUser(user);
			
			Order order = new Order();
			order.setNo(rs.getInt("order_no"));
			myMembership.setOrder(order);
			
			myMembership.setCount(rs.getInt("my_membership_cnt"));
			myMembership.setStatus(rs.getString("my_membership_status"));
			myMembership.setStartDate(rs.getDate("my_membership_start_date"));
			
			java.sql.Date expirationDateSql = rs.getDate("my_membership_expiration_date");
			LocalDate expirationDate = expirationDateSql.toLocalDate();
			myMembership.setExpirationDate(expirationDate);
			myMembership.setRestartDate(rs.getDate("my_membership_restart_date"));
			myMembership.setPauseDate(rs.getDate("my_membership_pause_date"));
			
			Membership membership = new Membership();
			membership.setNo(rs.getInt("membership_no"));
			membership.setName(rs.getString("membership_name"));
			membership.setType(rs.getString("membership_cat"));
			membership.setCat(rs.getString("membership_type"));
			membership.setDescription(rs.getString("membership_description"));
			membership.setPrice(rs.getInt("membership_price"));
			membership.setDiscountedRate(rs.getDouble("membership_discounted_rate"));
			membership.setNumOfUseDay(rs.getInt("membership_num_of_use_day"));
			membership.setNumOfUseWeek(rs.getInt("membership_num_of_use_week"));
			membership.setNumOfPause(rs.getInt("membership_num_of_pause"));
			membership.setDuration(rs.getString("membership_duration"));
			membership.setCount(rs.getInt("membership_cnt"));
			
			
			Gym gym = new Gym();
			gym.setNo(rs.getInt("gym_no"));
			gym.setName(rs.getString("gym_name"));
			membership.setGym(gym);
			
			myMembership.setMembership(membership);
			
			return myMembership; 
		}, userId, myMembershipNo);
	}
	
	public int getTotalDays(int orderNo) {
	    return DaoHelper.selectOne("MyMembershipDao.getTotalDays", rs -> { 
	        try {
	            return rs.getInt("totalDays"); 
	        } catch (SQLException e) {
	            throw new RuntimeException(e);
	        }
	    }, orderNo);
	}

	public int getRemainingDays(int orderNo) {
		return DaoHelper.selectOne("MyMembershipDao.getRemainingDays", rs -> { 
	        try {
	            return rs.getInt("remainingDays"); 
	        } catch (SQLException e) {
	            throw new RuntimeException(e);
	        }
	    }, orderNo);
	}
	
	
	public int getTotalRows() {
		return DaoHelper.selectOne("myMembershipDao.getTotalRows", rs ->{
			return rs.getInt("cnt");
			
		});
	}
	
	/**
	 * 관리자가 회원 관리할 때 유저가 가지고 있는 모든 이용권 리스트(페이징처리 안된 것)
	 * @param loginId
	 * @return
	 */
	public List<MyMembership> getUsersMemberships(String userId){
		return DaoHelper.selectList("MyMembershipDao.getUsersMemberships", rs ->{
			MyMembership myMembership = new MyMembership();
			myMembership.setNo(rs.getInt("my_membership_no"));
			
			User user = new User();
			user.setId(rs.getString("user_id"));
			myMembership.setUser(user);
			
			Order order = new Order();
			order.setNo(rs.getInt("order_no"));
			myMembership.setOrder(order);
			
			myMembership.setCount(rs.getInt("my_membership_cnt"));
			myMembership.setStatus(rs.getString("my_membership_status"));
			myMembership.setStartDate(rs.getDate("my_membership_start_date"));
			
			java.sql.Date expirationDateSql = rs.getDate("my_membership_expiration_date");
			LocalDate expirationDate = expirationDateSql.toLocalDate();
			myMembership.setExpirationDate(expirationDate);
			myMembership.setRestartDate(rs.getDate("my_membership_restart_date"));
			myMembership.setPauseDate(rs.getDate("my_membership_pause_date"));
			
			Membership membership = new Membership();
			membership.setNo(rs.getInt("membership_no"));
			membership.setName(rs.getString("membership_name"));
			membership.setType(rs.getString("membership_cat"));
			membership.setCat(rs.getString("membership_type"));
			membership.setDescription(rs.getString("membership_description"));
			membership.setPrice(rs.getInt("membership_price"));
			membership.setDiscountedRate(rs.getDouble("membership_discounted_rate"));
			membership.setNumOfUseDay(rs.getInt("membership_num_of_use_day"));
			membership.setNumOfUseWeek(rs.getInt("membership_num_of_use_week"));
			membership.setNumOfPause(rs.getInt("membership_num_of_pause"));
			membership.setDuration(rs.getString("membership_duration"));
			membership.setCount(rs.getInt("membership_cnt"));
			
			
			Gym gym = new Gym();
			gym.setNo(rs.getInt("gym_no"));
			gym.setName(rs.getString("gym_name"));
			membership.setGym(gym);
			
			myMembership.setMembership(membership);
			
			return myMembership;
		}, userId);
	}
	
	
}
