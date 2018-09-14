//用户余额
var userBalance = 0;

//项目id字符串，用“,”号分隔多个
/***********MatchVersus查询参数***********/
var sportId = new Array();
var type = "scroll"; //today、scroll、after、end
var date = null;//scroll为false时要用到
/***********MatchVersus查询参数***********/

//更新余额方法
var updateBalance = function(balance){
	userBalance = balance;
	$("#userBalanceDiv").html(balance.toFixed(2));
};

//显示运动项目选择框
var showSportSelect = function(){
	$("section.filter-matches").hide();
	$("section.filter-games").show();
	$("div.vux-popup-dialog-mfqea").show();
};

//关闭运动项目选择框
var closeSportSelect = function(){
	$("section.filter-games").hide();
	$("div.vux-popup-dialog-mfqea").hide();
	$("section.filter-matches").show();
};

//运动项目选择
var sportSelect = function(sportId, e){
	if(sportId > 0) {
		$("#selected-allSport").removeClass("selected-checker-item");
		$("div.vux-checker-item").removeClass("selected-all-games");
		$(e).toggleClass("selected-checker-item");
	} else { //选择了全部
		$("#selected-allSport").addClass("selected-checker-item");
		$("div.vux-checker-item").removeClass("selected-checker-item");
		$("div.vux-checker-item").addClass("selected-all-games");
	}
};
//确认选择
var sportSelectOk = function(){
	if($("#selected-allSport").hasClass("selected-checker-item")) {//全部
		sportId = new Array();
	} else {
		sportId = new Array();
		$("div.selected-checker-item").each(function(){
			sportId.push($(this).attr("data-sportId"));
		});
	}
	closeSportSelect();
	loadMatchVersus(pageSize, 1);
};

//加载MatchVersus
var loadMatchVersus = function(pageSize, pageNo){
	loadData({
		url : "getMatchVersus",
		data : {
			"sportId[]" : sportId,
			"type" : type,
			"date" : date,
			"pageSize" : pageSize,
			"pageNo" : pageNo
		},
		success : function(data){
			if(data.code == 100) {
				var list = data.result.list;
				var page = data.result.page;
				var playTypeList = data.result.playTypeList;
				var remainingTimeList = data.result.remainingTimeList;
				var str = '';
				if(list.length > 0) {
					for(var i=0; i<list.length; i++) {
						if(remainingTimeList != null) {
							str += getMatchVersusStr(list[i], playTypeList[i], remainingTimeList[i]);
						} else {
							str += getMatchVersusStr(list[i], playTypeList[i]);
						}
					}
				} else {
				}
				$("div.vux-tab-selected .match-number").html(page.rowCount);
				if(pageNo == 1) { //第一页清空
					mescroll.scrollTo(0); //滚动到顶部
					mescroll.setPageNum(1); //把页数重设为1
					$("#betListContainer").empty();
				}
				$("#betListContainer").append(str);
				
				mescroll.endSuccess(page.pageSize, page.next);//在这里关闭加载提示
				
				if(list.length > 0) {
					getBatchOddsAndPlayTypeStatus(); //加载赔率
				}
			} else {
				m_toast(data.msg);
				mescroll.endErr();//在这里关闭加载提示
			}
			
		},
		error : function(){
			mescroll.endErr();//在这里关闭加载提示
		}
	});
};

//加载运动项目
var loadAllSport = function(){
	loadData({
		url : "getAllSport",
		success : function(data){
			if(data.code == 100) {
				var list = data.result;
				var str = '';
				for(var i=0; i<list.length; i++) {
					var obj = list[i];
					str += '<div data-v-cd1e9d3c="" onclick="sportSelect(' + obj.id + ', this)" data-sportId="' + obj.id + '" class="vux-checker-item vux-tap-active default-checker-item selected-all-games">';
					str += '	<div data-v-cd1e9d3c="" style="height:2px;">&nbsp;</div>';
					str += '	<div data-v-cd1e9d3c="" class="games-info">';
					str += '		<div data-v-cd1e9d3c="" class="games-icon" style="background-image: url(\'' + obj.logoUrl + '\');"></div>';
					str += '		<div data-v-cd1e9d3c="">' + obj.name + '</div>';
					str += '	</div>';
					str += '	<div data-v-cd1e9d3c="" class="selected-checker-light"></div>';
					str += '</div>';
				}
				$("div.vux-checker-item").remove();
				$("div.checker-content").append(str);
			}
		}
	});
};

