<%
	String contextPath = request.getContextPath();
	session.removeAttribute("loginUser");
%>
<script type="text/javascript">	
	location.href="<%=contextPath%>/index.jsp";
</script>