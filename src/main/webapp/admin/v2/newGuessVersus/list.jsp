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

//全局赔率切换
var globalUseFixedOddsChange = function(e) {
	var useFixedOdds = $(e).val();
	if(!empty(useFixedOdds)) {
		$("select.versus-item-use-fixed-odds").val(useFixedOdds);
		if("true" == useFixedOdds) {
			$("input.versus-item-fixed-odds").removeAttr("readonly");
			$("input.versus-item-change-odds").attr("readonly", "readonly");
		} else if("false" == useFixedOdds) {
			$("input.versus-item-fixed-odds").attr("readonly", "readonly");
			$("input.versus-item-change-odds").removeAttr("readonly");
		}
	}
}

//赔率切换
var useFixedOddsChange = function(e){
	var ts = $(e);
	var useFixedOdds = ts.val();
	if("true" == useFixedOdds) {
		ts.parent().next().find("input").removeAttr("readonly");
		ts.parent().next().next().find("input").attr("readonly", "readonly");
	} else if("false" == useFixedOdds) {
		ts.parent().next().next().find("input").removeAttr("readonly");
		ts.parent().next().find("input").attr("readonly", "readonly");
	}
};

//赔率变化策略切换
var changeOddsStrategyChange = function(e) {
	var ts = $(e);
	var strategy = parseInt(ts.val());
	if(strategy > 0) {
		var next = ts.next();
		next.val(next.attr("data-change-value"));
	} else if(strategy < 0) {
		var next = ts.next();
		next.val(next.attr("data-change-ratio"));
	} else {
		ts.next().val("0");
	}
};

//全局赔率变化策略切换
var globalChangeOddsStrategyChange = function(type, e) {
	var strategy = $(e).val();
	if(!empty(strategy)) {
		var select = $("select." + type);
		select.val(strategy);
		select.next().each(function(){
			if(parseInt(strategy) > 0) {
				$(this).val($(this).attr("data-change-value"));
			} else if(parseInt(strategy) < 0) {
				$(this).val($(this).attr("data-change-ratio"));
			} else {
				$(this).val("0");
			}
		});
	}
};

//统一更改
var changeOddsLimitInput = function(type, e) {
	var ts = $(e);
	var val = $.trim(ts.val());
	if(!empty(val)) {
		ts.val(val);
		$("input." + type).val(val);
	} else {
		ts.val("");
		$("input." + type).val(val);
	}
};

//修改竞猜项
var updateVersusItem = function(e) {
	var parent = $(e).parent().parent();
	
	var id = $.trim(parent.attr("data-versus-item-id"));
	var name = $.trim(parent.find(".versus-item-name").val());
	var useFixedOdds = $.trim(parent.find(".versus-item-use-fixed-odds").val());
	var fixedOdds = $.trim(parent.find(".versus-item-fixed-odds").val());
	var changeOdds = $.trim(parent.find(".versus-item-change-odds").val());
	var changeOddsPlusStrategy = $.trim(parent.find(".versus-item-change-odds-plus-strategy").val());
	var changeOddsPlusVal = $.trim(parent.find(".versus-item-change-odds-plus-val").val());
	var changeOddsMinusStrategy = $.trim(parent.find(".versus-item-change-odds-minus-strategy").val());
	var changeOddsMinusVal = $.trim(parent.find(".versus-item-change-odds-minus-val").val());
	var changeOddsMin = $.trim(parent.find(".versus-item-change-odds-min").val());
	var changeOddsMax = $.trim(parent.find(".versus-item-change-odds-max").val());

	if(empty(name)) {
		showMsg("名称不能为空");
		return;
	}

	if(empty(fixedOdds) || isNaN(fixedOdds) || empty(changeOdds) || isNaN(changeOdds)) {
		showMsg("赔率不能为空，并且必须是一个数字");
		return;
	}
	
	if(empty(changeOddsPlusVal) || isNaN(changeOddsPlusVal) || empty(changeOddsMinusVal) || isNaN(changeOddsMinusVal) || empty(changeOddsMin) || isNaN(changeOddsMin) || empty(changeOddsMax) || isNaN(changeOddsMax)) {
		showMsg("赔率限制不能为空，并且必须是一个数字");
		return;
	}
	loadData({
		"url" : "administration/v2/versusAdmin/versusItemUpdate",
		"data" : {
			"id" : id,
			"name" : name,
			"useFixedOdds" : useFixedOdds,
			"fixedOdds" : fixedOdds,
			"changeOdds" : changeOdds,
			"changeOddsPlusStrategy" : changeOddsPlusStrategy,
			"changeOddsPlusVal" : changeOddsPlusVal,
			"changeOddsMinusStrategy" : changeOddsMinusStrategy,
			"changeOddsMinusVal" : changeOddsMinusVal,
			"changeOddsMin" : changeOddsMin,
			"changeOddsMax" : changeOddsMax
		},
		"success" : function(data) {
			showMsg(data.msg);
			if(data.code == 100) {
				
			}
		}
	});
};

