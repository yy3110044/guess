<%@ page language="java" pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%><!DOCTYPE html>
<html>
<head>
<base href="${basePath}"/>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>添加项目 - <%=com.yy.guess.util.Util.getConfigCom(application).getWebTitle()%></title>
<link rel="stylesheet" href="admin/css/bootstrap.css">
<link rel="stylesheet" href="admin/css/css.css">
<script src="js/jquery.js"></script>
<script src="js/jquery.ui.widget.js"></script>
<script src="js/jquery.fileupload.js"></script>
<script src="js/jquery.iframe-transport.js"></script>
<script src="admin/js/common.js"></script>
<script>
$(document).ready(function(){
	addImageUploadEvent({
		"inputId" : "uploadImageInput",
		"url" : "<%=com.yy.guess.util.Util.getConfigCom(application).getUploadUrl()%>",
		"imgId" : "logoUrl",
		"defaultImgUrl" : "images/sportDefaultLogo.png"
	});
});

var add = function() {
	var name = $.trim($("#name").val());
	var logoUrl = $.trim($("#logoUrl").attr("src"));
	var description = $.trim($("#description").val());
	if(empty(name)) {
		showMsg("项目名不能为空");
		return;
	}
	if(empty(logoUrl)) {
		showMsg("请上传一个logo图");
		return;
	}
	loadData({
		url : "administration/sportAdd",
		data : {
			"name" : name,
			"logoUrl" : logoUrl,
			"description" : description
		},
		success : function(data) {
			showMsg(data.msg);
			if(data.code == 100) {
				$("#name").val("");
				if(logoUrl != "images/sportDefaultLogo.png") {
					$("#logoUrl").removeAttr("src");
				}
				$("#description").val("");
			}
		},
		redirectUrl : "admin/login.jsp?msg=" + encodeURI("请先登录")
	});
};
</script>
</head>
<body>
<%@include file="/admin/header.jsp"%>
<div id="middle">
<jsp:include page="/admin/left.jsp">
	<jsp:param name="p" value="添加项目"/>
</jsp:include>
	<div class="right">
	<div class="right_cont">
	<div class="breadcrumb">当前位置：
		<a href="javascript:;">竞猜管理</a><span class="divider">/</span>
		<a href="javascript:;">添加项目</a>
	</div>
	<div class="title_right"><strong>添加项目</strong><span style="color:red;font-size:18px;padding-left:200px;" id="showMsg"></span></div>
	<div style="width:900px; margin:auto">
	<table class="table table-bordered">
		<tr>
			<td width="12%" align="right" nowrap="nowrap" bgcolor="#f1f1f1">项目名称：</td>
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