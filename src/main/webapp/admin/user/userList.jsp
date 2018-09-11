<%@ page language="java" pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%><!DOCTYPE html>
<html>
<head>
<base href="${basePath}">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>用户列表 - <%=com.yy.guess.util.Util.getConfigCom(application).getWebTitle()%></title>
<link rel="stylesheet" href="admin/css/bootstrap.css">
<link rel="stylesheet" href="admin/css/css.css">
<script src="js/jquery.js"></script>
<script src="laydate/laydate.js"></script>
<script src="admin/js/common.js"></script>
<script>
var userRebateRateMin = parseFloat('<%=com.yy.guess.util.Util.getConfigCom(application).getUserRebateRateMin()%>');
var userRebateRateMax = parseFloat('<%=com.yy.guess.util.Util.getConfigCom(application).getUserRebateRateMax()%>');
$(document).ready(function(){
	query(20, 1);
});

var sendNotice = function(userId, e) {
	var str = '';
	str += '<tr class="contentTr detailTr"><td colspan="99" style="padding:4px;">';
	str += '<input type="text" id="noticeContent" placeholder="输入通知内容" style="width:700px;">';
	str += '&nbsp;&nbsp;<input type="button" onclick="sendNotice2(' + userId + ')" value="发送">';
	str += '&nbsp;&nbsp;<input type="button" onclick="$(this).parent().parent().remove()" value="关闭">';
	str += '</td></tr>';
	$("tr.detailTr").remove();
	$(e).parent().parent().after(str);
};
var sendNotice2 = function(userId){
	var content = $.trim($("#noticeContent").val());
	if(empty(content)) {
		showMsg("请输入通知内容");
		return;
	}
	loadData({
		url : "administration/userNoticeAdd",
		data : {
			"userId" : userId,
			"content" : content
		},
		success : function(data){
			showMsg(data.msg);
			if(data.code == 100) {
				$("#noticeContent").val("");
			}
		}
	});
};

var query = function(pageSize, pageNo) {
	var userId = $.trim($("#userId").val());
	var userName = $.trim($("#userName").val());
	var sortField = $.trim($("#sortField").val());
	var sortType = $.trim($("#sortType").val());
	
	loadData({
		url : "administration/userList",
		data : {
			"userId" : userId,
			"userName" : userName,
			"sortField" : sortField,
			"sortType" : sortType,
			"pageSize" : pageSize,
			"pageNo" : pageNo
		},
		success : function(data){
			if(data.code == 100) {
				fillResult(data, [
					{field : "id"},
					{field : "userName"},
					{fn : function(obj){return '<span style="font-weight:bold;">¥</span>' + obj.balance.toFixed(2);}},
					{field : "nickName"},
					{field : "qq"},
					{field : "phone"},
					{field : "email"},
					{field : "registTime"},
					{field : "lastLoginIp"},
					{field : "lastLoginTime"},
					{field : "lastLoginType"},
					{fn : function(obj){
						return (obj.rebateRate * 100).toFixed(2) + "%";
					}},
					{fn : function(obj){
						return (obj.subordinateDefaultRebateRate * 100).toFixed(2) + "%";
					}},
					{fn : function(obj){
						var str = '';
						str += '<a href="javascript:;" onclick="updateInfo(' + obj.id + ', this)">修改资料</a>';
						str += '&nbsp;<a href="javascript:;" onclick="updateRebateRate(' + obj.id + ', this)">修改返点</a>';
						str += '&nbsp;<a href="javascript:;" onclick="updateBalance(' + obj.id + ', this)">修改余额</a>';
						str += '&nbsp;<a href="admin/tradeFlow/tradeFlowList.jsp?userId=' + obj.id + '" target="_blank">查看流水</a>';
						str += '&nbsp;<a href="javascript:;" onclick="sendNotice(' + obj.id + ', this)">发送通知</a>';
						str += '&nbsp;<a href="admin/user/betList.jsp?userId=' + obj.id + '" target="_blank">查看下注</a>';
						return str;
					}}
				]);
			} else {
				showMsg(data.msg);
			}
		},
		redirectUrl : "admin/login.jsp?msg=" + encodeURI("请先登录")
	});
};