//统一修改竞猜项
var updateAllVersusItem = function(versusId) {
	var globalUseFixedOdds = $.trim($("#globalUseFixedOdds").val());
	var globalChangeOddsPlusStrategy = $.trim($("#globalChangeOddsPlusStrategy").val());
	var globalChangeOddsPlusVal = $.trim($("#globalChangeOddsPlusVal").val());
	var globalChangeOddsMinusStrategy = $.trim($("#globalChangeOddsMinusStrategy").val());
	var globalChangeOddsMinusVal = $.trim($("#globalChangeOddsMinusVal").val());
	var globalChangeOddsMin = $.trim($("#globalChangeOddsMin").val());
	var globalChangeOddsMax = $.trim($("#globalChangeOddsMax").val());

	var useFixedOdds = empty(globalUseFixedOdds) ? null : globalUseFixedOdds;
	var changeOddsPlusStrategy = empty(globalChangeOddsPlusStrategy) ? null : globalChangeOddsPlusStrategy;
	var changeOddsPlusVal = (empty(globalChangeOddsPlusVal) || isNaN(globalChangeOddsPlusVal)) ? null : globalChangeOddsPlusVal;
	var changeOddsMinusStrategy = empty(globalChangeOddsMinusStrategy) ? null : globalChangeOddsMinusStrategy;
	var changeOddsMinusVal = (empty(globalChangeOddsMinusVal) || isNaN(globalChangeOddsMinusVal)) ? null : globalChangeOddsMinusVal;
	var changeOddsMin = (empty(globalChangeOddsMin) || isNaN(globalChangeOddsMin)) ? null : globalChangeOddsMin;
	var changeOddsMax = (empty(globalChangeOddsMax) || isNaN(globalChangeOddsMax)) ? null : globalChangeOddsMax;

	loadData({
		"url" : "administration/v2/versusAdmin/versusItemUpdateByVersusId",
		"data" : {
			"versusId" : versusId,
			"useFixedOdds" : useFixedOdds,
			"changeOddsPlusStrategy" : changeOddsPlusStrategy,
			"changeOddsPlusVal" : changeOddsPlusVal,
			"changeOddsMinusStrategy" : changeOddsMinusStrategy,
			"changeOddsMinusVal" : changeOddsMinusVal,
			"changeOddsMin" : changeOddsMin,
			"changeOddsMax" : changeOddsMax
		},
		"success" : function(data) {
			showMsg(data.msg);
			if(data.code == 100) {
			}
		}
	});
};

