<%@ page language="java" pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%><!DOCTYPE html>
<html>
<head>
<base href="${basePath}">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>对阵列表 - <%=com.yy.guess.util.Util.getConfigCom(application).getWebTitle()%></title>
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
			var listLength = data.result.list.length;
			fillResult(data, [
				{field : "id"},
				{field : "sportName"},
				{field : "matchName"},
				{field : "name"},
				{fn : function(obj){return '<span style="color:red;">' + obj.leftTeamName + '</span>&nbsp;vs&nbsp;<span style="color:green;">' + obj.rightTeamName + '</span>';}},
				{field : "startTime"},
				{fn : function(obj){
					var str = '';
					str += '<select style="width:50px;" onchange="autoSwitchStatusChange(' + obj.id + ', this)">';
					str += '<option value="true"' + (obj.autoSwitchStatus ? ' selected="selected"' : '') + '>是</option>';
					str += '<option value="false"' + (obj.autoSwitchStatus ? '' : ' selected="selected"') + '>否</option>';
					str += '</select>';
					return str;
				}},
				{field : "endTime"},
				{fn : function(obj){
					if("未开始" == obj.status) {
						return '<span style="color:blue;">' + obj.status + '</span>';
					} else if("进行中" == obj.status) {
						return '<span style="color:green;">' + obj.status + '</span>';
					} else if("已结束" == obj.status) {
						return '<span style="color:red;">' + obj.status + '</span>';
					} else {
						return obj.status;
					}
				}},
				{fn : function(obj){
					var str = obj.leftTeamScore + '&nbsp;:&nbsp;' + obj.rightTeamScore;
					return str;
				}},
				{field : "boCount"},
				{field : "realBoCount"},
				{fn : function(obj){
					if(obj.status == '已结束') {
						if(obj.result > 0) {
							return obj.rightTeamName + "胜";
						} else if(obj.result < 0) {
							return obj.leftTeamName + "胜";
						} else {
							return "平";
						}
					} else {
						return "";
					}
				}},
				{field : "createTime"},
				{fn : function(obj){
					var str = '';
					if(obj.playTypeCount > 0) {
						str += '<span style="color:green;">' + obj.playTypeCount + '</span>';
					} else {
						str += '<span style="color:red;">未添加</span>';
					}
					return str;
				}},
				{fn : function(obj, tdId, index){
					var str = '';
					str += '<a href="javascript:;" onclick="detail(' + obj.id + ', this)" id="versusDetailA' + obj.id + '">详情</a>';
					str += '&nbsp;<a href="admin/guess/playTypeAdd.jsp?matchVersusId=' + obj.id + '" target="_blank">添加玩法</a>';
					str += '&nbsp;<a href="admin/guess/playTypeList.jsp?versusId=' + obj.id + '" target="_blank">玩法列表</a>';
					str += '&nbsp;<a href="javascript:;" onclick="del(' + obj.id + ', this)">删除</a>';
					return str;
				}}
			]);
		}
	});
};

//自动切换状态更新
var autoSwitchStatusChange = function(versusId, e) {
	loadData({
		url : "administration/updateAutoSwitchStatus",
		data : {
			"autoSwitchStatus" : $.trim($(e).val()),
			"versusId" : versusId
		},
		success : function(data) {
			showMsg(data.msg);
		}
	});
};

var parseHour = function(seconds) {
	return parseInt(seconds / 60 / 60, 10);
};
var parseMinute = function(seconds) {
	return parseInt(seconds / 60 % 60, 10);
};
var parseSecond = function(seconds) {
	return parseInt(seconds % 60, 10);
};

