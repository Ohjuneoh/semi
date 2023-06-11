package dao;

import util.DaoHelper;
import vo.Membership;

public class MembershipDao {

	
	
	public void insertMembership(Membership membership){
		DaoHelper.update("membershipDao.insertMembership", membership.getCat(), 
														   membership.getType(),
														   membership.getName(),
														   membership.getDescription(),
														   membership.getPrice(),
														   membership.getDiscountedRate(), 
														   membership.getNumOfUseDay(),
														   membership.getNumOfUseWeek(),
														   membership.getNumOfPause(),
														   membership.getDuration(),
														   membership.getCount(),
														   membership.getGym().getNo());
		
	}
	
}