/*
//删除竞猜项
var deleteVersusItem = function(e) {
	if(confirm("确认删除此竞猜项？")) {
		loadData({
			"url" : "administration/v2/versusAdmin/versusItemDelete",
			"data" : {"versusItemId" : $(e).parent().parent().attr("data-versus-item-id")},
			"success" : function(data) {
				showMsg(data.msg);
				if(data.code == 100) {
					$(e).parent().parent().remove();
				}
			}
		});
	}
};
*/

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
					str += '<tr><th colspan="11">' + versus.name + '&nbsp;竞猜项详情</th><th><input type="button" value="关闭" onclick="$(this).parent().parent().parent().parent().parent().parent().parent().remove()"></th></tr>';
					str += '<tr><th>竞猜名</th><th>下注金额</th><th>下注比例/公平赔率</th><th>赔率类型</th><th>固定赔率</th><th>变动赔率</th><th style="color:red;">实际赔率</th><th>赔率增加限制</th><th>赔率减少限制</th><th>变动下限</th><th>变动上限</th><th></th></tr>';
					str += '</thead>';
					str += '<tbody>';
					for(var i=0; i<versusItemList.length; i++) {
						var versusItem = versusItemList[i];
						str += '<tr data-versus-item-id="' + versusItem.id + '">';
						str += '<td><input type="text" class="versus-item-name" value="' + versusItem.name + '"></td>';
						str += '<td>¥' + versusItem.betAmount.toFixed(2) + '</td>';
						str += '<td data-bet-amount="' + versusItem.betAmount + '" class="betAmountTd"></td>';
						str += '<td><select class="versus-item-use-fixed-odds" style="width:55px;" onchange="useFixedOddsChange(this)"><option value="true"' + (versusItem.useFixedOdds?' selected="selected"':'') + '>固定</option><option value="false"' + (versusItem.useFixedOdds?'':' selected="selected"') + '>变动</option></select></td>';
						str += '<td><input class="versus-item-fixed-odds" type="text" value="' + versusItem.fixedOdds + '"' + (versusItem.useFixedOdds?'':' readonly="readonly"') + ' style="width:50px;"></td>';
						str += '<td><input class="versus-item-change-odds" type="text" value="' + versusItem.changeOdds + '"' + (versusItem.useFixedOdds?' readonly="readonly"':'') + ' style="width:50px;"></td>';
						str += '<td class="versus-item-real-odds"></td>';
						
						str += '<td>';
						str += '<select class="versus-item-change-odds-plus-strategy" style="width:73px;" onchange="changeOddsStrategyChange(this)"><option value="0"' + (versusItem.changeOddsPlusStrategy==0?' selected="selected"':'') + '>不限制</option><option value="-1"' + (versusItem.changeOddsPlusStrategy<0?' selected="selected"':'') + '>百分比</option><option value="1"' + (versusItem.changeOddsPlusStrategy>0?' selected="selected"':'') + '>固定值</option></select>';
						if(versusItem.changeOddsPlusStrategy > 0) {
							str += '&nbsp;<input class="versus-item-change-odds-plus-val" type="text" data-change-value="' + versusItem.changeOddsPlusValue + '" data-change-ratio="' + versusItem.changeOddsPlusRatio + '" value="' + versusItem.changeOddsPlusValue + '" style="width:50px;">';
						} else if(versusItem.changeOddsPlusStrategy < 0) {
							str += '&nbsp;<input class="versus-item-change-odds-plus-val" type="text" data-change-value="' + versusItem.changeOddsPlusValue + '" data-change-ratio="' + versusItem.changeOddsPlusRatio + '" value="' + versusItem.changeOddsPlusRatio + '" style="width:50px;">';
						} else {
							str += '&nbsp;<input class="versus-item-change-odds-plus-val" type="text" data-change-value="' + versusItem.changeOddsPlusValue + '" data-change-ratio="' + versusItem.changeOddsPlusRatio + '" value="0" style="width:50px;">';
						}
						str += '</td>';
						
						str += '<td>';
						str += '<select class="versus-item-change-odds-minus-strategy" style="width:73px;" onchange="changeOddsStrategyChange(this)"><option value="0"' + (versusItem.changeOddsMinusStrategy==0?' selected="selected"':'') + '>不限制</option><option value="-1"' + (versusItem.changeOddsMinusStrategy<0?' selected="selected"':'') + '>百分比</option><option value="1"' + (versusItem.changeOddsMinusStrategy>0?' selected="selected"':'') + '>固定值</option></select>';
						if(versusItem.changeOddsMinusStrategy > 0) {
							str += '&nbsp;<input class="versus-item-change-odds-minus-val" type="text" data-change-value="' + versusItem.changeOddsMinusValue + '" data-change-ratio="' + versusItem.changeOddsMinusRatio + '" value="' + versusItem.changeOddsMinusValue + '" style="width:50px;">';
						} else if(versusItem.changeOddsMinusStrategy < 0) {
							str += '&nbsp;<input class="versus-item-change-odds-minus-val" type="text" data-change-value="' + versusItem.changeOddsMinusValue + '" data-change-ratio="' + versusItem.changeOddsMinusRatio + '" value="' + versusItem.changeOddsMinusRatio + '" style="width:50px;">';
						} else {
							str += '&nbsp;<input class="versus-item-change-odds-minus-val" type="text" data-change-value="' + versusItem.changeOddsMinusValue + '" data-change-ratio="' + versusItem.changeOddsMinusRatio + '" value="0" style="width:50px;">';
						}
						str += '</td>';
						
						str += '<td><input type="text" class="versus-item-change-odds-min" value="' + versusItem.changeOddsMin + '" style="width:50px;"></td>';
						str += '<td><input type="text" class="versus-item-change-odds-max" value="' + versusItem.changeOddsMax + '" style="width:50px;"></td>';
						str += '<td><input type="button" onclick="updateVersusItem(this)" value="修改" style="width:70px;"></td>';
						str += '</tr>';
					}
					str += '<tr>';
					str += '<td colspan="3"></td>';
					str += '<td><select id="globalUseFixedOdds" style="width:55px;" onchange="globalUseFixedOddsChange(this)"><option value="" selected="selected">选择</option><option value="true">固定</option><option value="false">变动</option></select></td>';
					str += '<td colspan="3"></td>';
					str += '<td><select id="globalChangeOddsPlusStrategy" style="width:73px;" onchange="globalChangeOddsStrategyChange(\'versus-item-change-odds-plus-strategy\', this)"><option value="" selected="selected">选择</option><option value="0">不限制</option><option value="-1">百分比</option><option value="1">固定值</option></select>&nbsp;<input id="globalChangeOddsPlusVal" onclick="changeOddsLimitInput(\'versus-item-change-odds-plus-val\', this)" onblur="changeOddsLimitInput(\'versus-item-change-odds-plus-val\', this)" onkeyup="changeOddsLimitInput(\'versus-item-change-odds-plus-val\', this)" onfocus="changeOddsLimitInput(\'versus-item-change-odds-plus-val\', this)" type="text" style="width:50px;" placeholder="统一修改"></td>';
					str += '<td><select id="globalChangeOddsMinusStrategy" style="width:73px;" onchange="globalChangeOddsStrategyChange(\'versus-item-change-odds-minus-strategy\', this)"><option value="" selected="selected">选择</option><option value="0">不限制</option><option value="-1">百分比</option><option value="1">固定值</option></select>&nbsp;<input id="globalChangeOddsMinusVal" onclick="changeOddsLimitInput(\'versus-item-change-odds-minus-val\', this)" onblur="changeOddsLimitInput(\'versus-item-change-odds-minus-val\', this)" onkeyup="changeOddsLimitInput(\'versus-item-change-odds-minus-val\', this)" onfocus="changeOddsLimitInput(\'versus-item-change-odds-minus-val\', this)" type="text" style="width:50px;" placeholder="统一修改"></td>';
					str += '<td><input id="globalChangeOddsMin" type="text" onclick="changeOddsLimitInput(\'versus-item-change-odds-min\', this)" onblur="changeOddsLimitInput(\'versus-item-change-odds-min\', this)" onkeyup="changeOddsLimitInput(\'versus-item-change-odds-min\', this)" onfocus="changeOddsLimitInput(\'versus-item-change-odds-min\', this)" style="width:50px;" placeholder="统一修改"></td>';
					str += '<td><input id="globalChangeOddsMax" type="text" onclick="changeOddsLimitInput(\'versus-item-change-odds-max\', this)" onblur="changeOddsLimitInput(\'versus-item-change-odds-max\', this)" onkeyup="changeOddsLimitInput(\'versus-item-change-odds-max\', this)" onfocus="changeOddsLimitInput(\'versus-item-change-odds-max\', this)" style="width:50px;" placeholder="统一修改"></td>';
					str += '<td><input type="button" onclick="updateAllVersusItem(' + versus.id + ')" value="统一修改" style="width:70px;"></td>';
					str += '<tr>';
					str += '</tbody>';
					str += '</table></div>';

					str += '</td></tr>';
					$("tr.versusItemTr").remove();
					$(e).parent().parent().after(str);
					betAmountRateAndOdds(versus.betAllAmount);//计算下注比例以及公平赔率
					loadRealOdds(); //加载实际赔率
				} else {
					showMsg(data.msg);
				}
			}
		});
	}
};

