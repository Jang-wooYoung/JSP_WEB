<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@page import="board.BoardService"%>
<%@page import="board.FileService"%>
<%@page import="board.DataVO"%>
<%@page import="board.FileVO"%>

<%@page import="java.util.List"%>
<%@page import="java.util.Date"%>

<%
	String contextPath = request.getContextPath();
	String mode = "";
	String boardUid = "";	
	String dataUid = "";
	String resultMsg = "";
	
	int deletecount = 0;
	int file_deletecount = 0;
	
	if(request.getParameter("mode") != null && !"".equals((String)request.getParameter("mode"))) mode = (String)request.getParameter("mode");
	if(request.getParameter("boardUid") != null && !"".equals((String)request.getParameter("boardUid"))) boardUid = (String)request.getParameter("boardUid");
	if(request.getParameter("dataUid") != null && !"".equals((String)request.getParameter("dataUid"))) dataUid = (String)request.getParameter("dataUid");
	
	if(!"delete".equals(mode) || "".equals(boardUid) || "".equals(dataUid)) {
		%>
			<script type="text/javascript">
				alert('비정상적인 경로입니다.');
				location.href = "<%=contextPath%>/board/notice_list.jsp";
			</script>
		<%
		return;
	}
	
	BoardService boardService = new BoardService();
	FileService fileService = new FileService();
	
	DataVO dataVO = boardService.getData(dataUid);
	
	dataVO.setDataState(1);
	dataVO.setModify_dt(new Date());
	
	deletecount = boardService.DataDelete(dataVO);	
	
	if(deletecount > 0) {
		
		List<FileVO> attachFileList = fileService.getAttachFileLsit(dataUid, 0);
		
		if(attachFileList != null && attachFileList.size() > 0) {
			for(FileVO fileVO : attachFileList) {
				fileService.deleteFile(fileVO.getFileUid());			
			}
		}
		
		%>
			<script type="text/javascript">
				alert('삭제에 성공하였습니다.');
				location.href = "<%=contextPath%>/board/notice_list.jsp";
			</script>
		<%
		return;
	}else {
		%>
			<script type="text/javascript">
				alert('삭제에 실패하였습니다.');
				history.back();
			</script>
		<%
		return;
	}
%>