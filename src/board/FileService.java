package board;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.sql.Timestamp;

import common.DBConnection;

public class FileService {
	
	DBConnection dbcon = new DBConnection();	
	
	public int FileWrite(FileVO fileVO) throws SQLException { //첨부파일 등록
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
	
}
