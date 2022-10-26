<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@include file="/layout/top_layout.jsp" %>

<%@page import="board.DataVO"%>
<%@page import="board.FileVO"%>
<%@page import="board.FileService"%>
<%@page import="board.BoardService"%>

<%@page import="java.util.List"%>

<%	
	String mode = "";
	String boardUid = "NOTICEBOARDUID"; //board고유값	
	String dataUid = "";
	int currentPage = 1;
	int rowCount = 5;	
	int file_max = 3; //쵀대 첨부파일 갯수
	boolean isManager = false;
	boolean errorFlag = false;
	
	if(loginUser != null && loginUser.getUserLevel() >= 9) isManager = true;
	
	if(request.getParameter("mode") != null && !"".equals((String)request.getParameter("mode"))) mode = (String)request.getParameter("mode");
	if(request.getParameter("boardUid") != null && !"".equals((String)request.getParameter("boardUid"))) boardUid = (String)request.getParameter("boardUid");
	if(request.getParameter("dataUid") != null && !"".equals((String)request.getParameter("dataUid"))) dataUid = (String)request.getParameter("dataUid");
	if(request.getParameter("rowCount") != null) rowCount = Integer.valueOf(request.getParameter("rowCount"));
	if(request.getParameter("page") != null) currentPage = Integer.valueOf(request.getParameter("page"));
	
	if(loginUser == null || "".equals(mode)) {
		errorFlag = true;
	}
	
	String paramOption = "page="+currentPage+"&amp;rowCount="+rowCount+"&amp;boardUid="+boardUid;
	
	BoardService boardService = new BoardService();
	FileService fileService = new FileService();
	
	DataVO dataVO = boardService.getData(dataUid);
	List<FileVO> attachFileList = fileService.getAttachFileLsit(dataUid, 0);
	
	if("update".equals(mode)) {		
		if("".equals(dataUid)) {
			errorFlag = true;
		}		
	}
	
	if(errorFlag) {
		%>
			<script type="text/javascript">
				alert('비정상적인 경로 입니다.');
				location.href = "<%=contextPath%>/board/notice_list.jsp";
			</script>
		<%
	}
%>
			
			<div id="content" style="flex-direction: column;">				
				<form method="POST" id="dataVO" name="dataVO" action="<%=contextPath%>/common/boardAction.jsp" onsubmit="return boardFormChk(this);" enctype="multipart/form-data">
					
					<%if("write".equals(mode)) { //게시글등록%>
						
						<input type="hidden" id="boardUid" name="boardUid" value="<%=boardUid%>" />
						<input type="hidden" id="userId" name="userId" value="<%=loginUser.getUserId()%>" />
						<input type="hidden" id="userName" name="userName" value="<%=loginUser.getUserName()%>" />
						
					<%}else if("update".equals(mode)) { //게시글 수정%>
					
						<input type="hidden" id="dataUid" name="dataUid" value="<%=dataVO.getDataUid() %>" />
						<input type="hidden" id="boardUid" name="boardUid" value="<%=dataVO.getBoardUid()%>" />
						<input type="hidden" id="userId" name="userId" value="<%=dataVO.getUserId()%>" />
						<input type="hidden" id="userName" name="userName" value="<%=dataVO.getUserName()%>" />
					
					<%} %>					
					
					<%if(loginUser != null && !isManager) {%>
					
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
							<%if(loginUser != null && isManager) { //관리자 권한이라면%>
							<tr>
								<td>글상태</td>
								<td>
									<select id="dataState" name="dataState">
										<option value="0" <%if(dataVO.getDataState() == 0) {%>selected="selected"<%} %>>일반</option>									
										<option value="2" <%if(dataVO.getDataState() == 2) {%>selected="selected"<%} %>>차단</option>
										<option value="3" <%if(dataVO.getDataState() == 3) {%>selected="selected"<%} %>>공지</option>
									</select>
								</td>
							</tr>
							<%} %>
							<tr>
								<td>제목</td>
								<td>
									<input type="text" id="dataTitle" name="dataTitle" value="<%=dataVO.getDataTitle() %>" />
								</td>
							</tr>
							<tr>
								<td>작성자</td>
								<td>
									<input type="text" id="userNickname" name="userNickname" value="<%if("write".equals(mode)){ %><%=loginUser.getUserNickname()%><%}else if("update".equals(mode)) {%><%=dataVO.getUserNickname() %><%} %>" <%if(loginUser != null && !isManager) { %>readonly="readonly"<%} %> />
								</td>
							</tr>
							<tr>
								<td>첨부파일</td>
								<td class="attachFile">
									<%if(file_max > attachFileList.size()) {%>
									<div>
										<input type="file" name="file0" />
										<button type="button" class="add_file">+</button>
									</div>
									<%} %>
									<%
										if(attachFileList != null && attachFileList.size() > 0) {
											for(FileVO fileVO : attachFileList) {
												%>
													<div>
														<a href="javascript:deleteFile('<%=fileVO.getFileUid()%>', '<%=fileVO.getBoardUid()%>', '<%=fileVO.getDataUid()%>');"><%=fileVO.getFileName() %> [삭제]</a>
													</div>
												<%
											}
										}
									%>
								</td>
							</tr>
							<tr>
								<td>내용</td>
								<td>
									<textarea id="dataContent" name="dataContent"><%=dataVO.getDataContent().replaceAll("<br />", "\r\n") %></textarea>
								</td>
							</tr>
						</tbody>					
					</table>
					
					<div class="board_btn_area">
						<button type="submit">확인</button>
						<%if("write".equals(mode)) {%>
						<a href="<%=contextPath%>/board/notice_list.jsp?&amp;<%=paramOption%>">취소</a>
						<%}else if("update".equals(mode)) {%>
						<a href="<%=contextPath%>/board/notice_detail.jsp?dataUid=<%=dataVO.getDataUid()%>&amp;<%=paramOption%>">취소</a>
						<%} %>
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
		
		function deleteFile(fileUid, boardUid, dataUid) {
			if(confirm('첨부파일을 삭제하시겠습니까?')) {
				location.href = "<%=contextPath%>/common/deleteFile.jsp?fileUid="+fileUid+"&boardUid="+boardUid+"&dataUid="+dataUid+"";
				return true;
			}else {
				return false;
			}
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