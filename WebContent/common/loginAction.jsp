<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@page import="user.UserService" %>
<%@page import="user.UserVO"%>

<%
	String contextPath = request.getContextPath();
	
	UserVO loginUser = (UserVO)session.getAttribute("loginUser");	

	if(loginUser != null && !"".equals(loginUser.getUserId()) ) {
		%>
			<script type="text/javascript">
				alert('현재 로그인 중입니다.');
				location.href = "<%=contextPath%>/index.jsp";
			</script>
		<%
	}	

	String userId = "";
	String userPassword = "";
	
	if(request.getParameter("userId") != null && !"".equals((String)request.getParameter("userId"))) userId = (String)request.getParameter("userId");
	if(request.getParameter("userPassword") != null && !"".equals((String)request.getParameter("userPassword"))) userPassword = (String)request.getParameter("userPassword");
	
	if("".equals(userId) || "".equals(userPassword)) { //아이디 또는 비밀번호값이 존재하지 않을 경우.
		%>
			<script type="text/javascript">
				alert('필수값이 존재하지 않습니다.');
				location.href='<%=contextPath%>/content/login.jsp';
			</script>
		<%	
		return;
	}else {
		UserService userService = new UserService();
		UserVO userVO = null;
		
		userVO = userService.userLogin(userId, userPassword); //로그인서비스호출
		
		if("".equals(userVO.getUserUid()) || userVO.getUserUid() == null ) { //로그인 실패			
			%>
				<script type="text/javascript">
					alert('아이디 또는 비밀번호가 일치하지 않습니다.');
					location.href='<%=contextPath%>/content/login.jsp';
				</script>
			<%
			return;
		}else if(0 != userVO.getUserState()) {
			%>
				<script type="text/javascript">
					alert('회원이 삭제 또는 차단 상태입니다.');
					location.href='<%=contextPath%>/content/login.jsp';
				</script>
			<%
			return;
		}else { // 로그인 성공
			
			session.setAttribute("loginUser", userVO);
			
			%>
				<script type="text/javascript">					
					location.href='<%=contextPath%>/index.jsp';
				</script>
			<%
			return;
		}
	}
%>