var detail = function(versusId, e) {
	loadData({
		url : "administration/getMatchVersus",
		data : {"versusId" : versusId},
		success : function(data) {
			if(data.code == 100) {
				var versus = data.result.versus;
				var boList = data.result.boList;

				var str = '<tr class="contentTr detailTr"><td colspan="99">';
				str += '<div style="margin-top:8px;font-weight:bold;font-size:16px;">' + versus.matchName + '&nbsp;' + versus.name + '&nbsp;' + versus.leftTeamName + '&nbsp;VS&nbsp;' + versus.rightTeamName + '</div>';
				str += '<div style="margin-top:8px;border:1px dashed blue;padding:4px;" id="versus' + versus.id + '" class="detailDiv">';
				str += '<div style="margin-top:4px;font-weight:bold;font-size:16px;">主盘口</div>';
				str += '<div style="margin-top:4px;">开始时间：<input type="text" class="startTime" value="' + versus.startTime + '" placeholder="比赛开始时间" class="laydate-icon" onclick="laydate({istime:true,format:\'YYYY-MM-DD hh:mm:ss\'});" style="width:140px;cursor:pointer;" readonly="readonly"></div>';
				str += '<div style="margin-top:4px;">比赛局数：<input type="number" class="boCount" value="' + versus.boCount + '" data-oldBoCount="' + versus.boCount + '" min="1" readonly="readonly"></div>';
				str += '<div style="margin-top:4px;">实际局数：<input type="number" class="realBoCount" value="' + versus.realBoCount + '" min="0"></div>';
				str += '<div style="margin-top:4px;">比分：' + versus.leftTeamName + '<input type="number" class="leftTeamScore" value="' + versus.leftTeamScore + '" min="0" style="width:45px;">&nbsp;:&nbsp;<input type="number" class="rightTeamScore" value="' + versus.rightTeamScore + '" min="0" style="width:45px;text-align:right;">' + versus.rightTeamName + '</div>';
				str += '<div style="margin-top:4px;">比赛状态：<select class="status" data-value="' + versus.status + '" onchange="detailStatusChange(this)"><%=com.yy.fast4j.Fast4jUtils.getSelectOptionHtmlStr(com.yy.guess.po.enums.MatchStatus.class)%></select><span style="display:none;">&nbsp;&nbsp;<input id="autoUpdateStartTime" type="checkbox" style="vertical-align:middle;margin-top:0px;"><label style="vertical-align:middle;display:inline-block;margin-bottom:0px;" for="autoUpdateStartTime">是否自动同时更新开始时间</label></span></div>';
				str += '<div style="margin-top:4px;' + (versus.status != '已结束' ? 'display:none;' : '') + '">比赛结果：<select class="result"><option value="-1"' + (versus.result < 0 ? ' selected="selected"' : '') + '>' + versus.leftTeamName + '胜</option><option value="0"' + (versus.result == 0 ? ' selected="selected"' : '') + '>平</option><option value="1"' + (versus.result > 0 ? ' selected="selected"' : '') + '>' + versus.rightTeamName + '胜</option></select></div>';
				str += '<div style="margin-top:4px;"><input type="button" value="修改" onclick="modifyVersus(' + versus.id + ')"></div>';
				str += '</div>';
				for(var i=0; i<boList.length; i++) {
					var obj = boList[i];
					str += '<div id="versusBo' + obj.id + '" style="margin-top:8px;border:1px dashed blue;padding:4px;" class="detailDiv">';
					str += '<div style="margin-top:4px;font-weight:bold;font-size:16px;">第' + obj.bo + '局</div>';
					str += '<div style="margin-top:4px;">首杀：<select class="firstKillTeam"><option value="-1"' + (obj.firstKillTeam < 0 ? ' selected="selected"' : '') + '>' + versus.leftTeamName + '</option><option value="0"' + (obj.firstKillTeam == 0 ? ' selected="selected"' : '') + '>无</option><option value="1"' + (obj.firstKillTeam > 0 ? ' selected="selected"' : '') + '>' + versus.rightTeamName + '</option></select></div>';
					str += '<div style="margin-top:4px;">首杀时间：<input class="firstKillTimeHour" type="number" value="' + parseHour(obj.firstKillTime) + '" min="0" style="width:50px;">小时&nbsp;<input class="firstKillTimeMinute" type="number" value="' + parseMinute(obj.firstKillTime) + '" min="0" style="width:50px;">分&nbsp;<input class="firstKillTimeSecond" type="number" value="' + parseSecond(obj.firstKillTime) + '" min="0" style="width:50px;">秒</div>';
					str += '<div style="margin-top:4px;">十杀：<select class="tenthKillTeam"><option value="-1"' + (obj.tenthKillTeam < 0 ? ' selected="selected"' : '') + '>' + versus.leftTeamName + '</option><option value="0"' + (obj.tenthKillTeam == 0 ? ' selected="selected"' : '') + '>无</option><option value="1"' + (obj.tenthKillTeam > 0 ? ' selected="selected"' : '') + '>' + versus.rightTeamName + '</option></select></div>';
					str += '<div style="margin-top:4px;">十杀时间：<input class="tenthKillTimeHour" type="number" value="' + parseHour(obj.tenthKillTime) + '" min="0" style="width:50px;">小时&nbsp;<input class="tenthKillTimeMinute" type="number" value="' + parseMinute(obj.tenthKillTime) + '" min="0" style="width:50px;">分&nbsp;<input class="tenthKillTimeSecond" type="number" value="' + parseSecond(obj.tenthKillTime) + '" min="0" style="width:50px;">秒</div>';
					str += '<div style="margin-top:4px;">比分：' + versus.leftTeamName + '<input class="leftTeamKillCount" type="number" value="' + obj.leftTeamKillCount + '" min="0" style="width:50px;">&nbsp;&nbsp;VS&nbsp;&nbsp;<input class="rightTeamKillCount" type="number" value="' + obj.rightTeamKillCount + '" min="0" style="width:50px;">' + versus.rightTeamName + '</div>';
					str += '<div style="margin-top:4px;">比赛时长：<input class="matchTimeHour" type="number" value="' + parseHour(obj.matchTime) + '" min="0" style="width:50px;">小时&nbsp;<input class="matchTimeMinute" type="number" value="' + parseMinute(obj.matchTime) + '" min="0" style="width:50px;">分&nbsp;<input class="matchTimeSecond" type="number" value="' + parseSecond(obj.matchTime) + '" min="0" style="width:50px;">秒</div>';
					str += '<div style="margin-top:4px;">比赛状态：<select class="status" data-value="' + obj.status + '" onchange="detailStatusChange(this)"><%=com.yy.fast4j.Fast4jUtils.getSelectOptionHtmlStr(com.yy.guess.po.enums.MatchStatus.class)%></select></div>';
					str += '<div style="margin-top:4px;' + (obj.status != '已结束' ? 'display:none;' : '') + '">比赛结果：<select class="result"><option value="-1"' + (obj.result < 0 ? ' selected="selected"' : '') + '>' + versus.leftTeamName + '胜</option><option value="0"' + (obj.result == 0 ? ' selected="selected"' : '') + '>平</option><option value="1"' + (obj.result > 0 ? ' selected="selected"' : '') + '>' + versus.rightTeamName + '胜</option></select></div>';
					str += '<div style="margin-top:4px;"><input type="button" value="修改" onclick="modifyVersusBo(' + obj.id + ')"></div>';
					str += '</div>';
				}
				str += '<div style="margin-top:8px;"><input onclick="$(this).parent().parent().parent().remove()" type="button" value="关闭"></div>';
				str += '<script>';
				str += '$(document).ready(function(){';
				str += '	$("div.detailDiv .status").each(function(){';
				str += '		$(this).val($(this).attr("data-value"));';
				str += '	});';
				str += '});';
				str += '</'+'script>';
				str += '</td></tr>';
				$("tr.detailTr").remove();
				$(e).parent().parent().after(str);
			} else {
				showMsg(data.msg);
			}
		}
	});
};

