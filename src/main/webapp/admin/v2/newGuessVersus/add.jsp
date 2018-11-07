<%@ page language="java" pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%><!DOCTYPE html>
<html>
<head>
<base href="${basePath}">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>添加竞猜 - <%=com.yy.guess.util.Util.getConfigCom(application).getWebTitle()%></title>
<link rel="stylesheet" href="admin/css/bootstrap.css">
<link rel="stylesheet" href="admin/css/css.css">
<script src="js/jquery.js"></script>
<script src="laydate/laydate.js"></script>
<script src="js/jquery.ui.widget.js"></script>
<script src="js/jquery.fileupload.js"></script>
<script src="js/jquery.iframe-transport.js"></script>
<script src="admin/js/common.js"></script>
<script>
var superVersusId = "${empty param.superVersusId ? '0' : param.superVersusId}";
var globalChangeOddsMin = 1.1;
var globalChangeOddsMax = 11;
var globalChangeOddsPlusRatio = 0.8;
var globalChangeOddsPlusValue = 2;
var globalChangeOddsPlusStrategy = 0;
var globalChangeOddsMinusRatio = 0.4;
var globalChangeOddsMinusValue = 1;
var globalChangeOddsMinusStrategy = 0;

$(document).ready(function(){
	addImageUploadEvent({
		"inputId" : "uploadImageInput",
		"url" : "<%=com.yy.guess.util.Util.getConfigCom(application).getUploadUrl()%>",
		"imgId" : "logoUrl",
		"defaultImgUrl" : "images/sportDefaultLogo.png"
	});
	
	if(!empty(superVersusId) && parseInt(superVersusId) > 0) {
		loadData({
			"url" : "administration/v2/versusAdmin/versusGet",
			"data" : {"versusId" : superVersusId},
			"success" : function(data) {
				if(data.code == 100) {
					if(data.result != null) {
						$("#fatherVersus").show();
						$("#fatherVersus span").html(data.result.versus.name);
					}
				}
			}
		});
	}
	
	loadData({
		"url" : "administration/v2/itemAdmin/getAll",
		"success" : function(data) {
			if(data.code == 100) {
				var list = data.result;
				var str = '<option value="">请选择类别</option>';
				for(var i=0; i<list.length; i++) {
					var obj = list[i];
					str += '<option value="' + obj.id + ';' + obj.name + ';' + (obj.logoUrl == null ? "" : obj.logoUrl) + '">' + obj.name + '</option>';
				}
				$("#item").html(str);
			}
		},
		"redirectUrl" : "admin/login.jsp?msg=" + encodeURI("请先登录")
	});
});

var itemChange = function() {
	var itemValue = $("#item").val();
	var vals = itemValue.split(";");
	var logoUrl = vals[2];
	if(empty(logoUrl)) {
		$("#logoUrl").attr("src", "images/sportDefaultLogo.png");
	} else {
		$("#logoUrl").attr("src", logoUrl);
	}
};

var jisuangailv = function() {
	var itemOddsInput = $("tr.versusItemTr .item-odds");
	var gailv = 0;
	itemOddsInput.each(function(){
		var ts = $(this);
		var val = $.trim(ts.val());
		if(!isNaN(val)) {
			var gl = 1 / parseFloat(val);
			if(!isNaN(gl)) {
				ts.parent().find(".gailv").html("概率：" + (gl * 100).toFixed(4) + "%");
			} else {
				ts.parent().find(".gailv").html("");
			}
			gailv += gl;
		} else {
			ts.parent().find(".gailv").html("");
		}
	});
	if(isNaN(gailv)) {
		$("#totalgailv").html("");
	} else {
		if(gailv > 0) {
			$("#totalgailv").html("总概率：" + (gailv * 100).toFixed(4) + "%");
		} else {
			$("#totalgailv").html("");
		}
	}
};

var strategyChange = function(type, e) {
	if("plus" == type) {
		var val = parseInt($.trim($(e).val()));
		if(val > 0) {
			$(e).next().val(globalChangeOddsPlusValue);
		} else if(val < 0) {
			$(e).next().val(globalChangeOddsPlusRatio);
		} else {
			$(e).next().val("0");
		}
	} else if("minus" == type) {
		var val = parseInt($.trim($(e).val()));
		if(val > 0) {
			$(e).next().val(globalChangeOddsMinusValue);
		} else if(val < 0) {
			$(e).next().val(globalChangeOddsMinusRatio);
		} else {
			$(e).next().val("0");
		}
	}
};

