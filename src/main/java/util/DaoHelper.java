package util;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Types;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Properties;

public class DaoHelper {
	
	private static Properties prop = new Properties();
	
	static {
		try {
			String projectPath = Thread.currentThread().getContextClassLoader().getResource("").getPath();
			File directory = new File(projectPath + "/dao");
			File[] files = directory.listFiles((dir, name) -> name.endsWith(".properties"));
			for (File file : files) {
				FileInputStream in= new FileInputStream(file);
				prop.load(in);
				in.close();
			}
		} catch (IOException ex) {
			throw new RuntimeException(ex);
		}
	} 
	
	/**
	 * SELECT문을 실행하고, 조회결과를 객체에 담아서 반환한다.
	 * @param <T> 조회결과를 저장하는 객체의 클래스명
	 * @param key SQL구문에 대한 key값
	 * @param rowMapper RowMapper 인터페이스의 구현객체, ResultSet에서 현재 커서가 위치한 행의 값을 조회해서 지정된 객체에 담아서 반환한다.
	 * @param params 쿼리실행에 필요한 파라미터값, ?에 바인딩되는 값
	 * @return 조회결과가 포함된 객체 한 개
	 */
	public static <T> T selectOne(String key, RowMapper<T> rowMapper, Object...params) {
		try {
			T t = null;
			Connection conn = ConnUtils.getConnection();
			PreparedStatement pstmt = conn.prepareStatement(prop.getProperty(key));
			setParams(pstmt, params);
			ResultSet rs = pstmt.executeQuery();
			while (rs.next()) {
				t = rowMapper.mapRow(rs);
			}
			rs.close();
			pstmt.close();
			conn.close();
			
			return t;
		} catch (SQLException ex) {
			throw new RuntimeException(ex);
		}
	}

	/**
	 * SELECT문을 실행하고, 조회결과를 List객체에 담아서 반환한다.
	 * @param <T> 조회결과를 저장하는 객체의 클래스명
	 * @param key SQL구문에 대한 key값
	 * @param rowMapper RowMapper 인터페이스의 구현객체, ResultSet에서 현재 커서가 위치한 행의 값을 조회해서 지정된 객체에 담아서 반환한다.
	 * @param params 쿼리실행에 필요한 파라미터값, ?에 바인딩되는 값
	 * @return 조회결과가 포함된 List객체
	 */
	public static <T> List<T> selectList(String key, RowMapper<T> rowMapper, Object...params) {
		try {
			List<T> list = new ArrayList<>();
			Connection conn = ConnUtils.getConnection();
			PreparedStatement pstmt = conn.prepareStatement(prop.getProperty(key));
			setParams(pstmt, params);
			ResultSet rs = pstmt.executeQuery();
			while (rs.next()) {
				T t = rowMapper.mapRow(rs);
				list.add(t);
			}
			
			rs.close();
			pstmt.close();
			conn.close();
			
			return list;
		} catch (SQLException ex) {
			throw new RuntimeException(ex);
		}
	}

	/**
	 * INSERT, UPDATE, DELETE 문을 실행한다.
	 * @param key SQL구문에 대한 key값
	 * @param params 쿼리실행에 필요한 파라미터값, ?에 바인딩되는 값
	 */
	public static void update(String key, Object... params) {
	
		try {
			Connection conn = ConnUtils.getConnection();
			PreparedStatement pstmt = conn.prepareStatement(prop.getProperty(key));
			setParams(pstmt, params);
			pstmt.executeUpdate();
			
			pstmt.close();
			conn.close();
		} catch (SQLException ex) {
			throw new RuntimeException(ex);
		}
	}
	
	// PreparedStatement가 포함하고 있는 SQL 구문의 ?(바인딩 변수)에 파라미터값을 설정한다.
	private static void setParams(PreparedStatement pstmt, Object[] params) throws SQLException {
		if (params.length > 0) {
			int index = 1;
			for (Object param : params) {
				if (param instanceof String) {
					pstmt.setString(index, (String) param);
				} else if (param instanceof Date) {
					Date date = (Date) param;
					pstmt.setDate(index, new java.sql.Date(date.getTime()));
				} else if (param instanceof Integer) {
					pstmt.setInt(index, (Integer) param);
				} else if (param instanceof Long) {
					pstmt.setLong(index, (Long) param);
				} else if (param instanceof Double) {
					pstmt.setDouble(index, (Double) param);
				} else {
					pstmt.setNull(index, Types.NULL);
				}
				index++;
			}
		}
	}
	
	/**
	 * ResutSet에서 커서가 가르키는 행의 값을 객체로 반환하는 기능에 대한 표준을 지정한다.
	 *
	 * @param <T>
	 */
	public static interface RowMapper<T> {
		T mapRow(ResultSet rs) throws SQLException;
	}
}
