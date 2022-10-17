package board;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;

import common.DBConnection;

public class BoardService {
	
	DBConnection dbcon = new DBConnection();
	
	public int getDataMaxIdx() throws SQLException { //게시글 최대갯수
		
		int count = 0;
		
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			
			String query = "SELECT COUNT(*) FROM board_data_tb";
			
			conn = dbcon.getConnection();
			pstmt = conn.prepareStatement(query);
			
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				count = rs.getInt("COUNT(*)");
			}
			
			rs.close();
			pstmt.close();
			conn.close();
			
		}catch(Exception e) {
			System.out.println("======== BoardService getDataMaxIdx DB SELECT error START ========");
			e.printStackTrace();
		}finally {
			if(rs != null) rs.close();
			if(pstmt != null) pstmt.close();
			if(conn != null) conn.close();
		}
		
		return count;
	}
	
	public int DataWrite(DataVO dataVO) throws SQLException { //게시글 등록
		int count = 0;
		
		Connection conn = null;
		PreparedStatement pstmt = null;		
		
		try {
			long tmpdate = dataVO.getRegister_dt().getTime();			
			Timestamp date = new Timestamp(tmpdate);
			
			String query = "";
			query += "INSERT INTO board_data_tb";
			query += "(DATA_UID, BOARD_UID, DATA_TITLE, DATA_CONTENT, DATA_STATE, DATA_IDX, USER_ID, USER_NAME, USER_NICKNAME, REGISTER_DT, VIEW_COUNT) VALUES";
			query += " (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
			
			conn = dbcon.getConnection();
			pstmt = conn.prepareStatement(query);
			
			pstmt.setString(1, dataVO.getDataUid());
			pstmt.setString(2, dataVO.getBoardUid());
			pstmt.setString(3, dataVO.getDataTitle());
			pstmt.setString(4, dataVO.getDataContent());
			pstmt.setInt(5, dataVO.getDataState());
			pstmt.setInt(6, dataVO.getDataIdx());
			pstmt.setString(7, dataVO.getUserId());
			pstmt.setString(8, dataVO.getUserName());
			pstmt.setString(9, dataVO.getUserNickname());
			pstmt.setTimestamp(10, date);
			pstmt.setInt(11, dataVO.getViewCount());
			
			count = pstmt.executeUpdate();
			
			pstmt.close();
			conn.close();
			
		}catch(Exception e) {
			System.out.println("======== BoardService DataWrite DB INSERT error START ========");
			e.printStackTrace();
		}finally {
			if(pstmt != null) pstmt.close();
			if(conn != null) conn.close();
		}
		
		return count;
	}
	
	public List<DataVO> getDataList(String boardUid, int dataState, int currentPage, int rowCount) throws SQLException {
		
		ArrayList<DataVO> resultList = null;
		
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		int start = (currentPage-1)*rowCount;		
		
		if(start < 0) start = 0;
		
		try {
			
			resultList = new ArrayList<DataVO>();
			
			String query = "";
			query += "SELECT * FROM board_data_tb WHERE";
			query += " BOARD_UID = ? AND DATA_STATE = ?";
			query += " ORDER BY REGISTER_DT DESC";
			query += " LIMIT ?,?";
			
			conn = dbcon.getConnection();
			pstmt = conn.prepareStatement(query);
			
			pstmt.setString(1, boardUid);
			pstmt.setInt(2, dataState);
			pstmt.setInt(3, start);
			pstmt.setInt(4, rowCount);
			
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				DataVO dataVO = new DataVO();
				
				dataVO.setDataUid(rs.getString("DATA_UID"));
				dataVO.setBoardUid(rs.getString("BOARD_UID"));
				dataVO.setDataTitle(rs.getString("DATA_TITLE"));
				dataVO.setDataContent(rs.getString("DATA_CONTENT"));
				dataVO.setDataState(rs.getInt("DATA_STATE"));
				dataVO.setDataIdx(rs.getInt("DATA_IDX"));
				dataVO.setUserId(rs.getString("USER_ID"));
				dataVO.setUserName(rs.getString("USER_NAME"));
				dataVO.setUserNickname(rs.getString("USER_NICKNAME"));
				dataVO.setRegister_dt(rs.getTimestamp("REGISTER_DT"));
				dataVO.setModify_dt(rs.getTimestamp("MODIFY_DT"));
				dataVO.setViewCount(rs.getInt("VIEW_COUNT"));
				dataVO.setTmpField1(rs.getString("TMPFIELD1"));
				dataVO.setTmpField2(rs.getString("TMPFIELD2"));
				dataVO.setTmpField3(rs.getString("TMPFIELD3"));
				dataVO.setTmpField4(rs.getString("TMPFIELD4"));
				dataVO.setTmpField5(rs.getString("TMPFIELD5"));
				
				resultList.add(dataVO);
			}
			
			rs.close();
			pstmt.close();
			conn.close();
			
		}catch(Exception e) {
			System.out.println("======== BoardService getDataList DB SELECT error START ========");
			e.printStackTrace();
		}finally {
			if(rs != null) rs.close();
			if(pstmt != null) pstmt.close();
			if(conn != null) conn.close();
		}
		
		return resultList;
	}
	
	public long getDataCount(String boardUid, int dataState) throws SQLException {
		long totalcount = 0;
		
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
		
			String query = "";
			query += "SELECT COUNT(*) FROM board_data_tb WHERE";
			query += " BOARD_UID = ? AND DATA_STATE = ?";
			
			conn = dbcon.getConnection();
			pstmt = conn.prepareStatement(query);
			
			pstmt.setString(1, boardUid);
			pstmt.setInt(2, dataState);
			
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				totalcount = rs.getLong("COUNT(*)");
			}
			
			rs.close();
			pstmt.close();
			conn.close();
			
		}catch(Exception e) {
			
		}finally {
			if(rs != null) rs.close();
			if(pstmt != null) pstmt.close();
			if(conn != null) conn.close();
		}
		
		return totalcount;
	}
	
}
