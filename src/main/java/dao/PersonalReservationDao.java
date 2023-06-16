package dao;

import util.DaoHelper;
import vo.Reservation;

public class PersonalReservationDao {

	private PersonalReservationDao() {}
	public static PersonalReservationDao instance = new PersonalReservationDao();
	public static PersonalReservationDao getInstance() {
		return instance;
	}
	
	public void insertPersonalReservation(Reservation reservation) {
		DaoHelper.update("personalReservationDao.insertGroupReservation", reservation.getUser().getId(), reservation.getLesson().getNo());
	}
}
