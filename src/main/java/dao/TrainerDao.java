package dao;

import util.DaoHelper;
import vo.Trainer;

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
	


	

}
