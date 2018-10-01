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
		"hideLoading" : true,
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
					{"fn" : function(data){
						if("处理中" == data.status) {
							return data.status;
						} else if("已同意" == data.status) {
							return '<span style="color:red;">' + data.status + '</span>';
						} else if("已拒绝" == data.status) {
							return '<span style="color:blue;">' + data.status + '</span>';
						} else {
							return data.status;
						}
					}},
					{"field" : "remark"},
					{"field" : "createTime"},
					{"fn" : function(obj){
						var str = '<a href="javascript:;" onclick="detail(' + obj.id + ', this)">详情</a>';
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
	setInterval("intervalQuery()", 20000);
});

var intervalQuery = function(){
	if($("tr.detailTr").length > 0) {
		return;
	}
	query(20, 1);
};

var detail = function(withdrawalId, e){
	loadData({
		"url" : "administration/getWithdrawal",
		"data" : {"withdrawalId" : withdrawalId},
		"success" : function(data) {
			if(data.code == 100) {
				var obj = data.result;
				var str = '';
				str += '<tr class="contentTr detailTr"><td colspan="99" style="padding:4px;">';
				str += '<div style="margin-top:5px;">提款用户：' + obj.userName + "</div>";
				str += '<div style="margin-top:5px;">提款金额：' + obj.amount + '</div>';
				str += '<div style="margin-top:5px;">收款银行：' + obj.bankName + '</div>';
				str += '<div style="margin-top:5px;">收款帐号：' + obj.bankAccount + '</div>';
				str += '<div style="margin-top:5px;">收款姓名：' + obj.bankAccountName + '</div>';
				if("处理中" == obj.status) { //未处理
					str += '<div style="margin-top:5px;">状态：<%=com.yy.fast4j.Fast4jUtils.getSelectHtmlStr(com.yy.guess.po.enums.UserWithdrawalStatus.class, "userWithdrawalStatus", "width:70px;", "处理中")%></div>';
					str += '<div style="margin-top:5px;display:none;">备注：<input type="text" id="remark" value="' + (obj.remark == null ? "" : obj.remark) + '" style="width:500px;"></div>';
					str += '<div style="margin-top:5px;"><input type="button" value="处理" onclick="chuli(' + obj.id + ')"></div>';
				} else { //已处理
					str += '<div style="margin-top:5px;">状态：<span style="color:' + (obj.status=="已同意"?"red;":"blue;") + '">' + obj.status + '</span></div>';
					str += '<div style="margin-top:5px;">备注：' + (obj.remark == null ? "" : obj.remark) + '</div>';
				}
				str += '<div style="margin-top:5px;"><input type="button" onclick="$(this).parent().parent().parent().remove()" value="关闭"></div>';
				str += '</td></tr>';
				$("tr.detailTr").remove();
				$(e).parent().parent().after(str);
				$("#userWithdrawalStatus").change(statusChange);
			} else {
				showMsg(data.msg);
			}
		}
	});
};
var chuli = function(withdrawalId) {
	var status = $.trim($("#userWithdrawalStatus").val());
	var remark = $.trim($("#remark").val());
	if("处理中" == status) {
		showMsg("请选择同意还是拒绝");
		return;
	} else {
		loadData({
			"url" : "administration/updateWithdrawal",
			"data" : {
				"withdrawalId" : withdrawalId,
				"status" : status,
				"remark" : remark
			},
			"success" : function(data) {
				if(data.code == 100) {
					showMsg(data.msg);
				} else {
					showMsg(data.msg);
				}
			}
		});
	}
};
var statusChange = function(){
	var status = $.trim($(this).val());
	if("处理中" == status) {
		$("#remark").val("");
		$("#remark").parent().hide();
	} else if("已同意" == status) {
		$("#remark").val("您的提款已到帐");
		$("#remark").parent().show();
	} else if("已拒绝" == status) {
		$("#remark").val("");
		$("#remark").attr("placeholder", "填写拒绝原因");
		$("#remark").parent().show();
	}
};
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