<%@ page language="java" pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%><!DOCTYPE html>
<html>
<head>
<base href="${basePath}">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>竞猜列表 - <%=com.yy.guess.util.Util.getConfigCom(application).getWebTitle()%></title>
<link rel="stylesheet" href="admin/css/bootstrap.css">
<link rel="stylesheet" href="admin/css/css.css">
<script src="js/jquery.js"></script>
<script src="laydate/laydate.js"></script>
<script src="admin/js/common.js"></script>
<script>
var query = function(pageSize, pageNo){
	var itemId = $.trim($("#itemId").val());
	var status = $.trim($("#status").val());
	var startTimeStart = $.trim($("#startTimeStart").val());
	var startTimeEnd = $.trim($("#startTimeEnd").val());
	loadData({
		"url" : "administration/v2/versusAdmin/versusList",
		"data" : {
			"itemId" : (itemId > 0 ? itemId : null),
			"status" : ("全部" == status ? null : status),
			"startTimeStart" : startTimeStart,
			"startTimeEnd" : startTimeEnd,
			"pageSize" : pageSize,
			"pageNo" : pageNo
		},
		"success" : function(data) {
			if(data.code == 100) {
				var list = data.result.list;
				var str = '';
				for(var i=0; i<list.length; i++) {
					var versus = list[i].versus;
					var versusItemList = list[i].versusItemList;
					str += '<tr align="center" class="contentTr">';
					str += '<td>' + versus.id + '</td>';
					str += '<td>' + versus.name + '</td>';
					str += '<td><a href="' + versus.logoUrl + '" target="_blank"><img src="' + versus.logoUrl + '" style="width:30px;height:30px;"></a></td>';
					str += '<td data-itemId=' + versus.itemId + '>' + versus.itemName + '</td>';
					str += '<td>' + versus.returnRate + '</td>';
					str += '<td>' + versus.betAmountMin.toFixed(2) + '</td>';
					str += '<td>' + versus.betAmountMax.toFixed(2) + '</td>';
					str += '<td>¥' + versus.betAllAmount.toFixed(2) + '</td>';
					str += '<td>' + versus.startTime + '</td>';
					str += '<td>' + (versus.endTime == null ? "" : versus.endTime) + '</td>';
					str += '<td>' + versus.betPause + '</td>';
					str += '<td>' + versus.resultItemName + '</td>';
					str += '<td>' + versus.status + '</td>';
					str += '<td>' + versus.childVersusCount + '</td>';
					str += '<td>' + versus.createTime + '</td>';
					str += '<td>';
					str += '<a href="javascript:;">竞猜项</a>';
					str += '&nbsp;&nbsp;<a href="javascript:;">添加子竞猜</a>';
					str += '&nbsp;&nbsp;<a href="javascript:;">查看子竞猜</a>';
					str += '&nbsp;&nbsp;<a href="javascript:;">删除</a>';
					str += '</td>';
					str += '</tr>';
				}
				
				$("tr.contentTr").remove();
				$("table.table-bordered").append(str);
				$("#pageTd").html(getPageStr(data.result.page));
			} else {
				showMsg(data.msg);
			}
		}
	});
};

$(document).ready(function(){
	loadData({
		"url" : "administration/v2/itemAdmin/getAll",
		"success" : function(data) {
			if(data.code == 100) {
				var list = data.result;
				var str = '';
				for(var i=0; i<list.length; i++) {
					var obj = list[i];
					str += '<option value="' + obj.id + '">' + obj.name + '</option>';
				}
				$("#itemId").append(str);
				query(20, 1);
			}
		},
		"redirectUrl" : "admin/login.jsp?msg=" + encodeURI("请先登录")
	});
});
</script>
</head>

<body>
<%@include file="/admin/header.jsp"%>
<div id="middle">
<jsp:include page="/admin/left.jsp">
	<jsp:param name="p" value="竞猜列表"/>
</jsp:include>
	<div class="right">
	<div class="right_cont">
	<div class="breadcrumb">当前位置：
		<a href="javascript:;">网站管理</a><span class="divider">/</span>
		<a href="javascript:;">竞猜列表</a>
	</div>
	<div class="title_right"><strong>竞猜列表</strong><span style="color:red;font-size:18px;padding-left:200px;" id="showMsg"></span></div>
	<table class="table table-bordered table-striped table-hover">
		<tr>
			<td colspan="99" style="padding:3px;line-height:30px;">
				&nbsp;&nbsp;类别：<select id="itemId" style="width:100px;"><option value="0">全部</option></select>
				&nbsp;&nbsp;状态：<%=com.yy.fast4j.Fast4jUtils.getSelectHtmlStr(com.yy.guess.po.enums.NewGuessVersusStatus.class, "status", "width:70px;", null, new String[]{"全部"})%>
				&nbsp;&nbsp;开始时间：<input type="text" id="startTimeStart" class="laydate-icon" onclick="laydate({istime:true,format:'YYYY-MM-DD hh:mm:ss'});" style="width:140px;cursor:pointer;" readonly="readonly">
				-
				<input type="text" id="startTimeEnd" class="laydate-icon" onclick="laydate({istime:true,format:'YYYY-MM-DD hh:mm:ss'});" style="width:140px;cursor:pointer;" readonly="readonly">
				&nbsp;&nbsp;<input type="button" value="查询" onclick="query(20, 1)">
				&nbsp;&nbsp;<a href="admin/v2/newGuessVersus/add.jsp" target="_blank">添加竞猜</a>
			</td>
		</tr>
		<tr align="center">
			<td><strong>ID</strong></td>
			<td><strong>名称</strong></td>
			<td><strong>logo</strong></td>
			<td><strong>类目</strong></td>
			<td><strong>返还率</strong></td>
			<td><strong>下注下限</strong></td>
			<td><strong>下注上限</strong></td>
			<td><strong>总下注额</strong></td>
			<td><strong>开始时间</strong></td>
			<td><strong>结束时间</strong></td>
			<td><strong>下注</strong></td>
			<td><strong>结果</strong></td>
			<td><strong>状态</strong></td>
			<td><strong>子对阵数</strong></td>
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