//修改返点
var updateRebateRate = function(userId, e){
	loadData({
		url : "administration/userDetail",
		data : {"userId" : userId},
		success : function(data) {
			if(data.code == 100) {
				loadData({
					url : "administration/userDetail",
					data : {"userId" : data.result.superUserId},
					success : function(data2) {
						if(data2.code == 100) {
							var str = '';
							str += '<tr class="contentTr detailTr"><td colspan="99" style="padding:4px;">';
							str += '输入返点：<input type="text" id="updateRebateRate_rebateRate" value="' + (data.result.rebateRate * 100).toFixed(2) + '" style="width:40px;">%';
							var rateMax = 0;
							if(data2.result == null) {
								rateMax = userRebateRateMax;
							} else {
								rateMax = data2.result.rebateRate < userRebateRateMax ? data2.result.rebateRate : userRebateRateMax;
							}
							str += '&nbsp;&nbsp;<span style="color:red;">范围' + (userRebateRateMin * 100).toFixed(2) + '% ~ ' + (rateMax * 100).toFixed(2) + '%<span>';
							str += '&nbsp;&nbsp;<input type="button" value="更改" onclick="updateRebateRate2(' + userId + ', ' + userRebateRateMin + ', ' + rateMax + ')">';
							str += '&nbsp;&nbsp;<input type="button" value="关闭" onclick="$(this).parent().parent().parent().remove()">';
							str += '</td></tr>';
							$("tr.detailTr").remove();
							$(e).parent().parent().after(str);
						} else {
							showMsg(data2.msg);
						}
					}
				});
			} else {
				showMsg(data.msg);
			}
		},
		redirectUrl : "admin/login.jsp?msg=" + encodeURI("请先登录")
	});
};
var updateRebateRate2 = function(userId, rateMin, rateMax) {
	var rebateRate = $.trim($("#updateRebateRate_rebateRate").val());
	if(empty(rebateRate)) {
		showMsg("请输入返点");
		return;
	}
	if(isNaN(rebateRate)) {
		showMsg("返点必须是一个数字");
		return;
	}
	var rebateRateStr = parseFloat(rebateRate).toFixed(2);
	
	var newRebateRate = parseFloat(rebateRateStr) / 100;
	if(newRebateRate < rateMin || newRebateRate > rateMax) {
		showMsg("不在范围内");
		return;
	}
	
	if(confirm("确定修改？")) {
		loadData({
			url : "administration/updateRebateRate",
			data : {
				"userId" : userId,
				"rebateRate" : newRebateRate
			},
			success : function(data) {
				showMsg(data.msg);
				if(data.code == 100) {
					$("#updateRebateRate_rebateRate").val(rebateRateStr);
				}
			}
		});
	}
};

//修改资料
var updateInfo = function(userId, e) {
	loadData({
		url : "administration/userDetail",
		data : {"userId" : userId},
		success : function(data) {
			if(data.code == 100) {
				var obj = data.result;
				var str = '';
				str += '<tr class="contentTr detailTr"><td colspan="99" style="padding:4px;">';
				str += '<div style="margin-top:4px;">昵称：<input type="text" id="updateInfo_nickName" value="' + obj.nickName + '"></div>';
				str += '<div style="margin-top:4px;">QQ：<input type="text" id="updateInfo_qq" value="' + obj.qq + '"></div>';
				str += '<div style="margin-top:4px;">手机：<input type="text" id="updateInfo_phone" value="' + obj.phone + '"></div>';
				str += '<div style="margin-top:4px;">邮箱：<input type="text" id="updateInfo_email" value="' + obj.email + '"></div>';
				str += '<div style="margin-top:4px;"><input type="button" value="修改" onclick="updateInfo2(' + userId + ')">&nbsp;<input type="button" value="关闭" onclick="$(this).parent().parent().parent().remove()"></div>';
				str += '</td></tr>';
				$("tr.detailTr").remove();
				$(e).parent().parent().after(str);
			} else {
				showMsg(data.msg);
			}
		},
		redirectUrl : "admin/login.jsp?msg=" + encodeURI("请先登录")
	});
};
var updateInfo2 = function(userId) {
	var nickName = $.trim($("#updateInfo_nickName").val());
	var qq = $.trim($("#updateInfo_qq").val());
	var phone = $.trim($("#updateInfo_phone").val());
	var email = $.trim($("#updateInfo_email").val());
	if(confirm("确定修改？")) {
		loadData({
			url : "administration/updateInfo",
			data : {
				"userId" : userId,
				"nickName" : nickName,
				"qq" : qq,
				"phone" : phone,
				"email" : email
			},
			success : function(data) {
				showMsg(data.msg);
			},
			redirectUrl : "admin/login.jsp?msg=" + encodeURI("请先登录")
		});
	}
};

