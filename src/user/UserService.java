package user;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;

import common.DBConnection;
import common.DES;

public class UserService {
	
	DBConnection dbcon = new DBConnection();
	
	public String userWrite(UserVO userVO) throws SQLException { //사용자 등록
		
		String result_Msg = "";
		
		Connection conn = null;
		PreparedStatement pstmt = null;
		
		try {						
			long tmpdate = userVO.getRegister_dt().getTime();			
			Timestamp date = new Timestamp(tmpdate);
			
			int count = 0;
			
			String query = "";
			query += "INSERT INTO user_tb(USER_UID, USER_ID, USER_PASSWORD, USER_NAME, USER_NICKNAME, USER_PHONE, USER_LEVEL, USER_EMAIL, USER_STATE, REGISTER_DT) VALUES";
			query += " (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
			
			conn = dbcon.getConnection();
			pstmt = conn.prepareStatement(query);
			
			pstmt.setString(1, userVO.getUserUid());
			pstmt.setString(2, userVO.getUserId());
			pstmt.setString(3, userVO.getUserPassword());
			pstmt.setString(4, userVO.getUserName());
			pstmt.setString(5, userVO.getUserNickname());
			pstmt.setString(6, userVO.getUserPhone());
			pstmt.setInt(7, userVO.getUserState());
			pstmt.setString(8, userVO.getUserEmail());
			pstmt.setInt(9, userVO.getUserState());
			pstmt.setTimestamp(10, date);
			
			count = pstmt.executeUpdate();
			
			if(count >= 1) { //정상가입완료
				result_Msg = "회원가입이 완료되었습니다.";
			}else { // 가입실패
				result_Msg = "회원가입을 실패하였습니다.";
			}
			
			pstmt.close();
			conn.close();
			
		}catch(Exception e) {
			System.out.println("======== UserService userWrite DB INSERT error START ========");
			e.printStackTrace();			
		}finally {
			if(pstmt != null) pstmt.close();
			if(conn != null) conn.close();
		}		
		
		return result_Msg;
	}
		
	public UserVO userLogin(String userId, String userPassword) throws SQLException { //사용자 로그인
		
		UserVO userVO = new UserVO();
		DES des3 = new DES();
		
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			
			String query = "";
			query += "SELECT * FROM user_tb WHERE USER_ID = ? AND USER_PASSWORD = ?";
			
			conn = dbcon.getConnection();
			pstmt = conn.prepareStatement(query);
			
			pstmt.setString(1, userId);
			pstmt.setString(2, des3.encrypt(userPassword));			
			
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				userVO.setUserUid(rs.getString("USER_UID"));
				userVO.setUserId(rs.getString("USER_ID"));
				userVO.setUserPassword(des3.decrypt(rs.getString("USER_PASSWORD")));
				userVO.setUserName(rs.getString("USER_NAME"));
				userVO.setUserNickname(rs.getString("USER_NICKNAME"));
				userVO.setUserPhone(rs.getString("USER_PHONE"));
				userVO.setUserLevel(rs.getInt("USER_LEVEL"));
				userVO.setUserEmail(rs.getString("USER_EMAIL"));
				userVO.setUserState(rs.getInt("USER_STATE"));
				userVO.setRegister_dt(rs.getTimestamp("REGISTER_DT"));
				userVO.setModify_dt(rs.getTimestamp("MODIFY_DT"));
				userVO.setUsertmpField1(rs.getString("USER_TMPFIELD1"));
				userVO.setUsertmpField2(rs.getString("USER_TMPFIELD2"));
				userVO.setUsertmpField3(rs.getString("USER_TMPFIELD3"));
				userVO.setUsertmpField4(rs.getString("USER_TMPFIELD4"));
				userVO.setUsertmpField5(rs.getString("USER_TMPFIELD5"));
				
				break;
			}
			
