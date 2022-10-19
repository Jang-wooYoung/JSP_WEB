<%@page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>

<%@page import="java.io.FileInputStream"%>
<%@page import="java.net.URLEncoder"%>
<%@page import="java.io.File"%>
<%@page import="java.io.BufferedOutputStream"%>
<%@page import="java.io.BufferedInputStream"%>
<%
	request.setCharacterEncoding("UTF-8");
	
	String downloadPath = request.getServletContext().getRealPath("/uploadFile/board/"); //파일다운로드경로
	String browser = request.getHeader("user-agent"); //브라우저 종류
	String fileMask = ""; //서버파일명
	
	if(request.getParameter("fileMask") != null && !"".equals((String)request.getParameter("fileMask"))) fileMask = (String)request.getParameter("fileMask");
	
	if("".equals(fileMask)) {
		%>
			<script type="text/javascript">
				alert('파일명이 존재하지 않습니다.');
				history.back();
			</script>
		<%
		return;
	}
		
	BufferedInputStream is = null;
	BufferedOutputStream os = null;
	File file = new File(downloadPath, fileMask);

	if(browser.indexOf("MISE") > -1 || browser.indexOf("Trident") > -1) { //IE 환경이라면
		fileMask = URLEncoder.encode(fileMask, "UTF-8");		
	}else {
		fileMask = new String(fileMask.getBytes("utf-8"), "ISO-8859-1");		
	}
	
	response.reset();	
	response.setContentType("application/octet-stream");
	response.setHeader("Content-Disposition", "attachment; filename="+fileMask);
		
	try {
		
		out.clear();
		out = pageContext.pushBody();
				
		is = new BufferedInputStream(new FileInputStream(file));
		os = new BufferedOutputStream(response.getOutputStream());
		

		byte[] buffer = new byte[(int)file.length()];
		int read = 0;
		
		while( (read = is.read(buffer)) > 0) {
			os.write(buffer, 0, read);
		}
		
		os.close();
		is.close();		
		
	}catch(Exception e) {
		System.out.println("======== fileDownload.jsp error START ========");
		e.printStackTrace();
	}finally {
		if(os != null) os.close();
		if(is != null) is.close();
	}
	
%>