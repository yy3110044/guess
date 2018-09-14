<%@ page language="java" pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%><!DOCTYPE html>
<html>
<head>
<base href="${basePath}">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>玩法列表 - <%=com.yy.guess.util.Util.getConfigCom(application).getWebTitle()%></title>
<link rel="stylesheet" href="admin/css/bootstrap.css">
<link rel="stylesheet" href="admin/css/css.css">
<script src="js/jquery.js"></script>
<script src="laydate/laydate.js"></script>
<script src="admin/js/common.js"></script>
<script>
var versusId = "${param.versusId}";
var bo = "${param.bo}";
var query = function(){
	loadData({
		url : "administration/getMatchVersus",
		data : {"versusId" : versusId},
		success : function(data){
			if(data.code == 100) {
				var versus = data.result.versus;
				$("#versusTitle").html(versus.sportName + "&nbsp;" + versus.matchName + "&nbsp;" + versus.name + "</span>&nbsp;<span style='color:red;'>" + versus.leftTeamName + "</span>&nbsp;VS&nbsp;<span style='color:blue;'>" + versus.rightTeamName + "</span>");
				
				var versusBoOption = '';
				versusBoOption += '<option value=""' + (empty(bo) ? ' selected="selected"' : '') + '>全部</option>';
				versusBoOption += '<option value="0"' + (bo == "0" ? ' selected="selected"' : '') + '>总盘口</option>';
				for(var i=1; i<=versus.boCount; i++) {
					versusBoOption += '<option value="' + i + '"' + (bo == i ? ' selected="selected"' : '') + '>第' + i + '局</option>';
				}
				$("#versusBo").html(versusBoOption);
			} else {
				showMsg(data.msg);
			}
		}
	});
	loadData({
		url : "administration/getPlayType",
		data : {"versusId" : versusId, "bo" : bo},
		success : function(data){
			if(data.code == 100) {
				var length = data.result.length;
				$("tr.contentTr").remove();
				var str = getContentStr({
					"list" : data.result,
					"fields" : [
						{fn : function(obj, tdId, index){
							if(length == (index + 1)) {
								var str = '<span>' + obj.id + '</span>';
								str += '<script>';
								str += '$(document).ready(function(){loadOddsAndBonusPool();})';
								str += '</scr' + 'ipt>';
								return str;
							} else {
								return obj.id;
							}
						}},
						{field : "versusId"},
						{fn : function(obj){
							var str = '';
							str += obj.name;
							str += '&nbsp;<a href="javascript:;" onclick="modifyName(' + obj.id + ', \'' + obj.name + '\', this)">修改</a>';
							return str;
						}},
						{fn : function(obj){
							var str = '';
							str += '<span style="color:red;">' + obj.leftGuessName + '</span>';
							str += '&nbsp;<span style="font-weight:bold;font-size:18px;color:red;">:</span>&nbsp;';
							str += '<span style="color:blue;">' + obj.rightGuessName + '</span>';
							str += '&nbsp;<a href="javascript:;" onclick="modifyGuessName(' + obj.id + ', \'' + obj.leftGuessName + '\', \'' + obj.rightGuessName + '\', this)">修改</a>';
							return str;
						}},
						{fn : function(obj){
							if(obj.bo == 0) {
								return '总盘口';
							} else {
								return '第' + obj.bo + '局';
							}
						}},
						{field : "paramStr"},
						{fn : function(obj){
							var str = '';
							str += '<select onchange="pauseChange(' + obj.id + ', this)" style="width:50px;">';
							str += '<option value="true"' + (obj.pause ? ' selected="selected"' : '') + '>是</option>';
							str += '<option value="false"' + (obj.pause ? '' : ' selected="selected"') + '>否</option>';
							str += '</select>';
							return str;
						}},
						{fn : function(obj){
							var str = '';
							str += (obj.leftWinRate * 100).toFixed(0) + '%&nbsp;<span style="font-weight:bold;font-size:18px;color:red;">:</span>&nbsp;' + (obj.rightWinRate * 100).toFixed(0) + '%';
							str += '&nbsp;&nbsp;<a href="javascript:;" onclick="updateWinRate(' + obj.leftWinRate + ', ' + obj.rightWinRate + ', ' + obj.id + ', this)">更改</a>';
							return str;
						}},
						{fn : function(obj){
							if(obj.guessStart) {
								var str = '';
								str += '<span data-playTypeId="' + obj.id + '" class="odds"></span>';
								str += '&nbsp;<select onchange="fixedOddsChange(' + obj.id + ', this)" style="width:60px;">';
								str += '<option value="true"' + (obj.fixedOdds ? ' selected="selected"' : '') + '>固定</option>';
								str += '<option value="false"' + (obj.fixedOdds ? '' : ' selected="selected"') + '>变动</option>';
								str += '</select>';
								return str;
							} else {
								return '<span>竞猜已结束</span>';
							}
						}},
						{fn : function(obj){
							if(obj.guessStart) {
								return '<span data-playTypeId="' + obj.id + '" class="bonusPool"></span>';
							} else {
								return '<span style="color:red;">' + obj.leftBonusPool.toFixed(2) + '</span>&nbsp;<span style="font-weight:bold;font-size:18px;color:red;">:</span>&nbsp;<span style="color:blue;">' + obj.rightBonusPool.toFixed(2) + '</span>';
							}
						}},
						{fn : function(obj){
							var str = '';
							str += '<a href="javascript:;" onclick="del(' + obj.id + ')">删除</a>';
							return str;
						}}
					]
				});
				$("table.table-bordered").append(str);
			} else {
				showMsg(data.msg);
			}
		},
		redirectUrl : "admin/login.jsp?msg=" + encodeURI("请先登录")
	});
};

