package dao;

import util.DaoHelper;
import vo.User;

public class UserDao {
	public void insertUser(User user) {
		DaoHelper.update("userDao.insertUser", user.getId(),
												user.getPassword(),
												user.getName(),
												user.getEmail(),
												user.getTel(),
												user.getType(),
												user.getGym().getNo());
		
		
	}

}
