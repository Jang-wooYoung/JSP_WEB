<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@include file="/layout/top_layout.jsp" %>
			
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
								제목제목제목제목제목제목제목제목제목제목제목제목제목제목제목제목
							</td>
						</tr>
						<tr>
							<td>작성자</td>
							<td>
								김아무개
							</td>
						</tr>
						<tr>
							<td>첨부파일</td>
							<td>
								<a href="#">파일명</a>
							</td>
						</tr>
						<tr>
							<td>내용</td>
							<td>
								내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용								
							</td>
						</tr>
					</tbody>					
				</table>
					
				<div class="board_btn_area">
					<a href="#">수정</a>
					<a href="#">삭제</a>
					<a href="<%=contextPath%>/board/notice_list.jsp">목록</a>
				</div><!-- *board_btn_area -->
			</div><!-- *content -->
			
<%@include file="/layout/bottom_layout.jsp" %>