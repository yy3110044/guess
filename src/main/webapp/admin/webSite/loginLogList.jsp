<%@ page language="java" pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%><!DOCTYPE html>
<html>
<head>
<base href="${basePath}">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>登陆日志 - <%=com.yy.guess.util.Util.getConfigCom(application).getWebTitle()%></title>
<link rel="stylesheet" href="admin/css/bootstrap.css">
<link rel="stylesheet" href="admin/css/css.css">
<script src="js/jquery.js"></script>
<script src="laydate/laydate.js"></script>
<script src="admin/js/common.js"></script>
<script>
var typeChange = function(){
	var type = $.trim($("#type").val());
	var str = '';
	if("user" == type) {
		str += '<tr align="center" class="titleTr">';
		str += '<td><strong>ID</strong></td>';
		str += '<td><strong>用户ID</strong></td>';
		str += '<td><strong>用户名</strong></td>';
		str += '<td><strong>登陆IP</strong></td>';
		str += '<td><strong>登陆时间</strong></td>';
		str += '<td><strong>登陆类型</strong></td>';
		str += '<td><strong>userAgent</strong></td>';
		str += '<td><strong>创建时间</strong></td>';
		str += '</tr>';
	} else if("adminUser" == type) {
		str += '<tr align="center" class="titleTr">';
		str += '<td><strong>ID</strong></td>';
		str += '<td><strong>用户ID</strong></td>';
		str += '<td><strong>用户名</strong></td>';
		str += '<td><strong>登陆IP</strong></td>';
		str += '<td><strong>登陆时间</strong></td>';
		str += '<td><strong>userAgent</strong></td>';
		str += '<td><strong>创建时间</strong></td>';
		str += '</tr>';
	}
	$("tr.titleTr").remove();
	$("tr.queryTr").after(str);
};
$(document).ready(function(){
	query(20, 1);
});
var query = function(pageSize, pageNo){
	var type = $.trim($("#type").val());
	var userName = $.trim($("#userName").val());
	loadData({
		url : "administration/loginLogList",
		data : {
			"type" : type,
			"userName" : userName
		},
		success : function(data) {
			if(data.code == 100) {
				if("user" == type) {
					fillResult(data, [
						{field : "id"},
						{field : "userId"},
						{field : "userName"},
						{field : "loginIp"},
						{field : "loginTime"},
						{field : "loginType"},
						{field : "userAgent"},
						{field : "createTime"}
					]);
				} else if("adminUser" == type) {
					fillResult(data, [
						{field : "id"},
						{field : "adminUserId"},
						{field : "adminUserName"},
						{field : "loginIp"},
						{field : "loginTime"},
						{field : "userAgent"},
						{field : "createTime"}
					]);
				}
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
	<jsp:param name="p" value="登陆日志"/>
</jsp:include>
	<div class="right">
	<div class="right_cont">
	<div class="breadcrumb">当前位置：
		<a href="javascript:;">网站管理</a><span class="divider">/</span>
		<a href="javascript:;">登陆日志</a>
	</div>
	<div class="title_right"><strong>登陆日志</strong><span style="color:red;font-size:18px;padding-left:200px;" id="showMsg"></span></div>
	<table class="table table-bordered table-striped table-hover">
		<tr class="queryTr">
			<td colspan="99" style="padding:3px;line-height:30px;">
				类型：<select id="type" onchange="typeChange()" style="width:80px;"><option value="user" selected="selected">用户</option><option value="adminUser">管理员</option></select>
				&nbsp;&nbsp;用户名：<input type="text" id="userName" placeholder="输入用户名查询">
				&nbsp;&nbsp;<input type="button" value="查询" onclick="query(20, 1)">
			</td>
		</tr>
		<tr align="center" class="titleTr">
			<td><strong>ID</strong></td>
			<td><strong>用户ID</strong></td>
			<td><strong>用户名</strong></td>
			<td><strong>登陆IP</strong></td>
			<td><strong>登陆时间</strong></td>
			<td><strong>登陆类型</strong></td>
			<td><strong>userAgent</strong></td>
			<td><strong>创建时间</strong></td>
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