//修改名称
var modifyName = function(playTypeId, name, e) {
	var str = '<tr class="contentTr updatePlayTypeTr"><td colspan="99">';
	str += '&nbsp;&nbsp;名称：<input type="text" id="modifyNameInput" value="' + name + '">';
	str += '&nbsp;&nbsp;<input type="button" value="修改" onclick="modifyName2(' + playTypeId + ')">';
	str += '&nbsp;&nbsp;<input type="button" value="关闭" onclick="$(this).parent().parent().remove()">';
	str += '</td></tr>'
	$("tr.updatePlayTypeTr").remove();
	$(e).parent().parent().after(str);
};
var modifyName2 = function(playTypeId) {
	var name = $.trim($("#modifyNameInput").val());
	if(empty(name)) {
		showMsg("名称不能为空");
		return;
	}
	loadData({
		url : "administration/updateName",
		data : {
			"name" : name,
			"playTypeId" : playTypeId
		},
		success : function(data){
			showMsg(data.msg);
			if(data.code == 100) {
				query();
			}
		}
	});
}

//修改双方竞猜名
var modifyGuessName = function(playTypeId, leftGuessName, rightGuessName, e) {
	var str = '<tr class="contentTr updatePlayTypeTr"><td colspan="99">';
	str += '&nbsp;&nbsp;左方显示名：<input type="text" id="modifyLeftGuessNameInput" value="' + leftGuessName + '">';
	str += '&nbsp;&nbsp;左方显示名：<input type="text" id="modifyRightGuessNameInput" value="' + rightGuessName + '">';
	str += '&nbsp;&nbsp;<input type="button" value="修改" onclick="modifyGuessName2(' + playTypeId + ')">';
	str += '&nbsp;&nbsp;<input type="button" value="关闭" onclick="$(this).parent().parent().remove()">';
	str += '</td></tr>'
	$("tr.updatePlayTypeTr").remove();
	$(e).parent().parent().after(str);
};
var modifyGuessName2 = function(playTypeId){
	var leftGuessName = $.trim($("#modifyLeftGuessNameInput").val());
	var rightGuessName = $.trim($("#modifyRightGuessNameInput").val());
	if(empty(leftGuessName) || empty(rightGuessName)) {
		showMsg("显示名不能为空");
		return;
	}
	loadData({
		url : "administration/updateGuessName",
		data : {
			"leftGuessName" : leftGuessName,
			"rightGuessName" : rightGuessName,
			"playTypeId" : playTypeId
		},
		success : function(data) {
			showMsg(data.msg);
			if(data.code == 100) {
				query();
			}
		}
	});
};

//删除玩法
var del = function(playTypeId){
	if(confirm("确定删除？")) {
		loadData({
			url : "administration/playTypeDelete",
			data : {"playTypeId" : playTypeId},
			success : function(data) {
				showMsg(data.msg);
				if(data.code == 100) {
					query();
				}
			}
		});
	}
};

//修改固定赔率
var fixedOddsChange = function(playTypeId, e){
	if(confirm("确定修改？")) {
		loadData({
			url : "administration/updateFixedOdds",
			data : {
				"fixedOdds" : $.trim($(e).val()),
				"playTypeId" : playTypeId
			},
			success : function(data) {
				showMsg(data.msg);
				if(data.code == 100) {
					query();
				}
			}
		});
	}
};

