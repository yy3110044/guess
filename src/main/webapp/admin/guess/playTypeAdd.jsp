<%@ page language="java" pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%><!DOCTYPE html>
<html>
<head>
<base href="${basePath}">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>添加玩法 - <%=com.yy.guess.util.Util.getConfigCom(application).getWebTitle()%></title>
<link rel="stylesheet" href="admin/css/bootstrap.css">
<link rel="stylesheet" href="admin/css/css.css">
<script src="js/jquery.js"></script>
<script src="admin/js/common.js"></script>
<script>
var matchVersusId = "${param.matchVersusId}";
var winRateInput = function(){
	var ts = $(this);
	
	var val = $.trim(ts.val());
	var valInt = parseInt(val, 10);
	if(valInt > 100) valInt = 100;
	if(valInt < 0) valInt = 0;
	ts.val(valInt);
	
	var id = ts.attr("id");
	if("leftWinRate" == id) {
		$("#rightWinRate").val(100 - valInt);
	} else if("rightWinRate" == id) {
		$("#leftWinRate").val(100 - valInt);
	}
};
$(document).ready(function(){
	if(empty(matchVersusId)) {
		loadData({
			url : "administration/getAllSports",
			success : function(data){
				if(data.code == 100) {
					var list = data.result;
					var str = '<option value="0">选择项目类型</option>';
					for(var i=0; i<list.length; i++) {
						var obj = list[i];
						str += '<option value="' + obj.id + '">' + obj.name + '</option>';
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
			url : "administration/getGuessPlayTemplateAndMatchVersus",
			data : {"versusId" : matchVersusId},
			success : function(data){
				var versus = data.result.versus;
				var boList = data.result.boList;
				var templateList = data.result.templateList;
				
				$("#leftWinRateSpan").html(versus.leftTeamName);
				$("#rightWinRateSpan").html(versus.rightTeamName);
				
				boCount = boList.length;
				var templateClassStr = '<option value="0">选择玩法</option>';
				for(var i=0; i<templateList.length; i++) {
					var obj = templateList[i];
					templateClassStr += '<option value="' + obj.className + '">' + obj.description + '</option>';
				}
				$("#templateClass").html(templateClassStr);
				$("#matchVersusId").html('<option value="' + versus.id + '">' + versus.name + '：' + versus.leftTeamName + '&nbsp;VS&nbsp;' + versus.rightTeamName + '</option>');
				$("#matchId").parent().parent().hide();
				$("#sportId").parent().parent().hide();
			},
			redirectUrl : "admin/login.jsp?msg=" + encodeURI("请先登录")
		});
	}

	$("#leftWinRate,#rightWinRate").keyup(winRateInput);
	$("#leftWinRate,#rightWinRate").blur(winRateInput);
	$("#leftWinRate,#rightWinRate").focus(winRateInput);
	$("#leftWinRate,#rightWinRate").click(winRateInput);
});

//项目类型变换
var sportChange = function(){
	$("#matchId").empty();
	$("#matchVersusId").empty();
	$("#templateClass").empty();
	$("#applyScope").empty();
	$("#leftWinRateSpan,#rightWinRateSpan").empty();
	$("tr.paramTr").remove();
	
	var sportId = $.trim($("#sportId").val());
	if("0" != sportId) {
		loadData({
			url : "administration/getAllMatchsBySportId",
			data : {"sportId" : sportId},
			success : function(data){
				if(data.code == 100) {
					var list = data.result;
					var str = '<option value="0">选择赛事</option>';
					for(var i=0; i<list.length; i++) {
						var obj = list[i];
						str += '<option value="' + obj.id + '">' + obj.name + '</option>';
					}
					$("#matchId").html(str);
				} else {
					showMsg(data.msg);
				}
			}
		});
	}
};

//赛事变换
var matchChange = function(){
	$("#matchVersusId").empty();
	$("#templateClass").empty();
	$("#applyScope").empty();
	$("#leftWinRateSpan,#rightWinRateSpan").empty();
	$("tr.paramTr").remove();
	
	var matchId = $.trim($("#matchId").val());
	if("0" != matchId) {
		loadData({
			url : "administration/getAllMatchVersusByMatch",
			data : {"matchId" : matchId},
			success : function(data){
				if(data.code == 100) {
					var list = data.result;
					var str = '<option value="0">选择对阵</option>';
					for(var i=0; i<list.length; i++) {
						var obj = list[i];
						str += '<option value="' + obj.id + '">' + obj.name + '：' + obj.leftTeamName + '&nbsp;VS&nbsp;' + obj.rightTeamName + '</option>';
					}
					$("#matchVersusId").html(str);
				} else {
					showMsg(data.msg);
				}
			}
		});
	}
};

var boCount = 0;

//赛事对阵变换
var matchVersusChange = function(){
	$("#templateClass").empty();
	$("#applyScope").empty();
	$("#leftWinRateSpan,#rightWinRateSpan").empty();
	$("tr.paramTr").remove();

	var matchVersusId = $.trim($("#matchVersusId").val());
	if("0" != matchVersusId) {
		loadData({
			url : "administration/getGuessPlayTemplateAndMatchVersus",
			data : {"versusId" : matchVersusId},
			success : function(data){
				var versus = data.result.versus;
				var boList = data.result.boList;
				var templateList = data.result.templateList;
				
				$("#leftWinRateSpan").html(versus.leftTeamName);
				$("#rightWinRateSpan").html(versus.rightTeamName);
				
				boCount = boList.length;
				var templateClassStr = '<option value="0">选择玩法</option>';
				for(var i=0; i<templateList.length; i++) {
					var obj = templateList[i];
					templateClassStr += '<option value="' + obj.className + '">' + obj.description + '</option>';
				}
				$("#templateClass").html(templateClassStr);
			}
		});
	}
};

//玩法变换
var templateClassChange = function() {
	$("#applyScope").empty();
	$("tr.paramTr").remove();

	var templateClass = $.trim($("#templateClass").val());
	if("0" != templateClass) {
		loadData({
			url : "administration/getGuessPlayTemplateByClassName",
			data : {"className" : templateClass},
			success : function(data){
				if(data.code == 100) {
					var support = data.result.support;
					var templateParamInfos = data.result.templateParamInfos;
					if(templateParamInfos != null && templateParamInfos.length > 0) { //有参数
						var str = '';
						for(var i=0; i<templateParamInfos.length; i++) {
							var obj = templateParamInfos[i];
							str += '<tr class="paramTr">';
							str += '<td align="right" nowrap="nowrap" bgcolor="#f1f1f1">' + obj.description + '：</td>';
							str += '<td>';
							if("String" == obj.type) {
								str += '<input name="' + obj.name + '" type="text" value="' + (empty(obj.defaultValue) ? '' : obj.defaultValue) + '" data-required="' + obj.required + '" data-type="' + obj.type + '" class="addPlayTypeParamElements">';
							} else if("Integer" == obj.type) {
								str += '<input name="' + obj.name + '" type="number" value="' + (empty(obj.defaultValue) ? '' : obj.defaultValue) + '" data-required="' + obj.required + '" data-type="' + obj.type + '" class="addPlayTypeParamElements">';
							} else if("Double" == obj.type) {
								str += '<input name="' + obj.name + '" type="number" value="' + (empty(obj.defaultValue) ? '' : obj.defaultValue) + '" step="0.000001" data-required="' + obj.required + '" data-type="' + obj.type + '" class="addPlayTypeParamElements">';
							} else if("Enum" == obj.type) {
								str += '<select name="' + obj.name + '" data-required="' + obj.required + '" data-type="' + obj.type + '" class="addPlayTypeParamElements">';
								for(var j=0; j<obj.enumElement.length; j++) {
									var element = obj.enumElement[j];
									str += '<option value="' + element + '"' + (obj.defaultValue==element ? ' selected="selected"' : '') + '>' + element + '</option>';
								}
								str += '</select>';
							}
							str += '</td>';
							str += '</tr>';
						}
						$("tr.paramTr").remove();
						$("#paramAfterTr").after(str);
					} else {
						$("tr.paramTr").remove();
					}

					var str = '<option value="-1">应用到所有</option>';
					if(-1 == support) { //支持所有
						str += '<option value="0">应用到主盘口</option>';
						for(var i=1; i<=boCount; i++) {
							str += '<option value="' + i + '">应用到第' + i + '局</option>';
						}
					} else if(0 == support) { //支持总对阵
						str += '<option value="0">应用到总盘口</option>';
					} else if(1 == support) { //支持bo对阵
						for(var i=1; i<=boCount; i++) {
							str += '<option value="' + i + '">应用到第' + i + '局</option>';
						}
					} else {
						showMsg("玩法有误：support=" + support);
					}
					$("#applyScope").html(str);
				} else {
					showMsg(data.msg);
				}
			}
		});
	}
};

var addPlayType = function(){
	var sportId = $.trim($("#sportId").val());
	var matchId = $.trim($("#matchId").val());
	var matchVersusId = $.trim($("#matchVersusId").val());
	var templateClass = $.trim($("#templateClass").val());
	var applyScope = $.trim($("#applyScope").val());
	var leftWinRate = $.trim($("#leftWinRate").val());
	var rightWinRate = $.trim($("#rightWinRate").val());
	var fixedOdds = $.trim($("#fixedOdds").val());
	if(empty(matchVersusId) || "0" == matchVersusId) {
		showMsg("请选择对阵");
		return;
	}
	if(empty(templateClass) || "0" == templateClass) {
		showMsg("请选择玩法");
		return;
	}
	if(empty(applyScope)) {
		showMsg("请选择应用范围");
		return;
	}
	
	var params = new Array();
	var checkParam = true;
	var checkMsg = '';
	$(".addPlayTypeParamElements").each(function(){
		var ts = $(this);
		var name = ts.attr("name");
		var value = ts.val();
		var required = ts.attr("data-required");
		var type = ts.attr("data-type");
		if(empty(value)) {
			if("true" == required) { //这个参数是必须的
				checkParam = false;
				checkMsg = name + "参数不能为空";
				return;
			}
		} else {
			if("String" == type) {
				
			} else if("Integer" == type) {
				if(isNaN(value)) {
					checkParam = false;
					checkMsg = name + "参数必须是一个整数";
					return;
				}
			} else if("Double" == type) {
				if(isNaN(value)) {
					checkParam = false;
					checkMsg = name + "参数必须是一个数字";
					return;
				}
			} else if("Enum" == type) {
				
			}
		}
		params.push(name + "|" + value);
	});
	if(checkParam) {
		loadData({
			url : "administration/addPlayType",
			data : {
				"versusId" : matchVersusId,
				"bo" : applyScope,
				"templateClass" : templateClass,
				"leftWinRate" : parseFloat(leftWinRate) / 100,
				"rightWinRate" : parseFloat(rightWinRate) / 100,
				"fixedOdds" : fixedOdds,
				"params[]" : params
			},
			success : function(data){
				showMsg(data.msg);
				if(data.code == 100) {
					
				}
			}
		});
	} else {
		showMsg(checkMsg);
	}
};
</script>
</head>
<body>
<%@include file="/admin/header.jsp"%>
<div id="middle">
<jsp:include page="/admin/left.jsp">
	<jsp:param name="p" value="添加玩法"/>
</jsp:include>
	<div class="right">
	<div class="right_cont">
	<div class="breadcrumb">当前位置：
		<a href="javascript:;">网站管理</a><span class="divider">/</span>
		<a href="javascript:;">添加玩法</a>
	</div>
	<div class="title_right"><strong>添加玩法</strong><span style="color:red;font-size:18px;padding-left:200px;" id="showMsg"></span></div>
	<div style="width:900px; margin:auto">
	<table class="table table-bordered">
		<tr>
			<td width="20%" align="right" nowrap="nowrap" bgcolor="#f1f1f1">项目类型：</td>
			<td><select id="sportId" onchange="sportChange()"></select></td>
		</tr>
		<tr>
			<td align="right" nowrap="nowrap" bgcolor="#f1f1f1">赛事：</td>
			<td><select id="matchId" onchange="matchChange()"></select></td>
		</tr>
		<tr>
			<td align="right" nowrap="nowrap" bgcolor="#f1f1f1">对阵：</td>
			<td><select id="matchVersusId" onchange="matchVersusChange()"></select></td>
		</tr>
		<tr>
			<td align="right" nowrap="nowrap" bgcolor="#f1f1f1">选择玩法：</td>
			<td><select id="templateClass" onchange="templateClassChange()"></select></td>
		</tr>
		<tr>
			<td align="right" nowrap="nowrap" bgcolor="#f1f1f1">应用范围：</td>
			<td><select id="applyScope"></select></td>
		</tr>
		<tr>
			<td align="right" nowrap="nowrap" bgcolor="#f1f1f1">预计胜率：</td>
			<td><span id="leftWinRateSpan"></span>&nbsp;<input type="number" id="leftWinRate" value="50" min="0" style="width:40px;">%&nbsp;<span style="font-weight:bold;font-size:18px;color:red;">:</span>&nbsp;<span id="rightWinRateSpan"></span>&nbsp;<input type="number" id="rightWinRate" value="50" min="0" style="width:40px;">%&nbsp;<span style="color:red;">会用这个计算初始赔率</span></td>
		</tr>
		<tr id="paramAfterTr">
			<td align="right" nowrap="nowrap" bgcolor="#f1f1f1">赔率类型：</td>
			<td><select id="fixedOdds"><option value="false">变动</option><option value="true">固定</option></select></td>
		</tr>
		<tr>
			<td align="right" nowrap="nowrap" bgcolor="#f1f1f1"></td>
			<td colspan="3">
				<input type="button" value="添加" onclick="addPlayType()" class="btn btn-info" style="width:80px;">
				&nbsp;&nbsp;&nbsp;&nbsp;
				<input type="button" value="查看" onclick="window.open('${basePath}admin/guess/playTypeList.jsp?versusId=' + matchVersusId)" class="btn btn-info" style="width:80px;">
			</td>
		</tr>
	</table>
	</div> 
	</div>     
	</div>
</div>
</body>
</html>