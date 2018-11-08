<%@ page language="java" pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%><!DOCTYPE html>
<html>
<head>
<base href="${basePath}">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>下注列表 - <%=com.yy.guess.util.Util.getConfigCom(application).getWebTitle()%></title>
<link rel="stylesheet" href="admin/css/bootstrap.css">
<link rel="stylesheet" href="admin/css/css.css">
<script src="js/jquery.js"></script>
<script src="laydate/laydate.js"></script>
<script src="admin/js/common.js"></script>
<script>
var versusId = "${param.versusId}";
var versusItemId = "${param.versusItemId}";
var userId = "${param.userId}";
var query = function(pageSize, pageNo) {
	var orderNumber = $.trim($("#orderNumber").val());
	var status = $.trim($("#status").val());
	loadData({
		"url" : "administration/v2/betAdmin/betList",
		"data" : {
			"orderNumber" : orderNumber,
			"versusId" : versusId,
			"versusItemId" : versusItemId,
			"userId" : userId,
			"status" : (status == "全部" ? null : status),
			"pageSize" : pageSize,
			"pageNo" : pageNo
		},
		"success" : function(data) {
			if(data.code == 100) {
				fillResult(data, [
					{"field" : "id"},
					{"field" : "orderNumber"},
					{"field" : "userId"},
					{"field" : "userName"},
					{"fn" : function(data){return '<span class="versus-id" data-versus-id="' + data.versusId + '"></span>';}},
					{"fn" : function(data){return '<span class="versus-item-id" data-versus-item-id="' + data.versusItemId + '"></span>';}},
					{"fn" : function(data){return data.odds;}},
					{"fn" : function(data){return "¥" + data.betAmount.toFixed(2);}},
					{"fn" : function(data){
						if("未结算" == data.status) {
							return '<span style="color:blue;">' + data.status + '</span>';
						} else if("未猜中" == data.status) {
							return '<span style="color:green;">' + data.status + '</span>';
						} else if("已猜中" == data.status) {
							return '<span style="color:red;">' + data.status + '</span>';
						} else if("已退回" == data.status) {
							return '<span style="color:black;">' + data.status + '</span>';
						} else {
							return '<span style="">' + data.status + '</span>';
						}
					}},
					{"fn" : function(data){return "¥" + data.payBonus.toFixed(2);}},
					{"field" : "createTime"},
					{"fn" : function(data){
						var str = '';
						if(data.status == "未结算") {
							str += '<a href="javascript:;" onclick="refund(' + data.id + ', this)">退款</a>';
						}
						str += '&nbsp;&nbsp;<a href="admin/v2/newGuessVersus/list.jsp?versusId=' + data.versusId + '" target="_blank">查看此竞猜</a>';
						return str;
					}}
				]);
			} else {
				showMsg(data.msg);
			}
		},
		"complete" : function() {
			var versusIds = new Array();
			var versusIdSpan = $("span.versus-id");
			versusIdSpan.each(function(){
				versusIds.push($(this).attr("data-versus-id"));
			});
			if(versusIds.length > 0) {
				loadData({
					"url" : "administration/v2/versusAdmin/getVersusNamesByVersusIds",
					"hideLoading" : true,
					"data" : {"versusIds[]" : versusIds},
					"success" : function(data){
						if(data.code == 100) {
							var list = data.result;
							for(var i=0; i<list.length; i++) {
								versusIdSpan.eq(i).html(list[i]);
							}
						} else {
							showMsg(data.msg);
						}
					}
				});
			}
			
			var versusItemIds = new Array();
			var versusItemIdSpan = $("span.versus-item-id");
			versusItemIdSpan.each(function(){
				versusItemIds.push($(this).attr("data-versus-item-id"));
			});
			if(versusItemIds.length > 0) {
				loadData({
					"url" : "administration/v2/versusAdmin/getVersusItemNamesByVersusItemIds",
					"hideLoading" : true,
					"data" : {"versusItemIds[]" : versusItemIds},
					"success" : function(data){
						if(data.code == 100) {
							var list = data.result;
							for(var i=0; i<list.length; i++) {
								versusItemIdSpan.eq(i).html(list[i]);
							}
						} else {
							showMsg(data.msg);
						}
					}
				});
			}
		},
		"redirectUrl" : "admin/login.jsp?msg=" + encodeURI("请先登录")
	});
};

//退款
var refund = function(betId, e) {
	if($("tr.betRefundTr" + betId).length > 0) {
		$("tr.betRefundTr" + betId).remove();
	} else {
		var str = '';
		str += '<tr align="center" class="contentTr betRefundTr betRefundTr' + betId + '"><td colspan="99" style="text-align:left;">';
		str += '<div style="margin-top:4px;margin-bottom:4px;">';
		str += '备注：<input type="text" id="description" placeholder="非必填">';
		str += '&nbsp;&nbsp;<input type="button" onclick="refund2(' + betId + ')" value="退款">';
		str += '&nbsp;&nbsp;<input type="button" value="关闭" onclick="$(this).parent().parent().parent().remove()">';
		str += '</div>';
		str += '</td></tr>';
		$("tr.betRefundTr").remove();
		$(e).parent().parent().after(str);
	}
};
var refund2 = function(betId) {
	var description = $.trim($("#description").val());
	loadData({
		"url" : "administration/v2/betAdmin/betRefund",
		"data" : {"description" : description, "betId" : betId},
		"success" : function(data) {
			showMsg(data.msg);
			if(data.code == 100) {
				
			}
		}
	});
};

$(document).ready(function(){query(20, 1);});
</script>
</head>

<body>
<%@include file="/admin/header.jsp"%>
<div id="middle">
<jsp:include page="/admin/left.jsp">
	<jsp:param name="p" value="下注列表"/>
</jsp:include>
	<div class="right">
	<div class="right_cont">
	<div class="breadcrumb">当前位置：
		<a href="javascript:;">网站管理</a><span class="divider">/</span>
		<a href="javascript:;">下注列表</a>
	</div>
	<div class="title_right"><strong>下注列表</strong><span style="color:red;font-size:18px;padding-left:200px;" id="showMsg"></span></div>
	<table class="table table-bordered table-striped table-hover">
		<tr>
			<td colspan="99" style="padding:3px;line-height:30px;">
				订单号：<input type="text" id="orderNumber" placeholder="输入订单号查询">
				&nbsp;&nbsp;状态：<%=com.yy.fast4j.Fast4jUtils.getSelectHtmlStr(com.yy.guess.po.enums.NewGuessBetStatus.class, "status", "width:70px;", null, new String[]{"全部"})%>
				&nbsp;&nbsp;<input type="button" value="查询" onclick="query(20, 1)">
			</td>
		</tr>
		<tr align="center">
			<td><strong>ID</strong></td>
			<td><strong>订单号</strong></td>
			<td><strong>用户ID</strong></td>
			<td><strong>用户名</strong></td>
			<td><strong>竞猜名</strong></td>
			<td><strong>竞猜项</strong></td>
			<td><strong>赔率</strong></td>
			<td><strong>下注额</strong></td>
			<td><strong>状态</strong></td>
			<td><strong>奖金</strong></td>
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