//加载实际赔率
var loadRealOdds = function() {
	var versusItemIds = new Array();
	$("td.versus-item-real-odds").each(function(){
		versusItemIds.push($(this).parent().attr("data-versus-item-id"));
	});
	if(versusItemIds.length > 0) {
		loadData({
			"url" : "administration/v2/versusAdmin/getRealOdds",
			"data" : {"versusItemIds[]" : versusItemIds},
			"success" : function(data) {
				if(data.code == 100) {
					var tds = $("td.versus-item-real-odds");
					var list = data.result;
					for(var i=0; i<list.length; i++) {
						var obj = list[i];
						tds.eq(i).html(obj.odds);
					}
				} else {
					showMsg(data.msg);
				}
			}
		});
	}
};

//计算下注比例以及公平赔率
var betAmountRateAndOdds = function(betAllAmount) {
	if(betAllAmount > 0) {
		$("td.betAmountTd").each(function(){
			var ts = $(this);
			var betAmount = parseFloat(ts.attr("data-bet-amount"));
			if(betAmount > 0) {
				var betRate = betAmount / betAllAmount;
				var odds = 1 / betRate;
				ts.html((betRate * 100).toFixed(2) + "%&nbsp;/&nbsp;" + odds.toFixed(2));
			}
		});
	}
};

