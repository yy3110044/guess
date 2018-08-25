<%@ page language="java" pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%><!DOCTYPE html>
<html>
<head>
<base href="${basePath}">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>交易流水 - <%=com.yy.guess.util.Util.getConfigCom(application).getWebTitle()%></title>
<link rel="stylesheet" href="admin/css/bootstrap.css">
<link rel="stylesheet" href="admin/css/css.css">
<script src="js/jquery.js"></script>
<script src="laydate/laydate.js"></script>
<script src="admin/js/common.js"></script>
<script>
$(document).ready(function(){
	query(20, 1);
});
var query = function(pageSize, pageNo) {
	var userId = $.trim($("#userId").val());
	var type = $.trim($("#type").val());
	var startTime = $.trim($("#startTime").val());
	var endTime = $.trim($("#endTime").val());
	loadData({
		url : "administration/tradeFlowList",
		data : {
			"userId" : userId,
			"type" : ("全部" == type ? null : type),
			"startTime" : startTime,
			"endTime" : endTime,
			"pageSize" : pageSize,
			"pageNo" : pageNo
		},
		success : function(data){
			if(data.code == 100) {
				fillResult(data, [
					{field : "id"},
					{field : "userId"},
					{field : "userName"},
					{fn : function(data){
						return data.preBalance.toFixed(2);
					}},
					{fn : function(data){
						if(data.amount > 0) {
							return '<span style="color:red;">+' + (data.amount.toFixed(2)) + '</span>';
						} else if(data.amount < 0) {
							return '<span style="color:green;">' + (data.amount.toFixed(2)) + '</span>';
						} else {
							return data.amount.toFixed(2);
						}
					}},
					{fn : function(data){
						return (data.preBalance + data.amount).toFixed(2);
					}},
					{field : "type"},
					{field : "description"},
					{field : "createTime"}
				]);
			} else {
				showMsg(data.msg);
			}
		},
		redirectUrl : "admin/login.jsp?msg=" + encodeURI("请先登录")
	});
};
</script>
</head>

<body>
<%@include file="/admin/header.jsp"%>
<div id="middle">
<jsp:include page="/admin/left.jsp">
	<jsp:param name="p" value="交易流水"/>
</jsp:include>
	<div class="right">
	<div class="right_cont">
	<div class="breadcrumb">当前位置：
		<a href="javascript:;">网站管理</a><span class="divider">/</span>
		<a href="javascript:;">交易流水</a>
	</div>
	<div class="title_right"><strong>交易流水</strong><span style="color:red;font-size:18px;padding-left:200px;" id="showMsg"></span></div>
	<table class="table table-bordered table-striped table-hover">
		<tr>
			<td colspan="99" style="padding:3px;line-height:30px;">
				用户ID：<input type="number" id="userId" value="${param.userId}" placeholder="用户id">
				&nbsp;&nbsp;类型：<%=com.yy.fast4j.Fast4jUtils.getSelectHtmlStr(com.yy.guess.po.enums.TradeType.class, "type", "width:60px;", null, new String[]{"全部"})%>
				&nbsp;&nbsp;<input type="text" id="startTime" placeholder="开始时间" class="laydate-icon" onclick="laydate({istime:true,format:'YYYY-MM-DD hh:mm:ss'});" style="width:140px;cursor:pointer;" readonly="readonly">
				-
				&nbsp;&nbsp;<input type="text" id="endTime" placeholder="结束时间" class="laydate-icon" onclick="laydate({istime:true,format:'YYYY-MM-DD hh:mm:ss'});" style="width:140px;cursor:pointer;" readonly="readonly">
				&nbsp;&nbsp;<input type="button" value="查询" onclick="query(20, 1)">
			</td>
		</tr>
		<tr align="center">
			<td><strong>ID</strong></td>
			<td><strong>用户ID</strong></td>
			<td><strong>用户名</strong></td>
			<td><strong>交易前余额</strong></td>
			<td><strong>交易金额</strong></td>
			<td><strong>交易后余额</strong></td>
			<td><strong>类型</strong></td>
			<td><strong>备注</strong></td>
			<td><strong>时间</strong></td>
		</tr>
	</table>
	<table class="margin-bottom-20 table no-border">
		<tr>
			<td class="text-center" id="pageTd"></td>
		</tr>
	</table>
	</div>     
	</div>
</div>
</body>
</html>