var globalChange = function(type, e) {
	if("useFixedOdds" == type) {
		$("select.item-useFixedOdds").val($(e).val());
	} else if("changeOddsPlusStrategy" == type) {
		$("select.item-changeOddsPlusStrategy").val($(e).val());
	} else if("changeOddsMinusStrategy" == type) {
		$("select.item-changeOddsMinusStrategy").val($(e).val());
	}
};

var globalInput = function(type, e) {
	$("input." + type).val($(e).val());
};

var versusItemAdd = function(e) {
	var str = '';
	
	if($("tr.versusItemTitleTr").length <= 0) {
		str += '<tr class="versusItemTitleTr">';
		str += '<td></td>';
		str += '<td><select style="width:80px;" onchange="globalChange(\'useFixedOdds\', this)"><option value="false">变动赔率</option><option value="true">固定赔率</option></select></td>';
		str += '<td></td>';
		
		str += '<td>';
		str += '<select style="width:73px;" onchange="globalChange(\'changeOddsPlusStrategy\', this)"><option value="0"' + (globalChangeOddsPlusStrategy==0?' selected="selected"':'') + '>不限制</option><option value="-1"' + (globalChangeOddsPlusStrategy<0?' selected="selected"':'') + '>百分比</option><option value="1"' + (globalChangeOddsPlusStrategy>0?' selected="selected"':'') + '>固定值</option></select>';
		if(globalChangeOddsPlusStrategy > 0) {
			str += '&nbsp;限制值:<input value="' + globalChangeOddsPlusValue + '" onclick="globalInput(\'item-limitPlusValue\', this)" onblur="globalInput(\'item-limitPlusValue\', this)" onkeyup="globalInput(\'item-limitPlusValue\', this)" onfocus="globalInput(\'item-limitPlusValue\', this)" type="text" style="width:50px;" placeholder="统一设置">';
		} else if(globalChangeOddsPlusStrategy < 0) {
			str += '&nbsp;限制值:<input value="' + globalChangeOddsPlusRatio + '" onclick="globalInput(\'item-limitPlusValue\', this)" onblur="globalInput(\'item-limitPlusValue\', this)" onkeyup="globalInput(\'item-limitPlusValue\', this)" onfocus="globalInput(\'item-limitPlusValue\', this)" type="text" style="width:50px;" placeholder="统一设置">';
		} else {
			str += '&nbsp;限制值:<input value="0" onclick="globalInput(\'item-limitPlusValue\', this)" onblur="globalInput(\'item-limitPlusValue\', this)" onkeyup="globalInput(\'item-limitPlusValue\', this)" onfocus="globalInput(\'item-limitPlusValue\', this)" type="text" style="width:50px;" placeholder="统一设置">';
		}
		str += '</td>';
		
		str += '<td>';
		str += '<select style="width:73px;" onchange="globalChange(\'changeOddsMinusStrategy\', this)"><option value="0"' + (globalChangeOddsMinusStrategy==0?' selected="selected"':'') + '>不限制</option><option value="-1"' + (globalChangeOddsMinusStrategy<0?' selected="selected"':'') + '>百分比</option><option value="1"' + (globalChangeOddsMinusStrategy>0?' selected="selected"':'') + '>固定值</option></select>';
		if(globalChangeOddsMinusStrategy > 0) {
			str += '&nbsp;限制值:<input value="' + globalChangeOddsMinusValue + '" onclick="globalInput(\'item-limitMinusValue\', this)" onblur="globalInput(\'item-limitMinusValue\', this)" onkeyup="globalInput(\'item-limitMinusValue\', this)" onfocus="globalInput(\'item-limitMinusValue\', this)" type="text" style="width:50px;" placeholder="统一设置">';
		} else if(globalChangeOddsMinusStrategy < 0) {
			str += '&nbsp;限制值:<input value="' + globalChangeOddsMinusRatio + '" onclick="globalInput(\'item-limitMinusValue\', this)" onblur="globalInput(\'item-limitMinusValue\', this)" onkeyup="globalInput(\'item-limitMinusValue\', this)" onfocus="globalInput(\'item-limitMinusValue\', this)" type="text" style="width:50px;" placeholder="统一设置">';
		} else {
			str += '&nbsp;限制值:<input value="0" onclick="globalInput(\'item-limitMinusValue\', this)" onblur="globalInput(\'item-limitMinusValue\', this)" onkeyup="globalInput(\'item-limitMinusValue\', this)" onfocus="globalInput(\'item-limitMinusValue\', this)" type="text" style="width:50px;" placeholder="统一设置">';
		}
		str += '</td>';
		
		str += '<td><input type="text" value="' + globalChangeOddsMin + '" onclick="globalInput(\'item-changeOddsMin\', this)" onblur="globalInput(\'item-changeOddsMin\', this)" onkeyup="globalInput(\'item-changeOddsMin\', this)" onfocus="globalInput(\'item-changeOddsMin\', this)" style="width:50px;" placeholder="统一设置"></td>';
		str += '<td><input type="text" value="' + globalChangeOddsMax + '" onclick="globalInput(\'item-changeOddsMax\', this)" onblur="globalInput(\'item-changeOddsMax\', this)" onkeyup="globalInput(\'item-changeOddsMax\', this)" onfocus="globalInput(\'item-changeOddsMax\', this)" style="width:50px;" placeholder="统一设置"></td>';
		str += '<td></td>';
		str += '</tr>';
	}
	
	str += '<tr class="versusItemTr">';
	str += '<td><input type="text" class="item-name" placeholder="名称"></td>';
	str += '<td><select class="item-useFixedOdds" style="width:80px;"><option value="false">变动赔率</option><option value="true">固定赔率</option></select></td>';
	
	str += '<td>';
	str += '<input onclick="jisuangailv()" onblur="jisuangailv()" onkeyup="jisuangailv()" onfocus="jisuangailv()" type="text" class="item-odds" placeholder="赔率" style="width:50px;">';
	str += '&nbsp;&nbsp;<span style="color:red;font-weight:bold" class="gailv"></span>';
	str += '</td>';
	
	str += '<td>';
	str += '<select onchange="strategyChange(\'plus\', this)" class="item-changeOddsPlusStrategy" style="width:73px;"><option value="0"' + (globalChangeOddsPlusStrategy==0?' selected="selected"':'') + '>不限制</option><option value="-1"' + (globalChangeOddsPlusStrategy<0?' selected="selected"':'') + '>百分比</option><option value="1"' + (globalChangeOddsPlusStrategy>0?' selected="selected"':'') + '>固定值</option></select>';
	if(globalChangeOddsPlusStrategy > 0) {
		str += '&nbsp;限制值:<input type="text" value="' + globalChangeOddsPlusValue + '" class="item-limitPlusValue" style="width:50px;" placeholder="限制值">';
	} else if(globalChangeOddsPlusStrategy < 0) {
		str += '&nbsp;限制值:<input type="text" value="' + globalChangeOddsPlusRatio + '" class="item-limitPlusValue" style="width:50px;" placeholder="限制值">';
	} else {
		str += '&nbsp;限制值:<input type="text" value="0" style="width:50px;" class="item-limitPlusValue" placeholder="限制值">';
	}
	str += '</td>';
	
	
	str += '<td>';
	str += '<select onchange="strategyChange(\'minus\', this)" class="item-changeOddsMinusStrategy" style="width:73px;"><option value="0"' + (globalChangeOddsMinusStrategy==0?' selected="selected"':'') + '>不限制</option><option value="-1"' + (globalChangeOddsMinusStrategy<0?' selected="selected"':'') + '>百分比</option><option value="1"' + (globalChangeOddsMinusStrategy>0?' selected="selected"':'') + '>固定值</option></select>';
	if(globalChangeOddsMinusStrategy > 0) {
		str += '&nbsp;限制值:<input type="text" value="' + globalChangeOddsMinusValue + '" class="item-limitMinusValue" style="width:50px;" placeholder="限制值">';
	} else if(globalChangeOddsMinusStrategy < 0) {
		str += '&nbsp;限制值:<input type="text" value="' + globalChangeOddsMinusRatio + '" class="item-limitMinusValue" style="width:50px;" placeholder="限制值">';
	} else {
		str += '&nbsp;限制值:<input type="text" value="0" style="width:50px;" class="item-limitMinusValue" placeholder="限制值">';
	}
	str += '</td>';
	
	str += '<td><input type="text" class="item-changeOddsMin" value="' + globalChangeOddsMin + '" placeholder="变动下限" style="width:50px;"></td>';
	str += '<td><input type="text" class="item-changeOddsMax" value="' + globalChangeOddsMax + '" placeholder="变动上限" style="width:50px;"></td>';
	str += '<td><span style="color:red;font-weight:bold;cursor:pointer;" title="删除" onclick="versusItemDelete(this)">✖</span></td>';
	str += '</tr>';
	$(e).parent().next().find("table").append(str);
};

