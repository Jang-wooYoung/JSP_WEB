<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@page import="board.CommentService" %>
<%@page import="board.CommentVO" %>

<%@page import="java.util.UUID"%>
<%@page import="java.util.Date"%>

<%
	request.setCharacterEncoding("UTF-8"); //post값 한글처리
	
	String contextPath = request.getContextPath();
	String mode = "";
	String commentUid = "";
	String commentContent = "";
	String boardUid = "";
	String dataUid = "";
	String userId = "";
	String userName = "";
	String userNickname = "";
	int currentPage = 1;
	int rowCount = 5;
	
	if(request.getParameter("mode") != null && !"".equals((String)request.getParameter("mode"))) mode = (String)request.getParameter("mode");
	if(request.getParameter("commentUid") != null && !"".equals((String)request.getParameter("commentUid"))) commentUid = (String)request.getParameter("commentUid");
	if(request.getParameter("commentContent") != null && !"".equals((String)request.getParameter("commentContent"))) commentContent = (String)request.getParameter("commentContent");
	if(request.getParameter("boardUid") != null && !"".equals((String)request.getParameter("boardUid"))) boardUid = (String)request.getParameter("boardUid");
	if(request.getParameter("dataUid") != null && !"".equals((String)request.getParameter("dataUid"))) dataUid = (String)request.getParameter("dataUid");
	if(request.getParameter("userId") != null && !"".equals((String)request.getParameter("userId"))) userId = (String)request.getParameter("userId");
	if(request.getParameter("userName") != null && !"".equals((String)request.getParameter("userName"))) userName = (String)request.getParameter("userName");
	if(request.getParameter("userNickname") != null && !"".equals((String)request.getParameter("userNickname"))) userNickname = (String)request.getParameter("userNickname");
	if(request.getParameter("rowCount") != null) rowCount = Integer.valueOf(request.getParameter("rowCount"));
	if(request.getParameter("page") != null) currentPage = Integer.valueOf(request.getParameter("page"));
	
	if("".equals(commentContent) || "".equals(boardUid) || "".equals(dataUid) || "".equals(userId) || "".equals(userName) || "".equals(userNickname)) {
		%>
			<script type="text/javascript">
				alert('비정상적인 경로입니다.');
				location.href = "<%=contextPath%>/index.jsp";
			</script>
		<%
	}
	
	String paramOption = "page="+currentPage+"&rowCount="+rowCount+"&boardUid="+boardUid;
	
	CommentService commentService = new CommentService();
	
	if("write".equals(mode)) {
		int write_count = 0;
		String cuid = "";
		String alert_Msg = "";
		
		UUID uuid = UUID.randomUUID();
		cuid = uuid.toString().replaceAll("-","");
		
		CommentVO commentVO = new CommentVO();
		
		commentVO.setCommentUid(cuid);
		commentVO.setCommentContent(commentContent.replaceAll("\r\n", "<br />"));
		commentVO.setBoardUid(boardUid);
		commentVO.setDataUid(dataUid);
		commentVO.setUserId(userId);
		commentVO.setUserName(userName);
		commentVO.setUserNickname(userNickname);
		commentVO.setCommentIdx(commentService.getCommentMaxIdx() + 1);
		commentVO.setCommentState(0);
		commentVO.setRegister_dt(new Date());
				
		write_count = commentService.CommentWrite(commentVO);
		
		if(write_count > 0) {
			alert_Msg = "댓글등록에 성공하였습니다.";
		}else {
			alert_Msg = "댓글등록에 실패하였습니다.";
		}
		
		%>
			<script type="text/javascript">
				alert('<%=alert_Msg%>');
				location.href = "<%=contextPath%>/board/notice_detail.jsp?dataUid=<%=dataUid%>&<%=paramOption%>";
			</script>
		<%
		
		return;
		
	}else if("delete".equals(mode)) {
		
	}else {
		%>
			<script type="text/javascript">
				alert('비정상적인 경로입니다.');
				location.href = "<%=contextPath%>/index.jsp";
			</script>
		<%
	}
%>
