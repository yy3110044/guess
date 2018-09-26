<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%><!DOCTYPE html>
<html>
<head>
<title>- <%=com.yy.guess.util.Util.getConfigCom(application).getWebTitle()%></title>
<%@include file="/m/head-common.jsp"%>
<script src="m/js/usercenter.js"></script>
<script>
var msg = "<%=com.yy.fast4j.Fast4jUtils.urlDecode(request.getParameter("msg"))%>";
$(document).ready(function(){if(!empty(msg)) m_alert(msg);});
</script>
</head>
<body>
	<div id="app">
		<nav data-v-1db5fc32="" class="app-header">
			<ul data-v-1db5fc32="">
				<li data-v-1db5fc32="" onclick="window.location.href='m/usercenter/setting/index.jsp'" class="base-icon history-back"></li>
				<li data-v-1db5fc32="" id="title"></li>
				<li data-v-1db5fc32="" class="base-icon"></li>
			</ul>
		</nav>
		<div class="weui-tab">
			<div id="vux_view_box_body" class="weui-tab__panel vux-fix-safari-overflow-scrolling"></div>
		</div>
	</div>
</body>
</html>