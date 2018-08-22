<%@ page language="java" pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%><!DOCTYPE html>
<html>
<head>
<base href="${basePath}">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>用户列表 - <%=com.yy.fast4j.RedisUtil.getObject(application, com.yy.guess.util.CachePre.GUESS_CONFIG, "webTitle")%></title>
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
	var userName = $.trim($("#userName").val());
	var sortField = $.trim($("#sortField").val());
	var sortType = $.trim($("#sortType").val());
	
	loadData({
		url : "administration/userList",
		data : {
			"userId" : userId,
			"userName" : userName,
			"sortField" : sortField,
			"sortType" : sortType,
			"pageSize" : pageSize,
			"pageNo" : pageNo
		},
		success : function(data){
			if(data.code == 100) {
				fillResult(data, [
					{field : "id"},
					{field : "userName"},
					{fn : function(obj){return '<span style="font-weight:bold;">¥</span>' + obj.balance.toFixed(2);}},
					{field : "nickName"},
					{field : "qq"},
					{field : "phone"},
					{field : "email"},
					{field : "registTime"},
					{field : "lastLoginIp"},
					{field : "lastLoginTime"},
					{field : "lastLoginType"},
					{fn : function(obj){
						return (obj.rebateRate * 100).toFixed(2) + "%";
					}},
					{fn : function(obj){
						var str = '';
						str += '<a href="javascript:;" onclick="updateBalance(' + obj.id + ', this)">修改余额</a>';
						str += '&nbsp;<a>删除</a>';
						return str;
					}}
				]);
			} else {
				showMsg(data.msg);
			}
		},
		redirectUrl : "admin/login.jsp?msg=" + encodeURI("请先登录")
	});
};

//修改余额
var updateBalance = function(userId, e){
	var str = '';
	str += '<tr class="contentTr detailTr"><td colspan="99">';
	str += '';
	str += '</td></tr>';
};
</script>
</head>

<body>
<%@include file="/admin/header.jsp"%>
<div id="middle">
<jsp:include page="/admin/left.jsp">
	<jsp:param name="p" value="用户列表"/>
</jsp:include>
	<div class="right">
	<div class="right_cont">
	<div class="breadcrumb">当前位置：
		<a href="javascript:;">网站管理</a><span class="divider">/</span>
		<a href="javascript:;">用户列表</a>
	</div>
	<div class="title_right"><strong>用户列表</strong><span style="color:red;font-size:18px;padding-left:200px;" id="showMsg"></span></div>
	<table class="table table-bordered table-striped table-hover">
		<tr>
			<td colspan="99" style="padding:3px;line-height:30px;">
				ID：<input type="number" id="userId" placeholder="用户id">
				&nbsp;&nbsp;用户名：<input type="text" id="userName" placeholder="用户名">
				&nbsp;&nbsp;排序：<select id="sortField" style="width:80px;"><option value="id">ID</option><option value="userName">用户名</option><option value="balance">余额</option><option value="registTime">注册时间</option><option value="lastLoginTime">登陆时间</option><option value="rebateRate">返点率</option></select>
				&nbsp;&nbsp;<select id="sortType" style="width:80px;"><option value="DESC">从大到小</option><option value="ASC">从小到大</option></select>
				&nbsp;&nbsp;<input type="button" value="查询" onclick="query(20, 1)">
			</td>
		</tr>
		<tr align="center">
			<td><strong>id</strong></td>
			<td><strong>用户名</strong></td>
			<td><strong>余额</strong></td>
			<td><strong>昵称 </strong></td>
			<td><strong>qq</strong></td>
			<td><strong>手机</strong></td>
			<td><strong>邮箱</strong></td>
			<td><strong>注册时间</strong></td>
			<td><strong>登陆IP</strong></td>
			<td><strong>登陆时间</strong></td>
			<td><strong>登陆类型</strong></td>
			<td><strong>返点</strong></td>
			<td><strong>操作</strong></td>
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