//修改预计胜率
var updateWinRate = function(leftWinRate, rightWinRate, playTypeId, e){
	var str = '<tr class="contentTr updatePlayTypeTr"><td colspan="99">';
	str += '&nbsp;&nbsp;左方赔率:<input id="updateLeftWinRate" type="number" step="0.01" value="' + leftWinRate + '" style="width:60px;">';
	str += '&nbsp;&nbsp;右方赔率:<input id="updateRightWinRate" type="number" step="0.01" value="' + rightWinRate + '" style="width:60px;">';
	str += '&nbsp;&nbsp;<input type="button" value="确定" onclick="updateWinRate2(' + playTypeId + ')">';
	str += '&nbsp;&nbsp;<input type="button" value="关闭" onclick="$(this).parent().parent().remove()">';
	str += '</td></tr>'
	$("tr.updatePlayTypeTr").remove();
	$(e).parent().parent().after(str);
};
var updateWinRate2 = function(playTypeId) {
	var leftWinRate = $.trim($("#updateLeftWinRate").val());
	var rightWinRate = $.trim($("#updateRightWinRate").val());
	if(confirm("确定更改？")) {
		loadData({
			url : "administration/updateWinRate",
			data : {
				"leftWinRate" : leftWinRate,
				"rightWinRate" : rightWinRate,
				"playTypeId" : playTypeId
			},
			success : function(data) {
				showMsg(data.msg);
				if(data.code == 100) {
					query();
				}
			}
		});
	}
};

//暂停切换
var pauseChange = function(playTypeId, e) {
	if(confirm("确定更改？")) {
		loadData({
			url : "administration/setPause",
			data : {
				"playTypeId" : playTypeId,
				"pause" : $.trim($(e).val())
			},
			success : function(data) {
				showMsg(data.msg);
				if(data.code == 100) {
					query();
				}
			}
		});
	}
};

//加载赔率和奖金池
var loadOddsAndBonusPool = function() {
	var oddsPlayTypeId = new Array();
	$("span.odds").each(function(){
		oddsPlayTypeId.push($(this).attr("data-playTypeId"));
	});
	if(oddsPlayTypeId.length > 0) {
		loadData({
			url : "getBatchOdds",
			data : {"playTypeId[]" : oddsPlayTypeId},
			success : function(data) {
				if(data.code == 100) {
					var list = data.result;
					$("span.odds").each(function(index){
						var obj = list[index];
						var str = '<span style="color:red;">' + obj.leftOdds.toFixed(2) + '</span>';
						str += '&nbsp;<span style="font-weight:bold;font-size:18px;color:red;">:</span>&nbsp;';
						str += '<span style="color:blue;">' + obj.rightOdds.toFixed(2) + '</span>';
						$(this).html(str);
					});
				} else {
					showMsg(data.msg);
				}
			}
		});
	}

	
	var bonusPoolPlayTypeId = new Array();
	$("span.bonusPool").each(function(){
		bonusPoolPlayTypeId.push($(this).attr("data-playTypeId"));
	});
	if(bonusPoolPlayTypeId.length > 0) {
		loadData({
			url : "getBatchBonusPool",
			data : {"playTypeId[]" : bonusPoolPlayTypeId},
			success : function(data) {
				if(data.code == 100) {
					var list = data.result;
					$("span.bonusPool").each(function(index){
						var obj = list[index];
						var str = '<span style="color:red;">' + obj.leftBonusPool.toFixed(2) + '</span>';
						str += '&nbsp;<span style="font-weight:bold;font-size:18px;color:red;">:</span>&nbsp;';
						str += '<span style="color:blue;">' + obj.rightBonusPool.toFixed(2) + '</span>';
						$(this).html(str);
					});
				} else {
					showMsg(data.msg);
				}
			}
		});
	}
};

var versusBoChange = function(){
	var versusBo = $.trim($("#versusBo").val());
	window.location.href = "${basePath}admin/guess/playTypeList.jsp?versusId=" + versusId + "&bo=" + versusBo;
};

$(document).ready(function(){
	query();
});
</script>
</head>

<body>
<%@include file="/admin/header.jsp"%>
<div id="middle">
<jsp:include page="/admin/left.jsp">
	<jsp:param name="p" value="玩法列表"/>
</jsp:include>
	<div class="right">
	<div class="right_cont">
	<div class="breadcrumb">当前位置：
		<a href="javascript:;">网站管理</a><span class="divider">/</span>
		<a href="javascript:;">玩法列表</a>
	</div>
	<div class="title_right"><strong>玩法列表</strong><span style="color:red;font-size:18px;padding-left:200px;" id="showMsg"></span></div>
	<table class="table table-bordered table-striped table-hover">
		<tr>
			<td colspan="99" style="padding:3px;line-height:30px;">
				<span id="versusTitle"></span>&nbsp;&nbsp;局数：<select id="versusBo" onchange="versusBoChange()" style="width:70px;"></select>&nbsp;&nbsp;<a href="admin/guess/playTypeAdd.jsp" target="_blank">添加玩法</a>
			</td>
		</tr>
		<tr align="center">
			<td><strong>ID</strong></td>
			<td><strong>versusId</strong></td>
			<td><strong>名称</strong></td>
			<td><strong>双方竞猜显示名称</strong></td>
			<td><strong>对局</strong></td>
			<td><strong>参数</strong></td>
			<td><strong>暂停下注</strong></td>
			<td><strong>预计胜率</strong></td>
			<td><strong>赔率</strong></td>
			<td><strong>奖金池</strong></td>
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