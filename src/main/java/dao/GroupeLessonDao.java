package dao;

import java.util.List;

import util.DaoHelper;
import vo.Gym;
import vo.Lesson;
import vo.User;

public class GroupeLessonDao {

	
	private GroupeLessonDao() {}
	
	public static GroupeLessonDao instance = new GroupeLessonDao();
	public static GroupeLessonDao getinstance() {
		return instance;
	}
	
	
	
	public void insertGroupLesson(Lesson lesson) {
		DaoHelper.update("groupLessonDao.insertGroupLesson", 
															 lesson.getName(),
															 lesson.getType(),
															 lesson.getQuota(),
															 lesson.getDescription(),
															 lesson.getUser().getId(),
															 lesson.getTime(),
															 lesson.getGym().getNo());
	}
	
	
	public List<Lesson> getGroupLessons(int begin, int end) {
		return DaoHelper.selectList("groupLessonDao.getGroupLessons", rs->{
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

			User user = new User();
			user.setId(rs.getString("user_id"));
			user.setName(rs.getString("user_name"));
			
			Gym gym = new Gym();
			gym.setNo(rs.getInt("gym_no"));
			gym.setName(rs.getString("gym_name"));
		
			groupLesson.setUser(user);
			groupLesson.setGym(gym);
			
			return groupLesson;
		}, begin, end);
	}
	
	public int getTotalRows () {
		return DaoHelper.selectOne("groupLessonDao.getTotalRows", rs->{
			return rs.getInt("cnt");
		});
	}
	
	public Lesson getGroupLessonByLessonNo(int lessonNo) {
		return DaoHelper.selectOne("groupLessonDao.getGroupLessonByLessonNo", rs->{
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
	
	public void updateGroupLesson(Lesson lesson) {
		DaoHelper.update("groupLessonDao.updateGroupLesson", 
															
															 lesson.getName(),
															 lesson.getType(),
															 lesson.getQuota(),
															 lesson.getReqCnt(),
															 lesson.getDescription(),
															 lesson.getUser().getId(),
															 lesson.getTime(),
															 lesson.getStatus(),
															 lesson.getGym().getNo(),
															 lesson.getNo());
	}
	
	public void deleteGroupLesson(int lessonNo) {
		DaoHelper.update("groupLessonDao.deleteGroupLesson", lessonNo);
	}
	
	
	public List<Lesson> getGroupMyLessonsById(String id, int begin, int end) {
		return DaoHelper.selectList("groupLessonDao.getGroupMyLessonsById", rs->{
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

			User user = new User();
			user.setId(rs.getString("user_id"));
			user.setName(rs.getString("user_name"));
			
			Gym gym = new Gym();
			gym.setNo(rs.getInt("gym_no"));
			gym.setName(rs.getString("gym_name"));
		
			groupLesson.setUser(user);
			groupLesson.setGym(gym);
			
			return groupLesson;
		}, id,begin,end);
	}
	
	public int getTotalMyRows(String id) {
		return DaoHelper.selectOne("groupLessonDao.getTotalMyRows", rs->{
			return rs.getInt("cnt");
		}, id);
	}
}
