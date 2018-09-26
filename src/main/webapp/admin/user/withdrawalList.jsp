<%@ page language="java" pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%><!DOCTYPE html>
<html>
<head>
<base href="${basePath}">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>提款列表 - <%=com.yy.guess.util.Util.getConfigCom(application).getWebTitle()%></title>
<link rel="stylesheet" href="admin/css/bootstrap.css">
<link rel="stylesheet" href="admin/css/css.css">
<script src="js/jquery.js"></script>
<script src="laydate/laydate.js"></script>
<script src="admin/js/common.js"></script>
<script>
var query = function(pageSize, pageNo){
	var status = $.trim($("#status").val());
	var startTime = $.trim($("#startTime").val());
	var endTime = $.trim($("#endTime").val());
	loadData({
		"url" : "administration/withdrawalList",
		"data" : {
			"status" : "全部" == status ? null : status,
			"startTime" : startTime,
			"endTime" : endTime,
			"pageNo" : pageNo,
			"pageSize" : pageSize
		},
		"success" : function(data) {
			if(data.code == 100) {
				fillResult(data, [
					{"field" : "id"},
					{"field" : "userId"},
					{"field" : "userName"},
					{"field" : "amount"},
					{"field" : "bankName"},
					{"field" : "bankAccount"},
					{"field" : "bankAccountName"},
					{"field" : "status"},
					{"field" : "remark"},
					{"field" : "createTime"},
					{"fn" : function(){
						var str = '';
						return str;
					}}
				]);
			} else {
				showMsg(data.msg);
			}
		},
		"redirectUrl" : "admin/login.jsp?msg=" + encodeURI("请先登录")
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
	<jsp:param name="p" value="提款列表"/>
</jsp:include>
	<div class="right">
	<div class="right_cont">
	<div class="breadcrumb">当前位置：
		<a href="javascript:;">网站管理</a><span class="divider">/</span>
		<a href="javascript:;">提款列表</a>
	</div>
	<div class="title_right"><strong>提款列表</strong><span style="color:red;font-size:18px;padding-left:200px;" id="showMsg"></span></div>
	<table class="table table-bordered table-striped table-hover">
		<tr>
			<td colspan="99" style="padding:3px;line-height:30px;">
				状态：<%=com.yy.fast4j.Fast4jUtils.getSelectHtmlStr(com.yy.guess.po.enums.UserWithdrawalStatus.class, "status", "width:80px;", "全部", new String[]{"全部"})%>
				&nbsp;&nbsp;<input type="text" id="startTime" placeholder="开始时间" class="laydate-icon" onclick="laydate({istime:true,format:'YYYY-MM-DD hh:mm:ss'});" style="width:140px;cursor:pointer;" readonly="readonly">
				-
				<input type="text" id="endTime" placeholder="结束时间" class="laydate-icon" onclick="laydate({istime:true,format:'YYYY-MM-DD hh:mm:ss'});" style="width:140px;cursor:pointer;" readonly="readonly">
				&nbsp;&nbsp;<input type="button" value="查询" onclick="query(20, 1)">
			</td>
		</tr>
		<tr align="center">
			<td><strong>ID</strong></td>
			<td><strong>用户ID</strong></td>
			<td><strong>用户名</strong></td>
			<td><strong>提款金额</strong></td>
			<td><strong>收款银行</strong></td>
			<td><strong>收款帐号</strong></td>
			<td><strong>收款人</strong></td>
			<td><strong>状态</strong></td>
			<td><strong>备注</strong></td>
			<td><strong>时间</strong></td>
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