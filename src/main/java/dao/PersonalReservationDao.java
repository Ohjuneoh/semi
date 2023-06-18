package dao;

import java.util.List;

import util.DaoHelper;
import vo.Gym;
import vo.Lesson;
import vo.Reservation;
import vo.User;

public class PersonalReservationDao {

	private PersonalReservationDao() {}
	public static PersonalReservationDao instance = new PersonalReservationDao();
	public static PersonalReservationDao getInstance() {
		return instance;
	}
	
	public void insertPersonalReservation(Reservation reservation) {
		DaoHelper.update("personalReservationDao.insertGroupReservation", reservation.getUser().getId(), reservation.getLesson().getNo());
	}
	/*
	 * 아이디,레슨번호를 전달받아서 신청정보를 조회한다.
	 * 	회원의 수업 신청을 조회하여, 같은회원이 2번이상 신청할 수 없게 한다.
	 */
	public Reservation getPersonalReservationsByIdAndLessonNo(String id, int no) {
		return DaoHelper.selectOne("personalReservationDao.getPersonalReservationsByIdAndLessonNo", rs->{
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
	/*
	 * My page에서 나의 모든 수업신청 내역의 갯수를 확인할 수 있다.
	 */
	public int getAllTotalMyRows(String id) {
		return DaoHelper.selectOne("personalReservationDao.getAllTotalMyRows",rs->{
			return rs.getInt("cnt");
		}, id);
	}
	/*
	 *  My page에서 나의 개인수업 신청정보를 조회할 수 있다.
	 */
	public List<Reservation> getPersonalMyReservationsById(String id, int begin, int end) {
		return DaoHelper.selectList("personalReservationDao.getPersonalMyReservationsById", rs->{
			
			Reservation reservation = new Reservation();
			User user = new User();
			Lesson personalLesson = new Lesson();
			
			reservation.setNo(rs.getInt("reserve_no"));
			
			user.setId(rs.getString("user_id"));
			reservation.setUser(user);
			
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
			
			Gym gym = new Gym();
			gym.setNo(rs.getInt("gym_no"));
			gym.setName(rs.getString("gym_name"));
			personalLesson.setGym(gym);
			
			reservation.setLesson(personalLesson);
			user.setName(rs.getString("user_name"));
			return reservation;
		}, id,begin,end);
	}
	/*
	 * My page에서 내가 신청한 개인수업 갯수를 알 수 있다.
	 */
	public int getPersonalTotalMyRows (String id) {
		return DaoHelper.selectOne("personalReservationDao.getPersonalTotalMyRows",rs->{
			return rs.getInt("cnt");
		}, id);
	}
}
