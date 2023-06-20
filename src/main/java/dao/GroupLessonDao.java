package dao;

import java.util.List;

import util.DaoHelper;
import vo.Gym;
import vo.Lesson;
import vo.User;

public class GroupLessonDao {

	
	private GroupLessonDao() {}
	
	public static GroupLessonDao instance = new GroupLessonDao();
	public static GroupLessonDao getinstance() {
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
			
			groupLesson.setDeleted(rs.getString("lesson_deleted"));
			
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
	
	public void updateGroupLesson(Lesson lesson) {
		DaoHelper.update("groupLessonDao.updateGroupLesson", lesson.getName(), 
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
	 * My page에서 모든 나의 개인,그룹 수업을 조회할 수 있다.
	 */
	public List<Lesson> getAllMyLessonsById(String id, int begin, int end) {
		return DaoHelper.selectList("groupLessonDao.getAllMyLessonsById", rs->{
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
		}, id,begin,end);
	}
	
	/*
	 * My Page에서 모든 나의 수업들의 갯수를 알 수 있다.
	 */
	public int getTotalMyAllRows(String id) {
		return DaoHelper.selectOne("groupLessonDao.getTotalMyAllRows", rs->{
			return rs.getInt("cnt");
		}, id);
	}
	
	
	/*
	 * My page에서 나의 모든 그룹수업을 조회한다.
	 * 
	 */
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
		}, id,begin,end);
	}
	
	/*
	 * My page에서 나의 그룹수업들의 갯수를 알 수 있다.
	 */
	public int getTotalMyGroupRows(String id) {
		return DaoHelper.selectOne("groupLessonDao.getTotalMyGroupRows", rs->{
			return rs.getInt("cnt");
		}, id);
	}

}
