<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@include file="/layout/top_layout.jsp" %>

<%@page import="board.DataVO"%>
<%@page import="board.BoardService"%>

<%@page import="java.util.List"%>
<%@page import="java.text.SimpleDateFormat"%>

<%

	String boardUid = "NOTICEBOARDUID";		//게시판 고유값
	int rowCount = 5;						//페이지당 춮력게시글 수	
	int currentPage = 1;					//현재페이지
	int totalCount = 0;						//게시물 총갯수	
	boolean isManager = false;				//관리자 여부
	
	if(loginUser != null && loginUser.getUserLevel() >= 9) isManager = true;
	
	if(request.getParameter("boardUid") != null && !"".equals((String)request.getParameter("boardUid"))) boardUid = (String)request.getParameter("boardUid");
	if(request.getParameter("rowCount") != null) rowCount = Integer.valueOf(request.getParameter("rowCount"));
	if(request.getParameter("page") != null) currentPage = Integer.valueOf(request.getParameter("page"));	
		
	String paramOption = "page="+currentPage+"&amp;rowCount="+rowCount+"&amp;boardUid="+boardUid;
	String pageOption = "rowCount="+rowCount+"&amp;boardUid="+boardUid;
	
	BoardService boardService = new BoardService();
	List<DataVO> dataList = boardService.getDataList(boardUid, 0, currentPage, rowCount);
	totalCount = (int)boardService.getDataCount(boardUid, 0);
	
	SimpleDateFormat sf = new SimpleDateFormat("yyyy-MM-dd");
%>
<%
	/* 페이징 - S */
	
	int blockPerPage = 5;		//페이지번호 수
	int totalPage = 0;			//총페이지
	int prevBlockPage = 0;		//이전페이지
	int nextBlockPage = 0;		//다음페이지
	int startBlockPage = 0;		//시작페이지	
	
	totalPage = (int)Math.ceil( (double)totalCount / (double)rowCount );
	
	if(totalPage > blockPerPage) {
		startBlockPage = (int)Math.floor((double)(currentPage-1) / (double)blockPerPage) * blockPerPage + 1;
		prevBlockPage = startBlockPage - 1;
		nextBlockPage = startBlockPage + blockPerPage;
	}else {
		startBlockPage = 1;
	}
	
	/* 페이징 - E */
%>
	
			<div id="content" style="flex-direction: column;">				
				<table class="notice_list">
					<thead>
						<tr>
							<th class="num">번호</th>
							<th class="">제목</th>
							<th class="reg">등록일</th>
							<th class="name">작성자</th>
							<th class="view">조회수</th>
						</tr>	
					</thead>
					<tbody>
						<%
							if(dataList != null && dataList.size() > 0) {
								
								int number = 0;
								number = totalCount - (currentPage - 1) * rowCount;								
								
								for(DataVO dataVO : dataList) {
									%>
										<tr>
											<td class="num"><%=number %></td>
											<td class="title"><a href="<%=contextPath%>/board/notice_detail.jsp?dataUid=<%=dataVO.getDataUid()%>&amp;<%=paramOption%>"><%=dataVO.getDataTitle() %></a></td>
											<td class="reg"><%=sf.format(dataVO.getRegister_dt()) %></td>
											<td class="name"><%=dataVO.getUserNickname() %></td>
											<td class="view"><%=dataVO.getViewCount() %></td>
										</tr>
									<%
									number--;
								}
							}else {
								%>
									<tr>
										<td colspan="5">게시글이 존재하지 않습니다.</td>
									</tr>
								<%
							}
						%>						
					</tbody>
				</table>
				
				<div class="paging">
					<%if(prevBlockPage > 0) { %>
					<a href="<%=contextPath %>/board/notice_list.jsp?page=1&amp;<%=pageOption %>" class="first"><span> &lt;&lt; </span></a>
					<a href="<%=contextPath %>/board/notice_list.jsp?page=<%=currentPage-1 %>&amp;<%=pageOption %>" class="prev"><span> &lt; </span></a>
					<%} %>
					
					<%
						for(int i=startBlockPage; i<startBlockPage+blockPerPage && i <= totalPage; i++) {							
							%>
								<a href="<%=contextPath %>/board/notice_list.jsp?page=<%=i %>&amp;<%=pageOption %>" class="page_num <%if(i == currentPage){%>active<%}%>"><%=i %></a>
							<%
						}
					%>
					
					<%if(nextBlockPage > blockPerPage && nextBlockPage <= totalPage) { %>
					<a href="<%=contextPath %>/board/notice_list.jsp?page=<%=currentPage+1 %>&amp;<%=pageOption %>" class="next"><span> &gt; </span></a>
					<a href="<%=contextPath %>/board/notice_list.jsp?page=<%=totalPage %>&amp;<%=pageOption %>" class="last"><span> &gt;&gt; </span></a>
					<%} %>
				</div><!-- *pagination -->
				
				<div class="board_btn_area">
					<a href="<%=contextPath%>/board/notice_write.jsp?mode=write&amp;<%=paramOption%>">글쓰기</a>
				</div><!-- *board_btn_area -->
			</div><!-- *content -->
			
<%@include file="/layout/bottom_layout.jsp" %>