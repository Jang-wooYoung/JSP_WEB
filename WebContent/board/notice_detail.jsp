<%@page import="java.net.URLEncoder"%>
<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@include file="/layout/top_layout.jsp" %>

<%@page import="board.DataVO"%>
<%@page import="board.FileVO"%>
<%@page import="board.FileService"%>
<%@page import="board.BoardService"%>

<%@page import="java.util.List"%>

<%
	String boardUid = "";
	String dataUid = "";
	int currentPage = 1;
	int rowCount = 5;
	boolean errorFlag = false; //에러구분
	boolean isManager = false;
	
	if(loginUser != null && loginUser.getUserLevel() >= 9) isManager = true;
	
	if(request.getParameter("boardUid") != null && !"".equals((String)request.getParameter("boardUid"))) boardUid = (String)request.getParameter("boardUid");
	if(request.getParameter("dataUid") != null && !"".equals((String)request.getParameter("dataUid"))) dataUid = (String)request.getParameter("dataUid");
	if(request.getParameter("rowCount") != null) rowCount = Integer.valueOf(request.getParameter("rowCount"));
	if(request.getParameter("page") != null) currentPage = Integer.valueOf(request.getParameter("page"));
	
	String paramOption = "page="+currentPage+"&amp;rowCount="+rowCount+"&amp;boardUid="+boardUid;
	
	if("".equals(boardUid) || "".equals(dataUid)) {
		errorFlag = true;
	}
	
	if(errorFlag) {
		%>
			<script type="text/javascript">
				alert('비정상적인 경로 입니다.');
				location.href = "<%=contextPath%>/board/notice_list.jsp";
			</script>
		<%
	}
	
	BoardService boardService = new BoardService();
	FileService fileService = new FileService();
	
	DataVO dataVO = boardService.getData(dataUid);
	List<FileVO> attachFileList = fileService.getAttachFileLsit(dataUid, 0);
%>			
			<div id="content" style="flex-direction: column;">
				<table class="notice_detail">
					<thead>
						<tr>
							<th>분류</th>
							<th>내용</th>
						</tr>
					</thead>
					<tbody>						
						<tr>
							<td>제목</td>
							<td>
								<%=dataVO.getDataTitle() %>
							</td>
						</tr>
						<tr>
							<td>작성자</td>
							<td>
								<%=dataVO.getUserNickname() %>
							</td>
						</tr>
						<tr>
							<td>첨부파일</td>
							<td>
								<%
									if(attachFileList != null && attachFileList.size() > 0) {
										for(FileVO fileVO : attachFileList) {
											%>
												<a href="<%=contextPath%>/common/fileDownload.jsp?fileMask=<%=URLEncoder.encode(fileVO.getFileMask(), "UTF-8")%>"><%=fileVO.getFileName() %></a><br />
											<%
										}
									}
								%>
							</td>
						</tr>
						<tr>
							<td>내용</td>
							<td>
								<%=dataVO.getDataContent() %>								
							</td>
						</tr>
					</tbody>					
				</table>
					
				<div class="board_btn_area">
					<%if( isManager || (loginUser != null && loginUser.getUserId().equals(dataVO.getUserId())) ) {%>
					<a href="<%=contextPath%>/board/notice_write.jsp?mode=update&amp;dataUid=<%=dataUid %>&amp;<%=paramOption%>">수정</a>
					<a href="#">삭제</a>
					<%} %>
					<a href="<%=contextPath%>/board/notice_list.jsp?&amp;<%=paramOption%>">목록</a>
				</div><!-- *board_btn_area -->
			</div><!-- *content -->
			
<%@include file="/layout/bottom_layout.jsp" %>