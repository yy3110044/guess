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
//对阵暂停切换
var betPauseChange = function(versusId, e) {
	var betPause = $.trim($(e).val());
	loadData({
		"url" : "administration/v2/versusAdmin/versusBetPauseUpdate",
		"data" : {"versusId" : versusId, "betPause" : betPause},
		"success" : function(data) {
			showMsg(data.msg);
		}
	});
};

//删除对阵
var deleteVersus = function(versusId, e) {
	if(confirm("您确定删除此竞猜，以及此竞猜下的所有子竞猜？")) {
		loadData({
			"url" : "administration/v2/versusAdmin/versusDelete",
			"data" : {"versusId" : versusId},
			"success" : function(data) {
				showMsg(data.msg);
				if(data.code) {
					$(e).parent().parent().remove();
				}
			}
		});
	}
};

//查看竞猜缓存
var viewVersusCache = function(versusId, e) {
	if($("tr.cacheTrChild" + versusId).length > 0) {
		$("tr.cacheTrChild" + versusId).remove();
	} else {
		loadData({
			"url" : "administration/v2/versusAdmin/versusGetCache",
			"data" : {"versusId" : versusId},
			"success" : function(data) {
				if(data.code == 100) {
					var versus = data.result.versus;
					var versusItemList = data.result.versusItemList;
					if(versus == null) {
						showMsg("缓存中不存在此对象");
					} else {
						var str = '';
						str += '<tr align="center" class="contentTr cacheTr cacheTrChild' + versus.id + ' children' + versus.id + '">';
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
						str += '<td>' + (versus.betPause ? '暂停' : '开启') + '</td>';
						
						if(versus.status == "未开始") {
							str += '<td style="color:blue;">' + versus.status + '</td>';
						} else if(versus.status == "进行中") {
							str += '<td style="color:green;">' + versus.status + '</td>';
						} else if(versus.status == "已结束") {
							str += '<td style="color:red;">' + versus.status + '</td>';
						} else if(versus.status == "流局") {
							str += '<td style="color:black;">' + versus.status + '</td>';
						} else {
							str += '<td>' + versus.status + '</td>';
						}
						
						str += '<td style="font-weight:bold" data-resultItemId="' + versus.resultItemId + '" data-resultItemName="' + versus.resultItemName + '">' + (versus.resultItemId > 0 ? versus.resultItemName : "") + '</td>';
						str += '<td>' + versus.childVersusCount + '</td>';
						str += '<td>' + versus.createTime + '</td>';
						str += '<td>(缓存)&nbsp;<input type="button" value="关闭" onclick="$(this).parent().parent().remove()"></td>';
						str += '</tr>';
						$("tr.cacheTr").remove();
						$(e).parent().parent().after(str);
					}
				} else {
					showMsg(data.msg);
				}
			}
		});
	}
};

//查看竞猜项
var viewVersusItem = function(versusId, e) {
	if($("tr.versusItemChild" + versusId).length > 0) {
		$("tr.versusItemChild" + versusId).remove();
	} else {
		loadData({
			"url" : "administration/v2/versusAdmin/versusGet",
			"data" : {"versusId" : versusId},
			"success" : function(data) {
				if(data.code == 100) {
					var versus = data.result.versus;
					var versusItemList = data.result.versusItemList;
					var str = '';
					str += '<tr align="center" class="contentTr versusItemTr versusItemChild' + versus.id + ' versusItem' + versus.id + '"><td colspan="99" style="text-align:left;">';
					
					str += '<div class="itemDiv"><table class="table table-bordered table-striped table-hover my-table" style="text-align:center;width:auto;">';
					str += '<thead>';
					str += '<tr><th colspan="8">' + versus.name + '&nbsp;竞猜项详情</th><th><input type="button" value="关闭" onclick="$(this).parent().parent().parent().parent().parent().parent().parent().remove()"></th></tr>';
					str += '<tr><th>竞猜名</th><th>下注金额</th><th>赔率类型</th><th>固定赔率</th><th>变动赔率</th><th style="color:red;">实际赔率</th><th>变动下限</th><th>变动上限</th><th></th></tr>';
					str += '</thead>';
					str += '<tbody>';
					for(var i=0; i<versusItemList.length; i++) {
						var versusItem = versusItemList[i];
						str += '<tr>';
						str += '<td>' + versusItem.name + '</td>';
						str += '<td data-betAmount="' + versusItem.betAmount + '" class="bet-amount-td">¥' + versusItem.betAmount.toFixed(2) + '</td>';
						str += '<td><select style="width:55px;"><option value="true"' + (versusItem.fixedOdds?' selected="selected"':'') + '>固定</option><option value="false"' + (versusItem.fixedOdds?'':' selected="selected"') + '>变动</option></select></td>';
						str += '<td><input type="text" value="' + versusItem.odds + '" style="width:50px;"></td>';
						str += '<td data-betAmount="' + versusItem.betAmount + '" class="change-odds-td"></td>';
						str += '<td></td>';
						str += '<td><input type="text" value="' + versusItem.changeOddsMin + '" style="width:50px;"></td>';
						str += '<td><input type="text" value="' + versusItem.changeOddsMax + '" style="width:50px;"></td>';
						str += '<td><input type="button" value="修改"></td>';
						str += '</tr>';
					}
					str += '<tr>';
					str += '<td colspan="2"></td>';
					str += '<td><select style="width:55px;"><option value="" selected="selected">选择</option><option value="true">固定</option><option value="false">变动</option></select></td>';
					str += '<td colspan="3"></td>';
					str += '<td><input type="text" style="width:50px;"></td>';
					str += '<td><input type="text" style="width:50px;"></td>';
					str += '<td><input type="button" value="统一修改"></td>';
					str += '<tr>';
					str += '</tbody>';
					str += '</table></div>';

					str += '</td></tr>';
					$("tr.versusItemTr").remove();
					$(e).parent().parent().after(str);
					jisuanChangeOdds(versus.betAllAmount);//计算变动赔率
				} else {
					showMsg(data.msg);
				}
			}
		});
	}
};

