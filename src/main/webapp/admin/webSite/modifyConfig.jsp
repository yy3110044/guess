<%@ page language="java" pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%><!DOCTYPE html>
<html>
<head>
<base href="${basePath}"/>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>修改参数 - <%=com.yy.fast4j.Fast4jUtils.getBean(com.yy.fast4j.Cache.class, application).getString(com.yy.guess.util.CachePre.GUESS_CONFIG, "webTitle")%></title>
<link rel="stylesheet" href="admin/css/bootstrap.css">
<link rel="stylesheet" href="admin/css/css.css">
<script type="text/javascript" src="js/jquery.js"></script>
<script type="text/javascript" src="js/common.js"></script>
<script>
$(document).ready(function(){
	loadData({
		url : "administration/getAllConfigs",
		success : function(data) {
			if(data.code == 100) {
				var list = data.result;
				var str = '';
				for(var i=0; i<list.length; i++) {
					var obj = list[i];
					str += '<tr>';
					str += '<td align="right" nowrap="nowrap" bgcolor="#f1f1f1">' + obj.description + '：</td>';
					str += '<td><input class="configInput" type="text" name="' + obj.name + '" value="' + obj.val + '" style="width:300px;"></td>';
					str += '</tr>';
				}
				$("table.table-bordered").prepend(str);
			}
		},
		redirectUrl : "admin/login.jsp?msg=" + encodeURI("请先登录")
	});
});

var modify = function(){
	if(confirm('确定修改？')) {
		var params = new Array();
		$("input.configInput").each(function(){
			var name = $(this).attr("name");
			var val = $.trim($(this).val());
			params.push(name + "=>" + val);
		});
		loadData({
			url : "administration/modifyConfig",
			data : {
				"name_val[]" : params
			},
			success : function(data) {
				$("#showMsg").html(data.msg);
			},
			redirectUrl : "admin/login.jsp?msg=" + encodeURI("请先登录")
		});
	}
};
</script>
</head>
<body>
<%@include file="/admin/header.jsp"%>
<div id="middle">
<jsp:include page="/admin/left.jsp">
	<jsp:param name="p" value="修改参数"/>
</jsp:include>
	<div class="right">
	<div class="right_cont">
	<div class="breadcrumb">当前位置：
		<a href="javascript:;">网站管理</a><span class="divider">/</span>
		<a href="javascript:;">修改参数</a>
	</div>
	<div class="title_right"><strong>修改参数</strong><span style="color:red;font-size:18px;padding-left:200px;" id="showMsg"></span></div>
	<div style="width:900px; margin:auto">
	<table class="table table-bordered">
		<tr>
			<td align="right" nowrap="nowrap" bgcolor="#f1f1f1"></td>
			<td colspan="3"><input type="button" value="修改" class="btn btn-info" style="width:80px;" onclick="modify()"></td>
		</tr>
	</table>
	</div> 
	</div>     
	</div>
</div>
</body>
</html>