/**
 * 输入框
 * ok_callback按ok的回调函数
 */
var numberInput_ok_callback = null;
var numberInputShow = function(ok_callback) {
	numberInput_ok_callback = ok_callback;
	var str = '';
	str += '<div data-v-60a57f0c="" id="numberInputDiv" class="vux-popup-dialog bet-slip-pop vux-popup-bottom vux-popup-show vux-popup-dialog-73jz6" style="height:auto;bottom:0;">';
	str += '	<section data-v-60a57f0c="" class="bet-slip-pop-header">';
	str += '		<div data-v-60a57f0c="" class="slip-number">1</div>';
	str += '		<div data-v-60a57f0c="" class="remove-all">删除全部</div>';
	str += '		<div data-v-60a57f0c="" class="pop-header-text">';
	str += '			<div data-v-60a57f0c="" class="pop-header-balance">余额</div>';
	str += '			<div data-v-60a57f0c="" id="userBalanceDiv">' + userBalance.toFixed(2) + '</div>';
	str += '		</div>';
	str += '		<div data-v-60a57f0c="" class="pop-header-close" onclick="numberInputClose()"></div>';
	str += '	</section>';
	str += '	<section data-v-60a57f0c="" class="bet-slip-pop-body">';
	str += '		<div data-v-60a57f0c="" class="pop-scroll" id="vux-scroller-bomdf" style="touch-action: auto; user-select: none; -webkit-user-drag: none; -webkit-tap-highlight-color: rgba(0, 0, 0, 0); position: relative; overflow:auto;">';
	str += '			<div class="xs-container" style="transform-origin: 0px 0px 0px; transform: translate(0px, 0px) translateZ(0px);">';
	str += '				<div data-v-60a57f0c="" style="transform-origin: 0px 0px 0px; transform: translate(0px, 0px) scale(1) translateZ(0px);">';
	str += '					<div data-v-60a57f0c="" class="vux-checker-box odds-list">';
	str += '						<div data-v-60a57f0c="">';
	str += '							<div data-v-60a57f0c="" class="vux-checker-item odds-item vux-tap-active">';
	str += '								<div data-v-60a57f0c="" class="odds-list-line"></div>';
	str += '								<section data-v-60a57f0c="" class="remove-odds" style="visibility:hidden;">';
	str += '									<div data-v-60a57f0c="" class="remove-odds-icon"></div>';
	str += '								</section>';
	str += '								<section data-v-60a57f0c="" class="odds-item-match">';
	str += '									<div data-v-60a57f0c="" class="odds-name">SaveBuyBackPlz</div>';
	str += '									<div data-v-60a57f0c="">全场 获胜者</div>';
	str += '									<div data-v-60a57f0c="">Athletico Esport - VS - SaveBuyBackPlz</div>';
	str += '								</section>';
	str += '								<section data-v-60a57f0c="" class="odds-item-money">';
	str += '									<div data-v-60a57f0c="" class="item-money">';
	str += '										<div data-v-60a57f0c="" class="money-odds">@3.97</div>';
	str += '										<div data-v-60a57f0c="" class="stake-input stake-input-focus">';
	str += '											<span data-v-60a57f0c="" class="input-placeholder" id="inputValueSpan" data-value="">输入金额</span>';
	str += '										</div>';
	str += '									</div>';
	str += '									<div data-v-60a57f0c="" class="item-return">预计还返 <span data-v-60a57f0c="" class="return-amount">0</span></div>';
	str += '								</section>';
	str += '							</div>';
	str += '							<div data-v-90afda32="" data-v-60a57f0c="" class="base-Keyboard single-keyboard">';
	str += '								<div data-v-90afda32="" class="content">';
	str += '									<div data-v-90afda32="" class="content-number" onclick="numberInput(\'1\')"><div data-v-90afda32="">1</div></div>';
	str += '									<div data-v-90afda32="" class="content-number" onclick="numberInput(\'2\')"><div data-v-90afda32="">2</div></div>';
	str += '									<div data-v-90afda32="" class="content-number" onclick="numberInput(\'3\')"><div data-v-90afda32="">3</div></div>';
	str += '									<div data-v-90afda32="" class="content-number" onclick="numberInput(\'4\')"><div data-v-90afda32="">4</div></div>';
	str += '									<div data-v-90afda32="" class="content-number" onclick="numberInput(\'5\')"><div data-v-90afda32="">5</div></div>';
	str += '									<div data-v-90afda32="" class="content-number" onclick="numberInput(\'6\')"><div data-v-90afda32="">6</div></div>';
	str += '									<div data-v-90afda32="" class="content-number" onclick="numberInput(\'7\')"><div data-v-90afda32="">7</div></div>';
	str += '									<div data-v-90afda32="" class="content-number" onclick="numberInput(\'8\')"><div data-v-90afda32="">8</div></div>';
	str += '									<div data-v-90afda32="" class="content-number" onclick="numberInput(\'9\')"><div data-v-90afda32="">9</div></div>';
	str += '									<div data-v-90afda32="" class="content-number" onclick="numberInput(\'0\')"><div data-v-90afda32="">0</div></div>';
	str += '								</div>';
	str += '								<div data-v-90afda32="" class="content">';
	str += '									<div data-v-90afda32="" class="max-btn"><div data-v-90afda32="">最大投注</div></div>';
	str += '									<div data-v-90afda32="" class="del-btn" onclick="numberInput(\'x\')"><div data-v-90afda32="" class="del-icon"></div></div>';
	str += '									<div data-v-90afda32="" class="confirm-btn" onclick="numberInputOk()"><div data-v-90afda32="">确认</div></div>';
	str += '								</div>';
	str += '							</div>';
	str += '						</div>';
	str += '					</div>';
	str += '				</div>';
	str += '			</div>';
	str += '			<div class=" xs-fixed-container"></div>';
	str += '		</div>';
	str += '	</section>';
	str += '</div>';
	$("#numberInputDiv").remove();
	$("body").append(str);
};
var numberInputClose = function(){
	$("#numberInputDiv").remove();
};
var numberInputOk = function(){
	if(numberInput_ok_callback != null) {
		var inputValueSpan = $.trim($("#inputValueSpan").attr("data-value"));
		var amount = 0;
		if(!empty(inputValueSpan)) {
			amount = parseInt(inputValueSpan, 10);
		}
		numberInput_ok_callback(amount);
	}
};
//输入按钮
var numberInput = function(num){
	var e = $("#inputValueSpan");
	var value = e.attr("data-value");
	if("x" == num) {
		if(!empty(value)) {
			value = value.substring(0, value.length - 1);
		}
	} else {
		if(value.length < 6) {
			value = value + num;
		}
	}

	e.attr("data-value", value);

	if(!empty(value)) {
		var amount = parseInt(value, 10);
		if(amount > userBalance) {
			e.parent().addClass("stake-input-over");
		} else {
			e.parent().removeClass("stake-input-over");
		}
		e.attr("class", "input-text");
		e.html(value);
	} else {
		e.parent().removeClass("stake-input-over");
		e.attr("class", "input-placeholder");
		e.html("输入金额");
	}
};


