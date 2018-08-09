<%@ page language="java" pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%><!DOCTYPE html>
<html>
<head>
<base href="${basePath}">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>对阵列表 - <%=com.yy.fast4j.Fast4jUtils.getBean(com.yy.fast4j.Cache.class, application).getString(com.yy.guess.util.CachePre.GUESS_CONFIG, "webTitle")%></title>
<link rel="stylesheet" href="admin/css/bootstrap.css">
<link rel="stylesheet" href="admin/css/css.css">
<script src="js/jquery.js"></script>
<script src="laydate/laydate.js"></script>
<script src="admin/js/common.js"></script>
<script>
var paramMatchId = "${param.matchId}";
$(document).ready(function(){
	if(empty(paramMatchId)) {
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
	} else {
		loadData({
			url : "administration/getSportAndTeamsByMatchId",
			data : {
				"matchId" : paramMatchId
			},
			success : function(data) {
				if(data.code == 100) {
					var sport = data.result.sport;
					var match = data.result.match;
					$("#sportId").html('<option value="' + sport.id + '">' + sport.name + '</option>');
					$("#matchId").html('<option value="' + match.id + '">' + match.name + '</option>');
					query(20, 1);
				} else {
					showMsg(data.msg);
				}
			},
			redirectUrl : "admin/login.jsp?msg=" + encodeURI("请先登录")
		});
	}
});

var del = function(versusId, e) {
	if(confirm('确定删除？')) {
		loadData({
			url : "administration/matchVersusDelete",
			data : {
				"versusId" : versusId
			},
			success : function(data) {
				showMsg(data.msg);
				if(data.code == 100) {
					$(e).parent().parent().remove();
				}
			}
		});
	}
};

var query = function(pageSize, pageNo) {
	var matchId = $.trim($("#matchId").val());
	var status = $.trim($("#status").val());
	loadData({
		url : "administration/matchVersusList",
		data : {
			"matchId" : matchId,
			"status" : ("全部" == status ? null : status),
			"pageSize" : pageSize,
			"pageNo" : pageNo
		},
		success : function(data) {
			fillResult(data, [
				{field : "id"},
				{field : "matchName"},
				{field : "name"},
				{fn : function(obj){return obj.leftTeamName + '&nbsp;vs&nbsp;' + obj.rightTeamName;}},
				{field : "startTime"},
				{field : "status"},
				{field : "boCount"},
				{field : "realBoCount"},
				{field : "result"},
				{field : "createTime"},
				{fn : function(obj){
					var str = '';
					str += '<a href="javascript:;" onclick="del(' + obj.id + ', this)">删除</a>';
					return str;
				}}
			]);
		}
	});
};

var sportIdChange = function(){
	var sportId = $.trim($("#sportId").val());
	if(sportId != "0") {
		loadData({
			url : "administration/getAllMatchsBySportId",
			data : {
				"sportId" : sportId
			},
			success : function(data){
				var list = data.result;
				var str = '';
				if(list.length > 0) {
					for(var i=0; i<list.length; i++) {
						var obj = list[i];
						str += '<option value="' + obj.id + '">' + obj.name + '</option>';
					}
				} else {
					str += '<option value="-1">无</option>';
				}
				$("#matchId").html(str);
			}
		});
	} else {
		$("#matchId").html('<option value="0">全部</option>');
	}
};
</script>
</head>

<body>
<%@include file="/admin/header.jsp"%>
<div id="middle">
<jsp:include page="/admin/left.jsp">
	<jsp:param name="p" value="对阵列表"/>
</jsp:include>
	<div class="right">
	<div class="right_cont">
	<div class="breadcrumb">当前位置：
		<a href="javascript:;">网站管理</a><span class="divider">/</span>
		<a href="javascript:;">对阵列表</a>
	</div>
	<div class="title_right"><strong>对阵列表</strong><span style="color:red;font-size:18px;padding-left:200px;" id="showMsg"></span></div>
	<table class="table table-bordered table-striped table-hover">
		<tr>
			<td colspan="99" style="padding:3px;line-height:30px;">
				类型：<select id="sportId" style="width:100px;" onchange="sportIdChange()"></select>
				&nbsp;&nbsp;赛事：<select id="matchId"><option value="0">全部</option></select>
				&nbsp;&nbsp;状态：<%=com.yy.fast4j.Fast4jUtils.getSelectHtmlStr(com.yy.guess.po.enums.MatchStatus.class, "status", "width:100px;", new String[]{"全部"})%>
				&nbsp;&nbsp;<input type="button" value="查询" onclick="query(20, 1)">
				&nbsp;&nbsp;<a href="admin/guess/matchVersusAdd.jsp" target="_blank">添加对阵</a>
			</td>
		</tr>
		<tr align="center">
			<td><strong>id</strong></td>
			<td><strong>赛事</strong></td>
			<td><strong>名称</strong></td>
			<td><strong>对阵</strong></td>
			<td><strong>开始时间</strong></td>
			<td><strong>状态</strong></td>
			<td><strong>比赛局数</strong></td>
			<td><strong>实际比赛局数</strong></td>
			<td><strong>比赛结果</strong></td>
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