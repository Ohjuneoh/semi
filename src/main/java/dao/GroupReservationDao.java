package dao;

import util.DaoHelper;
import vo.Reservation;


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
	
}
