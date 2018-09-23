<%
if(com.yy.guess.util.Util.isMobile(request)) {
	response.sendRedirect(request.getAttribute("basePath") + "m/index.jsp");
}
%><%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%><!DOCTYPE html>
<html>
<head>
<base href="${basePath}">
<title>竞猜</title>
<script src="js/jquery.js"></script>
</head>
<body>
<h2>Hello guess!</h2>
</body>
</html>