var getVersusItemParam = function() {
	var itemDivs = $("tr.versusItemTr");
	if(itemDivs.length < 2) {
		return {"result" : false, "msg" : "必须至少添加两个竞猜项"};
	}
	var params = new Array();
	var result = true;
	var msg = "";
	itemDivs.each(function(){
		var ts = $(this);
		var name = $.trim(ts.find(".item-name").val());
		var useFixedOdds = $.trim(ts.find(".item-useFixedOdds").val());
		var odds = $.trim(ts.find(".item-odds").val());
		
		var changeOddsPlusStrategy = parseInt($.trim(ts.find(".item-changeOddsPlusStrategy").val()));
		var changeOddsPlusValue = 0;
		var changeOddsPlusRatio = 0
		if(changeOddsPlusStrategy != 0) {
			var limitValue = $.trim(ts.find(".item-limitPlusValue").val());
			if(empty(limitValue) || isNaN(limitValue)) {
				result = false;
				msg = "请正确输入限制值";
				return;
			}
			if(changeOddsPlusStrategy > 0) {
				changeOddsPlusValue = parseFloat(limitValue);
			} else if(changeOddsPlusStrategy < 0) {
				changeOddsPlusRatio = parseFloat(limitValue);
			}
		}

		var changeOddsMinusStrategy = parseInt($.trim(ts.find(".item-changeOddsMinusStrategy").val()));
		var changeOddsMinusValue = 0;
		var changeOddsMinusRatio = 0;
		if(changeOddsMinusStrategy != 0) {
			var limitValue = $.trim(ts.find(".item-limitMinusValue").val());
			if(empty(limitValue) || isNaN(limitValue)) {
				result = false;
				msg = "请正确输入限制值";
				return;
			}
			if(changeOddsMinusStrategy > 0) {
				changeOddsMinusValue = parseFloat(limitValue);
			} else if(changeOddsMinusStrategy < 0) {
				changeOddsMinusRatio = parseFloat(limitValue);
			}
		}
		
		var changeOddsMin = $.trim(ts.find(".item-changeOddsMin").val());
		var changeOddsMax = $.trim(ts.find(".item-changeOddsMax").val());
		if(empty(name)) {
			result = false;
			msg = "请输入竞猜项名";
			return;
		}
		if(empty(odds) || isNaN(odds) || empty(changeOddsMin) || isNaN(changeOddsMin) || empty(changeOddsMax) || isNaN(changeOddsMax)) {
			result = false;
			msg = "请正确输入赔率";
			return;
		}
		if(empty(useFixedOdds)) {
			result = false;
			msg = "请选择赔率类型";
			return;
		}
		params.push(name + "|" + odds + "|" + useFixedOdds + "|" + changeOddsPlusStrategy + "|" + changeOddsPlusValue + "|" + changeOddsPlusRatio + "|" + changeOddsMinusStrategy + "|" + changeOddsMinusValue + "|" + changeOddsMinusRatio + "|" + changeOddsMin + "|" + changeOddsMax);
	});
	if(result) {
		return {"result" : result, "msg" : msg, "params" : params};
	} else {
		return {"result" : result, "msg" : msg};
	}
};

