<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@include file="/layout/top_layout.jsp" %>

<%	
	String mode = "";
	String boardUid = "NOTICEBOARDUID"; //board고유값
	int file_max = 3; //쵀대 첨부파일 갯수
	
	if(request.getParameter("mode") != null && !"".equals((String)request.getParameter("mode"))) mode = (String)request.getParameter("mode");
	
	if(loginUser == null || "".equals(mode)) {
		%>
			<script type="text/javascript">
				alert('비정상적인 경로입니다.');
				location.href = '<%=contextPath%>/board/notice_list.jsp';
			</script>
		<%
		return;
	}
%>
			
			<div id="content" style="flex-direction: column;">				
				<form method="POST" id="dataVO" name="dataVO" action="<%=contextPath%>/common/boardAction.jsp" onsubmit="return boardFormChk(this);" enctype="multipart/form-data">
					
					<%if("write".equals(mode)) { //게시글등록%>
						
						<input type="hidden" id="boardUid" name="boardUid" value="<%=boardUid%>" />
						<input type="hidden" id="userId" name="userId" value="<%=loginUser.getUserId()%>" />
						<input type="hidden" id="userName" name="userName" value="<%=loginUser.getUserName()%>" />
						
					<%}else if("update".equals(mode)) { //게시글 수정%>
					
						
					
					<%} %>					
					
					<%if(loginUser != null && loginUser.getUserLevel() < 9) {%>
					
						<input type="hidden" id="dataState" name="dataState" value="0" />
						
					<%} %>
					
						<input type="hidden" id="mode" name="mode" value="<%=mode%>" />
					
					<table class="notice_write">
						<thead>
							<tr>
								<th>분류</th>
								<th>내용</th>
							</tr>
						</thead>
						<tbody>
							<%if(loginUser != null && loginUser.getUserLevel() >= 9) { //관리자 권한이라면%>
							<tr>
								<td>글상태</td>
								<td>
									<select id="dataState" name="dataState">
										<option value="0">일반</option>									
										<option value="2">차단</option>
										<option value="3">공지</option>
									</select>
								</td>
							</tr>
							<%} %>
							<tr>
								<td>제목</td>
								<td>
									<input type="text" id="dataTitle" name="dataTitle" value="" />
								</td>
							</tr>
							<tr>
								<td>작성자</td>
								<td>
									<input type="text" id="userNickname" name="userNickname" value="<%=loginUser.getUserNickname()%>" <%if(loginUser != null && loginUser.getUserLevel() < 9) { %>readonly="readonly"<%} %> />
								</td>
							</tr>
							<tr>
								<td>첨부파일</td>
								<td class="attachFile">
									<div>
										<input type="file" name="file0" />
										<button type="button" class="add_file">+</button>
									</div>
								</td>
							</tr>
							<tr>
								<td>내용</td>
								<td>
									<textarea id="dataContent" name="dataContent"></textarea>
								</td>
							</tr>
						</tbody>					
					</table>
					
					<div class="board_btn_area">
						<button type="submit">확인</button>
						<a href="<%=contextPath%>/board/notice_list.jsp">목록</a>
					</div><!-- *board_btn_area -->
					
				</form>				
			</div><!-- *content -->
	
	
	<script type="text/javascript">
		
		function boardFormChk(form) {
			
			if(!form.dataTitle.value) { alert('제목을 입력하여 주십시오.'); form.dataTitle.focus(); return false; }
			if(!form.userNickname.value) { alert('작성자를 입력하여 주십시오.'); form.userNickname.focus(); return false; }
			if(!form.dataContent.value) { alert('내용을 입력하여 주십시오.'); form.dataContent.focus(); return false;}
			
			if(confirm('등록하시겠습니까?')) {
				return true;
			}else {
				return false;
			}
		}
		
		function del_file() {			
			$(".attachFile").children("div").last().remove();
		}
		
		$(".add_file").on("click", function() {
			
			var max_cnt = <%=file_max%>; //첨부파일 최대갯수
			var current_cnt = $(".attachFile").children("div").length;			
			
			if(max_cnt > current_cnt) {
				var html = "";
				html += "<div>";
				html += "<input type='file' name='file"+current_cnt+"' />";
				html += "<button type='button' onclick='del_file();'>-</button>"
				html += "</div>";
				
				$(".attachFile").append(html);
			}
			
		});
		
	</script>
			
<%@include file="/layout/bottom_layout.jsp" %>