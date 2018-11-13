<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%><!DOCTYPE html>
<html>
<head>
<title>下注详情 - <%=com.yy.guess.util.Util.getConfigCom(application).getWebTitle()%></title>
<%@include file="/m/head-common.jsp"%>
<script src="m/js/bet.js"></script>
<style type="text/css">
#vux_view_box_body::-webkit-scrollbar{display:none;width:0;height:0;}
.liu-icon{background-position:50%;background-repeat:no-repeat;width:28px;height:34px;background-image:url('m/images/liu.svg');margin-top:-5px;}
.info-title{display:flex;align-items:center;}
.info-title .tournament-name{margin-left:6px;font-size:1.2rem;}
.info-title .match-round{font-size:1.2rem;color:#758bb5;margin-left:6px;}
</style>
<script>
$(document).ready(function(){betDetailInit("${param.versusId}", <%=com.yy.guess.util.Util.getConfigCom(application).getClientLoadDataInterval()%>);});
</script>
</head>
<body>
	<div id="app" class="">
		<nav data-v-1db5fc32="" class="app-header">
			<ul data-v-1db5fc32="">
				<li data-v-1db5fc32="" onclick="window.location.href='${basePath}m/index.jsp?index=${param.index}&date=${param.date}'" class="base-icon history-back"></li>
				<li data-v-1db5fc32="">下注详情</li>
				<li data-v-1db5fc32="" class="base-icon"></li>
			</ul>
		</nav>
		<div class="weui-tab">
			<div id="vux_view_box_body" class="weui-tab__panel vux-fix-safari-overflow-scrolling" style="padding-bottom:25px !important;">
				<div data-v-31296f00="" class="betting-page router-view"></div>
			</div>
		</div>
	</div>
	<%@include file="/m/numberInput.jsp"%>
</body>
</html>