var versusItemDelete = function(e) {
	$(e).parent().parent().remove();
	if($("tr.versusItemTr").length <= 0) {
		$("tr.versusItemTitleTr").remove();
	}
	jisuangailv();
	if($("tr.versusItemTr").length <= 0) {
		$("#totalgailv").html("");
	}
};

var add = function() {
	var name = $.trim($("#name").val());
	var item = $.trim($("#item").val());
	var logoUrl = $.trim($("#logoUrl").attr("src"));
	var returnRate = $.trim($("#returnRate").val());
	var betAmountMin = $.trim($("#betAmountMin").val());
	var betAmountMax = $.trim($("#betAmountMax").val());
	var startTime = $.trim($("#startTime").val());
	var versusItemParam = getVersusItemParam();
	if(empty(name)) {
		showMsg("竞猜名称不能为空");
		return;
	}
	if(empty(item)) {
		showMsg("请选择类别，如没有类别，请先添加");
		return;
	}
	if(empty(logoUrl)) {
		showMsg("请上传一个logo图");
		return;
	}
	if(empty(returnRate) || isNaN(returnRate)) {
		showMsg("请输入返还率，并且必须是一个数字");
		return;
	}
	if(empty(betAmountMin) || isNaN(betAmountMin) || empty(betAmountMax) || isNaN(betAmountMax)) {
		showMsg("请输入最高下注额和最低下注额，并且必须是一个数字");
		return;
	}
	if(!versusItemParam.result) {
		showMsg(versusItemParam.msg);
		return;
	}
	
	var itemArray = item.split(";");
	loadData({
		"url" : "administration/v2/versusAdmin/versusAdd",
		"data" : {
			"name" : name,
			"logoUrl" : logoUrl,
			"itemId" : itemArray[0],
			"itemName" : itemArray[1],
			"returnRate" : parseFloat(returnRate),
			"betAmountMin" : parseFloat(betAmountMin),
			"betAmountMax" : parseFloat(betAmountMax),
			"startTime" : startTime,
			"superVersusId" : superVersusId,
			"versusItems[]" : versusItemParam.params
		},
		"success" : function(data) {
			showMsg(data.msg);
			if(data.code == 100) {
				$("#name").val("");
				$("tr.versusItemTitleTr").remove();
				$("tr.versusItemTr").remove();
				$("#totalgailv").empty();
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
	<jsp:param name="p" value="添加竞猜"/>
</jsp:include>
	<div class="right">
	<div class="right_cont">
	<div class="breadcrumb">当前位置：
		<a href="javascript:;">网站管理</a><span class="divider">/</span>
		<a href="javascript:;">添加竞猜</a>
	</div>
	<div class="title_right"><strong>添加竞猜</strong><span style="color:red;font-size:18px;padding-left:200px;" id="showMsg"></span></div>
	<div style="width:100%; margin:auto">
	<table class="table table-bordered" style="width:100%;">
		<tr id="fatherVersus" style="display:none;">
			<td width="12%" align="right" nowrap="nowrap" bgcolor="#f1f1f1"></td>
			<td>添加&nbsp;<span style="font-weight:bold;"></span>&nbsp;的子竞猜</td>
		</tr>
		<tr>
			<td width="12%" align="right" nowrap="nowrap" bgcolor="#f1f1f1">竞猜名称：</td>
			<td><input type="text" id="name" style="width:400px;"></td>
		</tr>
		<tr>
			<td align="right" nowrap="nowrap" bgcolor="#f1f1f1">选择类别：</td>
			<td><select id="item" onchange="itemChange()"></select>&nbsp;&nbsp;<a href="admin/v2/newGuessItem/add.jsp" target="_blank">添加类别</a></td>
		</tr>
		<tr>
			<td align="right" nowrap="nowrap" bgcolor="#f1f1f1">logo图：</td>
			<td><input type="file" name="file" id="uploadImageInput"></td>
		</tr>
		<tr>
			<td align="right" nowrap="nowrap" bgcolor="#f1f1f1">赔率返还率：</td>
			<td><input type="text" id="returnRate" value="<%=com.yy.guess.util.Util.getConfigCom(application).getReturnRate()%>"></td>
		</tr>
		<tr>
			<td align="right" nowrap="nowrap" bgcolor="#f1f1f1">最低下注额：</td>
			<td><input type="text" id="betAmountMin" value="<%=com.yy.guess.util.Util.getConfigCom(application).getBetAmountMin()%>"></td>
		</tr>
		<tr>
			<td align="right" nowrap="nowrap" bgcolor="#f1f1f1">最高下注额：</td>
			<td><input type="text" id="betAmountMax" value="<%=com.yy.guess.util.Util.getConfigCom(application).getBetAmountMax()%>"></td>
		</tr>
		<tr>
			<td align="right" nowrap="nowrap" bgcolor="#f1f1f1">开始时间：</td>
			<td>
				<input type="text" id="startTime" placeholder="" class="laydate-icon" onclick="laydate({istime:true,format:'YYYY-MM-DD hh:mm:ss'});" style="width:140px;cursor:pointer;" readonly="readonly">
				&nbsp;
				<span style="color:red;">若设置了开始时间，只有在时间到的时候才会开启下注，不设置则立即开始</span>
			</td>
		</tr>
		<tr>
			<td align="right" nowrap="nowrap" bgcolor="#f1f1f1">竞猜项：</td>
			<td>
				<div style="margin-top:4px;">
					<a href="javascript:;" onclick="versusItemAdd(this)">添加</a>
					&nbsp;<span style="color:red;font-weight:bold;" id="totalgailv"></span>
				</div>
				<div style="margin-top:4px;text-align:center;">
					<table class="table table-bordered" style="width:100%;">
						<tr><th>名称</th><th>赔率类型</th><th>赔率</th><th>赔率增加限制</th><th>赔率减少限制</th><th>变动下限</th><th>变动上限</th><th></th></tr>
					</table>
				</div>
			</td>
		</tr>
		<tr>
			<td align="right" nowrap="nowrap" bgcolor="#f1f1f1"></td>
			<td colspan="3"><input type="button" value="添加" onclick="add()" class="btn btn-info" style="width:80px;"></td>
		</tr>
	</table>
	</div> 
	</div>     
	</div>
</div>
</body>
</html>