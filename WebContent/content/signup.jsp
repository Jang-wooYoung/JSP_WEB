<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@include file="/layout/top_layout.jsp" %>

<%
	boolean errorFlag = false;
	String mode = "";
	String userPhone[] = {"", "", ""};
	String userEmail[] = {"", ""};
	
	
	if (request.getParameter("mode") != null && !"".equals(request.getParameter("mode"))) mode = (String)request.getParameter("mode");
	
	if("write".equals(mode) && loginUser != null) { //회원가입이고 로그인상태라면
		errorFlag = true;
	}
	
	if("update".equals(mode)) { //회원수정
		if(loginUser == null) { //비로그인 상태라면
			errorFlag = true;
		}else {
			userPhone = loginUser.getUserPhone().split("-");
			userEmail = loginUser.getUserEmail().split("@");
		}
	}
	
	if("".equals(mode)) { //모드값이 존재하지않는다면
		errorFlag = true;
	}
	
	if(errorFlag) {
		%>
			<script type="text/javascript">	
				alert("비정상적인 경로입니다.");
				location.href = "<%=contextPath%>/index.jsp";
			</script>
		<%
	}
%>

		<div id="content">
			<div class="signup_box">
				<div class="signup_tb_box">
					<%if("write".equals(mode)) {%>
					<h1>회원가입</h1>
					<%}else if("update".equals(mode)) {%>
					<h1>회원수정</h1>
					<%} %>
					
					<form method="POST" action="<%=contextPath%>/common/userAction.jsp" onsubmit="return userFormChk(this);">						
						<input type="hidden" id="mode" name="mode" value="<%=mode%>" />
						<input type="hidden" id="userNickname" name="userNickname" value="" />
						<input type="hidden" id="userPhone" name="userPhone" value="" />
						<input type="hidden" id="userEmail" name="userEmail" value="" />						
						<%if("update".equals(mode)) {%>
						<input type="hidden" id="userUid" name="userUid" value="<%=loginUser.getUserUid() %>" />
						<%} %>
						
						<table class="signup_tb">
							<tr>
								<td><label for="userId">아이디</label></td>
								<td style="width:450px;">
									<input type="text" class="input_box" id="userId" name="userId" <%if("update".equals(mode)) {%>value="<%=loginUser.getUserId()%>" readonly="readonly"<%} %> maxlength="20" />
									<%if("write".equals(mode)) {%>									
									<input type="button" class="input_btn" value="중복확인" onclick="id_overlap_chk();">
									<%} %>									
									<p id="id_chk"></p>
								</td>
							</tr>
							<tr>
								<td><label for="userPassword">비밀번호</label></td>
								<td>
									<input type="password" class="input_box" id="userPassword" name="userPassword" onkeyup="pw_val_chk();" maxlength="32" />
								</td>
							</tr>
							<tr>
								<td><label for="userId">비밀번호확인</label></td>
								<td>
									<input type="password" class="input_box" id="userPassword_chk" name="userPassword_chk" onkeyup="pw_val_chk();" maxlength="32" />
									<p id="pw_chk"></p>
								</td>
							</tr>
							<tr>
								<td><label for="userName">이름</label></td>
								<td>
									<input type="text" class="input_box" id="userName" name="userName" <%if("update".equals(mode)) {%>value="<%=loginUser.getUserName()%>" readonly="readonly"<%} %> />
									<p id="name_chk"></p>
								</td>
							</tr>
							<tr>
								<td><label for="phone2">연락처</label></td>
								<td>
									<select id="phone1" name="phone1">
										<option value="">선택</option>
										<option value="010">010</option>
										<option value="011">011</option>
										<option value="016">016</option>										
										<option value="017">017</option>
										<option value="019">019</option>
									</select>
									- <input type="text" class="tel inNum" id="phone2" name="phone2" <%if("update".equals(mode)) {%>value="<%=userPhone[1]%>"<%} %> maxlength="4" />
									- <input type="text" class="tel inNum" id="phone3" name="phone3" <%if("update".equals(mode)) {%>value="<%=userPhone[2]%>"<%} %> maxlength="4" />
								</td>
							</tr>
							<tr>
								<td><label for="email1">이메일</label></td>
								<td>
									<input type="text" id="email1" name="email1" <%if("update".equals(mode)) {%>value="<%=userEmail[0]%>"<%} %> /> @
									<select id="email_select">
										<option value="">선택</option>
										<option value="naver.com">naver.com</option>
										<option value="daum.net">daum.net</option>
										<option value="nate.com">nate.com</option>
										<option value="hanmail.net">hanmail.net</option>
										<option value="gmail.com">gmail.com</option>
										<option value="hotmail.com">hotmail.com</option>
										<option value="outlook.com">outlook.com</option>
										<option value="empal.com">empal.com</option>
					                </select>
									&nbsp;&nbsp;&nbsp;&nbsp;<input type="text" id="email2" name="email2" <%if("update".equals(mode)) {%>value="<%=userEmail[1]%>"<%} %> placeholder="직접입력">
								</td>
							</tr>
						</table>
						
						<div class="btn_area">
							<%if("write".equals(mode)) {%>
							<input type="submit" value="확인" />							
							<%}else if("update".equals(mode)) { %>
							<input type="submit" value="수정" />
							<input type="button" class="delete" value="탈퇴" />							
							<%} %>
							<input type="button" class="cancel" value="취소" />
						</div><!-- *btn_area -->
					</form>
				</div><!-- *signup_tb_box -->				
			</div><!-- *signup_box -->
		</div><!-- *content -->
		
<%@include file="/layout/bottom_layout.jsp" %>