//计算变动赔率
var jisuanChangeOdds = function(betAllAmount){
	var allHasBet = true;
	$("tr.versusItemTr .bet-amount-td").each(function(){
		var betAmount = parseFloat($(this).attr("data-betAmount"));
		if(betAmount <= 0) allHasBet = false;
	});
	$("tr.versusItemTr .change-odds-td").each(function(){
		if(allHasBet) {
			var betAmount = parseFloat($(this).attr("data-betAmount"));
			var odds = 1 / (betAmount / betAllAmount);
			$(this).html(odds.toFixed(2));
		} else {
			$(this).html("<span style=\"color:red;\">无</span>");
		}
	});
};

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
					str += '<td><select onchange="betPauseChange(' + versus.id + ', this)" style="width:55px;"><option' + (versus.betPause?'':' selected="selected"') + ' value="false">开启</option><option' + (versus.betPause?' selected="selected"':'') + ' value="true">暂停</option></select></td>';
					
					if(versus.status == "未开始") {
						str += '<td style="color:blue;">' + versus.status + '</td>';
					} else if(versus.status == "进行中") {
						str += '<td style="color:green;">' + versus.status + '</td>';
					} else if(versus.status == "已结束") {
						str += '<td style="color:red;">' + versus.status + '</td>';
					} else if(versus.status == "流局") {
						str += '<td style="color:black;">' + versus.status + '</td>';
					} else {
						str += '<td>' + versus.status + '</td>';
					}
					
					str += '<td style="font-weight:bold" data-resultItemId="' + versus.resultItemId + '" data-resultItemName="' + versus.resultItemName + '">' + (versus.resultItemId > 0 ? versus.resultItemName : "") + '</td>';
					str += '<td>' + versus.childVersusCount + '</td>';
					str += '<td>' + versus.createTime + '</td>';
					str += '<td>';
					str += '<a href="javascript:;" onclick="viewVersusItem(' + versus.id + ', this)">查看竞猜项</a>';
					str += '&nbsp;&nbsp;<a href="javascript:;">修改参数</a>';
					str += '&nbsp;&nbsp;<a href="javascript:;" onclick="viewVersusCache(' + versus.id + ', this)">查看缓存</a>';
					str += '&nbsp;&nbsp;<a href="admin/v2/newGuessVersus/add.jsp?superVersusId=' + versus.id + '" target="_blank">添加子竞猜</a>';
					str += '&nbsp;&nbsp;<a href="javascript:;">查看子竞猜</a>';
					str += '&nbsp;&nbsp;<a href="javascript:;" onclick="deleteVersus(' + versus.id + ', this)">删除</a>';
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
<style type="text/css">
div.itemDiv{margin-top:3px;margin-bottom:3px;}
.my-table th, .my-table td{padding-left:5px;padding-right:5px;}
</style>
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
			<td><strong>状态</strong></td>
			<td><strong>结果</strong></td>
			<td><strong>子竞猜数</strong></td>
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