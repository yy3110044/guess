<%@ page language="java" pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%><!DOCTYPE html>
<html>
<head>
<base href="${basePath}">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>添加赛事 - <%=com.yy.guess.util.Util.getConfigCom(application).getWebTitle()%></title>
<link rel="stylesheet" href="admin/css/bootstrap.css">
<link rel="stylesheet" href="admin/css/css.css">
<script src="js/jquery.js"></script>
<script src="js/jquery.ui.widget.js"></script>
<script src="js/jquery.fileupload.js"></script>
<script src="js/jquery.iframe-transport.js"></script>
<script src="laydate/laydate.js"></script>
<script src="admin/js/common.js"></script>
<script>
$(document).ready(function(){
	addImageUploadEvent({
		"inputId" : "uploadImageInput",
		"url" : "<%=com.yy.guess.util.Util.getConfigCom(application).getUploadUrl()%>",
		"imgId" : "logoUrl",
		"defaultImgUrl" : "images/matchDefaultLogo.png"
	});
	loadData({
		url : "administration/getAllSports",
		success : function(data) {
			var list = data.result;
			var str = '';
			for(var i=0; i<list.length; i++) {
				var obj = list[i];
				str += '<option value="' + obj.id + '">' + obj.name + '</option>';
			}
			$("#sportId").html(str);
		},
		redirectUrl : "admin/login.jsp?msg=" + encodeURI("请先登录")
	});
});
var add = function(){
	var sportId = $.trim($("#sportId").val());
	var name = $.trim($("#name").val());
	var logoUrl = $.trim($("#logoUrl").attr("src"));
	var description = $.trim($("#description").val());
	var startTime = $.trim($("#startTime").val());
	var endTime = $.trim($("#endTime").val());
	var status = $.trim($("#status").val());
	if(empty(sportId)) {
		showMsg("请先添加运动项目");
		return;
	}
	if(empty(name)) {
		showMsg("请输入赛事名");
		return;
	}
	if(empty(logoUrl)) {
		showMsg("请上传一个logo图");
		return;
	}
	if(empty(status)) {
		showMsg("请选择状态");
		return;
	}
	loadData({
		url : "administration/matchAdd",
		data : {
			"sportId" : sportId,
			"name" : name,
			"logoUrl" : logoUrl,
			"description" : description,
			"startTime" : startTime,
			"endTime" : endTime,
			"status" : status
		},
		success : function(data){
			showMsg(data.msg);
			if(data.code == 100) {
				$("#name").val("");
				$("#logoUrl").removeAttr("src");
				$("#description").val("");
				$("#startTime").val("");
				$("#endTime").val("");
			}
		}
	});
};
</script>
</head>
<body>
<%@include file="/admin/header.jsp"%>
<div id="middle">
<jsp:include page="/admin/left.jsp">
	<jsp:param name="p" value="添加赛事"/>
</jsp:include>
	<div class="right">
	<div class="right_cont">
	<div class="breadcrumb">当前位置：
		<a href="javascript:;">网站管理</a><span class="divider">/</span>
		<a href="javascript:;">添加赛事</a>
	</div>
	<div class="title_right"><strong>添加赛事</strong><span style="color:red;font-size:18px;padding-left:200px;" id="showMsg"></span></div>
	<div style="width:900px; margin:auto">
	<table class="table table-bordered">
		<tr>
			<td width="12%" align="right" nowrap="nowrap" bgcolor="#f1f1f1">项目类型：</td>
			<td><select id="sportId"></select></td>
		</tr>
		<tr>
			<td align="right" nowrap="nowrap" bgcolor="#f1f1f1">赛事名：</td>
			<td><input type="text" id="name"></td>
		</tr>
		<tr>
			<td align="right" nowrap="nowrap" bgcolor="#f1f1f1">logo图：</td>
			<td><input type="file" name="file" id="uploadImageInput"></td>
		</tr>
		<tr>
			<td align="right" nowrap="nowrap" bgcolor="#f1f1f1">简介：</td>
			<td><textarea id="description" style="width: 374px; height: 132px;"></textarea></td>
		</tr>
		<tr>
			<td align="right" nowrap="nowrap" bgcolor="#f1f1f1">时间：</td>
			<td>
				<input type="text" id="startTime" placeholder="开始时间" class="laydate-icon" onclick="laydate({istime:true,format:'YYYY-MM-DD hh:mm:ss'});" style="width:140px;cursor:pointer;" readonly="readonly">
				-
				<input type="text" id="endTime" placeholder="结束时间" class="laydate-icon" onclick="laydate({istime:true,format:'YYYY-MM-DD hh:mm:ss'});" style="width:140px;cursor:pointer;" readonly="readonly">
			</td>
		</tr>
		<tr>
			<td align="right" nowrap="nowrap" bgcolor="#f1f1f1">状态：</td>
			<td><%=com.yy.fast4j.Fast4jUtils.getSelectHtmlStr(com.yy.guess.po.enums.MatchStatus.class, "status")%></td>
		</tr>
		<tr>
			<td align="right" nowrap="nowrap" bgcolor="#f1f1f1"></td>
			<td colspan="3"><input type="button" value="添加" class="btn btn-info" style="width:80px;" onclick="add()"></td>
		</tr>
	</table>
	</div> 
	</div>     
	</div>
</div>
</body>
</html>