//修改余额
var updateBalance = function(userId, e){
	var str = '';
	str += '<tr class="contentTr detailTr"><td colspan="99" style="padding:4px;">';
	str += '更改金额：<input id="updateBalance_amount" type="number" step="0.000001" style="width:100px;">';
	str += '&nbsp;&nbsp;类型：<%=com.yy.fast4j.Fast4jUtils.getSelectHtmlStr(com.yy.guess.po.enums.TradeType.class, "updateBalance_type", "width:60px;", "其它")%>';
	str += '&nbsp;&nbsp;备注：<input type="text" id="updateBalance_description">';
	str += '&nbsp;&nbsp;<input type="button" value="更改" onclick="updateBalance2(' + userId + ')">';
	str += '&nbsp;&nbsp;<input type="button" value="关闭" onclick="$(this).parent().parent().remove()">';
	str += '</td></tr>';
	$("tr.detailTr").remove();
	$(e).parent().parent().after(str);
};
var updateBalance2 = function(userId){
	var amount = $.trim($("#updateBalance_amount").val());
	var type = $.trim($("#updateBalance_type").val());
	var description = $.trim($("#updateBalance_description").val());
	if(empty(amount) || isNaN(amount)) {
		showMsg("金额必须是一个数字");
		return;
	}
	if(parseFloat(amount) == 0) {
		showMsg("金额不能为零");
		return;
	}
	if(empty(type)) {
		showMsg("请选择类型");
		return;
	}
	if(!confirm('确定更改吗？')) return;
	loadData({
		url : "administration/updateBalance",
		data : {
			"amount" : amount,
			"type" : type,
			"description" : description,
			"userId" : userId
		},
		success : function(data) {
			showMsg(data.msg);
			if(data.code == 100) {
				$("#updateBalance_amount").val("");
				$("#updateBalance_description").val("");
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
	<jsp:param name="p" value="用户列表"/>
</jsp:include>
	<div class="right">
	<div class="right_cont">
	<div class="breadcrumb">当前位置：
		<a href="javascript:;">网站管理</a><span class="divider">/</span>
		<a href="javascript:;">用户列表</a>
	</div>
	<div class="title_right"><strong>用户列表</strong><span style="color:red;font-size:18px;padding-left:200px;" id="showMsg"></span></div>
	<table class="table table-bordered table-striped table-hover">
		<tr>
			<td colspan="99" style="padding:3px;line-height:30px;">
				ID：<input type="number" id="userId" placeholder="用户id">
				&nbsp;&nbsp;用户名：<input type="text" id="userName" placeholder="用户名">
				&nbsp;&nbsp;排序：<select id="sortField" style="width:80px;"><option value="id">ID</option><option value="userName">用户名</option><option value="balance">余额</option><option value="registTime">注册时间</option><option value="lastLoginTime">登陆时间</option><option value="rebateRate">返点率</option></select>
				&nbsp;&nbsp;<select id="sortType" style="width:80px;"><option value="DESC">从大到小</option><option value="ASC">从小到大</option></select>
				&nbsp;&nbsp;<input type="button" value="查询" onclick="query(20, 1)">
			</td>
		</tr>
		<tr align="center">
			<td><strong>id</strong></td>
			<td><strong>用户名</strong></td>
			<td><strong>余额</strong></td>
			<td><strong>昵称 </strong></td>
			<td><strong>qq</strong></td>
			<td><strong>手机</strong></td>
			<td><strong>邮箱</strong></td>
			<td><strong>注册时间</strong></td>
			<td><strong>登陆IP</strong></td>
			<td><strong>登陆时间</strong></td>
			<td><strong>登陆类型</strong></td>
			<td><strong>返点</strong></td>
			<td><strong>下级默认返点</strong></td>
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