<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%><%@page import="common.DBConnection"%><%@page import="java.sql.Connection"%><%@page import="org.json.simple.JSONObject"%><%@page import="java.sql.PreparedStatement"%><%@page import="java.sql.ResultSet"%><%
	JSONObject jsonObj = new JSONObject();	

	String userId = ""; //전달받은 ID값	
	if(request.getParameter("userId") != null && !"".equals((String)request.getParameter("userId"))) userId = (String)request.getParameter("userId");
	
	if(userId == "") { //id값이 넘어오지 않을경우
		
		jsonObj.put("result_Code", "100");
		jsonObj.put("result_Msg", "아이디가 입력되지 않았습니다.");
		
	}else {
		DBConnection dbconn = new DBConnection();

		Connection conn = null;
		
		conn = dbconn.getConnection(); //DB연결
		
		if(conn != null) { //DB연결성공
			
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			int rs_count = 0;
			
			try {
				String query = "";
				query += "SELECT * FROM user_tb";
				query += " WHERE USER_ID = ?";
				
				pstmt = conn.prepareStatement(query);
				
				pstmt.setString(1, userId);
				
				rs = pstmt.executeQuery();
				
				while(rs.next()) {
					rs_count ++;
					break;
				}
				
				if(rs_count > 0) {
					jsonObj.put("result_Code", "200");
					jsonObj.put("result_Msg", "중복회원이 존재합니다.");
				}else {
					jsonObj.put("result_Code", "300");
					jsonObj.put("result_Msg", "회원가입 가능한 아이디입니다.");
				}
				
				rs.close();
				pstmt.close();
				
			}catch(Exception e) {
				System.out.println("==== userOverlap.jsp sql error START ====");
				e.printStackTrace();
				System.out.println("==== userOverlap.jsp sql error END ====");
			}finally {
				if(rs != null) rs.close();
				if(pstmt != null) pstmt.close();
				if(conn != null) conn.close();
			}
			
		}else { //DB연결실패
			jsonObj.put("result_Code", "400");
			jsonObj.put("result_Msg", "DB연결이 원활하지 않습니다.");
		}	
	}	
	
%><%=jsonObj.toString()%>