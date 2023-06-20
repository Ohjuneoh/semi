package dao;

import java.util.List;

import util.DaoHelper;
import vo.Gym;
import vo.Lesson;
import vo.User;

public class PersonalLessonDao {
	
	private PersonalLessonDao() {}
	
	public static PersonalLessonDao instance = new PersonalLessonDao();
	public static PersonalLessonDao getinstance() {
		return instance;
	}

	public void insertPersonalLesson(Lesson lesson) {
		DaoHelper.update("personalLessonDao.insertPersonalLesson", 
				lesson.getName(),lesson.getType(),lesson.getQuota(),
				lesson.getDescription(),lesson.getUser().getId(),lesson.getTime(),lesson.getGym().getNo());
	}
	public int getTotalRows() {
		return DaoHelper.selectOne("personalLessonDao.getTotalRows", rs -> {
			return rs.getInt("cnt");
		});
	}
	public List<Lesson> getPersonalLesson(int begin, int end){
		return DaoHelper.selectList("personalLessonDao.getPersonalLesson", rs ->{
			Lesson lesson = new Lesson();
			lesson.setNo(rs.getInt("lesson_no"));
			lesson.setName(rs.getString("lesson_name"));
			lesson.setType(rs.getString("lesson_type"));
			lesson.setQuota(rs.getInt("lesson_quota"));
			lesson.setReqCnt(rs.getInt("lesson_req_cnt"));
			lesson.setDescription(rs.getString("lesson_description"));
			lesson.setCreatDate(rs.getDate("lesson_create_date"));
			User user = new User();
			user.setId(rs.getString("user_id"));
			user.setName(rs.getString("user_name"));
			lesson.setUser(user);
			lesson.setTime(rs.getString("lesson_time"));
			lesson.setStatus(rs.getString("lesson_status"));
			Gym gym = new Gym();
			gym.setNo(rs.getInt("gym_no"));
			gym.setName(rs.getString("gym_name"));
			lesson.setGym(gym);
			return lesson;
		}, begin, end);
		
	}
	public Lesson getPersonalLessonByLessonNo(int lessonNo) {
		return DaoHelper.selectOne("personalLessonDao.getPersonalLessonByLessonNo", rs->{
			Lesson groupLesson = new Lesson();
			groupLesson.setNo(rs.getInt("lesson_no"));
			groupLesson.setName(rs.getString("lesson_name"));
			groupLesson.setType(rs.getString("lesson_type"));
			groupLesson.setQuota(rs.getInt("lesson_quota"));
			groupLesson.setReqCnt(rs.getInt("lesson_req_cnt"));
			groupLesson.setDescription(rs.getString("lesson_description"));
			groupLesson.setCreatDate(rs.getDate("lesson_create_date"));
			groupLesson.setTime(rs.getString("lesson_time"));
			groupLesson.setStatus(rs.getString("lesson_status"));
			groupLesson.setDeleted(rs.getString("lesson_deleted"));

			User user = new User();
			user.setId(rs.getString("user_id"));
			user.setName(rs.getString("user_name"));
			Gym gym = new Gym();
			gym.setNo(rs.getInt("gym_no"));
			gym.setName(rs.getString("gym_name"));
		
			groupLesson.setUser(user);
			groupLesson.setGym(gym);
			
			return groupLesson;
		}, lessonNo);
	}
	public void deletePersonalLesson(int lessonNo) {
		DaoHelper.update("personalLessonDao.deletePersonalLesson",lessonNo);
	}
	
	public void updatePersonalLesson(Lesson lesson) {
		DaoHelper.update("personalLessonDao.updatePersonalLesson", 															 
															 	lesson.getName(),
															 	lesson.getType(),
															 	lesson.getQuota(),
															 	lesson.getReqCnt(),
															 	lesson.getDescription(),
															 	lesson.getUser().getId(),
															 	lesson.getTime(),
															 	lesson.getStatus(),
															 	lesson.getGym().getNo(),
															 	lesson.getDeleted(),
															 	lesson.getNo());
	}
	/*
	 * My page에서 나의 개인수업들의 갯수를 알 수 있다.
	 */
	public int getTotalMyPersonalRows(String id) {
		return DaoHelper.selectOne("personalLessonDao.getTotalMyPersonalRows", rs->{
			return rs.getInt("cnt");
		}, id);
	}
	/*
	 * My page에서 나의 모든 개인수업을 조회한다.
	 * 
	 */
	public List<Lesson> getPersonalMyLessonsById(String id, int begin, int end) {
		return DaoHelper.selectList("personalLessonDao.getPersonalMyLessonsById", rs->{
			Lesson personalLesson = new Lesson();
			personalLesson.setNo(rs.getInt("lesson_no"));
			personalLesson.setName(rs.getString("lesson_name"));
			personalLesson.setType(rs.getString("lesson_type"));
			personalLesson.setQuota(rs.getInt("lesson_quota"));
			personalLesson.setReqCnt(rs.getInt("lesson_req_cnt"));
			personalLesson.setDescription(rs.getString("lesson_description"));
			personalLesson.setCreatDate(rs.getDate("lesson_create_date"));
			personalLesson.setTime(rs.getString("lesson_time"));
			personalLesson.setStatus(rs.getString("lesson_status"));
			personalLesson.setDeleted(rs.getString("lesson_deleted"));

			User user = new User();
			user.setId(rs.getString("user_id"));
			user.setName(rs.getString("user_name"));
			
			Gym gym = new Gym();
			gym.setNo(rs.getInt("gym_no"));
			gym.setName(rs.getString("gym_name"));
		
			personalLesson.setUser(user);
			personalLesson.setGym(gym);
			
			return personalLesson;
		}, id,begin,end);
	}
}