//修改versus
var updateVersus = function(versusId, e) {
	if($("tr.versusUpdateTr" + versusId).length > 0) {
		$("tr.versusUpdateTr" + versusId).remove();
	} else {
		loadData({
			"url" : "administration/v2/versusAdmin/versusGet",
			"data" : {"versusId" : versusId},
			"success" : function(data) {
				if(data.code == 100) {
					var versus = data.result.versus;
					var versusItemList = data.result.versusItemList;
					var str = '';
					str += '<tr align="center" class="contentTr versusUpdateTr versusUpdateTr' + versus.id + '"><td colspan="99" style="text-align:left;">';
					str += '<div class="itemDiv"><table class="table table-bordered table-striped table-hover my-table" style="width:auto;">';
					str += '<tr><td style="text-align:right;">名称：</td><td style="text-align:left;"><input id="updateVersusName" type="text" value="' + versus.name + '" style="width:400px;"></td></tr>';
					str += '<tr><td style="text-align:right;">返还率：</td><td style="text-align:left;"><input id="updateVersusReturnRate" type="text" value="' + versus.returnRate + '" style="width:50px;">&nbsp;<span style="color:red;">竞猜项赔率乘以返还率就是最终赔率</span></td></tr>';
					str += '<tr><td style="text-align:right;">最低下注：</td><td style="text-align:left;"><input id="updateVersusBetAmountMin" type="text" value="' + versus.betAmountMin + '" style="width:50px;"></td></tr>';
					str += '<tr><td style="text-align:right;">最高下注：</td><td style="text-align:left;"><input id="updateVersusBetAmountMax" type="text" value="' + versus.betAmountMax + '" style="width:50px;"></td></tr>';
					str += '<tr><td style="text-align:right;">开始时间：</td><td style="text-align:left;"><input id="updateVersusStartTime" type="text" class="laydate-icon" value="' + versus.startTime + '" onclick="laydate({istime:true,format:\'YYYY-MM-DD hh:mm:ss\'});" style="width:140px;cursor:pointer;" readonly="readonly"></td></tr>';
					str += '<tr><td style="text-align:right;"></td><td style="text-align:left;"><input type="button" value="修改" onclick="updateVersus2(' + versus.id + ', this)">&nbsp;&nbsp;<input type="button" value="关闭" onclick="$(this).parent().parent().parent().parent().parent().parent().parent().remove()"></td></tr>';
					str += '</table></div>';
					str += '</td></tr>';
					$("tr.versusUpdateTr").remove();
					$(e).parent().parent().after(str);
				} else {
					showMsg(data.msg);
				}
			}
		});
	}
};
var updateVersus2 = function(versusId, e){
	var name = $.trim($("#updateVersusName").val());
	var returnRate = $.trim($("#updateVersusReturnRate").val());
	var betAmountMin = $.trim($("#updateVersusBetAmountMin").val());
	var betAmountMax = $.trim($("#updateVersusBetAmountMax").val());
	var startTime = $.trim($("#updateVersusStartTime").val());
	if(empty(name)) {
		showMsg("名称不能为空");
		return;
	}
	if(empty(returnRate) || isNaN(returnRate)) {
		showMsg("返还率必须是一个数字");
		return;
	}
	if(empty(betAmountMin) || isNaN(betAmountMin) || empty(betAmountMax) || isNaN(betAmountMax)) {
		showMsg("下注额必须是一个数字");
		return;
	}
	if(empty(startTime)) {
		showMsg("开始时间不能为空");
		return;
	}
	loadData({
		"url" : "administration/v2/versusAdmin/versusUpdate",
		"data" : {
			"versusId" : versusId,
			"name" : name,
			"returnRate" : returnRate,
			"betAmountMin" : betAmountMin,
			"betAmountMax" : betAmountMax,
			"startTime" : startTime
		},
		"success" : function(data) {
			showMsg(data.msg);
			if(data.code == 100) {
				var prev = $(e).parent().parent().parent().parent().parent().parent().parent().prev();
				prev.find(".versusName").html(name);
				prev.find(".versusReturnRate").html(returnRate);
				prev.find(".versusBetAmountMin").html(parseFloat(betAmountMin).toFixed(2));
				prev.find(".versusBetAmountMax").html(parseFloat(betAmountMax).toFixed(2));
				prev.find(".versusStartTime").html(startTime);
			}
		}
	});
};

