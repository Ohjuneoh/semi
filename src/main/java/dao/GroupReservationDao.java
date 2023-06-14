package dao;

import java.util.List;

import util.DaoHelper;
import vo.Gym;
import vo.Lesson;
import vo.Reservation;
import vo.User;


public class GroupReservationDao {

	private GroupReservationDao() {}
	
	public static GroupReservationDao instance = new GroupReservationDao();
	public static GroupReservationDao getinstance() {
		return instance;
	}
	
	public void insertGroupReservation(Reservation reservation) {
		DaoHelper.update("groupReservationDao.insertGroupReservation", reservation.getUser().getId(),
																	   reservation.getLesson().getNo());
	}
	
	public List<Reservation> getGroupReservationsById(String id, int begin, int end) {
		return DaoHelper.selectList("groupReservationDao.getGroupReservationsById", rs->{
			
			Reservation reservation = new Reservation();
			User user = new User();
			Lesson groupLesson = new Lesson();
			
			reservation.setNo(rs.getInt("reserve_no"));
			
			user.setId(rs.getString("user_id"));
			reservation.setUser(user);
			
			groupLesson.setNo(rs.getInt("lesson_no"));
			groupLesson.setName(rs.getString("lesson_name"));
			groupLesson.setType(rs.getString("lesson_type"));
			groupLesson.setQuota(rs.getInt("lesson_quota"));
			groupLesson.setReqCnt(rs.getInt("lesson_req_cnt"));
			groupLesson.setDescription(rs.getString("lesson_description"));
			groupLesson.setCreatDate(rs.getDate("lesson_create_date"));
			groupLesson.setTime(rs.getString("lesson_time"));
			groupLesson.setStatus(rs.getString("lesson_status"));
			
			Gym gym = new Gym();
			gym.setNo(rs.getInt("gym_no"));
			gym.setName(rs.getString("gym_name"));
			groupLesson.setGym(gym);
			
			reservation.setLesson(groupLesson);
			user.setName(rs.getString("user_name"));
			return reservation;
		}, id,begin,end);
	}
	
	public int getTotalRows (String id) {
		return DaoHelper.selectOne("groupReservationDao.getTotalRows",rs->{
			return rs.getInt("cnt");
		}, id);
	}
	
	public Reservation getGroupReservationsByIdAndLessonNo(String id, int no) {
		return DaoHelper.selectOne("groupReservationDao.getGroupReservationsByIdAndLessonNo", rs->{
			Reservation reservation = new Reservation();
			reservation.setNo(rs.getInt("reserve_no"));
			
			User user = new User();
			user.setId(rs.getString("user_id"));
			reservation.setUser(user);
			
			Lesson lesson = new Lesson();
			lesson.setNo(rs.getInt("lesson_no"));
			reservation.setLesson(lesson);
			
			return reservation;
		}, id,no);
	}
	
}
