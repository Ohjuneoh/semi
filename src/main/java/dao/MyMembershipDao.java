package dao;

import util.DaoHelper;
import vo.Membership;
import vo.MyMembership;

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

}
