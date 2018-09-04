<%@ page language="java" pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%><!DOCTYPE html>
<html>
<head>
<base href="${basePath}">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>系统通知 - <%=com.yy.guess.util.Util.getConfigCom(application).getWebTitle()%></title>
<link rel="stylesheet" href="admin/css/bootstrap.css">
<link rel="stylesheet" href="admin/css/css.css">
<script src="js/jquery.js"></script>
<script src="laydate/laydate.js"></script>
<script src="admin/js/common.js"></script>
<script>
var del = function(systemNoticeId, e) {
	if(confirm("确定删除吗？")) {
		loadData({
			url : "administration/systemNoticeDelete",
			data : {"systemNoticeId" : systemNoticeId},
			success : function(data) {
				showMsg(data.msg);
				if(data.code == 100) {
					$(e).parent().parent().after().remove();
				}
			}
		});
	}
};
var setTop = function(systemNoticeId) {
	if(confirm("确定置顶吗？")) {
		loadData({
			url : "administration/systemNoticeTop",
			data : {"systemNoticeId" : systemNoticeId},
			success : function(data) {
				showMsg(data.msg);
				if(data.code == 100) {
					query(20, 1);
				}
			}
		});
	}
};
var query = function(pageSize, pageNo){
	loadData({
		url : "administration/systemNoticeList",
		data : {
			"pageSize" : pageSize,
			"pageNo" : pageNo
		},
		success : function(data){
			if(data.code == 100) {
				fillResult(data, [
					{field : "id"},
					{field : "content"},
					{field : "createTime"},
					{fn : function(obj){
						var str = '';
						str += '<a href="javascript:;" onclick="del(' + obj.id + ', this)">删除</a>';
						str += '&nbsp;<a href="javascript:;" onclick="setTop(' + obj.id + ')">置顶</a>';
						return str;
					}}
				]);
			}
		},
		redirectUrl : "admin/login.jsp?msg=" + encodeURI("请先登录")
	});
};
var add = function(){
	var content = $.trim($("#noticeContent").val());
	if(empty(content)) {
		showMsg("输入内容");
		return;
	}
	loadData({
		url : "administration/systemNoticeAdd",
		data : {"content" : content},
		success : function(data) {
			showMsg(data.msg);
			if(data.code == 100) {
				$("#noticeContent").val("");
				query(20, 1);
			}
		}
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
	<jsp:param name="p" value="系统通知"/>
</jsp:include>
	<div class="right">
	<div class="right_cont">
	<div class="breadcrumb">当前位置：
		<a href="javascript:;">网站管理</a><span class="divider">/</span>
		<a href="javascript:;">系统通知</a>
	</div>
	<div class="title_right"><strong>系统通知</strong><span style="color:red;font-size:18px;padding-left:200px;" id="showMsg"></span></div>
	<table class="table table-bordered table-striped table-hover">
		<tr>
			<td colspan="99" style="padding:3px;line-height:30px;">
				<input type="text" id="noticeContent" placeholder="通知内容" style="width:700px;">
				&nbsp;&nbsp;<input type="button" value="添加一条系统通知" onclick="add()">
			</td>
		</tr>
		<tr align="center">
			<td><strong>id</strong></td>
			<td><strong>内容</strong></td>
			<td><strong>时间</strong></td>
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