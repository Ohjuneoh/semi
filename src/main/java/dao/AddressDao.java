package dao;

import util.DaoHelper;
import vo.Address;

public class AddressDao {
	
	private static AddressDao addressDao = new AddressDao();
	private AddressDao() {}
	public static AddressDao getInstance() {
		return addressDao;
	}
	
	public void insertAddress(Address address) {
		DaoHelper.update("addressDao.insertAddress",address.getUser().getId(),
													address.getPostNo(),
													address.getStreetName(),
													address.getDetailAddress());
												
		
		
	}
	
	
	

}
