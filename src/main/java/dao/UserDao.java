package dao;

import util.DaoHelper;
import vo.Gym;
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
}
