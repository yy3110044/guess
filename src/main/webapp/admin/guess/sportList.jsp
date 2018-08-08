<%@ page language="java" pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%><!DOCTYPE html>
<html>
<head>
<base href="${basePath}"/>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>项目列表 - <%=com.yy.fast4j.Fast4jUtils.getBean(com.yy.fast4j.Cache.class, application).getString(com.yy.guess.util.CachePre.GUESS_CONFIG, "webTitle")%></title>
<link rel="stylesheet" href="admin/css/bootstrap.css">
<link rel="stylesheet" href="admin/css/css.css">
<script type="text/javascript" src="js/jquery.js"></script>
<script type="text/javascript" src="laydate/laydate.js"></script>
<script type="text/javascript" src="admin/js/common.js"></script>
<script>
var del = function(sportId, e) {
	if(!confirm('确定删除？')) {
		return;
	}
	loadData({
		url : "administration/sportDelete",
		data : {
			"sportId" : sportId
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
		url : "administration/sportList",
		data : {
			"pageSize" : pageSize,
			"pageNo" : pageNo
		},
		success : function(data) {
			if(data.code == 100) {
				fillResult(data, [
					{field : "id"},
					{field : "name"},
					{fn : function(obj){
						return '<a href="' + obj.logoUrl + '" target="_blank"><img src="' + obj.logoUrl + '" style="width:60px;height:60px;"></a>';
					}},
					{field : "description"},
					{field : "createTime"},
					{fn : function(obj){
						var str = '<a href="javascript:;" onclick="del(' + obj.id + ', this)">删除</a>';
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
$(document).ready(function(){
	query(20, 1);
});
</script>
</head>

<body>
<%@include file="/admin/header.jsp"%>
<div id="middle">
<jsp:include page="/admin/left.jsp">
	<jsp:param name="p" value="项目列表"/>
</jsp:include>
	<div class="right">
	<div class="right_cont">
	<div class="breadcrumb">当前位置：
		<a href="javascript:;">网站管理</a><span class="divider">/</span>
		<a href="javascript:;">项目列表</a>
	</div>
	<div class="title_right"><strong>项目列表</strong><span style="color:red;font-size:18px;padding-left:200px;" id="showMsg"></span></div>
	<table class="table table-bordered table-striped table-hover">
		<tr align="center">
			<td><strong>id</strong></td>
			<td><strong>名称</strong></td>
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