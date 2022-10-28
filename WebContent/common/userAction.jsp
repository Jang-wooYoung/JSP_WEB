<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@page import="user.UserService" %>
<%@page import="user.UserVO"%>
<%@page import="common.DES" %>

<%@page import="java.util.UUID"%>
<%@page import="java.util.Date"%>

<%
	request.setCharacterEncoding("UTF-8"); //post값 한글처리
	String contextPath = request.getContextPath();
	
	String result_Msg = "";
	
	String mode = ""; //write, update, delete
	String userUid = "";
	String userId = "";
	String userPassword = "";
	String userName = "";
	String userNickname = "";
	String userPhone = "";
	String userEmail = "";	
	
	if(request.getParameter("mode") != null && !"".equals((String)request.getParameter("mode"))) mode = (String)request.getParameter("mode");
	if(request.getParameter("userUid") != null && !"".equals((String)request.getParameter("userUid"))) userUid = (String)request.getParameter("userUid");
	if(request.getParameter("userId") != null && !"".equals((String)request.getParameter("userId"))) userId = (String)request.getParameter("userId");
	if(request.getParameter("userPassword") != null && !"".equals((String)request.getParameter("userPassword"))) userPassword = (String)request.getParameter("userPassword");
	if(request.getParameter("userName") != null && !"".equals((String)request.getParameter("userName"))) userName = (String)request.getParameter("userName");
	if(request.getParameter("userNickname") != null && !"".equals((String)request.getParameter("userNickname"))) userNickname = (String)request.getParameter("userNickname");
	if(request.getParameter("userPhone") != null && !"".equals((String)request.getParameter("userPhone"))) userPhone = (String)request.getParameter("userPhone");
	if(request.getParameter("userEmail") != null && !"".equals((String)request.getParameter("userEmail"))) userEmail = (String)request.getParameter("userEmail");
	
	UserService userService = new UserService();
	DES des3 = new DES();	
	
	if("write".equals(mode)) { //회원가입
		
		//필수값 체크 아이디, 패스워드, 이름, 연락처
		if("".equals(userId) || "".equals(userPassword) || "".equals(userName) || "".equals(userPhone)) {
			%>
				<script type="text/javascript">
					alert('필수값이 존재하지 않습니다.');
					location.href="<%=contextPath%>/content/signup.jsp";
				</script>
			<%
			return;
		}
				
		UUID uuid = UUID.randomUUID(); //사용자 고유값 랜덤UUID생성
		String uid = uuid.toString().replaceAll("-","");
	
		UserVO userVO = new UserVO();
		
		userVO.setUserUid(uid);
		userVO.setUserId(userId);
		userVO.setUserPassword(des3.encrypt(userPassword)); //개인정보보호를 위한 암호화
		userVO.setUserName(userName);
		userVO.setUserNickname(userName);
		userVO.setUserPhone(userPhone);
		userVO.setUserEmail(userEmail);
		userVO.setUserLevel(1);
		userVO.setUserState(0);
		userVO.setRegister_dt(new Date());
		
		result_Msg = userService.userWrite(userVO);
		
		%>
			<script type="text/javascript">
				alert('<%=result_Msg%>');
				location.href="<%=contextPath%>/content/login.jsp";
			</script>
		<%
		return ;
		
	}else if("update".equals(mode)) { //회원수정
		
		UserVO loginUser = (UserVO)session.getAttribute("loginUser");
		
		UserVO userVO = null;
		
		if(loginUser != null && !"".equals(loginUser.getUserId())) {			
			userVO = userService.getUser(loginUser.getUserUid());
		}
		
		if(userVO == null) { //회원정보가 존재하지않을경우
			%>
				<script type="text/javascript">
					alert('회원정보가 존재하지않습니다.');
					location.href = "<%=contextPath%>/index.jsp";
				</script>
			<%
			return;
		}else {
			
			userVO.setUserPassword(des3.encrypt(userPassword));
			userVO.setUserPhone(userPhone);
			userVO.setUserEmail(userEmail);
			userVO.setModify_dt(new Date());
			
			result_Msg = userService.userUpdate(userVO);
			
			session.removeAttribute("loginUser");
			
			%>
				<script type="text/javascript">
					alert('<%=result_Msg%>');
					location.href="<%=contextPath%>/content/login.jsp";
				</script>
			<%
			return ;
		}
		
	}else if("delete".equals(mode)) { //회원삭제
		
		UserVO loginUser = (UserVO)session.getAttribute("loginUser");
		
		UserVO userVO = null;
		
		if(loginUser != null && !"".equals(loginUser.getUserId())) {			
			userVO = userService.getUser(loginUser.getUserUid());
		}
		
		if(userVO == null) { //회원정보가 존재하지않을경우
			%>
				<script type="text/javascript">
					alert('회원정보가 존재하지않습니다.');
					location.href = "<%=contextPath%>/index.jsp";
				</script>
			<%
			return;
			
		}else {
			
			userVO.setUserState(1);
			userVO.setModify_dt(new Date());
			
			result_Msg = userService.userDelete(userVO);
			
			session.removeAttribute("loginUser");
			
			%>
				<script type="text/javascript">
					alert('<%=result_Msg%>');
					location.href="<%=contextPath%>/index.jsp";
				</script>
			<%
			return ;
			
		}		
		
	}else { 
		%>
			<script type="text/javascript">
				alert('부적절한 경로입니다.');
				location.href="<%=contextPath%>/index.jsp";
			</script>
		<%
		return;
	}
%>