//滚动条变换
var tabBarChange = function(index, ts) {
	var e = $("div.vux-tab-ink-bar-transition-backward");
	$("div.vux-tab-item").removeClass("vux-tab-selected");
	$("div.vux-tab-item").css("color", "rgb(186, 206, 241)");

	$(ts).addClass("vux-tab-selected");
	$(ts).css("color", "rgb(255, 255, 255)");
	if(1 == index) {
		type = "today";
		e.css("left", "0%");
		e.css("right", "75%");
	} else if(2 == index) {
		type = "scroll";
		e.css("left", "25%");
		e.css("right", "50%");
	} else if(3 == index) {
		type = "after";
		e.css("left", "50%");
		e.css("right", "25%");
	} else if(4 == index) {
		type = "end";
		e.css("left", "75%");
		e.css("right", "0%");
	}
	loadMatchVersus(pageSize, 1);
};

//对阵str
var getMatchVersusStr = function(versus, playType, remainingTime){
	var str = '';
	str += '<div data-v-18da170e="" data-v-bf66ef20="" data-versusId="' + versus.id + '" class="home-match-card"' + (playType == null ? ' style="height:125px !important;"' : '') + '>';
	str += '	<section data-v-18da170e="" class="card-header">';
	str += '		<img data-v-18da170e="" src="' + versus.matchLogoUrl + '" width="20px">';
	str += '		<div data-v-18da170e="" class="tournament-name">' + versus.sportName + '&nbsp;' + versus.matchName + '&nbsp;' + versus.name + '</div>';
	str += '		<div data-v-18da170e="" class="match-round">&nbsp;/&nbsp;bo' + versus.boCount + '</div>';
	str += '		<div data-v-18da170e="" class="play-count" style="display:none;">+4</div>';
	str += '	</section>';
	str += '	<section data-v-18da170e="" class="card-body">';
	str += '		<div data-v-18da170e="" class="card-body-team"><img data-v-18da170e="" src="' + versus.leftTeamLogoUrl + '" class="team-logo"></div>';
	str += '		<div data-v-18da170e="" class="card-body-center">';
	str += '			<img data-v-18da170e="" src="data:image/svg+xml;base64,PD94bWwgdmVyc2lvbj0iMS4wIiBlbmNvZGluZz0iVVRGLTgiPz4KPHN2ZyB3aWR0aD0iMjRweCIgaGVpZ2h0PSI3OHB4IiB2aWV3Qm94PSIwIDAgMjQgNzgiIHZlcnNpb249IjEuMSIgeG1sbnM9Imh0dHA6Ly93d3cudzMub3JnLzIwMDAvc3ZnIiB4bWxuczp4bGluaz0iaHR0cDovL3d3dy53My5vcmcvMTk5OS94bGluayI+CiAgICA8IS0tIEdlbmVyYXRvcjogU2tldGNoIDQ5LjMgKDUxMTY3KSAtIGh0dHA6Ly93d3cuYm9oZW1pYW5jb2RpbmcuY29tL3NrZXRjaCAtLT4KICAgIDx0aXRsZT7ljaHniYfljLrliIblibLlt6Y8L3RpdGxlPgogICAgPGRlc2M+Q3JlYXRlZCB3aXRoIFNrZXRjaC48L2Rlc2M+CiAgICA8ZGVmcz4KICAgICAgICA8cmFkaWFsR3JhZGllbnQgY3g9IjEwMCUiIGN5PSI1MCUiIGZ4PSIxMDAlIiBmeT0iNTAlIiByPSI5OC44MDMyODc2JSIgZ3JhZGllbnRUcmFuc2Zvcm09InRyYW5zbGF0ZSgxLjAwMDAwMCwwLjUwMDAwMCksc2NhbGUoMS4wMDAwMDAsMC4zMDAwMDApLHJvdGF0ZSgtMTc5Ljk5OTk5OCksc2NhbGUoMS4wMDAwMDAsMS42MzI1MTgpLHRyYW5zbGF0ZSgtMS4wMDAwMDAsLTAuNTAwMDAwKSIgaWQ9InJhZGlhbEdyYWRpZW50LTEiPgogICAgICAgICAgICA8c3RvcCBzdG9wLWNvbG9yPSIjMEMxMjFGIiBvZmZzZXQ9IjAlIj48L3N0b3A+CiAgICAgICAgICAgIDxzdG9wIHN0b3AtY29sb3I9IiMxQTI1MzgiIHN0b3Atb3BhY2l0eT0iMCIgb2Zmc2V0PSIxMDAlIj48L3N0b3A+CiAgICAgICAgPC9yYWRpYWxHcmFkaWVudD4KICAgIDwvZGVmcz4KICAgIDxnIGlkPSLpm7fnq57mioAyLjAtY29weSIgc3Ryb2tlPSJub25lIiBzdHJva2Utd2lkdGg9IjEiIGZpbGw9Im5vbmUiIGZpbGwtcnVsZT0iZXZlbm9kZCIgZmlsbC1vcGFjaXR5PSIwLjMiPgogICAgICAgIDxnIGlkPSJpY29u5YiH5Zu+IiB0cmFuc2Zvcm09InRyYW5zbGF0ZSgtMTEyLjAwMDAwMCwgLTE5NjUuMDAwMDAwKSIgZmlsbD0idXJsKCNyYWRpYWxHcmFkaWVudC0xKSI+CiAgICAgICAgICAgIDxyZWN0IGlkPSLljaHniYfljLrliIblibLlt6YiIHg9IjExMiIgeT0iMTk2NCIgd2lkdGg9IjI0IiBoZWlnaHQ9IjgwIj48L3JlY3Q+CiAgICAgICAgPC9nPgogICAgPC9nPgo8L3N2Zz4=" class="center-left">';
	
	if("today" == type) { //今天
		if("未开始" == versus.status) {
			str += '			<div data-v-18da170e="" class="start-time">' + versus.startTime.substring(10).substring(0, 6) + '</div>';
		} else {
			str += '			<div data-v-18da170e="" class="team-score"><div data-v-18da170e="">' + versus.leftTeamScore + '</div><div data-v-18da170e="" class="dash-symbol">-</div><div data-v-18da170e="">' + versus.rightTeamScore + '</div></div>';
		}
	} else if("scroll" == type) { //滚动
		if("未开始" == versus.status) {
			str += '			<div data-v-18da170e="" class="start-time"><div data-v-18da170e="" class="ready-start">即将开始</div><div data-v-18da170e="">' + getRemainingTime(remainingTime) + '</div></div>';
		} else {
			str += '			<div data-v-18da170e="" class="team-score"><div data-v-18da170e="">' + versus.leftTeamScore + '</div><div data-v-18da170e="" class="dash-symbol">-</div><div data-v-18da170e="">' + versus.rightTeamScore + '</div></div>';
		}
	} else if("after" == type) { //赛前(明天)
		str += '			<div data-v-18da170e="" class="start-time">' + versus.startTime.substring(10).substring(0, 6) + '</div>';
	} else if("end" == type) { //已结束
		
	}

	str += '			<img data-v-18da170e="" src="data:image/svg+xml;base64,PD94bWwgdmVyc2lvbj0iMS4wIiBlbmNvZGluZz0iVVRGLTgiPz4KPHN2ZyB3aWR0aD0iMjRweCIgaGVpZ2h0PSI3OHB4IiB2aWV3Qm94PSIwIDAgMjQgNzgiIHZlcnNpb249IjEuMSIgeG1sbnM9Imh0dHA6Ly93d3cudzMub3JnLzIwMDAvc3ZnIiB4bWxuczp4bGluaz0iaHR0cDovL3d3dy53My5vcmcvMTk5OS94bGluayI+CiAgICA8IS0tIEdlbmVyYXRvcjogU2tldGNoIDQ5LjMgKDUxMTY3KSAtIGh0dHA6Ly93d3cuYm9oZW1pYW5jb2RpbmcuY29tL3NrZXRjaCAtLT4KICAgIDx0aXRsZT7ljaHniYfljLrliIblibLlj7M8L3RpdGxlPgogICAgPGRlc2M+Q3JlYXRlZCB3aXRoIFNrZXRjaC48L2Rlc2M+CiAgICA8ZGVmcz4KICAgICAgICA8cmFkaWFsR3JhZGllbnQgY3g9IjEwMCUiIGN5PSI1MCUiIGZ4PSIxMDAlIiBmeT0iNTAlIiByPSI5OC44MDMyODc2JSIgZ3JhZGllbnRUcmFuc2Zvcm09InRyYW5zbGF0ZSgxLjAwMDAwMCwwLjUwMDAwMCksc2NhbGUoMS4wMDAwMDAsMC4zMDAwMDApLHJvdGF0ZSgtMTc5Ljk5OTk5OCksc2NhbGUoMS4wMDAwMDAsMS42MzI1MTgpLHRyYW5zbGF0ZSgtMS4wMDAwMDAsLTAuNTAwMDAwKSIgaWQ9InJhZGlhbEdyYWRpZW50LTEiPgogICAgICAgICAgICA8c3RvcCBzdG9wLWNvbG9yPSIjMEMxMjFGIiBvZmZzZXQ9IjAlIj48L3N0b3A+CiAgICAgICAgICAgIDxzdG9wIHN0b3AtY29sb3I9IiMxQTI1MzgiIHN0b3Atb3BhY2l0eT0iMCIgb2Zmc2V0PSIxMDAlIj48L3N0b3A+CiAgICAgICAgPC9yYWRpYWxHcmFkaWVudD4KICAgIDwvZGVmcz4KICAgIDxnIGlkPSLpm7fnq57mioAyLjAtY29weSIgc3Ryb2tlPSJub25lIiBzdHJva2Utd2lkdGg9IjEiIGZpbGw9Im5vbmUiIGZpbGwtcnVsZT0iZXZlbm9kZCIgZmlsbC1vcGFjaXR5PSIwLjMiPgogICAgICAgIDxnIGlkPSJpY29u5YiH5Zu+IiB0cmFuc2Zvcm09InRyYW5zbGF0ZSgtMTc2LjAwMDAwMCwgLTE5NjUuMDAwMDAwKSIgZmlsbD0idXJsKCNyYWRpYWxHcmFkaWVudC0xKSI+CiAgICAgICAgICAgIDxyZWN0IGlkPSLljaHniYfljLrliIblibLlj7MiIHRyYW5zZm9ybT0idHJhbnNsYXRlKDE4OC4wMDAwMDAsIDIwMDQuMDAwMDAwKSBzY2FsZSgtMSwgMSkgdHJhbnNsYXRlKC0xODguMDAwMDAwLCAtMjAwNC4wMDAwMDApICIgeD0iMTc2IiB5PSIxOTY0IiB3aWR0aD0iMjQiIGhlaWdodD0iODAiPjwvcmVjdD4KICAgICAgICA8L2c+CiAgICA8L2c+Cjwvc3ZnPg==" class="center-right">';
	str += '		</div>';
	str += '		<div data-v-18da170e="" class="card-body-team"><img data-v-18da170e="" src="' + versus.rightTeamLogoUrl + '" class="team-logo"></div>';
	str += '	</section>';
	
	if(playType != null) {
		str += '	<div data-v-8d7d541a="" data-v-18da170e="" class="odds-group-title">';
		str += '		<div data-v-8d7d541a="" class="empty-badge">&nbsp;</div>';
		str += '		<div data-v-8d7d541a="" class="title">' + playType.name + '</div>';
		str += '	</div>';
		str += '	<section data-v-18da170e="" class="card-footer" data-playTypeId="' + playType.id + '">';
		str += '		<div data-v-18da170e="" class="card-odds-btn">';
		str += '			<div data-v-ba6efc5c="" data-v-18da170e="" class="home-match-card-button' + (isVersusLock(versus, playType) ? ' btn-locked' : '') + '">';
		str += '				<div data-v-ba6efc5c="" class="button-dark-border">';
		str += '					<div data-v-ba6efc5c="" class="button-content">';
		str += '						<div data-v-ba6efc5c="" class="button-name">' + playType.leftGuessName + '</div>';
		str += '						<div data-v-ba6efc5c="" class="button-odds-content">';
		str += '							<div data-v-ba6efc5c="" class="odds-rising-icon"></div>';
		str += '							<div data-v-ba6efc5c="" class="btn-odds"><span data-v-ba6efc5c="" class="leftOdds"></span></div>';
		str += '							<div data-v-ba6efc5c="" class="odds-dropping-icon"></div>';
		str += '						</div>';
		str += '					</div>';
		str += '				</div>';
		str += '			</div>';
		str += '		</div>';
		str += '		<div data-v-18da170e="" class="match-status">';
		
		if("未开始" == versus.status) {
			str += '			<div data-v-18da170e="" class="match-is-early">';
			str += '				<div data-v-18da170e="" class="status-icon early-icon"></div>';
			str += '				<div data-v-18da170e="" class="match-status-text">' + versus.status + '</div>';
			str += '			</div>';
		} else if("进行中" == versus.status) {
			str += '			<div data-v-18da170e="" class="match-is-live">';
			str += '				<div data-v-18da170e="" class="status-icon live-icon"></div>';
			str += '				<div data-v-18da170e="" class="match-status-text">' + versus.status + '</div>';
			str += '			</div>';
		} else {
			str += '			<div data-v-18da170e="" class="match-is-live">';
			str += '				<div data-v-18da170e="" class="status-icon early-icon"></div>';
			str += '				<div data-v-18da170e="" class="match-status-text" style="color:green;">' + versus.status + '</div>';
			str += '			</div>';
		}
		
		str += '		</div>';
		str += '		<div data-v-18da170e="" class="card-odds-btn">';
		str += '			<div data-v-ba6efc5c="" data-v-18da170e="" class="home-match-card-button' + (isVersusLock(versus, playType) ? ' btn-locked' : '') + '">';
		str += '				<div data-v-ba6efc5c="" class="button-dark-border">';
		str += '					<div data-v-ba6efc5c="" class="button-content">';
		str += '						<div data-v-ba6efc5c="" class="button-name">' + playType.rightGuessName + '</div>';
		str += '						<div data-v-ba6efc5c="" class="button-odds-content">';
		str += '							<div data-v-ba6efc5c="" class="odds-rising-icon"></div>';
		str += '							<div data-v-ba6efc5c="" class="btn-odds"><span data-v-ba6efc5c="" class="rightOdds"></span></div>';
		str += '							<div data-v-ba6efc5c="" class="odds-dropping-icon"></div>';
		str += '						</div>';
		str += '					</div>';
		str += '				</div>';
		str += '			</div>';
		str += '		</div>';
		str += '	</section>';
	}
	str += '</div>';
	return str;
};

