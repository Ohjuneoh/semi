package dao;

import java.util.List;

import util.DaoHelper;
import vo.Membership;
import vo.Gym;

public class MembershipDao {

	
	/** 
	 * 이용권 등록하기 
	 * @param membership 입력받은 이용권정보를 전달받는다. 
	 */
	public void insertMembership(Membership membership){
		DaoHelper.update("membershipDao.insertMembership", membership.getCat(), 
														   membership.getType(),
														   membership.getName(),
														   membership.getDescription(),
														   membership.getPrice(),
														   membership.getNumOfUseDay(),
														   membership.getNumOfUseWeek(),
														   membership.getNumOfPause(),
														   membership.getDuration(),
														   membership.getCount(),
														   membership.getDiscountedRate());
		
	}
	
	/**
	 * 모든 이용권 조회하기
	 * @return 이용권 리스트를 반환한다. 
	 */
	public List<Membership> getAllMembership(){
		return DaoHelper.selectList("membershipDao.getAllMembership", rs-> {
			Membership membership = new Membership();
			membership.setNo(rs.getInt("membership_no"));
			membership.setCat(rs.getString("membership_cat"));
			membership.setType(rs.getString("membership_type"));
			membership.setName(rs.getString("membership_name"));
			membership.setPrice(rs.getInt("membership_price"));
			membership.setDiscountedRate(rs.getDouble("membership_discounted_rate"));
			return membership; 
		}); 
	}
	
	
	/**
	 * 이용권 번호를 전달받아서 이용권 상세 정보 조회하기 
	 * @param no 이용권번호 
	 * @return 이용권을 반환한다. 
	 */
	public Membership getMembershipDetailByNo(int no) {
		return DaoHelper.selectOne("membershipDao.getMembershipDetailByNo", rs -> {
			Membership membership = new Membership();
			membership.setNo(rs.getInt("membership_no"));
			membership.setCat(rs.getString("membership_cat"));
			membership.setType(rs.getString("membership_type"));
			membership.setName(rs.getString("membership_name"));
			membership.setDescription(rs.getString("membership_description"));
			membership.setPrice(rs.getInt("membership_price"));
			membership.setNumOfUseDay(rs.getInt("membership_num_of_use_day"));
			membership.setNumOfUseWeek(rs.getInt("membership_num_of_use_week"));
			membership.setNumOfPause(rs.getInt("membership_num_of_pause"));
			membership.setDuration(rs.getString("membership_duration"));
			
			Gym gym = new Gym();
			gym.setNo(rs.getInt("gym_no"));
			membership.setGym(gym);
			
			membership.setCount(rs.getInt("membership_CNT"));
			membership.setDiscountedRate(rs.getDouble("membership_discounted_rate"));
			
			return membership; 
			
		}, no);
		
	
	}
}

