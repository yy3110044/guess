<%@ page language="java" pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%><!DOCTYPE html>
<html>
<head>
<base href="${basePath}">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>添加对阵 - <%=com.yy.fast4j.Fast4jUtils.getBean(com.yy.fast4j.Cache.class, application).getString(com.yy.guess.util.CachePre.GUESS_CONFIG, "webTitle")%></title>
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
				if(data.code == 100) {
					var list = data.result;
					var str = '<option value="0">选择项目类型</option>';
					for(var i=0; i<list.length; i++) {
						var obj = list[i];
						str += '<option value="' + obj.id + '">';
						str += obj.name
						str += '</option>';
					}
					$("#sportId").html(str);
				} else {
					showMsg(data.msg);
				}
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
					var teamList = data.result.teamList;
					var match = data.result.match;
					$("#sportId").html('<option value="' + sport.id + '">' + sport.name + '</option>');
					$("#matchId").html('<option value="' + match.id + '">' + match.name + '</option>');
					var str = '';
					for(var i=0; i<teamList.length; i++) {
						var obj = teamList[i];
						str += '<option value="' + obj.id + '">' + obj.name + '</option>';
					}
					$("#leftTeamId,#rightTeamId").html(str);
				} else {
					showMsg(data.msg);
				}
			},
			redirectUrl : "admin/login.jsp?msg=" + encodeURI("请先登录")
		});
		loadData({
			url : "administration/getDistinctMatchVersusName",
			data : {
				"matchId" : paramMatchId
			},
			success : function(data) {
				var list = data.result;
				if(list.length > 0) {
					var str = '<option>选择名称</option>';
					for(var i=0; i<list.length; i++) {
						str += '<option>' + list[i] + '</option>';
					}
					$("#nameSelect").html(str);
				}
			}
		});
	}
});

var add = function() {
	var matchId = $.trim($("#matchId").val());
	var name = $.trim($("#name").val());
	var leftTeamId = $.trim($("#leftTeamId").val());
	var rightTeamId = $.trim($("#rightTeamId").val());
	var startTime = $.trim($("#startTime").val());
	var status = $.trim($("#status").val());
	var boCount = $.trim($("#boCount").val());
	if(empty(matchId)) {
		showMsg("请选择项目类型和赛事，没有则先添加");
		return;
	}
	if(empty(leftTeamId) || empty(rightTeamId)) {
		showMsg("请选择对阵队伍，没有则先添加");
		return;
	}
	if(leftTeamId == rightTeamId) {
		showMsg("两边队伍不能一样");
		return;
	}
	if(empty(startTime)) {
		showMsg("请设置比赛开始时间");
		return;
	}
	if(empty(boCount)) {
		showMsg("请设置比赛局数");
		return;
	}
	if(isNaN(boCount)) {
		showMsg("比赛局数必须是一个数字");
		return;
	}
	loadData({
		url : "administration/matchVersusAdd",
		data : {
			"matchId" : matchId,
			"name" : name,
			"leftTeamId" : leftTeamId,
			"rightTeamId" : rightTeamId,
			"startTime" : startTime,
			"status" : status,
			"boCount" : boCount
		},
		success : function(data) {
			showMsg(data.msg);
			if(data.code == 100) {
				$("#name").val("");
				$("#startTime").val("");
				$("#boCount").val("");
			}
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
			success : function(data) {
				var list = data.result;
				if(list.length > 0) {
					var str = '';
					for(var i=0; i<list.length; i++) {
						var obj = list[i];
						str += '<option value="' + obj.id + '">' + obj.name + '</option>';
					}
					$("#matchId").html(str);
					var matchId = $.trim($("#matchId").val());
					loadData({
						url : "administration/getDistinctMatchVersusName",
						data : {
							"matchId" : matchId
						},
						success : function(data) {
							var list = data.result;
							if(list.length > 0) {
								var str = '<option>选择名称</option>';
								for(var i=0; i<list.length; i++) {
									str += '<option>' + list[i] + '</option>';
								}
								$("#nameSelect").html(str);
							}
						}
					});
				} else {
					$("#matchId").empty();
					$("#nameSelect").empty();
				}
			}
		});
		
		loadData({
			url : "administration/getAllTeamsBySportId",
			data : {
				"sportId" : sportId
			},
			success : function(data){
				var list = data.result;
				var str = '';
				for(var i=0; i<list.length; i++) {
					var obj = list[i];
					str += '<option value="' + obj.id + '">' + obj.name + '</option>';
				}
				$("#leftTeamId,#rightTeamId").html(str);
			}
		});
	} else {
		$("#matchId").empty();
		$("#leftTeamId,#rightTeamId").empty();
		$("#nameSelect").empty();
	}
};

