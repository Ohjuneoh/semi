package dao;

import util.DaoHelper;
import vo.Gym;
import vo.Membership;
import vo.Trainer;
import vo.User;

public class UserDao {
	
	private UserDao() {}
	
	public static UserDao instance = new UserDao();
	public static UserDao getinstance() {
		return instance;
	}
	
	public void insertUser(User user) {
		DaoHelper.update("userDao.insertUser", user.getId(),
												user.getPassword(),
												user.getName(),
												user.getEmail(),
												user.getTel(),
												user.getType(),
												user.getGym().getNo());
		
		
	}
	public void insertManager(User user) {
		DaoHelper.update("userDao.insertManager", user.getId(),
												user.getPassword(),
												user.getName(),
												user.getEmail(),
												user.getTel(),
												user.getType());
	}
	
	public User getUserById(String id) {
		return DaoHelper.selectOne("userDao.getUserById", rs ->{
			User user = new User();
			user.setId(rs.getString("user_id"));
			user.setPassword(rs.getString("user_password"));
			user.setName(rs.getString("user_name"));
			user.setEmail(rs.getString("user_email"));
			user.setTel(rs.getString("user_tel"));
			user.setType(rs.getString("user_type"));
			user.setCreateDate(rs.getDate("user_create_date"));
			user.setUpdateDate(rs.getDate("user_update_date"));
			user.setStatus(rs.getString("user_status"));
			
			Gym gym = new Gym();
			gym.setNo(rs.getInt("gym_no"));
			user.setGym(gym);
			return user;
			
			
		}, id);
	}

	public User getUserByEmail(String email) {
		return DaoHelper.selectOne("userDao.getUserByEmail", rs ->{
			User user = new User();
			user.setId(rs.getString("user_id"));
			user.setPassword(rs.getString("user_password"));
			user.setName(rs.getString("user_name"));
			user.setEmail(rs.getString("user_email"));
			user.setTel(rs.getString("user_tel"));
			user.setType(rs.getString("user_type"));
			user.setStatus(rs.getString("user_status"));
			user.setCreateDate(rs.getDate("user_create_date"));
			user.setUpdateDate(rs.getDate("user_update_date"));
			
			Gym gym = new Gym();
			gym.setNo(rs.getInt("gym_no"));
			user.setGym(gym);
			return user;
		}, email);
	}
	
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
	public void insertTrainer(Trainer trainer) {
		DaoHelper.update("trainerDao.insertTrainer", trainer.getUser().getId(),
															trainer.getPosition());
			
	}
	
	public void deleteUserById(String id) {
		DaoHelper.update("userDao.deleteUserById", id);
	}
	public void deleteTrainerById(String id) {
		DaoHelper.update("userDao.deleteTrainerById", id);
	}
	
	public void updateUser(User user) {
		DaoHelper.update("userDao.updateUser", user.getPassword(),
														user.getName(),
														user.getTel(),
														user.getEmail(),
														user.getStatus(),
														user.getGym().getNo(),
														user.getId());
		
	}
	
	
}
