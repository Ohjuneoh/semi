package dao;

import java.util.List;

import util.DaoHelper;
import vo.Membership;
import vo.MyMembership;
import vo.User;
import vo.Order;
import vo.Gym;
import java.time.LocalDate;

public class MyMembershipDao {

	private static MyMembershipDao instance = new MyMembershipDao();

	private MyMembershipDao() {
	}

	public static MyMembershipDao getInstance() {
		return instance;
	}

	public void insertMyMembership(MyMembership myMembership) {
		DaoHelper.update("MyMembershipDao.insertMyMembership", myMembership.getUser().getId(),
				myMembership.getMembership().getNo(), myMembership.getOrder().getNo(), myMembership.getStatus(),
				myMembership.getStartDate(), java.sql.Date.valueOf(myMembership.getExpirationDate()),
				myMembership.getCount());
	}

	public List<MyMembership> getAllMyMembership(String userId) {
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
		}, userId);
	}

	public MyMembership getMyMembershipDetail(String userId, int myMembershipNo) {
		return DaoHelper.selectOne("MyMembershipDao.getAllMyMembership", rs -> {
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
		}, userId, myMembershipNo);
	}

	public MyMembership getMyMembershipByIdAndNo(String userId, int memNo) {
		return DaoHelper.selectOne("MyMembershipDao.getMyMembershipByIdAndNo", rs->{
			MyMembership mymem = new MyMembership();
			
			Order order = new Order();
			order.setNo(rs.getInt("order_no"));
			
			mymem.setOrder(order);
			
			mymem.setStatus(rs.getString("my_membership_status"));
			mymem.setStartDate(rs.getDate("my_membership_start_date"));
			mymem.setExpirationDate(rs.getDate("my_membership_expiration_date").toLocalDate());
			mymem.setRestartDate(rs.getDate("my_membership_restart_date"));
			mymem.setPauseDate(rs.getDate("my_membership_pause_date"));
			mymem.setNo(rs.getInt("my_membership_no"));
			mymem.setCount(rs.getInt("my_membership_cnt"));
			
			return mymem;
		}, userId, memNo);
	}
	
	public void updateMymembershipByIdAndNo(MyMembership mymembership) {
		DaoHelper.update("MyMembershipDao.updateMymembershipByIdAndNo", mymembership.getUser().getId(),
																		mymembership.getMembership().getNo(),
																		mymembership.getOrder().getNo(),
																		mymembership.getStatus(),
																		mymembership.getStartDate(),
																		mymembership.getExpirationDate(),
																		mymembership.getRestartDate(),
																		mymembership.getPauseDate(),
																		mymembership.getNo(),
																		mymembership.getCount()
																		);
	}

	public List<MyMembership> getGroupMyMembershipById(String userId, int begin, int end) {
		return DaoHelper.selectList("MyMembershipDao.getGroupMyMembershipById", rs -> {
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

	public int getTotalGroupMyMembershipRows(String userId) {
		return DaoHelper.selectOne("MyMembershipDao.getTotalGroupMyMembershipRows", rs->{
			return rs.getInt("cnt");
		},userId);
	}

}
