package dao;

import util.DaoHelper;
import vo.Customer;

public class CustomerDao {
	
	public void insertCustomer(Customer customer) {
		DaoHelper.update("customerDao.insertCustomer", customer.getUser().getId());
		
	}
	
	

}
