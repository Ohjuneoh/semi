package dao;

import java.util.List;

import util.DaoHelper;
import vo.Lesson;
import vo.Trainer;
import vo.User;
import vo.Gym;

public class TrainerDao {
	
	private static TrainerDao instance = new TrainerDao();
	private TrainerDao() {}
	public static TrainerDao getInstance() {
		return instance;
	}
	
	
	public void insertTrainer(Trainer trainer) {
		DaoHelper.update("trainerDao.insertTrainer", trainer.getUser().getId(),
															trainer.getPosition());
			
	}
	/**
	 * 강사가 진행하는 모든 수업 조회하기  written by chaegyeong
	 * @param userId 강사 아이디 
	 * @param type 수업 타입 (개인레슨 personal, 그룹레슨 group)
	 * @return 모든 수업 리스트 
	 */
	public List<Lesson> getAllLessonsByTrainerId(String userId, String type){
		return DaoHelper.selectList("trainerDao.getAllLessonsByTrainerId", rs -> {
			Lesson lesson = new Lesson();
			lesson.setNo(rs.getInt("lesson_no"));
			lesson.setName(rs.getString("lesson_name"));
			lesson.setType(rs.getString("lesson_type"));
			lesson.setQuota(rs.getInt("lesson_quota"));
			lesson.setReqCnt(rs.getInt("lesson_req_cnt"));
			lesson.setCreatDate(rs.getDate("lesson_create_date"));
			lesson.setTime(rs.getString("lesson_time"));
			lesson.setStatus(rs.getString("lesson_status"));
			
			Gym gym = new Gym();
			gym.setNo(rs.getInt("gym_no"));
			lesson.setGym(gym);
	
			lesson.setDeleted(rs.getString("lesson_deleted"));
			return lesson; 
		}, userId, type);	
	}
	
	/**
	 * 강사 개인 정보 가져오기 written by chaegyeong
	 * @param userId 강사 아이디 
	 * @return 강사 개인 정보 
	 */
	public Trainer getTrainerDetails(String userId){
		return DaoHelper.selectOne("userDao.getTrainerDetails", rs -> {
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
		}, userId);
	}
	
	
	
	
}