//计算剩余时间
var getRemainingTime = function(remainingTime){
	if(remainingTime <= 0) {
		return "开盘中";
	} else if(remainingTime > 0 && remainingTime < 60000) { //小于一分(60秒)
		return parseInt(remainingTime / 1000) + "秒后";
	} else if(remainingTime >= 60000 && remainingTime < 3600000) { //大于一分小于1小时(60分)
		return parseInt(remainingTime / 1000 / 60) + "分钟后";
	} else if(remainingTime >= 3600000 && remainingTime < 86400000) { //大于1小时小于一天(24小时)
		return parseInt(remainingTime / 1000 / 60 / 60) + "小时后";
	} else { //大于等于一天
		return parseInt(remainingTime / 1000 / 60 / 60 / 24) + "天后";
	}
};

//计算versus是否不能投注
var isVersusLock = function(versus, playType) {
	if(playType.pause || !playType.guessStart) {
		return true;
	} else {
		if("已结束" == versus.status || "未比赛" == versus.status) {
			return true;
		} else {
			return false;
		}
	}
};

//加载赔率
var getBatchOddsAndPlayTypeStatus = function() {
	var playTypeId = new Array();
	$("section.card-footer").each(function(){
		playTypeId.push($(this).attr("data-playTypeId"));
	});
	if(playTypeId.length > 0) {
		loadData({
			"url" : "getBatchOddsAndPlayTypeStatus",
			"data" : {
				"playTypeId[]" : playTypeId
			},
			"success" : function(data){
				if(data.code == 100) {
					var resultList = data.result;
					$("section.card-footer").each(function(index){
						var result = resultList[index];
						var ts = $(this);
						if(result.status) {
							ts.find(".home-match-card-button").removeClass("btn-locked");
							
							var leftOdds = result.leftOdds;
							ts.find(".leftOdds").html(leftOdds.toFixed(2));

							var rightOdds = result.rightOdds;
							ts.find(".rightOdds").html(rightOdds.toFixed(2));
						} else {
							ts.find(".home-match-card-button").addClass("btn-locked");
							ts.find(".leftOdds").empty();
							ts.find(".rightOdds").empty();
						}
					});
				} else {
					m_toast(data.msg);
				}
			}
		});
	}
};
