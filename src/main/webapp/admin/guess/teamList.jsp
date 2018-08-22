<%@ page language="java" pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%><!DOCTYPE html>
<html>
<head>
<base href="${basePath}"/>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>战队列表 - <%=com.yy.fast4j.RedisUtil.getObject(application, com.yy.guess.util.CachePre.GUESS_CONFIG, "webTitle")%></title>
<link rel="stylesheet" href="admin/css/bootstrap.css">
<link rel="stylesheet" href="admin/css/css.css">
<script src="js/jquery.js"></script>
<script src="laydate/laydate.js"></script>
<script src="admin/js/common.js"></script>
<script>
var del = function(teamId, e) {
	if(!confirm('确定删除？')) {
		return;
	}
	loadData({
		url : "administration/teamDelete",
		data : {
			"teamId" : teamId
		},
		success : function(data) {
			showMsg(data.msg);
			if(data.code == 100) {
				$(e).parent().parent().remove();
			}
		}
	});
};
var query = function(pageSize, pageNo) {
	loadData({
		url : "administration/teamList",
		data : {
			"sportId" : $.trim($("#sportId").val()),
			"pageSize" : pageSize,
			"pageNo" : pageNo
		},
		success : function(data) {
			if(data.code == 100) {
				fillResult(data, [
					{field : "id"},
					{field : "sportName"},
					{field : "name"},
					{fn : function(obj){
						return '<a href="' + obj.logoUrl + '" target="_blank"><img src="' + obj.logoUrl + '" style="width:60px;height:60px;"></a>';
					}},
					{field : "description"},
					{field : "createTime"},
					{fn : function(obj){
						return '<a href="javascript:;" onclick="del(' + obj.id + ', this)">删除</a>';
					}}
				]);
			} else {
				showMsg(data.msg);
			}
		}
	});
};
$(document).ready(function(){
	loadData({
		url : "administration/getAllSports",
		success : function(data) {
			var list = data.result;
			var str = '<option value="0">全部</option>';
			for(var i=0; i<list.length; i++) {
				var obj = list[i];
				str += '<option value="' + obj.id + '">';
				str += obj.name
				str += '</option>';
			}
			$("#sportId").html(str);
			query(20, 1);
		},
		redirectUrl : "admin/login.jsp?msg=" + encodeURI("请先登录")
	});
});
</script>
</head>

<body>
<%@include file="/admin/header.jsp"%>
<div id="middle">
<jsp:include page="/admin/left.jsp">
	<jsp:param name="p" value="战队列表"/>
</jsp:include>
	<div class="right">
	<div class="right_cont">
	<div class="breadcrumb">当前位置：
		<a href="javascript:;">网站管理</a><span class="divider">/</span>
		<a href="javascript:;">战队列表</a>
	</div>
	<div class="title_right"><strong>战队列表</strong><span style="color:red;font-size:18px;padding-left:200px;" id="showMsg"></span></div>
	<table class="table table-bordered table-striped table-hover">
		<tr>
			<td colspan="99" style="padding:3px;line-height:30px;">
				项目类型：<select id="sportId" style="width:100px;"></select>
				&nbsp;&nbsp;<input type="button" value="查询" onclick="query(20, 1)">
				&nbsp;&nbsp;<a href="admin/guess/teamAdd.jsp" target="_blank">添加战队</a>
			</td>
		</tr>
		<tr align="center">
			<td><strong>id</strong></td>
			<td><strong>项目类型</strong></td>
			<td><strong>战队名</strong></td>
			<td><strong>logo图</strong></td>
			<td><strong>简介</strong></td>
			<td><strong>添加时间</strong></td>
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