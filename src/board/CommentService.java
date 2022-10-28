package board;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;

import common.DBConnection;

public class CommentService {
	
	DBConnection dbcon = new DBConnection();
	
	/**
	 * 댓글테이블의 댓글 최대갯수를 구한다.
	 * @return 댓글 갯수
	 * @throws SQLException
	 */
	public int getCommentMaxIdx() throws SQLException {
		
		int count = 0;
		
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			
			String query = "SELECT COUNT(*) FROM board_comment_tb";
			
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
			System.out.println("======== CommentService getCommentMaxIdx DB SELECT error START ========");
			e.printStackTrace();
		}finally {
			if(rs != null) rs.close();
			if(pstmt != null) pstmt.close();
			if(conn != null) conn.close();
		}
		
		return count;
	}
	
	/**
	 * 댓글등록
	 * @param commentVO 댓굴 데이터 정보
	 * @return 등록성공 갯수반환
	 * @throws SQLException
	 */
	public int CommentWrite(CommentVO commentVO) throws SQLException {
		
		int write_count = 0;
		
		Connection conn = null;
		PreparedStatement pstmt = null;
		
		try {
			long tmpdate = commentVO.getRegister_dt().getTime();			
			Timestamp date = new Timestamp(tmpdate);
			
			String query = "";
			query += "INSERT INTO board_comment_tb";
			query += "(COMMENT_UID, BOARD_UID, DATA_UID, USER_ID, USER_NAME, USER_NICKNAME, COMMENT_CONTENT, COMMENT_IDX, COMMENT_STATE, REGISTER_DT)";
			query += " VALUES";
			query += "(?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
			
			conn = dbcon.getConnection();
			pstmt = conn.prepareStatement(query);
			
			pstmt.setString(1, commentVO.getCommentUid());
			pstmt.setString(2, commentVO.getBoardUid());
			pstmt.setString(3, commentVO.getDataUid());
			pstmt.setString(4, commentVO.getUserId());
			pstmt.setString(5, commentVO.getUserName());
			pstmt.setString(6, commentVO.getUserNickname());
			pstmt.setString(7, commentVO.getCommentContent());
			pstmt.setInt(8, commentVO.getCommentIdx());
			pstmt.setInt(9, commentVO.getCommentState());
			pstmt.setTimestamp(10, date);
			
			write_count = pstmt.executeUpdate();
			
			pstmt.close();
			conn.close();
			
		}catch(Exception e) {
			System.out.println("======== CommentService CommentWrite DB INSERT error START ========");
			e.printStackTrace();
		}finally {
			if(pstmt != null) pstmt.close();
			if(conn != null) conn.close();
		}
		
		return write_count;
	}
	
	public List<CommentVO> getCommentList(String boardUid, String dataUid, int commentState) throws SQLException {
		
		ArrayList<CommentVO> resultList = null;
		
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			
			resultList = new ArrayList<CommentVO>();
			
			String query = "";
			query += "SELECT * FROM board_comment_tb WHERE";
			query += " BOARD_UID = ? AND DATA_UID = ? AND COMMENT_STATE = ?";
			query += " ORDER BY REGISTER_DT ASC";
			
			conn = dbcon.getConnection();
			pstmt = conn.prepareStatement(query);
			
			pstmt.setString(1, boardUid);
			pstmt.setString(2, dataUid);
			pstmt.setInt(3, commentState);
			
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				CommentVO commentVO = new CommentVO();
				
				commentVO.setCommentUid(rs.getString("COMMENT_UID"));
				commentVO.setBoardUid(rs.getString("BOARD_UID"));
				commentVO.setDataUid(rs.getString("DATA_UID"));
				commentVO.setUserId(rs.getString("USER_ID"));
				commentVO.setUserName(rs.getString("USER_NAME"));
				commentVO.setUserNickname(rs.getString("USER_NICKNAME"));
				commentVO.setCommentContent(rs.getString("COMMENT_CONTENT"));
				commentVO.setCommentIdx(rs.getInt("COMMENT_IDX"));
				commentVO.setCommentState(rs.getInt("COMMENT_STATE"));
				commentVO.setRegister_dt(rs.getTimestamp("REGISTER_DT"));
				
				resultList.add(commentVO);				
			}
			
			rs.close();
			pstmt.close();
			conn.close();
			
		}catch(Exception e) {
			System.out.println("======== CommentService getCommentList DB SELECT error START ========");
			e.printStackTrace();
		}finally {
			if(rs != null) rs.close();
			if(pstmt != null) pstmt.close();
			if(conn != null) conn.close();
		}
		
		return resultList;
	}
}
