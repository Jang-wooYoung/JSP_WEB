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
	
	/**
	 * 게시판DB의 게시글 최대갯수를 구한다
	 * @return 게시물 갯수
	 * @throws SQLException
	 */
	public int getDataMaxIdx() throws SQLException {
		
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
	
	/**
	 * 게시판에 게시글을 등록.
	 * @param dataVO 게시물 데이터 정보
	 * @return 등록성공 갯수반환
	 * @throws SQLException
	 */
	public int DataWrite(DataVO dataVO) throws SQLException {
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
	
	/**
	 * 게시물 수정 처리
	 * @param dataVO 데이터정보
	 * @return 게시물 수정된 갯수를 반환한다.
	 * @throws SQLException
	 */
	public int DataUpdate(DataVO dataVO) throws SQLException {
		int updatecount = 0;
		
		Connection conn = null;
		PreparedStatement pstmt = null;
		
		try {
			
			long tmpdate = dataVO.getModify_dt().getTime();			
			Timestamp date = new Timestamp(tmpdate);
			
			String query = "";
			query += "UPDATE board_data_tb SET DATA_TITLE = ?, DATA_CONTENT = ?, MODIFY_DT = ?";
			query += " WHERE DATA_UID = ?";
			
			conn = dbcon.getConnection();
			pstmt = conn.prepareStatement(query);
			
			pstmt.setString(1, dataVO.getDataTitle());
			pstmt.setString(2, dataVO.getDataContent());			
			pstmt.setTimestamp(3, date);
			pstmt.setString(4, dataVO.getDataUid());
			
			updatecount = pstmt.executeUpdate();
			
			pstmt.close();
			conn.close();
			
		}catch(Exception e) {
			System.out.println("======== BoardService DataUpdate DB UPDATE error START ========");
			e.printStackTrace();
		}finally {
			if(pstmt != null) pstmt.close();
			if(conn != null) conn.close();
		}
		
		return updatecount;
	}
	
	public int DataDelete(DataVO dataVO) throws SQLException {
		int deletecount = 0;
		
		Connection conn = null;
		PreparedStatement pstmt = null;
		
		try {
			
			long tmpdate = dataVO.getModify_dt().getTime();			
			Timestamp date = new Timestamp(tmpdate);
			
			String query = "";
			query += "UPDATE board_data_tb SET DATA_STATE = ?, MODIFY_DT = ?";
			query += " WHERE DATA_UID = ?";
			
			conn = dbcon.getConnection();
			pstmt = conn.prepareStatement(query);
			
			pstmt.setInt(1, dataVO.getDataState());						
			pstmt.setTimestamp(2, date);
			pstmt.setString(3, dataVO.getDataUid());
			
			deletecount = pstmt.executeUpdate();
			
			pstmt.close();
			conn.close();
			
		}catch(Exception e) {
			System.out.println("======== BoardService DataDelete DB UPDATE error START ========");
			e.printStackTrace();
		}finally {
			if(pstmt != null) pstmt.close();
			if(conn != null) conn.close();
		}
		
		return deletecount;
	}
	
	/**
	 * 해당 게시판의 게시물 리스트를 출력한다.
	 * @param boardUid 게시판고유값
	 * @param dataState 게시글상태
	 * @param currentPage 페이지
	 * @param rowCount 페이지당 출력갯수
	 * @return 게시물리스트반환
	 * @throws SQLException
	 */
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
	
	/**
	 * 조건에맞는 게시판의 게시물갯수를 구한다
	 * @param boardUid 게시판 고유값
	 * @param dataState 게시글 상태
	 * @return 게시물 갯수반환
	 * @throws SQLException
	 */
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
			System.out.println("======== BoardService getDataCount DB SELECT error START ========");
			e.printStackTrace();
		}finally {
			if(rs != null) rs.close();
			if(pstmt != null) pstmt.close();
			if(conn != null) conn.close();
		}
		
		return totalcount;
	}
	
	/**
	 * 게시글의 정보를 가져온다
	 * @param dataUid 게시글 고유값
	 * @return 게시글 데이터 정보 반환
	 * @throws SQLException
	 */
	public DataVO getData(String dataUid) throws SQLException {
		DataVO dataVO = new DataVO();
		
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			
			String query = "";
			query += "SELECT * FROM board_data_tb WHERE";
			query += " DATA_UID = ?";
			
			conn = dbcon.getConnection();
			pstmt = conn.prepareStatement(query);
			
			pstmt.setString(1, dataUid);
			
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
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
			}
			
			rs.close();
			pstmt.close();
			conn.close();
			
		}catch(Exception e) {
			System.out.println("======== BoardService getData DB SELECT error START ========");
			e.printStackTrace();
		}finally {
			if(rs != null) rs.close();
			if(pstmt != null) pstmt.close();
			if(conn != null) conn.close();
		}
		
		return dataVO;
	}
}
