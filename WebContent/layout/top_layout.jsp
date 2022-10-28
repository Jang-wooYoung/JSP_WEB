<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@page import="user.UserVO"%>

<%
	String contextPath = request.getContextPath();

	UserVO loginUser = (UserVO)session.getAttribute("loginUser");
	if(loginUser == null) loginUser = new UserVO();
%>

<!DOCTYPE html>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" /> 
		<title>JSP_WEB</title>
		<link rel="stylesheet" href="<%=contextPath %>/css/main.css">
		<link rel="stylesheet" href="<%=contextPath %>/css/sub.css">
	</head>
	<body>	
		<script type="text/javascript" src="<%=contextPath %>/js/jquery.min.js"></script>		
	
		<div id="wrap">
			<div id="header">
				<div class="header_tit">WEB</div>
			</div><!-- *header -->
			
			<div id="nav">
				<div class="menu_box">
					<div class="menu">
						<a href="<%=contextPath%>/index.jsp">Home</a>
					</div>
					<div class="menu">
						<a href="<%=contextPath%>/board/notice_list.jsp">Notice</a>
					</div>					
				</div><!-- *menubox -->
				
				<div class="tool_box">
					<div class="login">
						<span>
							<%if(loginUser == null || "".equals(loginUser.getUserId())) {%>
								<a href="<%=contextPath%>/content/login.jsp">로그인</a>
							<%}else { %>
								<a href="<%=contextPath%>/content/signup.jsp?mode=update">마이페이지</a>
								<a href="<%=contextPath%>/content/logout.jsp">로그아웃</a>
							<%} %>
						</span>
					</div>					
				</div><!-- *tool_box -->
			</div><!-- *nav -->