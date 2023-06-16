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
	public static GroupReservationDao getInstance() {
		return instance;
	}
	
	/*
	 * 신청시, db에 신청내역을 넣는다.
	 */
	public void insertGroupReservation(Reservation reservation) {
		DaoHelper.update("groupReservationDao.insertGroupReservation", reservation.getUser().getId(),
																	   reservation.getLesson().getNo());
	}
	
	/*
	 * My page에서 나의 모든수업 신청정보를 조회할 수 있다.
	 */
	public List<Reservation> getAllReservationsById(String id, int begin, int end) {
		return DaoHelper.selectList("groupReservationDao.getAllReservationsById", rs->{
			
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
			groupLesson.setDeleted(rs.getString("lesson_deleted"));
			
			Gym gym = new Gym();
			gym.setNo(rs.getInt("gym_no"));
			gym.setName(rs.getString("gym_name"));
			groupLesson.setGym(gym);
			
			reservation.setLesson(groupLesson);
			user.setName(rs.getString("user_name"));
			return reservation;
		}, id,begin,end);
	}
	
	/*
	 * My page에서 나의 모든 수업신청 내역의 갯수를 확인할 수 있다.
	 */
	public int getAllTotalMyRows(String id) {
		return DaoHelper.selectOne("groupReservationDao.getAllTotalMyRows",rs->{
			return rs.getInt("cnt");
		}, id);
	}
	
	/*
	 *  My page에서 나의 그룹수업 신청정보를 조회할 수 있다.
	 */
	public List<Reservation> getGroupMyReservationsById(String id, int begin, int end) {
		return DaoHelper.selectList("groupReservationDao.getGroupMyReservationsById", rs->{
			
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
			groupLesson.setDeleted(rs.getString("lesson_deleted"));
			
			Gym gym = new Gym();
			gym.setNo(rs.getInt("gym_no"));
			gym.setName(rs.getString("gym_name"));
			groupLesson.setGym(gym);
			
			reservation.setLesson(groupLesson);
			user.setName(rs.getString("user_name"));
			return reservation;
		}, id,begin,end);
	}
	
	/*
	 * My page에서 내가 신청한 그룹수업 갯수를 알 수 있다.
	 */
	public int getGroupTotalMyRows (String id) {
		return DaoHelper.selectOne("groupReservationDao.getGroupTotalMyRows",rs->{
			return rs.getInt("cnt");
		}, id);
	}
	
	/*
	 * 아이디,레슨번호를 전달받아서 신청정보를 조회한다.
	 * 	회원의 수업 신청을 조회하여, 같은회원이 2번이상 신청할 수 없게 한다.
	 */
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
