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
			user.setFileName(rs.getString("file_name"));
			
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
														user.getId(),
														user.getFileName());
		
	}
	
	
	/**
	 * 유저 타입으로 유저 조회하기 
	 * @param type 유저 타입(회원/강사/관리자) written by chaegyeong 
	 * @return List<User>
	 */
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
	
	/**
	 * 모든 유저(회원/강사/관리자) 정보 조회하기 - 비밀번호 제외  written by chaegyeong
	 * @return List<User>
	 */
	public List<User> getAllUsers(int begin, int end){
		return DaoHelper.selectList("userDao.getAllUsers", rs -> {
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
		}, begin, end);
	}
	
	/**
	 * 모든 유저(회원/매니저/관리자) 정보 관련 페이징 처리 written by chaegyeong
	 * @return
	 */
	public int getTotalPages() {
		return DaoHelper.selectOne("userDao.totalPages", rs -> {
			return rs.getInt("totalPages");
		});
	}
	
	/**
	 * 회원/강사 정보 관련 페이지 처리 
	 * @return
	 */
	public int getTotalPagesUserTrainers(String type) {
		return DaoHelper.selectOne("userDao.totalPagesUserTrainers", rs -> {
			return rs.getInt("UserTrainerstotalPages");
		}, type);
	}
	
	/**
	 * 회원정보 리스트 조회하기 - 비밀번호 제외  written by chaegyeong
	 * @return List<User>
	 */
	public List<User> getAllUserUsers(int begin, int end){
		return DaoHelper.selectList("userDao.getAllUserUsers", rs -> {
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
		}, begin, end);
	}
	
	/**
	 * 전체 강사 정보 조회하기 - 비밀번호 제외  written by chaegyeong
	 * @return List<User>
	 */
	public List<Trainer> getAllTrainers(int begin, int end){
		return DaoHelper.selectList("userDao.getAllTrainers", rs -> {
			Trainer trainer = new Trainer();
			
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
			
			trainer.setUser(user);
			
			trainer.setSalary(rs.getInt("trainer_salary"));
			trainer.setCommissionPct((rs.getDouble("trainer_commission_pct")));
			trainer.setPosition(rs.getString("trainer_position"));
			
			return trainer; 
		}, begin, end);
	}
	
	/**
	 * 전달받은 검색 조건에 해당하는 회원수를 반환한다.  written by chaegyeong
	 * @param opt 검색옵션("name", "email", "tel" 중 하나다.)
	 * @param keyword 검색키워드 
	 * @return 검색 조건에 해당하는 회원 개수 
	 */
	public int getTotalPagesByCondition(String opt, String keyword) {
		String sql = "select count(*) cnt " ;
		sql 		+= "from helf_users ";
		sql 		+= "where user_type = 'user'"; 
		if("name".equals(opt)) {
			sql += "and user_name like '%' || ? || '%' ";
		} else if ("email".equals(opt)) {
			sql += "and user_email like '%' || ? || '%' ";
		} else if ("tel".equals(opt)) {
			sql += "and user_tel like '%' || ? || '%' ";
		}
		
		return DaoHelper.selectOne(sql, rs -> {
			return rs.getInt("cnt");
		}, keyword);
	}
	
	
	
	/**
	 * 전달받은 검색 범위와 검색 조건에 해당하는 회원 목록 정보를 반환한다. written by chaegyeong
	 * @param begin 검색 시작위치 
	 * @param end 검색 종료 위치 
	 * @param opt 검색 옵션("name", "email", "tel" 중 하나다.)
	 * @param keyword 검색 키워드 
	 * @return 회원 목록 
	 */
	public List<User> getUsersByCondition(int begin, int end, String opt, String keyword){
		String sql = "select * ";
		sql += "	  from ( ";
		sql += " 	         select A.*, row_number() over(order by A.user_id desc) row_number ";
		sql += "             from helf_users A ";
		if ("name".equals(opt)) {
			sql += "         where user_name like '%' || ? || '%' ";
		} else if ("email".equals(opt)) {
			sql += "         where user_email like '%' || ? || '%' ";
		} else if("tel".equals(opt)) {
			sql += "         where user_tel like '%' || ? || '%' "; 
		}
		sql += "       ) ";
		sql += "       where row_number between ? and ? ";
		sql += "       and user_type = 'user' ";
		
		return DaoHelper.selectList(sql, rs -> {
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
		}, keyword, begin, end);
	}
	
	
	/**
	 * 전달받은 검색 조건에 해당하는 강사수를 반환한다.  written by chaegyeong
	 * @param opt 검색옵션("name", "tel", "position" 중 하나다.)
	 * @param keyword 검색키워드 
	 * @return 검색 조건에 해당하는 회원 개수 
	 */
	public int getTotalPagesByConditionTrainer(String opt, String keyword) {
	    String sql = "select count(*) cnt " ;
	    sql         += "from helf_users A join helf_trainers B on A.user_id = B.user_id ";
	    sql         += "where A.user_type = 'trainer' ";

	    if("name".equals(opt)) {
	        sql += "and A.user_name like '%' || ? || '%' ";
	    } else if ("tel".equals(opt)) {
	        sql += "and A.user_tel like '%' || ? || '%' ";
	    } else if ("position".equals(opt)) {
	        sql += "and B.trainer_position like '%' || ? || '%' ";
	    }

	    return DaoHelper.selectOne(sql, rs -> {
	        return rs.getInt("cnt");
	    }, keyword);
	}

	
	/**
	 * 전달받은 검색 범위와 검색 조건에 해당하는 강사 목록 정보를 반환한다. written by chaegyeong
	 * @param begin 검색 시작위치 
	 * @param end 검색 종료 위치 
	 * @param opt 검색 옵션("name", "tel", "position" 중 하나다.)
	 * @param keyword 검색 키워드 
	 * @return 회원 목록 
	 */
	public List<Trainer> getTrainersByCondition(int begin, int end, String opt, String keyword){
		String sql = "select * ";
		sql += "	  from ( ";
		sql += " 	         select row_number() over(order by A.user_id desc) row_number,  ";
		sql += "             A.user_id, A.user_name, A.user_email, A.user_tel, A.user_type, A.user_create_date, A.user_status, ";
		sql += "             A.user_update_date, A.gym_no, B.trainer_no, B.trainer_salary, B.trainer_commission_pct, B.trainer_position ";
		sql += "             from helf_users A JOIN helf_trainers B ON A.user_id = B.user_id ";
		sql += "             where A.user_type = 'trainer' ";
		if ("name".equals(opt)) {
			sql += "         and A.user_name like '%' || ? || '%' ";
		} else if ("tel".equals(opt)) {
			sql += "         and A.user_tel like '%' || ? || '%' ";
		} else if("position".equals(opt)) {
			sql += "         and B.trainer_position like '%' || ? || '%' "; 
		}
		sql += "       ) ";
		sql += "       where row_number between ? and ? ";
		
		return DaoHelper.selectList(sql, rs -> {
			Trainer trainer = new Trainer();
			
			User user = new User();
			user.setId(rs.getString("user_id"));
			user.setName(rs.getString("user_name"));
			user.setEmail(rs.getString("user_email"));
			user.setTel(rs.getString("user_tel"));
			user.setType(rs.getString("user_type"));
			user.setCreateDate(rs.getDate("user_create_date"));
			user.setStatus(rs.getString("user_status"));
			user.setUpdateDate(rs.getDate("user_update_date"));
			
			Gym gym = new Gym();
			gym.setNo(rs.getInt("gym_no"));
			user.setGym(gym);
			
			trainer.setUser(user);
			
			trainer.setNo(rs.getInt("trainer_no"));
			trainer.setSalary(rs.getInt("trainer_salary"));
			trainer.setCommissionPct((rs.getDouble("trainer_commission_pct")));
			trainer.setPosition(rs.getString("trainer_position"));
			
			return trainer; 
		}, keyword, begin, end);
	}
	
	
	
	
	
}