var nameSelectChange = function(){
	var name = $.trim($("#nameSelect").val());
	if(name != '选择名称') {
		$("#name").val(name);
	}
};
</script>
</head>
<body>
<%@include file="/admin/header.jsp"%>
<div id="middle">
<jsp:include page="/admin/left.jsp">
	<jsp:param name="p" value="添加对阵"/>
</jsp:include>
	<div class="right">
	<div class="right_cont">
	<div class="breadcrumb">当前位置：
		<a href="javascript:;">网站管理</a><span class="divider">/</span>
		<a href="javascript:;">添加对阵</a>
	</div>
	<div class="title_right"><strong>添加对阵</strong><span style="color:red;font-size:18px;padding-left:200px;" id="showMsg"></span></div>
	<div style="width:900px; margin:auto">
	<table class="table table-bordered">
		<tr>
			<td width="12%" align="right" nowrap="nowrap" bgcolor="#f1f1f1">项目类型：</td>
			<td><select id="sportId" onchange="sportIdChange()"></select></td>
		</tr>
		<tr>
			<td align="right" nowrap="nowrap" bgcolor="#f1f1f1">赛事：</td>
			<td><select id="matchId"></select></td>
		</tr>
		<tr>
			<td align="right" nowrap="nowrap" bgcolor="#f1f1f1">比赛名称：</td>
			<td>
				<input type="text" id="name" placeholder="如：小组赛、半绝赛，没有则不填" style="width:200px;">
				<select id="nameSelect" onclick="nameSelectChange()"></select>
			</td>
		</tr>
		<tr>
			<td align="right" nowrap="nowrap" bgcolor="#f1f1f1">比赛队伍：</td>
			<td><select id="leftTeamId"></select>&nbsp;&nbsp;VS&nbsp;&nbsp;<select id="rightTeamId"></select></td>
		</tr>
		<tr>
			<td align="right" nowrap="nowrap" bgcolor="#f1f1f1">开始时间：</td>
			<td><input type="text" id="startTime" placeholder="比赛开始时间" class="laydate-icon" onclick="laydate({istime:true,format:'YYYY-MM-DD hh:mm:ss'});" style="width:140px;cursor:pointer;" readonly="readonly"></td>
		</tr>
		<tr>
			<td align="right" nowrap="nowrap" bgcolor="#f1f1f1">比赛状态：</td>
			<td><%=com.yy.fast4j.Fast4jUtils.getSelectHtmlStr(com.yy.guess.po.enums.MatchStatus.class, "status")%></td>
		</tr>
		<tr>
			<td align="right" nowrap="nowrap" bgcolor="#f1f1f1">比赛局数：</td>
			<td><input type="number" id="boCount" min="1"></td>
		</tr>
		<tr>
			<td align="right" nowrap="nowrap" bgcolor="#f1f1f1"></td>
			<td colspan="3"><input type="button" value="添加" onclick="add()" class="btn btn-info" style="width:80px;"></td>
		</tr>
	</table>
	</div> 
	</div>     
	</div>
</div>
</body>
</html>