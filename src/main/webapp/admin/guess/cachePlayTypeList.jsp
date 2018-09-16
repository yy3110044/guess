<%@ page language="java" pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%><!DOCTYPE html>
<html>
<head>
<base href="${basePath}">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>缓存列表 - <%=com.yy.guess.util.Util.getConfigCom(application).getWebTitle()%></title>
<link rel="stylesheet" href="admin/css/bootstrap.css">
<link rel="stylesheet" href="admin/css/css.css">
<script src="js/jquery.js"></script>
<script src="laydate/laydate.js"></script>
<script src="admin/js/common.js"></script>
<script type="text/javascript">
var query = function(){
	var versusId = $.trim($("#versusId").val());
	var playTypeId = $.trim($("#playTypeId").val());
	loadData({
		url : "administration/getAllCachePlayType",
		data : {
			"versusId" : versusId,
			"playTypeId" : playTypeId
		},
		success : function(data){
			if(data.code == 100) {
				var str = getContentStr({
					"list" : data.result.list,
					"fields" : [
						{"field" : "id"},
						{"field" : "versusId"},
						{"field" : "name"},
						{"field" : "bo"},
						{"field" : "versusBoId"},
						{"field" : "status"},
						{"field" : "result"},
						{"field" : "paramStr"},
						{"field" : "templateClass"},
						{"field" : "pause"},
						{"field" : "guessStart"},
						{"field" : "leftGuessName"},
						{"field" : "rightGuessName"},
						{"field" : "leftWinRate"},
						{"field" : "rightWinRate"},
						{"field" : "leftBonusPool"},
						{"field" : "rightBonusPool"},
						{"field" : "redisLeftBonusPool"},
						{"field" : "redisRightBonusPool"},
						{"field" : "fixedOdds"},
						{"field" : "createTime"},
						{"fn" : function(data){
							var str = '';
							str += '<span class="equalsSpan" id="equalsSpan' + data.id + '" data-id="' + data.id + '"></span>';
							return str;
						}}
					]
				});
				$("tr.contentTr").remove();
				$("table.table-bordered").append(str);
			} else {
				showMsg(data.msg);
			}
		},
		complete : function(data) {
			$("span.equalsSpan").each(function(){
				var ts = $(this);
				var playTypeId = $.trim(ts.attr("data-id"));
				loadData({
					url : "administration/equals",
					data : {"playTypeId" : playTypeId},
					success : function(data){
						if(data.code == 100) {
							if(data.result) {
								ts.html('<span style="color:red;">true</span>');
							} else {
								ts.html('<span style="color:green;">false</span>');
							}
						} else {
							showMsg(data.msg);
						}
					}
				});
			});
		},
		redirectUrl : "admin/login.jsp?msg=" + encodeURI("请先登录")
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
	<jsp:param name="p" value="缓存列表"/>
</jsp:include>
	<div class="right">
	<div class="right_cont">
	<div class="breadcrumb">当前位置：
		<a href="javascript:;">网站管理</a><span class="divider">/</span>
		<a href="javascript:;">缓存列表</a>
	</div>
	<div class="title_right"><strong>缓存列表</strong><span style="color:red;font-size:18px;padding-left:200px;" id="showMsg"></span></div>
	<table class="table table-bordered table-striped table-hover">
		<tr>
			<td colspan="99" style="padding:3px;line-height:30px;">
				versusId：<input type="number" id="versusId">
				&nbsp;&nbsp;playTypeId：<input type="number" id="playTypeId">
				&nbsp;&nbsp;<input type="button" value="查询" onclick="query()">
			</td>
		</tr>
		<tr align="center">
			<td><strong>id</strong></td>
			<td><strong>versusId</strong></td>
			<td><strong>name</strong></td>
			<td><strong>bo</strong></td>
			<td><strong>versusBoId</strong></td>
			<td><strong>status</strong></td>
			<td><strong>result</strong></td>
			<td><strong>paramStr</strong></td>
			<td><strong>templateClass</strong></td>
			<td><strong>pause</strong></td>
			<td><strong>guessStart</strong></td>
			<td><strong>leftGuessName</strong></td>
			<td><strong>rightGuessName</strong></td>
			<td><strong>leftWinRate</strong></td>
			<td><strong>rightWinRate</strong></td>
			<td><strong>leftBonusPool</strong></td>
			<td><strong>rightBonusPool</strong></td>
			<td><strong>leftBonusPool(redis)</strong></td>
			<td><strong>rightBonusPool(redis)</strong></td>
			<td><strong>fixedOdds</strong></td>
			<td><strong>createTime</strong></td>
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