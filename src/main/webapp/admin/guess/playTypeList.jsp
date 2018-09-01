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
						{field : "name"},
						{field : "bo"},
						{field : "paramStr"},
						{field : "templateClass"},
						{fn : function(obj){
							var str = '';
							str += '<select onchange="guessStartChange(' + obj.id + ', this)" style="width:60px;">';
							str += '<option value="true"' + (obj.guessStart ? ' selected="selected"' : '') + '>开启</option>';
							str += '<option value="false"' + (obj.guessStart ? '' : ' selected="selected"') + '>关闭</option>';
							str += '</select>';
							return str;
						}},
						{fn : function(obj){
							var str = '';
							str += (obj.fixedOdds ? '<span style="color:green;">固定赔率</span>' : '<span style="color:red;">变动赔率</span>');
							str += '&nbsp;&nbsp;';
							str += '<a href="javascript:;" onclick="updateOdds(' + obj.id + ', ' + obj.fixedOdds + ', ' + obj.leftOdds + ', ' + obj.rightOdds + ', this)">更改</a>';
							return str;
						}},
						{fn : function(obj){
							if(obj.guessStart) {
								if(obj.fixedOdds) {
									return obj.leftOdds;
								} else {
									return '<span data-playTypeId="' + obj.id + '" class="odds" data-betDirection="LEFT"></span>';
								}
							} else {
								return obj.leftOdds;
							}
						}},
						{fn : function(obj){
							if(obj.guessStart) {
								if(obj.fixedOdds) {
									return obj.rightOdds;
								} else {
									return '<span data-playTypeId="' + obj.id + '" class="odds" data-betDirection="RIGHT"></span>';
								}
							} else {
								return obj.rightOdds;
							}
						}},
						{fn : function(obj){
							if(obj.guessStart) {
								return '<span data-playTypeId="' + obj.id + '" class="bonusPool" data-betDirection="LEFT"></span>';
							} else {
								return obj.leftBonusPool.toFixed(2);
							}
						}},
						{fn : function(obj){
							if(obj.guessStart) {
								return '<span data-playTypeId="' + obj.id + '" class="bonusPool" data-betDirection="RIGHT"></span>';
							} else {
								return obj.rightBonusPool.toFixed(2);
							}
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

//更新赔率类型
var updateOdds = function(playTypeId, fixedOdds, leftOdds, rightOdds, e){
	var str = '<tr class="contentTr updateOddsTr"><td colspan="99">';
	str += '<select id="updateOddsFixedOdds" style="width:80px;" onchange="oddsChange(' + leftOdds + ', ' + rightOdds + ', this)">';
	str += '<option value="true"' + (fixedOdds ? ' selected="selected"' : '') + '>固定赔率</option>';
	str += '<option value="false"' + (fixedOdds ? '' : ' selected="selected"') + '>变动赔率</option>';
	str += '</select>';
	if(fixedOdds) {
		str += '<span id="oddsUpdateInput">';
		str += '&nbsp;&nbsp;左方赔率:<input id="updateLeftOdds" type="text" value="' + leftOdds + '" style="width:60px;">';
		str += '&nbsp;&nbsp;右方赔率:<input id="updateRightOdds" type="text" value="' + rightOdds + '" style="width:60px;">';
		str += '</span>';
	}
	str += '&nbsp;&nbsp;<input type="button" value="更改" onclick="updateOdds2(' + playTypeId + ')">';
	str += '</td></tr>'
	$("tr.updateOddsTr").remove();
	$(e).parent().parent().after(str);
};
var updateOdds2 = function(playTypeId){
	var fixedOdds = $.trim($("#updateOddsFixedOdds").val());
	var leftOdds = $.trim($("#updateLeftOdds").val());
	var rightOdds = $.trim($("#updateRightOdds").val());
	loadData({
		url : "administration/setFixedOdds",
		data : {
			"playTypeId" : playTypeId,
			"fixedOdds" : fixedOdds,
			"leftOdds" : empty(leftOdds) ? null : leftOdds,
			"rightOdds" : empty(rightOdds) ? null : rightOdds
		},
		success : function(data) {
			showMsg(data.msg);
			if(data.code == 100) {
				query();
			}
		}
	});
};
var oddsChange = function(leftOdds, rightOdds, e){
	var value = $(e).val();
	if("true" == value) {
		var str = '';
		str += '<span id="oddsUpdateInput">';
		str += '&nbsp;&nbsp;左方赔率:<input id="updateLeftOdds" type="text" value="' + leftOdds + '" style="width:60px;">';
		str += '&nbsp;&nbsp;右方赔率:<input id="updateRightOdds" type="text" value="' + rightOdds + '" style="width:60px;">';
		str += '</span>';
		$("#oddsUpdateInput").remove();
		$(e).after(str);
	} else if("false" == value) {
		$("#oddsUpdateInput").remove();
	}
};

var guessStartChange = function(playTypeId, e){
	var value = $.trim($(e).val());
	if(confirm("确定改变状态？")) {
		loadData({
			url : "administration/setGuessStart",
			data : {
				"playTypeId" : playTypeId,
				"guessStart" : value
			},
			success : function(data){
				showMsg(data.msg);
			}
		});
	} else {
		if("true" == value) {
			$(e).val("false");
		} else if("false" == value) {
			$(e).val("true");
		}
	}
};

var loadOddsAndBonusPool = function() {
	$("span.odds").each(function(){
		var ts = $(this);
		var playTypeId = $.trim(ts.attr("data-playTypeId"));
		var betDirection = $.trim(ts.attr("data-betDirection"));
		loadData({
			url : "getNewestOdds",
			data : {
				"playTypeId" : playTypeId,
				"betDirection" : betDirection
			},
			success : function(data) {
				ts.html(data.result);
			}
		});
	});
	$("span.bonusPool").each(function(){
		var ts = $(this);
		var playTypeId = $.trim(ts.attr("data-playTypeId"));
		var betDirection = $.trim(ts.attr("data-betDirection"));
		loadData({
			url : "getBonusPool",
			data : {
				"playTypeId" : playTypeId,
				"betDirection" : betDirection
			},
			success : function(data) {
				ts.html(data.result.toFixed(2));
			}
		});
	});
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
		<tr align="center">
			<td><strong>ID</strong></td>
			<td><strong>versusId</strong></td>
			<td><strong>名称</strong></td>
			<td><strong>对局</strong></td>
			<td><strong>参数</strong></td>
			<td><strong>模版</strong></td>
			<td><strong>竞猜</strong></td>
			<td><strong>赔率</strong></td>
			<td><strong>左方赔率</strong></td>
			<td><strong>右方赔率</strong></td>
			<td><strong>左方奖金池</strong></td>
			<td><strong>右方奖金池</strong></td>
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