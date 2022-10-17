<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@include file="/layout/top_layout.jsp" %>

<%@page import="board.DataVO"%>
<%@page import="board.BoardService"%>

<%@page import="java.util.List"%>
<%

	String boardUid = "NOTICEBOARDUID";		//게시판 고유값
	int rowCount = 1;						//페이지당 춮력게시글 수	
	int currentPage = 1;					//현재페이지
	
	int blockPerPage = 5;					//페이지번호 수
	int totalPage = 0;						//총페이지
	int totalCount = 0;						//게시물 총갯수
	
	BoardService boardService = new BoardService();
	List<DataVO> dataList = boardService.getDataList(boardUid, 0, currentPage, rowCount);
	totalCount = (int)boardService.getDataCount(boardUid, 0);
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
											<td class="title"><a href="#"><%=dataVO.getDataTitle() %></a></td>
											<td class="reg"><%=dataVO.getRegister_dt() %></td>
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
					<a href="#" class="first"><span> &lt;&lt; </span></a>
					<a href="#" class="prev"><span> &lt; </span></a>
					
					<a href="#" class="page_num">1</a>
					<a href="#" class="page_num">2</a>
					<a href="#" class="page_num">3</a>
					<a href="#" class="page_num">4</a>
					<a href="#" class="page_num">5</a>
					
					<a href="#" class="next"><span> &gt; </span></a>
					<a href="#" class="last"><span> &gt;&gt; </span></a>
				</div><!-- *pagination -->
				
				<div class="board_btn_area">
					<a href="<%=contextPath%>/board/notice_write.jsp?mode=write">글쓰기</a>
				</div><!-- *board_btn_area -->
			</div><!-- *content -->
			
<%@include file="/layout/bottom_layout.jsp" %>