<script type="text/javascript">
	var overlap_chk = false; //중복회원 체크여부
	var id_chk = false; //아이디정규식 체크
	var pw_chk = false; //비밀번호확인 체크
	var name_chk = false; //이름정규식 체크
	var submit_chk = false; //종복submit 방지
	
	<%if("update".equals(mode)) {%>
	overlap_chk = true;
	id_chk = true;
	name_chk = true;
	
	$(function() {
		$("#phone1").val("<%=userPhone[0]%>").trigger('change');
	});
	
	$(".delete").on("click", function() { //탈퇴버튼
		if(confirm('탈퇴를 진행하시겠습니까?')) {
			location.href = "<%=contextPath%>/common/userAction.jsp?mode=delete";
		}else {
			return false;
		}
		
	});
	
	<%}%>
	
	var regexp1 = /^[A-Za-z0-9+]*$/; //영문+숫자 정규식
	var regexp2 = /^[가-힣a-zA-Z]+$/; //한글+영문 정규식
	var regexp3 = /^[0-9]{2,3}-[0-9]{3,4}-[0-9]{4}$/; //휴대전화번호 정규식
	
	function id_overlap_chk() { //중복회원 체크
		
		var id_chk_val = $("#userId").val();
		
		if(id_chk_val != "") {
			
			$.ajax({
				url : '<%=contextPath%>/common/userOverlap.jsp',
				data : {userId : id_chk_val},
				type : "POST",
				dataType : "json",
				success : function(result) {
					if(result.result_Code == "300") {
						overlap_chk = true;						
					}else {
						overlap_chk = false;
					}
					alert(result.result_Msg);
				},
				error : function(request, status, error) {
					overlap_chk = false;
					alert("문제가 발생하였습니다.\n잠시후에 다시 시도해주세요.\n에러코드 : "+request.status);
				}
			});
			
		}else { //아이디값이 빈값이라면
			overlap_chk = false;
			alert('아이디를 입력하여 주십시오.');
		}		
	}
	
	function id_val_chk(idval) { //아이디 정규식체크
		if(!regexp1.test(idval.value)) {			
			$("#id_chk").text("영문과숫자만 입력가능합니다.");
			id_chk = false;
		}else {
			$("#id_chk").text("");
			id_chk = true;
		}
	}
	
	function pw_val_chk() { //패스워드 체크
		var pw1 = $("#userPassword").val();
		var pw2 = $("#userPassword_chk").val();
		
		if(pw1 != pw2) {
			$("#pw_chk").text("비밀번호가 일치하지 않습니다.");
			pw_chk = false;
		}else {
			$("#pw_chk").text("");
			pw_chk = true;
		}
	}
	
	$("#email_select").change(function() { //이메일 셀렉트박스 변경감지
		$("#email2").val($(this).val());		
	});
	
	function userFormChk(form) {
		
		if(submit_chk) { //가입진행중
			alert('가입이 진행중 입니다\n잠시만 기다려 주십시오.');
			return false;
		}
		
		//아이디 체크
		if(!form.userId.value) { alert('아이디를 입력하여 주십시오.'); form.userId.focus(); return false; } //아이디빈값체크
		if(!id_chk) { alert('아이디를 확인하여 주십시오.'); form.userId.focus(); return false; } //아이디 정규식 체크
		if(!overlap_chk) { alert('아이디 중복확인을 해주세요.'); form.userId.focus(); return false; } //아이디 중복확인 체크
		
		//패스워드 체크
		if(!form.userPassword.value) { alert('비밀번호를 입력하여 주십시오.'); form.userPassword.focus(); return false; } //패스워드 빈값체크
		if(!pw_chk) { alert('비밀번호흘 확인하여 주십시오.'); form.userPassword_chk.focus(); return false; } //패스워드 확인 체크
		
		//이름 체크
		if(!form.userName.value) { alert('이름을 입력하여 주십시오.'); form.userName.focus(); return false; } //이름 빈값체크
		if(!name_chk) { alert('이름을 확인하여 주십시오.'); form.userName.focus(); return false; } //이름 정규식체크		
		
		//연락처 체크
		var phone1 = form.phone1.value;
		var phone2 = form.phone2.value;
		var phone3 = form.phone3.value;
		var userPhone = phone1+"-"+phone2+"-"+phone3;
		
		if(!regexp3.test(userPhone)) { //연락처 정규식 체크
			alert('정확한 휴대전화번호를 입력하여 주십시오.');
			form.phone2.focus();
			return false;
		}
		
		//이메일체크
		var email1 = form.email1.value;
		var email2 = form.email2.value;
		var userEmail = email1+"@"+email2;
		if(email1 && !email2 || !email1 && email2) { alert('이메일을 입력하여 주십시오.'); form.email2.focus(); return false; }
		
		form.userNickname.value = form.userName.value;
		form.userPhone.value = userPhone;
		form.userEmail.value = userEmail;
		
		if(confirm('해당 내용으로 진행하시겠습니까?')) {
			submit_chk = true;
			return true;
		}else {
			return false;
		}
	}
	
	$("#userId").keyup(function() { //userId 변경마다 중복확인 체크값 초기화 및 입력값 체크
		overlap_chk = false;		
		id_val_chk(this);
	});
	
	$("#userName").keyup(function() { //이름 정규식체크
		name_chk = false;
		if(!regexp2.test(this.value)) {			
			$("#name_chk").text("한글또는영문만 입력가능합니다.");
			name_chk = false;
		}else {
			$("#name_chk").text("");
			name_chk = true;
		}
	});
	
	$(".inNum").keyup(function() { //숫자만 입력
		this.value = this.value.replace(/[^0-9]/g,'');
	});
	
	$(".cancel").on("click", function() { //취소버튼
		location.href = "<%=contextPath%>/index.jsp";
	});
</script>