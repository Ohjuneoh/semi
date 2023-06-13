package dao;

import java.util.List;

import util.DaoHelper;
import vo.Gym;

public class GymDao {
	
	private GymDao() {}
	
	public static GymDao instance = new GymDao();
	public static GymDao getinstance() {
		return instance;
	}
	public void insertGym(Gym gym) {
		DaoHelper.update("gymDao.insertGym", 	gym.getLocationName(),
												gym.getTel(),
												gym.getName());
	}
	public Gym getGymByName(String name) {
		return DaoHelper.selectOne("gymDao.getGymByNo", rs->{
			Gym gym = new Gym();
			gym.setLocationName(rs.getString("gym_location_name"));
			gym.setTel(rs.getString("gym_tel"));
			gym.setName(rs.getString("gym_name"));
			return gym;
		}, name);
		
	}
	public int totalPage() {
		return DaoHelper.selectOne("gymDao.totalPage", 
				rs -> {
					return rs.getInt("totalPage");
				});
	}
	
	public List<Gym> getGyms(int begin,int end ){
		return DaoHelper.selectList("gymDao.getGyms", rs ->{
			Gym gym = new Gym();
			gym.setNo(rs.getInt("gym_no"));
			gym.setLocationName(rs.getString("gym_location_name"));
			gym.setTel(rs.getString("gym_tel"));
			gym.setName(rs.getString("gym_name"));
			
			return gym;
		}, begin, end);
	}
	
	

}
