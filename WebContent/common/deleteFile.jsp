<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@page import="board.FileService"%>

<%
	String contextPath = request.getContextPath();
	String fileUid = "";
	String boardUid = "";	
	String dataUid = "";
	String resultMsg = "";
	
	int deletecount = 0;
	
	if(request.getParameter("fileUid") != null && !"".equals((String)request.getParameter("fileUid"))) fileUid = (String)request.getParameter("fileUid");
	if(request.getParameter("boardUid") != null && !"".equals((String)request.getParameter("boardUid"))) boardUid = (String)request.getParameter("boardUid");
	if(request.getParameter("dataUid") != null && !"".equals((String)request.getParameter("dataUid"))) dataUid = (String)request.getParameter("dataUid");
	
	if("".equals(fileUid) || "".equals(boardUid) || "".equals(dataUid)) {
		%>
			<script type="text/javascript">
				alert('비정상적인 경로입니다.');
				location.href = "<%=contextPath%>/board/notice_list.jsp";
			</script>
		<%
		return;
	}
	
	FileService fileService = new FileService();
	
	deletecount = fileService.deleteFile(fileUid);
	
	if(deletecount > 0) {
		resultMsg = "첨부파이 삭제에 성공하였습니다.";		
	}else {
		resultMsg = "첨부파이 삭제에 실패하였습니다.";		
	}
	%>
		<script type="text/javascript">
			alert('<%=resultMsg%>');
			location.href = "<%=contextPath%>/board/notice_write.jsp?mode=update&boardUid=<%=boardUid%>&dataUid=<%=dataUid%>";
		</script>
	<%
%>