//修改结果
var updateResult = function(versusId, e) {
	if($("tr.updateResultTr" + versusId).length > 0) {
		$("tr.updateResultTr" + versusId).remove();
	} else {
		loadData({
			"url" : "administration/v2/versusAdmin/versusGet",
			"data" : {"versusId" : versusId},
			"success" : function(data) {
				if(data.code == 100) {
					var versus = data.result.versus;
					var versusItemList = data.result.versusItemList;
					var str = '';
					str += '<tr align="center" class="contentTr updateResultTr updateResultTr' + versus.id + '"><td colspan="99" style="text-align:left;">';
					str += '<div class="itemDiv">';
					str += '<select id="updateResultSelect">';
					str += '<option value="">选择结果</option>';
					for(var i=0; i<versusItemList.length; i++) {
						var versusItem = versusItemList[i];
						str += '<option value="' + versusItem.id + '">├&nbsp;' + versusItem.name + '</option>';
					}
					str += '<option value="-1">├&nbsp;流局</option>';
					str += '</select>';
					str += '&nbsp;&nbsp;<input type="button" onclick="updateResult2(' + versusId + ')" value="修改">';
					str += '&nbsp;&nbsp;<input type="button" value="关闭" onclick="$(this).parent().parent().parent().remove()">';
					str += '</div>';
					str += '</td></tr>';
					$("tr.updateResultTr").remove();
					$(e).parent().parent().after(str);
				} else {
					showMsg(data.msg);
				}
			}
		});
	}
};
var updateResult2 = function(versusId) {
	var resultItemId = $.trim($("#updateResultSelect").val());
	if(!empty(resultItemId)) {
		var resultItemIdInt = parseInt(resultItemId);
		if(resultItemIdInt > 0) {
			if(!confirm("设置结果后，会立即结算此竞猜下的所有订单，确认设置吗？")) {
				return;
			}
		} else if(resultItemIdInt < 0) {
			if(!confirm("设置为流局，会将此竞猜下的所有订单，退款给用户，确认设置吗？")) {
				return;
			}
		}
		
	} else {
		showMsg("请选择结果");
	}
}

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
					str += '<td class="versusName">' + versus.name + '</td>';
					str += '<td><a href="' + versus.logoUrl + '" target="_blank"><img src="' + versus.logoUrl + '" style="width:30px;height:30px;"></a></td>';
					str += '<td data-itemId=' + versus.itemId + '>' + versus.itemName + '</td>';
					str += '<td class="versusReturnRate">' + versus.returnRate + '</td>';
					str += '<td class="versusBetAmountMin">' + versus.betAmountMin.toFixed(2) + '</td>';
					str += '<td class="versusBetAmountMax">' + versus.betAmountMax.toFixed(2) + '</td>';
					str += '<td>¥' + versus.betAllAmount.toFixed(2) + '</td>';
					str += '<td class="versusStartTime">' + versus.startTime + '</td>';
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
					str += '&nbsp;&nbsp;<a href="javascript:;" onclick="updateVersus(' + versus.id + ', this)">修改参数</a>';
					str += '&nbsp;&nbsp;<a href="javascript:;" onclick="updateResult(' + versus.id + ', this)">修改结果</a>';
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
			<td><strong>最低下注</strong></td>
			<td><strong>最高下注</strong></td>
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