<%@ page language="java" pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%><!DOCTYPE html>
<html>
<head>
<base href="${basePath}">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>赛事列表 - <%=com.yy.fast4j.Fast4jUtils.getBean(com.yy.fast4j.Cache.class, application).getString(com.yy.guess.util.CachePre.GUESS_CONFIG, "webTitle")%></title>
<link rel="stylesheet" href="admin/css/bootstrap.css">
<link rel="stylesheet" href="admin/css/css.css">
<script src="js/jquery.js"></script>
<script src="laydate/laydate.js"></script>
<script src="admin/js/common.js"></script>
<script>
var getTeamSelect = function(teamList, selectId) {
	var str = '<select id="' + selectId + '">';
	for(var i=0; i<teamList.length; i++) {
		var obj = teamList[i];
		str += '<option value="' + obj.id + '">' + obj.name + '</option>';
	}
	str += '</select>';
	return str;
};

var addVersus = function(matchId, sportId, e){
	loadData({
		url : "administration/getAllTeamsBySportId",
		data : {
			"sportId" : sportId
		},
		success : function(data) {
			if(data.code == 100) {
				$("tr.modifyTr").remove();

				var str = '<tr class="modifyTr"><td colspan="99" style="padding:8px;">';
				str += '<div>比赛队伍：' + getTeamSelect(data.result, "versus_leftTeamId") + '&nbsp;对阵&nbsp;' + getTeamSelect(data.result, "versus_rightTeamId") + '</div>';
				str += '<div style="margin-top:4px;">开始时间：<input type="text" id="versus_startTime" placeholder="比赛开始时间" class="laydate-icon" onclick="laydate({istime:true,format:\'YYYY-MM-DD hh:mm:ss\'});" style="width:140px;cursor:pointer;" readonly="readonly"></div>';
				str += '<div style="margin-top:4px;">比赛状态：<%=com.yy.fast4j.Fast4jUtils.getSelectHtmlStr(com.yy.guess.po.enums.MatchStatus.class, "versus_status", null, null)%></div>';
				str += '</td></tr>';
				$(e).parent().parent().after(str);
			} else {
				showMsg(data.msg);
			}
		}
	});
};

var query = function(pageSize, pageNo){
	var sportId = $.trim($("#sportId").val());
	var status = $.trim($("#status").val());
	loadData({
		url : "administration/matchList",
		data : {
			"sportId" : sportId,
			"status" : ("全部" == status ? null : status),
			"pageSize" : pageSize,
			"pageNo" : pageNo
		},
		success : function(data) {
			if(data.code == 100) {
				fillResult(data, [
					{field : "id"},
					{field : "sportName"},
					{field : "name"},
					{fn : function(obj){return '<a href="' + obj.logoUrl + '" target="_blank"><img src="' + obj.logoUrl + '" style="width:60px;height:60px;"></a>';}},
					{field : "description"},
					{field : "startTime"},
					{field : "endTime"},
					{field : "status"},
					{field : "createTime"},
					{fn : function(obj){
						var str = '<a href="javascript:;">删除</a>';
						str += '&nbsp;<a href="javascript:;" onclick="addVersus(' + obj.id + ', ' + obj.sportId + ', this)">添加对阵</a>';
						return str;
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
			if(data.code == 100) {
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
			} else {
				showMsg(data.msg);
			}
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
	<jsp:param name="p" value="赛事列表"/>
</jsp:include>
	<div class="right">
	<div class="right_cont">
	<div class="breadcrumb">当前位置：
		<a href="javascript:;">网站管理</a><span class="divider">/</span>
		<a href="javascript:;">赛事列表</a>
	</div>
	<div class="title_right"><strong>赛事列表</strong><span style="color:red;font-size:18px;padding-left:200px;" id="showMsg"></span></div>
	<table class="table table-bordered table-striped table-hover">
		<tr>
			<td colspan="99" style="padding:3px;line-height:30px;">
				类型：<select id="sportId" style="width:100px;"></select>
				&nbsp;&nbsp;状态：<%=com.yy.fast4j.Fast4jUtils.getSelectHtmlStr(com.yy.guess.po.enums.MatchStatus.class, "status", "width:100px;", new String[]{"全部"})%>
				&nbsp;&nbsp;<input type="button" value="查询" onclick="query(20, 1)">
			</td>
		</tr>
		<tr align="center">
			<td><strong>id</strong></td>
			<td><strong>项目类型</strong></td>
			<td><strong>名称</strong></td>
			<td><strong>logo图</strong></td>
			<td><strong>简介</strong></td>
			<td><strong>开始时间</strong></td>
			<td><strong>结束时间</strong></td>
			<td><strong>状态</strong></td>
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