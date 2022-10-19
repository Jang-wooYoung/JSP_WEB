package board;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;

import common.DBConnection;

public class FileService {
	
	DBConnection dbcon = new DBConnection();	
	
	/**
	 * 게시글에 첨부파일을 등록한다.
	 * @param fileVO 첨부파일정보
	 * @return 등록갯수 반환
	 * @throws SQLException
	 */
	public int FileWrite(FileVO fileVO) throws SQLException {
		int count = 0;
		
		Connection conn = null;
		PreparedStatement pstmt = null;
				
		try {
			long tmpdate = fileVO.getRegister_dt().getTime();			
			Timestamp date = new Timestamp(tmpdate);
			
			String query = "";
			query += "INSERT INTO board_file_tb";
			query += "(FILE_UID, BOARD_UID, DATA_UID, FILE_MASK, FILE_NAME, FILE_SIZE, FILE_STATE, REGISTER_DT) VALUES";
			query += " (?, ?, ?, ?, ?, ?, ?, ?)";
			
			conn = dbcon.getConnection();
			pstmt = conn.prepareStatement(query);
			
			pstmt.setString(1, fileVO.getFileUid());
			pstmt.setString(2, fileVO.getBoardUid());
			pstmt.setString(3, fileVO.getDataUid());
			pstmt.setString(4, fileVO.getFileMask());
			pstmt.setString(5, fileVO.getFileName());
			pstmt.setLong(6, fileVO.getFileSize());
			pstmt.setInt(7, fileVO.getFileState());
			pstmt.setTimestamp(8, date);
			
			count = pstmt.executeUpdate();
			
			pstmt.close();
			conn.close();
			
		}catch(Exception e) {
			System.out.println("======== FileService FileWrite DB INSERT error START ========");
			e.printStackTrace();
		}finally {
			if(pstmt != null) pstmt.close();
			if(conn != null) conn.close();
		}
		
		return count;
	}
	
	/**
	 * 게시글의 첨부파일 리스트를 가져온다.
	 * @param dataUid 게시물 고유값
	 * @param fileState 첨부파일 상태
	 * @return 첨부파일 리스트 반환
	 * @throws SQLException
	 */
	public List<FileVO> getAttachFileLsit(String dataUid, int fileState) throws SQLException {
		ArrayList<FileVO> resultList = new ArrayList<FileVO>();
		
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			
			String query = "";
			query += "SELECT * FROM board_file_tb WHERE";
			query += " DATA_UID = ? AND FILE_STATE = ?";
			
			conn = dbcon.getConnection();
			pstmt = conn.prepareStatement(query);
			
			pstmt.setString(1, dataUid);
			pstmt.setInt(2, fileState);
			
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				FileVO fileVO = new FileVO();
				
				fileVO.setFileUid(rs.getString("FILE_UID"));
				fileVO.setBoardUid(rs.getString("BOARD_UID"));
				fileVO.setDataUid(rs.getString("DATA_UID"));
				fileVO.setFileMask(rs.getString("FILE_MASK"));
				fileVO.setFileName(rs.getString("FILE_NAME"));
				fileVO.setFileSize(rs.getLong("FILE_SIZE"));
				fileVO.setFileState(rs.getInt("FILE_SIZE"));
				fileVO.setRegister_dt(rs.getTimestamp("REGISTER_DT"));
				fileVO.setTmpField1(rs.getString("TMPFIELD1"));
				fileVO.setTmpField2(rs.getString("TMPFIELD2"));
				fileVO.setTmpField3(rs.getString("TMPFIELD3"));
				
				resultList.add(fileVO);
			}
			
			rs.close();
			pstmt.close();
			conn.close();
			
		}catch(Exception e) {
			System.out.println("======== FileService getAttachFileLsit DB SELECT error START ========");
			e.printStackTrace();
		}finally {
			if(rs != null) rs.close();
			if(pstmt != null) pstmt.close();
			if(conn != null) conn.close();
		}
		
		return resultList;
	}
	
	/**
	 * 첨부파일 상태변경
	 * @param fileUid 첨부파일고유값
	 * @return 상태변경된 갯수
	 * @throws SQLException
	 */
	public int deleteFile(String fileUid) throws SQLException {
		int deletecount = 0;
		
		Connection conn = null;
		PreparedStatement pstmt = null;
		
		try {
			
			String query = "";
			query += "UPDATE board_file_tb SET FILE_STATE = 1";
			query += " WHERE FILE_UID = ?";
			
			conn = dbcon.getConnection();
			pstmt = conn.prepareStatement(query);
			
			pstmt.setString(1, fileUid);
			
			deletecount = pstmt.executeUpdate();
			
			pstmt.close();
			conn.close();
			
		}catch(Exception e) {
			System.out.println("======== FileService deleteFile DB UPDATE error START ========");
			e.printStackTrace();
		}finally {
			if(pstmt != null) pstmt.close();
			if(conn != null) conn.close();
		}
		
		return deletecount;
	}
}
