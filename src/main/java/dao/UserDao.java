package dao;

import java.util.List;

import util.DaoHelper;
import vo.Gym;
import vo.Lesson;
import vo.Membership;
import vo.Reservation;
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
		DaoHelper.update("userDao.updateUser", 			user.getPassword(),
														user.getName(),
														user.getTel(),
														user.getEmail(),
														user.getStatus(),
														user.getGym().getNo(),
														user.getId());
		
	}
	
	
	public List<User> getUserByType(String type){
		return DaoHelper.selectList("userDao.getUserByType", rs -> {
			User user = new User();
			user.setId(rs.getString("user_id"));
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
		}, type);
	}
	/*
	 * 유저타입의 모든 회원정보를 조회한다.(페이징처리)
	 */
	public List<User> getAllUserByUserType(int begin, int end) {
		return DaoHelper.selectList("userDao.getAllUserByUserType", rs->{
		User user = new User();
		user.setId(rs.getString("user_id"));
		user.setPassword(rs.getString("user_password"));
		user.setName(rs.getString("user_name"));
		user.setEmail(rs.getString("user_email"));
		user.setTel(rs.getString("user_tel"));
		user.setCreateDate(rs.getDate("user_create_date"));
		user.setUpdateDate(rs.getDate("user_update_date"));
		user.setStatus(rs.getString("user_status"));
		
		Gym gym = new Gym();
		gym.setNo(rs.getInt("gym_no"));
		user.setGym(gym);
		
		return user;
		
		}, begin,end);
	}
	/*
	 * 유저의 모든 행의갯수를 조회한다.
	 */
	public int getTotalUserRows() {
		return DaoHelper.selectOne("userDao.getTotalUserRows", rs->{
			return rs.getInt("cnt");
		});
	}
	
	/*
	 * id를 전달받아서 그 회원의 정보를 조회한다.
	 */
	public User getUserByUserTypeAndId(String id) {
		return DaoHelper.selectOne("userDao.getUserByUserTypeAndId", rs->{
			User user = new User();
			user.setId(rs.getString("user_id"));
			user.setPassword(rs.getString("user_password"));
			user.setName(rs.getString("user_name"));
			user.setEmail(rs.getString("user_email"));
			user.setTel(rs.getString("user_tel"));
			user.setCreateDate(rs.getDate("user_create_date"));
			user.setUpdateDate(rs.getDate("user_update_date"));
			user.setStatus(rs.getString("user_status"));
			
			Gym gym = new Gym();
			gym.setNo(rs.getInt("gym_no"));
			user.setGym(gym);
			
			return user;
		}, id);
	}
	
	public int getMyUserListTotalRows(String id, String type) {
		return DaoHelper.selectOne("userDao.getMyUserListTotalRows", rs ->{
			return rs.getInt("cnt");
		}, id, type);
		
	}
	public int getMyUserListByIdTotalRows(String id) {
		return DaoHelper.selectOne("userDao.getMyUserListByIdTotalRows", rs ->{
			return rs.getInt("cnt");
		}, id);
		
	}
	
	public List<Reservation> getMyUserByTrainerIdLessonType(String trianerId, String lessonType, int begin, int end) {
		return DaoHelper.selectList("userDao.getMyUserByTrainerIdLessonType", rs->{
			
			Lesson lesson = new Lesson();
			lesson.setNo(rs.getInt("lesson_no"));
			lesson.setName(rs.getString("lesson_name"));
			lesson.setType(rs.getString("lesson_type"));
			lesson.setTime(rs.getString("lesson_time"));
			lesson.setStatus(rs.getString("lesson_status"));
			
			
			User user =new User();
			user.setId(rs.getString("user_id"));
			user.setPassword(rs.getString("user_password"));
			user.setName(rs.getString("user_name"));
			user.setEmail(rs.getString("user_email"));
			user.setTel(rs.getString("user_tel"));
			user.setCreateDate(rs.getDate("user_create_date"));
			user.setUpdateDate(rs.getDate("user_update_date"));
			user.setStatus(rs.getString("user_status"));
			
			Reservation reserv = new Reservation();
			reserv.setNo(rs.getInt("reserve_no"));
			reserv.setLesson(lesson);
			reserv.setUser(user);
			
			return reserv; 
			
		}, trianerId, lessonType, begin, end);
	}
	public List<Reservation> getMyUserByTrainerId(String id, int begin, int end) {
		return DaoHelper.selectList("userDao.getMyUserByTrainerId", rs->{
			
			Lesson lesson = new Lesson();
			lesson.setNo(rs.getInt("lesson_no"));
			lesson.setName(rs.getString("lesson_name"));
			lesson.setType(rs.getString("lesson_type"));
			lesson.setTime(rs.getString("lesson_time"));
			lesson.setStatus(rs.getString("lesson_status"));
			
			
			User user =new User();
			user.setId(rs.getString("user_id"));
			user.setPassword(rs.getString("user_password"));
			user.setName(rs.getString("user_name"));
			user.setEmail(rs.getString("user_email"));
			user.setTel(rs.getString("user_tel"));
			user.setCreateDate(rs.getDate("user_create_date"));
			user.setUpdateDate(rs.getDate("user_update_date"));
			user.setStatus(rs.getString("user_status"));
			
			Reservation reserv = new Reservation();
			reserv.setNo(rs.getInt("reserve_no"));
			reserv.setLesson(lesson);
			reserv.setUser(user);
			
			return reserv; 
			
		}, id, begin, end);
	}
	
}