			rs.close();
			pstmt.close();
			conn.close();
			
		}catch(Exception e) {
			System.out.println("======== UserService userLogin DB SELECT error START ========");
			e.printStackTrace();
		}finally {
			if(rs != null) rs.close();
			if(pstmt != null) pstmt.close();
			if(conn != null) conn.close();
		}
		
		return userVO;
	}
	
	public UserVO getUser(String userUid) throws SQLException { //사용자 정보
		
		UserVO userVO = new UserVO();
		DES des3 = new DES();
		
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			
			String query = "";
			query += "SELECT * FROM user_tb WHERE USER_UID = ?";
			
			conn = dbcon.getConnection();
			pstmt = conn.prepareStatement(query);
			
			pstmt.setString(1, userUid);			
			
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				userVO.setUserUid(rs.getString("USER_UID"));
				userVO.setUserId(rs.getString("USER_ID"));
				userVO.setUserPassword(des3.decrypt(rs.getString("USER_PASSWORD")));
				userVO.setUserName(rs.getString("USER_NAME"));
				userVO.setUserNickname(rs.getString("USER_NICKNAME"));
				userVO.setUserPhone(rs.getString("USER_PHONE"));
				userVO.setUserLevel(rs.getInt("USER_LEVEL"));
				userVO.setUserEmail(rs.getString("USER_EMAIL"));
				userVO.setUserState(rs.getInt("USER_STATE"));
				userVO.setRegister_dt(rs.getTimestamp("REGISTER_DT"));
				userVO.setModify_dt(rs.getTimestamp("MODIFY_DT"));
				userVO.setUsertmpField1(rs.getString("USER_TMPFIELD1"));
				userVO.setUsertmpField2(rs.getString("USER_TMPFIELD2"));
				userVO.setUsertmpField3(rs.getString("USER_TMPFIELD3"));
				userVO.setUsertmpField4(rs.getString("USER_TMPFIELD4"));
				userVO.setUsertmpField5(rs.getString("USER_TMPFIELD5"));
				
				break;
			}
			
			rs.close();
			pstmt.close();
			conn.close();
			
		}catch(Exception e) {
			System.out.println("======== UserService getUser DB SELECT error START ========");
			e.printStackTrace();
		}finally {
			if(rs != null) rs.close();
			if(pstmt != null) pstmt.close();
			if(conn != null) conn.close();
		}
		
		return userVO;
	}
	
	
	public String userUpdate(UserVO userVO) throws SQLException { //사용자 수정
		String result_Msg = "";		
		long tmpdate = userVO.getModify_dt().getTime();			
		Timestamp date = new Timestamp(tmpdate);
		int update_count = 0;
		
		Connection conn = null;
		PreparedStatement pstmt = null;		
		
		try {
			
			String query = "";
			
			query += "UPDATE user_tb SET USER_PASSWORD = ?, USER_PHONE = ?, USER_EMAIL = ?, MODIFY_DT = ? WHERE USER_UID = ?";
			
			conn = dbcon.getConnection();
			pstmt = conn.prepareStatement(query);
			
			pstmt.setString(1, userVO.getUserPassword());
			pstmt.setString(2, userVO.getUserPhone());
			pstmt.setString(3, userVO.getUserEmail());
			pstmt.setTimestamp(4, date);
			pstmt.setString(5, userVO.getUserUid());
			
			update_count = pstmt.executeUpdate();
			
			if(update_count >= 1) {
				result_Msg = "정보수정이 완료되었습니다. 다시로그인해주세요.";
			}else {
				result_Msg = "정보수정을 실패하였습니다. 다시로그인해주세요.";
			}
			
			pstmt.close();
			conn.close();
			
		}catch(Exception e) {
			System.out.println("======== UserService userUpdate DB UPDATE error START ========");
			e.printStackTrace();
		}finally {
			if(pstmt != null) pstmt.close();
			if(conn != null) conn.close();
		}
		
		return result_Msg;
	}
	
	
	public String userDelete(UserVO userVO) throws SQLException { //사용자 삭제
		String result_Msg = "";		
		long tmpdate = userVO.getModify_dt().getTime();			
		Timestamp date = new Timestamp(tmpdate);
		int update_count = 0;		
		
		Connection conn = null;
		PreparedStatement pstmt = null;		
		
		try {
			
			String query = "";
			
			query += "UPDATE user_tb SET USER_STATE = ?, MODIFY_DT = ? WHERE USER_UID = ?";
			
			conn = dbcon.getConnection();
			pstmt = conn.prepareStatement(query);
						
			pstmt.setInt(1, userVO.getUserState());
			pstmt.setTimestamp(2, date);
			pstmt.setString(3, userVO.getUserUid());
			
			update_count = pstmt.executeUpdate();
			
			if(update_count >= 1) {
				result_Msg = "회원탈퇴가 완료되었습니다.";
			}else {
				result_Msg = "회원탈퇴를 실패하였습니다.";
			}
			
			pstmt.close();
			conn.close();
			
		}catch(Exception e) {
			System.out.println("======== UserService userDelete DB UPDATE error START ========");
			e.printStackTrace();
		}finally {
			if(pstmt != null) pstmt.close();
			if(conn != null) conn.close();
		}
		
		return result_Msg;
	}
	
}
