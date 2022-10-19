<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@page import="user.UserVO"%>
<%@page import="board.DataVO"%>
<%@page import="board.BoardService"%>
<%@page import="board.FileVO"%>
<%@page import="board.FileService"%>

<%@page import="java.util.UUID"%>
<%@page import="java.util.Date"%>
<%@page import="java.util.Enumeration"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.io.File"%>

<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>

<%	
	UserVO loginUser = (UserVO)session.getAttribute("loginUser");

	String contextPath = request.getContextPath();
	String folderPath = "/uploadFile/board/";
	String savePath = request.getServletContext().getRealPath(folderPath); //파일저장경로
	String allowType = "hwp,hwpx,doc,docx,pptx,ppt,xls,xlsx,pdf,jpg,jpeg,png"; //허용파일확장자
	String mode = "";
	String dataUid = "";
	String boardUid = "";
	String userId = "";
	String userName = "";
	String userNickname = "";
	String dataState = "";
	String dataTitle = "";
	String dataContent = "";	
	
	int FileMaxSize = 1024*1024*50; //첨부파일 최대사이즈 50MB
	int file_count = 0; //input file 갯수
	int writecount = 0; //등록여부
	int updatecount = 0; //수정여부
	
	File folder_dir = new File(savePath); //파일저장경로
	if(!folder_dir.exists()) { //해당경로에 파일이 없다면
		folder_dir.mkdirs(); //파일생성
	}
	
	MultipartRequest multi = new MultipartRequest(request, savePath, FileMaxSize, "utf-8", new DefaultFileRenamePolicy()); //파일업로드
		
	if(multi.getParameter("mode") != null && !"".equals((String)multi.getParameter("mode"))) mode = (String)multi.getParameter("mode");
	if(multi.getParameter("dataUid") != null && !"".equals((String)multi.getParameter("dataUid"))) dataUid = (String)multi.getParameter("dataUid");
	if(multi.getParameter("boardUid") != null && !"".equals((String)multi.getParameter("boardUid"))) boardUid = (String)multi.getParameter("boardUid");
	if(multi.getParameter("userId") != null && !"".equals((String)multi.getParameter("userId"))) userId = (String)multi.getParameter("userId");
	if(multi.getParameter("userName") != null && !"".equals((String)multi.getParameter("userName"))) userName = (String)multi.getParameter("userName");
	if(multi.getParameter("userNickname") != null && !"".equals((String)multi.getParameter("userNickname"))) userNickname = (String)multi.getParameter("userNickname");
	if(multi.getParameter("dataState") != null && !"".equals((String)multi.getParameter("dataState"))) dataState = (String)multi.getParameter("dataState");
	if(multi.getParameter("dataTitle") != null && !"".equals((String)multi.getParameter("dataTitle"))) dataTitle = (String)multi.getParameter("dataTitle");
	if(multi.getParameter("dataContent") != null && !"".equals((String)multi.getParameter("dataContent"))) dataContent = (String)multi.getParameter("dataContent");
	
	if("".equals(mode) || "".equals(boardUid) || "".equals(userId) || "".equals(userName) || "".equals(userNickname) || "".equals(dataState) || "".equals(dataTitle) || "".equals(dataContent) || loginUser == null) {
		%>
			<script type="text/javascript">
				alert('비정상적인 경로 입니다.');
				history.back();
			</script>
		<%
		return;
	}
		
	BoardService boardService = new BoardService();	
	FileService fileService = new FileService();
	
	UUID uuid = UUID.randomUUID(); //게시글 고유값 랜덤UUID생성
	String duid = uuid.toString().replaceAll("-","");
	
	if("write".equals(mode)) { //게시글등록
		DataVO dataVO = new DataVO();
		
		dataVO.setDataUid(duid);
		dataVO.setBoardUid(boardUid);
		dataVO.setDataTitle(dataTitle);
		dataVO.setDataContent(dataContent.replaceAll("\r\n", "<br />"));
		dataVO.setDataIdx(boardService.getDataMaxIdx()+1);
		dataVO.setUserId(userId);
		dataVO.setUserName(userName);
		dataVO.setUserNickname(userNickname);
		dataVO.setRegister_dt(new Date());
		dataVO.setDataState(0);
		dataVO.setViewCount(0);
		
		writecount = boardService.DataWrite(dataVO);
		
		if(writecount == 0) {
			%>
				<script type="text/javascript">
					alert('글등록에 실패하였습니다.');
					history.back();
				</script>
			<%
			return;
		}		
		
	}else if("update".equals(mode)) { //게시글수정		
		DataVO dataVO = boardService.getData(dataUid);
		
		dataVO.setDataTitle(dataTitle);
		dataVO.setDataContent(dataContent.replaceAll("\r\n", "<br />"));		
		dataVO.setModify_dt((new Date()));		
		
		updatecount = boardService.DataUpdate(dataVO);
		
		if(updatecount == 0) {
			%>
				<script type="text/javascript">
					alert('글수정에 실패하였습니다.');
					history.back();
				</script>
			<%
			return;
		}
		
	}else if("delete".equals(mode)) { //게시글삭제
		
	}else {
		%>
			<script type="text/javascript">
				alert('비정상적인 경로 입니다.');
				location.href = '<%=contextPath%>/index.jsp';
			</script>
		<%
		return;
	}
	
	/* -------------- 첨부파일 검증 및 등록 - S -------------- */		
	if(writecount > 0 || updatecount > 0) { //글등록 및 수정 성공시 첨부파일등록 검증
		
		boolean upload_flag = true; //파일최종 업로드 여부			
		
		ArrayList<FileVO> fileList = new ArrayList<FileVO>(); //첨부파일 정보를 담을 List
		
		Enumeration<?> enu = multi.getFileNames(); //input file 정보가져옴
		
		while(enu.hasMoreElements()) { //input file 순회 file0~N
			
			String file_uid = ""; //첨부파일의 고유값
			String input_name = ""; //input file name
			String original_name = ""; //첨부파일 원본이름
			String system_name = ""; //서버에 저장될 첨부파일 이름
			long fileSize = 0; //첨부파일 크기
			
			input_name = (String)enu.nextElement();				
			File tmpFile = multi.getFile(input_name);
			original_name = multi.getOriginalFileName(input_name);
			system_name = multi.getFilesystemName(input_name);
			
			if(tmpFile != null && original_name != null && system_name != null) { //첨부파일이 존재한다면
				
				UUID fuuid = UUID.randomUUID();
			
				file_uid = fuuid.toString().replaceAll("-","");
				fileSize = tmpFile.length();
				
				FileVO fileVO = new FileVO();
				
				fileVO.setFileUid(file_uid);
				fileVO.setBoardUid(boardUid);
				if(writecount > 0) {
					fileVO.setDataUid(duid);
				}else if(updatecount > 0) {
					fileVO.setDataUid(dataUid);
				}
							
				fileVO.setFileMask(system_name);
				fileVO.setFileName(original_name);
				fileVO.setFileSize(fileSize);
				fileVO.setFileState(0);
				fileVO.setRegister_dt(new Date());
				
				fileList.add(fileVO);
				
			}else { //첨부파일이 없다면
				continue;
			}
			
		}
		
		/* -------------- 첨부파일 확장자 검증 - S -------------- */			
		if(fileList != null && fileList.size() > 0) {
			for(FileVO fileVO : fileList) {
				
				String fileType[] = fileVO.getFileName().split("\\."); //첨부파일타입
				String allow[] = allowType.split("\\,"); //허용확장자 타입
				
				boolean type_flag = false;
				
				for(int j=0; j<allow.length; j++) {
					if(allow[j].equals(fileType[1].toLowerCase())) { //허용된 확장자라면
						type_flag = true;
						break;
					}					
				}
				
				if(!type_flag) { //허용된 확장자가 아니라면
					upload_flag = false; //업로드 x
				}
				
			}
		}
		/* -------------- 첨부파일 확장자 검증 - E -------------- */
		
		
		/* -------------- 첨부파일 등록여부 - S -------------- */
		if(!upload_flag) { //파일업로드 불허상태라면 파일삭제
			if(fileList != null && fileList.size() > 0) {
				for(FileVO fileVO : fileList) {
					if(fileVO.getFileMask() != null && !"".equals(fileVO.getFileMask())) {
						File tmpFile = new File(savePath+fileVO.getFileMask()); //업로드된 파일조회
						if(tmpFile.exists()) { //해당파일존재한다면
							tmpFile.delete(); //삭제		
						}
					}
				}
				%>
					<script type="text/javascript">
						alert('첨부파일에 등록되지않은 확장자가 존재합니다.\r\n허용확장자 : <%=allowType%>');
						location.href = "<%=contextPath%>/board/notice_list.jsp";
					</script>
				<%
			}
		}else { //파일등록
			if(fileList != null && fileList.size() > 0) {
				
				int file_writecount = 0;
				
				for(FileVO fileVO : fileList) {
					file_writecount = fileService.FileWrite(fileVO);
					
					if(file_writecount == 0) { //등록실패
						%>
							<script type="text/javascript">
								alert('첨부파일 등록에 실패하였습니다.');
								location.href = "<%=contextPath%>/board/notice_list.jsp";
							</script>
						<%
						return;
					}
					
				}
			}
		}
		/* -------------- 첨부파일 등록여부 - E -------------- */
		
		%>
			<script type="text/javascript">
				alert('게시글이 정상적으로 등록되었습니다.');
				location.href = "<%=contextPath%>/board/notice_list.jsp";
			</script>
		<%
		return;
	}		
	/* -------------- 첨부파일 검증 및 등록 - E --------------*/	
%>