package common;

import java.sql.Connection;
import java.sql.DriverManager;

public class DBConnection {
	
	//mysql getConnection
	public Connection getConnection() {
		Connection conn = null;
		
		String url = "jdbc:mysql://localhost:3306/jsp_web?characterEncoding=UTF-8";
		String id = "root";
		String pw = "3354!@ASDF";
		
		try {
			Class.forName("com.mysql.jdbc.Driver");
			conn = DriverManager.getConnection(url, id, pw);			
		}catch(Exception e) {
			System.out.println("======== getConnection DB Connection error START ========");
			e.printStackTrace();			
		}		
		
		return conn;
	}
	
}
