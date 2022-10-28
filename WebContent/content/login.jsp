<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@include file="/layout/top_layout.jsp" %>

<%
	if(loginUser != null  && !"".equals(loginUser.getUserId()) ) {
		%>
			<script type="text/javascript">
				alert('현재 로그인 중입니다.');
				location.href = "<%=contextPath%>/index.jsp";
			</script>
		<%
	}
%>

		<div id="content">
			<div class="login_box">
				<div class="login_area">
					<h1>로그인</h1>
					
					<form method="POST" action="<%=contextPath %>/common/loginAction.jsp" onsubmit="return loginFormChk(this);">
						<input type="text" id="userId" name="userId" placeholder="아이디" />
						<input type="password" id="userPassword" name="userPassword" placeholder="패스워드" />
						<div class="login_btn">
							<input type="submit" value="로그인" />
						</div>
					</form>
				</div><!-- *login_area -->
				
				<div class="btn_area">					 
					<a href="<%=contextPath%>/content/signup.jsp?mode=write">회원가입</a>
				</div><!-- *btn_area -->
			</div><!-- *signup_box -->
		</div><!-- *content -->
		
		<script type="text/javascript">
			
			var login_chk = false;
		
			function loginFormChk(form) {
				
				if(login_chk) {
					alert('로그인이 진행중입니다 잠시만 기다려 주십시오.');
					return false;
				}
				
				if(!form.userId.value) { alert('아이디를 입력하여 주십시오.'); form.userId.focus(); return false; }
				if(!form.userPassword.value) { alert('비밀번호를 입력하여 주십시오.'); form.userPassword.focus(); return false; } 
				
				login_chk = true;
			}
		
		</script>
		
<%@include file="/layout/bottom_layout.jsp" %>