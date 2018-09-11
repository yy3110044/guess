<%@ page language="java" pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%><!DOCTYPE html>
<html>
<head>
<base href="${basePath}">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>下注列表 - <%=com.yy.guess.util.Util.getConfigCom(application).getWebTitle()%></title>
<link rel="stylesheet" href="admin/css/bootstrap.css">
<link rel="stylesheet" href="admin/css/css.css">
<script src="js/jquery.js"></script>
<script src="laydate/laydate.js"></script>
<script src="admin/js/common.js"></script>
<script>
$(document).ready(function(){
	query(20, 1);
});
var query = function(pageSize, pageNo){
	var userId = $.trim($("#userId").val());
	var status = $.trim($("#status").val());
	var startTime = $.trim($("#startTime").val());
	var endTime = $.trim($("#endTime").val());
	loadData({
		url : "administration/betList",
		data : {
			"userId" : userId,
			"status" : status == "全部" ? null : status,
			"startTime" : startTime,
			"endTime" : endTime,
			"pageSize" : pageSize,
			"pageNo" : pageNo
		},
		success : function(data) {
			if(data.code == 100) {
				fillResult(data, [
					{"field" : "id"},
					{"field" : "versusId"},
					{"field" : "bo"},
					{"field" : "playTypeId"},
					{"field" : "userId"},
					{"field" : "userName"},
					{"fn" : function(obj){
						if(obj.betDirection == "LEFT") {
							return '<span style="color:red;">' + obj.betDirection + '</span>';
						} else if(obj.betDirection == "RIGHT") {
							return '<span style="color:green;">' + obj.betDirection + '</span>';
						} else {
							return "";
						}
					}},
					{"fn" : function(obj){
						var str = '';
						str += '<span style="color:red;">' + obj.leftOdds.toFixed(2) + '</span>';
						str += '&nbsp;:&nbsp;';
						str += '<span style="color:blue;">' + obj.rightOdds.toFixed(2) + '</span>';
						return str;
					}},
					{"fn" : function(obj){
						return obj.betAmount.toFixed(2);
					}},
					{"fn" : function(obj){
						if(obj.status == "已下注") {
							return '<span style="color:black;">' + obj.status + '</span>';
						} else if(obj.status == "未猜中") {
							return '<span style="color:red;">' + obj.status + '</span>';
						} else if(obj.status == '已结算') {
							return '<span style="color:green;">' + obj.status + '</span>';
						} else if(obj.status == '已退回') {
							return '<span style="color:blue;">' + obj.status + '</span>';
						} else {
							return "";
						}
					}},
					{"fn" : function(obj){
						if(obj.status == "已结算") {
							return obj.realPayBonus.toFixed(2);
						} else {
							return "";
						}
					}},
					{"field" : "createTime"}
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
	<jsp:param name="p" value="下注列表"/>
</jsp:include>
	<div class="right">
	<div class="right_cont">
	<div class="breadcrumb">当前位置：
		<a href="javascript:;">网站管理</a><span class="divider">/</span>
		<a href="javascript:;">下注列表</a>
	</div>
	<div class="title_right"><strong>下注列表</strong><span style="color:red;font-size:18px;padding-left:200px;" id="showMsg"></span></div>
	<table class="table table-bordered table-striped table-hover">
		<tr>
			<td colspan="99" style="padding:3px;line-height:30px;">
				用户ID：<input type="text" id="userId" value="${param.userId}" placeholder="输入用户ID">
				&nbsp;&nbsp;状态：<%=com.yy.fast4j.Fast4jUtils.getSelectHtmlStr(com.yy.guess.po.enums.BetStatus.class, "status", "width:75px;", "全部", new String[]{"全部"})%>
				&nbsp;&nbsp;开始时间：<input type="text" id="startTime" placeholder="开始时间" class="laydate-icon" onclick="laydate({istime:true,format:'YYYY-MM-DD hh:mm:ss'});" style="width:140px;cursor:pointer;" readonly="readonly">
				-
				结束时间：<input type="text" id="endTime" placeholder="结束时间" class="laydate-icon" onclick="laydate({istime:true,format:'YYYY-MM-DD hh:mm:ss'});" style="width:140px;cursor:pointer;" readonly="readonly">
				&nbsp;&nbsp;<input type="button" value="查询" onclick="query(20, 1)">
			</td>
		</tr>
		<tr align="center">
			<td><strong>ID</strong></td>
			<td><strong>对阵ID</strong></td>
			<td><strong>对局</strong></td>
			<td><strong>玩法ID</strong></td>
			<td><strong>用户Id</strong></td>
			<td><strong>用户名</strong></td>
			<td><strong>下注方</strong></td>
			<td><strong>下注赔率</strong></td>
			<td><strong>下注金额</strong></td>
			<td><strong>状态</strong></td>
			<td><strong>实际发放金额</strong></td>
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