var getSecondTime = function(hour, minute, second) {
	return parseStrToInt(hour) * 60 * 60 + parseStrToInt(minute) * 60 + parseStrToInt(second);
};
//字符串转为int，默认为0
var parseStrToInt = function(str) {
	if(empty(str) || isNaN(str)) {
		return 0;
	}
	var strInt = parseInt(str, 10);
	if(strInt < 0) {
		return 0;
	} else {
		return strInt;
	}
};

var modifyVersus = function(versusIdNumber) {
	if(!confirm('确定修改？')) {
		return;
	}
	
	var versusId = "versus" + versusIdNumber;
	
	var startTime = $.trim($("#" + versusId).find(".startTime").val());
	var oldBoCount = $.trim($("#" + versusId).find(".boCount").attr("data-oldBoCount"));
	var boCount = $.trim($("#" + versusId).find(".boCount").val());
	if(oldBoCount != boCount) { //更改了boCount
		if(!confirm("更改了比赛局数，将会删除此对阵下的玩法，确定删除吗？")) {
			return;
		}
	}
	var realBoCount = $.trim($("#" + versusId).find(".realBoCount").val());
	var status = $.trim($("#" + versusId).find(".status").val());
	var result = $.trim($("#" + versusId).find(".result").val());
	if("已结束" == status) {
		if(!confirm("若将状态修改为已结束，将会关闭投注接口并结算，确定操作吗？")) {
			return;
		}
	} else if("未比赛" == status) {
		if(!confirm("若将状态修改为未比赛，将会关闭投注接口并退回用户的投注金额，确定操作吗？")) {
			return;
		}
	}
	
	var leftTeamScore = $.trim($("#" + versusId).find(".leftTeamScore").val());
	var rightTeamScore = $.trim($("#" + versusId).find(".rightTeamScore").val());
	loadData({
		url : "administration/matchVersusUpdate",
		data : {
			"id" : versusIdNumber,
			"startTime" : startTime,
			"boCount" : boCount,
			"realBoCount" : realBoCount,
			"status" : status,
			"result" : result,
			"leftTeamScore" : leftTeamScore,
			"rightTeamScore" : rightTeamScore,
			"autoUpdateStartTime" : $("#autoUpdateStartTime").is(":checked")
		},
		success : function(data){
			showMsg(data.msg);
			if(data.code == 100) {

			}
		}
	});
};

