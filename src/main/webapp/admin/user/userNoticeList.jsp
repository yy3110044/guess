<%@ page language="java" pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%><!DOCTYPE html>
<html>
<head>
<base href="${basePath}">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>用户通知 - <%=com.yy.guess.util.Util.getConfigCom(application).getWebTitle()%></title>
<link rel="stylesheet" href="admin/css/bootstrap.css">
<link rel="stylesheet" href="admin/css/css.css">
<script src="js/jquery.js"></script>
<script src="laydate/laydate.js"></script>
<script src="admin/js/common.js"></script>
<script>
var del = function(id, e) {
	if(confirm("确定删除吗？")) {
		loadData({
			url : "administration/userNoticeDelete",
			data : {"userNoticeId" : id},
			success : function(data) {
				showMsg(data.msg);
				if(data.code == 100) {
					$(e).parent().parent().remove();
				}
			}
		});
	}
}
var query = function(pageSize, pageNo){
	var userName = $.trim($("#userName").val());
	loadData({
		url : "administration/userNoticeList",
		data : {
			"userName" : userName,
			"pageSize" : pageSize,
			"pageNo" : pageNo
		},
		success : function(data){
			if(data.code == 100) {
				fillResult(data, [
					{field : "id"},
					{field : "userId"},
					{field : "userName"},
					{field : "content"},
					{fn : function(obj){
						return obj.hadRead ? '<span style="color:red;">已读</span>' : '<span style="color:green;">未读</span>';
					}},
					{field : "readTime"},
					{field : "createTime"},
					{fn : function(obj){
						var str = '';
						str += '<a href="javascript:;" onclick="del(' + obj.id + ', this)">删除</a>';
						return str;
					}}
				]);
			}
		},
		redirectUrl : "admin/login.jsp?msg=" + encodeURI("请先登录")
	});
};
$(document).ready(function(){
	query(20, 1);
});
</script>
</head>

<body>
<%@include file="/admin/header.jsp"%>
<div id="middle">
<jsp:include page="/admin/left.jsp">
	<jsp:param name="p" value="用户通知"/>
</jsp:include>
	<div class="right">
	<div class="right_cont">
	<div class="breadcrumb">当前位置：
		<a href="javascript:;">网站管理</a><span class="divider">/</span>
		<a href="javascript:;">用户通知</a>
	</div>
	<div class="title_right"><strong>用户通知</strong><span style="color:red;font-size:18px;padding-left:200px;" id="showMsg"></span></div>
	<table class="table table-bordered table-striped table-hover">
		<tr>
			<td colspan="99" style="padding:3px;line-height:30px;">
				<input type="text" id="userName" placeholder="用户名">
				&nbsp;&nbsp;<input type="button" value="查询" onclick="query(20, 1)">
			</td>
		</tr>
		<tr align="center">
			<td><strong>id</strong></td>
			<td><strong>用户id</strong></td>
			<td><strong>用户名</strong></td>
			<td><strong>内容</strong></td>
			<td><strong>已读</strong></td>
			<td><strong>读取时间</strong></td>
			<td><strong>创建时间</strong></td>
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