var modifyVersusBo = function(versusBoIdNumber) {
	if(!confirm('确定修改？')) {
		return;
	}
	var versusBoId = "versusBo" + versusBoIdNumber;
	
	var firstKillTeam = $.trim($("#" + versusBoId).find(".firstKillTeam").val());
	var firstKillTime = getSecondTime($.trim($("#" + versusBoId).find(".firstKillTimeHour").val()), $.trim($("#" + versusBoId).find(".firstKillTimeMinute").val()), $.trim($("#" + versusBoId).find(".firstKillTimeSecond").val()));
	var tenthKillTeam = $.trim($("#" + versusBoId).find(".tenthKillTeam").val());
	var tenthKillTime = getSecondTime($.trim($("#" + versusBoId).find(".tenthKillTimeHour").val()), $.trim($("#" + versusBoId).find(".tenthKillTimeMinute").val()), $.trim($("#" + versusBoId).find(".tenthKillTimeSecond").val()));
	var leftTeamKillCount = parseStrToInt($.trim($("#" + versusBoId).find(".leftTeamKillCount").val()));
	var rightTeamKillCount = parseStrToInt($.trim($("#" + versusBoId).find(".rightTeamKillCount").val()));
	var matchTime = getSecondTime($.trim($("#" + versusBoId).find(".matchTimeHour").val()), $.trim($("#" + versusBoId).find(".matchTimeMinute").val()), $.trim($("#" + versusBoId).find(".matchTimeSecond").val()));
	var status = $.trim($("#" + versusBoId).find(".status").val());
	var result = $.trim($("#" + versusBoId).find(".result").val());
	if("已结束" == status) {
		if(!confirm("若将状态修改为已结束，将会关闭投注接口并结算，确定操作吗？")) {
			return;
		}
	} else if("未比赛" == status) {
		if(!confirm("若将状态修改为未比赛，将会关闭投注接口并退回用户的投注金额，确定操作吗？")) {
			return;
		}
	}
	loadData({
		url : "administration/matchVersusBoUpdate",
		data : {
			"id" : versusBoIdNumber,
			"firstKillTeam" : firstKillTeam,
			"firstKillTime" : firstKillTime,
			"tenthKillTeam" : tenthKillTeam,
			"tenthKillTime" : tenthKillTime,
			"leftTeamKillCount" : leftTeamKillCount,
			"rightTeamKillCount" : rightTeamKillCount,
			"matchTime" : matchTime,
			"status" : status,
			"result" : result
		},
		success : function(data){
			showMsg(data.msg);
			if(data.code == 100) {
				
			}
		}
	});
};

var detailStatusChange = function(e) {
	var status = $(e).val();
	if("已结束" == status) {
		$(e).parent().next().slideDown();
	} else {
		$(e).parent().next().slideUp();
	}
	if("进行中" == status) {
		$("#autoUpdateStartTime").parent().show();
	} else {
		$("#autoUpdateStartTime").parent().hide();
		$("#autoUpdateStartTime").prop("checked", false);
	}
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
				if(data.code == 100) {
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
				} else {
					showMsg(data.msg);
				}
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
				项目类型：<select id="sportId" style="width:100px;" onchange="sportIdChange()"></select>
				&nbsp;&nbsp;赛事：<select id="matchId"><option value="0">全部</option></select>
				&nbsp;&nbsp;状态：<%=com.yy.fast4j.Fast4jUtils.getSelectHtmlStr(com.yy.guess.po.enums.MatchStatus.class, "status", "width:100px;", null, new String[]{"全部"})%>
				&nbsp;&nbsp;<input type="button" value="查询" onclick="query(20, 1)">
				&nbsp;&nbsp;<a href="admin/guess/matchVersusAdd.jsp" target="_blank">添加对阵</a>
			</td>
		</tr>
		<tr align="center">
			<td><strong>id</strong></td>
			<td><strong>项目</strong></td>
			<td><strong>赛事</strong></td>
			<td><strong>名称</strong></td>
			<td><strong>对阵</strong></td>
			<td><strong>开始时间</strong></td>
			<td><strong>自动切换状态</strong></td>
			<td><strong>结束时间</strong></td>
			<td><strong>状态</strong></td>
			<td><strong>比分</strong></td>
			<td><strong>比赛局数</strong></td>
			<td><strong>实际比赛局数</strong></td>
			<td><strong>比赛结果</strong></td>
			<td><strong>创建时间</strong></td>
			<td><strong>玩法</strong></td>
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