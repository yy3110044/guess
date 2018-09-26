//用户余额
var userBalance = 0;
var isLogin = false; //是否登陆

//项目id字符串，用“,”号分隔多个
/***********MatchVersus查询参数***********/
var oldLeftOddsArray = new Array();//左方赔率数组
var oldRightOddsArray = new Array();//右方赔率数组
var pageSize = 20;
var sportId = new Array();
var type = "scroll"; //today、scroll、after、end
var date = null;//scroll为false时要用到

var originalIntervalSecond = 60;
var intervalSecond = 60;

var mescroll = null;//scroll对象
/***********MatchVersus查询参数***********/

//初始化数据方法
var initData = function(versusType, seconds){
	if(seconds != null) {
		originalIntervalSecond = seconds;
		intervalSecond = seconds;
	}

	$("#vux-scroller-60yre").height($(window).height() - 132);//设置页面高度

	oldLeftOddsArray = new Array();
	oldRightOddsArray = new Array();
	pageSize = 20;
	sportId = new Array();
	type = "scroll";
	date = null;

	loadAllSport();//加载项目
	loadUserBalance(); //加载用户余额
	getUnreadUserNoticeCount(); //加载未读信息数量
	
	if(versusType == "today") {
		tabBarChange(1, $(".vux-tab-container .vux-tab-item").eq(0)[0]);
	} else if("scroll" == versusType) {
		tabBarChange(2, $(".vux-tab-container .vux-tab-item").eq(1)[0]);
	} else if("after" == versusType) {
		tabBarChange(3, $(".vux-tab-container .vux-tab-item").eq(2)[0]);
	} else if("end" == versusType) {
		tabBarChange(4, $(".vux-tab-container .vux-tab-item").eq(3)[0]);
	} else {
		tabBarChange(2, $(".vux-tab-container .vux-tab-item").eq(1)[0]);//默认加载scroll
	}

	setInterval("loadMatchVersusInterval()", 1000); //间隔加载对阵
	setInterval("loadOtherData()", seconds * 1000); //间隔加载其它数据
	
	//初始化scroll对象
	mescroll = new MeScroll("vux-scroller-60yre", {
		"down" : {
			"use" : true,
			"auto" : false, //是否在初始化完毕之后自动执行下拉回调callback; 默认true
			"callback" : function(){
				loadMatchVersus(pageSize, 1, true);
			}
		},
		"up" : {
			"use" : true,
			"auto" : false, //是否在初始化时以上拉加载的方式自动加载第一页数据; 默认false
			"isBounce" : false, //此处禁止ios回弹
			"htmlNodata" : '<div data-v-bf66ef20="" class="empty-list">暂时没有更多比赛了</div>',
			"onScroll" : function(){
				intervalSecond = originalIntervalSecond;
			},
			"callback" : function(page) {
				loadMatchVersus(pageSize, page.num + 1, true);
			}
		}
	});
};

//间隔加载对阵方法
var loadMatchVersusInterval = function() {
	if($("#numberInputDiv").length > 0) { //如果打开了输入框，则不计时
		return;
	}
	if(intervalSecond > 0) {
		intervalSecond --;
	} else {
		loadMatchVersus(pageSize, 1, true);
		intervalSecond = originalIntervalSecond;
	}
};

//间隔加载其它数据(赔率)的方法
var loadOtherData = function(){
	getBatchOddsAndPlayTypeStatus();
	getUnreadUserNoticeCount();
};

//公告定时切换方法
var systemNoticeChangeId = null;
var currentNotice = 0;
var systemNoticeChange = function(){
	if(systemNoticeChangeId != null) {
		clearInterval(systemNoticeChangeId);
	}
	currentNotice = 0;
	systemNoticeChangeId = setInterval("systemNoticeChange2()", 10000);
};
var systemNoticeChange2 = function(){
	var length = $(".content-hearer .vux-marquee-box li").length;
	if(length > 1) {
		var step = $(".content-hearer .vux-marquee-box li").height();
		currentNotice ++;
		if(currentNotice >= length) {
			currentNotice = 0;
		}
		$(".content-hearer .vux-marquee-box").attr("style", "transform: translate3d(0px, " + (0 - (currentNotice * step)) + "px, 0px); transition: transform 300ms ease 0s;");
	}
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
	loadMatchVersus(pageSize, 1, false);
};

//加载MatchVersus
var loadMatchVersus = function(pageSize, pageNo, hideLoading){
	loadData({
		"url" : "getMatchVersus",
		"data" : {
			"sportId[]" : sportId,
			"type" : type,
			"date" : date,
			"pageSize" : pageSize,
			"pageNo" : pageNo
		},
		"hideLoading" : hideLoading,
		"success" : function(data){
			if(data.code == 100) {
				var list = data.result.list;
				var page = data.result.page;
				var playTypeList = data.result.playTypeList;
				var remainingTimeList = data.result.remainingTimeList;
				var str = '';
				if("end" == type) {
					if(list.length > 0) {
						for(var i=0; i<list.length; i++) {
							str += getMatchVersusStr(list[i]);
						}
					}
				} else {
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
				}
				$("div.vux-tab-selected .match-number").html(page.rowCount);
				if(pageNo == 1) { //第一页清空
					mescroll.scrollTo(0); //滚动到顶部
					mescroll.setPageNum(1); //把页数重设为1
					$("#betListContainer").empty();
				}
				$("#betListContainer").append(str);
				
				mescroll.endSuccess(page.pageSize, page.next);//在这里关闭加载提示
			} else {
				m_toast(data.msg);
				mescroll.endErr();//在这里关闭加载提示
			}
			
		},
		"complete" : function(data){ //在success后执行
			getBatchOddsAndPlayTypeStatus(); //加载赔率
		},
		"error" : function(){
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
var numberInputShow = function(leftTeamName, rightTeamName, matchName, playTypeId, playTypeName, leftGuessName, rightGuessName, betDirection, odds, ok_callback) {
	numberInput_ok_callback = ok_callback;
	var str = '';
	str += '<div data-v-60a57f0c="" id="numberInputDiv" class="vux-popup-dialog bet-slip-pop vux-popup-bottom vux-popup-show vux-popup-dialog-73jz6" style="height:auto;bottom:0;">';
	str += '	<section data-v-60a57f0c="" class="bet-slip-pop-header">';
	str += '		<div data-v-60a57f0c="" class="slip-number" style="display:none;">1</div>';
	str += '		<div data-v-60a57f0c="" class="remove-all">' + matchName + '</div>';
	str += '		<div data-v-60a57f0c="" class="pop-header-text">';
	str += '			<div data-v-60a57f0c="" class="pop-header-balance">余额</div>';
	str += '			<div data-v-60a57f0c="" id="userBalanceDiv">' + getMoneyStr(userBalance) + '</div>';
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
	str += '									<div data-v-60a57f0c="" class="odds-name">' + (betDirection ? leftGuessName : rightGuessName) + '</div>';
	str += '									<div data-v-60a57f0c="">' + playTypeName + '</div>';
	str += '									<div data-v-60a57f0c="">' + leftTeamName + '&nbsp;VS&nbsp;' + rightTeamName + '</div>';
	str += '								</section>';
	str += '								<section data-v-60a57f0c="" class="odds-item-money">';
	str += '									<div data-v-60a57f0c="" class="item-money">';
	str += '										<div data-v-60a57f0c="" class="money-odds bet' + (betDirection ? "Left" : "Right") + 'Odds' + playTypeId + '" data-odds="' + odds + '">@' + odds.toFixed(2) + '</div>';
	str += '										<div data-v-60a57f0c="" class="stake-input stake-input-focus">';
	str += '											<span data-v-60a57f0c="" class="input-placeholder" id="inputValueSpan" data-value="">输入金额</span>';
	str += '										</div>';
	str += '									</div>';
	str += '									<div data-v-60a57f0c="" class="item-return">预计还返 <span data-v-60a57f0c="" class="return-amount return-amount' + (betDirection ? "-left" : "-right") + '">0</span></div>';
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
	str += '									<div data-v-90afda32="" class="max-btn" onclick="maxBet()"><div data-v-90afda32="">最大投注</div></div>';
	str += '									<div data-v-90afda32="" class="del-btn" onclick="numberInput(\'x\')"><div data-v-90afda32="" class="del-icon"></div></div>';
	str += '									<div data-v-90afda32="" class="confirm-btn" onclick="numberInputOk()"><div data-v-90afda32="">确认下注</div></div>';
	str += '								</div>';
	str += '							</div>';
	str += '						</div>';
	str += '					</div>';
	str += '				</div>';
	str += '			</div>';
	str += '			<div class=" xs-fixed-container"></div>';
	str += '		</div>';
	str += '	</section>';
	str += '	<section data-v-60a57f0c="" class="bet-slip-pop-note betChange' + playTypeId + '" style="display:none;"><div data-v-60a57f0c="" class="note-alert"><div data-v-60a57f0c="" class="alert-icon"></div>您所选投注项的盘口、赔率或有效性已经产生变化</div></section>';
	str += '</div>';
	$("#numberInputDiv").remove();
	$("body").append(str);
};
var numberInputClose = function(){
	$("div.home-match-card-button").removeClass("btn-selected");
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
	var value = $.trim(e.attr("data-value"));
	if("x" == num) {
		if(!empty(value)) {
			value = value.substring(0, value.length - 1);
		}
	} else {
		if(value.length < 6) {
			value = value + num;
		}
	}

	if(!empty(value)) {
		var amount = parseInt(value, 10);
		if(amount > userBalance) {
			e.parent().addClass("stake-input-over");
		} else {
			e.parent().removeClass("stake-input-over");
		}
		e.attr("class", "input-text");
		e.html(amount);
		
		var odds = parseFloat($("#numberInputDiv .money-odds").attr("data-odds"));
		var returnAmount = odds * amount;
		if(returnAmount > 0) {
			$("#numberInputDiv .return-amount").html(returnAmount.toFixed(2));
		}
		e.attr("data-value", amount);
	} else {
		e.parent().removeClass("stake-input-over");
		e.attr("class", "input-placeholder");
		$("#numberInputDiv .return-amount").html("0");
		e.html("输入金额");
		e.attr("data-value", value);
	}
};
//最大投注
var maxBet = function(){
	var max = 999999;
	loadUserBalance(function(data){
		if(data.code == 100) {
			var amount = parseInt(max > data.result ? data.result : max);
			$("#inputValueSpan").html(amount);
			$("#inputValueSpan").attr("data-value", amount);
			$("#inputValueSpan").parent().removeClass("stake-input-over");
			$("#inputValueSpan").attr("class", "input-text");
			
			var odds = parseFloat($("#numberInputDiv .money-odds").attr("data-odds"));
			var returnAmount = odds * amount;
			if(returnAmount > 0) {
				$("#numberInputDiv .return-amount").html(returnAmount.toFixed(2));
			}
		}
	});
};

//显示时间选取器
var showDatePicker = function() {
	var millis = 0;
	if("after" == type) {
		millis = new Date().getTime() + 24 * 60 * 60 * 1000;
	} else {
		millis = new Date().getTime();
	}
	var dateStr = getDateStr(millis);
	var str = '';
	str += '<div data-v-bf66ef20="" class="home-date">';
	str += '	<div data-v-bf66ef20="" id="left-arrow-icon" class="arrow-icon' + (type == "after" ? ' arrow-left-dark' : ' arrow-left') + '" onclick="preDay()"></div>';
	str += '	<div data-v-bf66ef20="" class="calendar-center">';
	str += '		<div data-v-bf66ef20="" class="calendar-icon"></div>';
	str += '		<div data-v-bf66ef20="" data-dateStr2="' + dateStr.dateStr2 + '" data-millis="' + millis + '" class="dateStr">' + dateStr.dateStr1 + '</div>';
	str += '	</div>';
	str += '	<div data-v-bf66ef20="" id="right-arrow-icon" class="arrow-icon' + (type == "after" ? ' arrow-right' : ' arrow-right-dark') + '" onclick="nextDay()"></div>';
	str += '</div>';
	$("section.content-hearer").html(str);
	date = dateStr.dateStr2;
};
var preDay = function(){//前一天
	var dateStrElement = $("section.content-hearer .home-date .dateStr");

	var nowDateStr2 = dateStrElement.attr("data-dateStr2");
	var nowMillis = parseInt(dateStrElement.attr("data-millis"), 10);
	
	var preDateStr = getDateStr(nowMillis - 24 * 60 * 60 * 1000);
	var preDateStr1 = preDateStr.dateStr1;
	var preDateStr2 = preDateStr.dateStr2;
	var preMillis = preDateStr.millis;

	if("after" == type) {
		var tomorrowDateStr = getDateStr(new Date().getTime() + 24 * 60 * 60 * 1000);
		if(preDateStr2 <= tomorrowDateStr.dateStr2) {
			$("section.content-hearer #left-arrow-icon").removeClass("arrow-left");
			$("section.content-hearer #left-arrow-icon").addClass("arrow-left-dark");
			dateStrElement.html(tomorrowDateStr.dateStr1);
			dateStrElement.attr("data-dateStr2", tomorrowDateStr.dateStr2);
			dateStrElement.attr("data-millis", tomorrowDateStr.millis);
			date = tomorrowDateStr.dateStr2;
		} else {
			$("section.content-hearer #left-arrow-icon").removeClass("arrow-left-dark");
			$("section.content-hearer #left-arrow-icon").addClass("arrow-left");
			dateStrElement.html(preDateStr1);
			dateStrElement.attr("data-dateStr2", preDateStr2);
			dateStrElement.attr("data-millis", preMillis);
			date = preDateStr2;
		}
	} else if("end" == type) {
		dateStrElement.html(preDateStr1);
		dateStrElement.attr("data-dateStr2", preDateStr2);
		dateStrElement.attr("data-millis", preMillis);
		$("section.content-hearer #right-arrow-icon").removeClass("arrow-right-dark");
		$("section.content-hearer #right-arrow-icon").addClass("arrow-right");
		date = preDateStr2;
	}
	loadMatchVersus(pageSize, 1, false);
};
var nextDay = function(){//后一天
	var dateStrElement = $("section.content-hearer .home-date .dateStr");

	var nowDateStr2 = dateStrElement.attr("data-dateStr2");
	var nowMillis = parseInt(dateStrElement.attr("data-millis"), 10);
	
	var nextDateStr = getDateStr(nowMillis + 24 * 60 * 60 * 1000);
	var nextDateStr1 = nextDateStr.dateStr1;
	var nextDateStr2 = nextDateStr.dateStr2;
	var nextMillis = nextDateStr.millis;

	if("after" == type) {
		dateStrElement.html(nextDateStr1);
		dateStrElement.attr("data-dateStr2", nextDateStr2);
		dateStrElement.attr("data-millis", nextMillis);
		$("section.content-hearer #left-arrow-icon").removeClass("arrow-left-dark");
		$("section.content-hearer #left-arrow-icon").addClass("arrow-left");
		date = nextDateStr2;
	} else if("end" == type) {
		var todayDateStr = getDateStr(new Date().getTime());
		if(nextDateStr2 >= todayDateStr.dateStr2) {
			$("section.content-hearer #right-arrow-icon").removeClass("arrow-right");
			$("section.content-hearer #right-arrow-icon").addClass("arrow-right-dark");
			dateStrElement.html(todayDateStr.dateStr1);
			dateStrElement.attr("data-dateStr2", todayDateStr.dateStr2);
			dateStrElement.attr("data-millis", todayDateStr.millis);
			date = todayDateStr.dateStr2;
		} else {
			$("section.content-hearer #right-arrow-icon").removeClass("arrow-right-dark");
			$("section.content-hearer #right-arrow-icon").addClass("arrow-right");
			dateStrElement.html(nextDateStr1);
			dateStrElement.attr("data-dateStr2", nextDateStr2);
			dateStrElement.attr("data-millis", nextMillis);
			date = nextDateStr2;
		}
	}
	loadMatchVersus(pageSize, 1, false);
};
var getDateStr = function(millis) {//返回字日期字符串
	var date = new Date();
	date.setTime(millis);

	var year = date.getFullYear(); //年份
	var month = date.getMonth(); //月份(0 ~ 11)
	var day = date.getDate(); //日期(1 ~ 31)
	var weekday = date.getDay(); //星期(0 ~ 6)
	
	var monthStr = '';
	month = month + 1;
	if(month < 10) {
		monthStr = '0' + month;
	} else {
		monthStr = '' + month;
	}
	
	var dayStr = '';
	if(day < 10) {
		dayStr = '0' + day;
	} else {
		dayStr = '' + day;
	}
	
	var weekDayStr = '';
	switch(weekday) {
	case 0:weekDayStr = '日';break;
	case 1:weekDayStr = '一';break;
	case 2:weekDayStr = '二';break;
	case 3:weekDayStr = '三';break;
	case 4:weekDayStr = '四';break;
	case 5:weekDayStr = '五';break;
	case 6:weekDayStr = '六';break;
	}
	
	var dateStr = {
		"dateStr1" : year + "年" + monthStr + "月" + day + "日" + "&nbsp" + "周" + weekDayStr,
		"dateStr2" : year + "-" + monthStr + "-" + day,
		"millis" : millis
	};
	return dateStr;
};

//加载系统公告
var loadSystemNotice = function(){
	loadData({
		"url" : "systemNoticeList",
		"hideLoading" : true,
		"data" : {
			"pageSize" : 20,
			"pageNo" : 1
		},
		"success" : function(data){
			if(data.code == 100) {
				var list = data.result.list;
				var str = '';
				
				str += '<div data-v-bf66ef20="" class="home-notice">';
				str += '	<div data-v-bf66ef20="" class="notice-icon"></div>';
				str += '	<div data-v-bf66ef20="" class="vux-marquee" style="height:16px;">';
				str += '		<ul class="vux-marquee-box" style="transform: translate3d(0px, 0px, 0px); transition: transform 300ms ease 0s;">';
				
				if(list.length > 0) {
					for(var i=0; i<list.length; i++) {
						var obj = list[i];
						str += '<li data-v-bf66ef20="" class="notice-item"><div data-v-bf66ef20="">【' + obj.content + '】</div></li>';
					}
				} else {
					str += '<li data-v-bf66ef20="" class="notice-item"><div data-v-bf66ef20="">【暂无公告】</div></li>';
				}
				
				str += '		</ul>';
				str += '	</div>';
				str += '</div>';
				
				$("section.content-hearer").html(str);
				systemNoticeChange();//定时切换
			} else {
				m_toast(data.msg);
			}
		}
	});
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
		date = null;
		loadSystemNotice(); //加载系统公告
		e.css("left", "0%");
		e.css("right", "75%");
	} else if(2 == index) {
		type = "scroll";
		date = null;
		loadSystemNotice(); //加载系统公告
		e.css("left", "25%");
		e.css("right", "50%");
	} else if(3 == index) {
		type = "after";
		showDatePicker(); //显示时间选择器
		e.css("left", "50%");
		e.css("right", "25%");
	} else if(4 == index) {
		type = "end";
		showDatePicker(); //显示时间选择器
		e.css("left", "75%");
		e.css("right", "0%");
	}
	loadMatchVersus(pageSize, 1, false);
};

//matchVersus点击事件
var matchVersusClick = function(versusId){
	window.location.href = "m/betDetail.jsp?versusId=" + versusId + "&type=" + type;
};

//对阵str
var getMatchVersusStr = function(versus, playType, remainingTime){
	var str = '';
	if("end" == type) {
		str += '<div onclick="matchVersusClick(' + versus.id + ')" data-v-18da170e="" data-v-bf66ef20="" class="home-match-card">';
		str += '	<section data-v-18da170e="" class="card-header">';
		str += '		<img data-v-18da170e="" src="' + (empty(versus.matchLogoUrl) ? versus.sportLogoUrl : versus.matchLogoUrl) + '" width="20px">';
		str += '		<div data-v-18da170e="" class="tournament-name">' + versus.sportName + '&nbsp;' + versus.matchName + '&nbsp;' + versus.name  + '</div>';
		str += '		<div data-v-18da170e="" class="match-round">&nbsp;/&nbsp;bo' + versus.boCount + '</div>';
		if(versus.playTypeCount > 1) {
			str += '		<div data-v-18da170e="" class="play-count">' + ('+' + versus.playTypeCount) + '</div>';
		}
		str += '	</section>';
		str += '	<section data-v-18da170e="" class="card-body">';
		str += '		<div data-v-18da170e="" class="card-body-team"><img data-v-18da170e="" src="' + versus.leftTeamLogoUrl + '" class="team-logo"></div>';
		str += '		<div data-v-18da170e="" class="card-body-center">';
		str += '			<img data-v-18da170e="" src="data:image/svg+xml;base64,PD94bWwgdmVyc2lvbj0iMS4wIiBlbmNvZGluZz0iVVRGLTgiPz4KPHN2ZyB3aWR0aD0iMjRweCIgaGVpZ2h0PSI3OHB4IiB2aWV3Qm94PSIwIDAgMjQgNzgiIHZlcnNpb249IjEuMSIgeG1sbnM9Imh0dHA6Ly93d3cudzMub3JnLzIwMDAvc3ZnIiB4bWxuczp4bGluaz0iaHR0cDovL3d3dy53My5vcmcvMTk5OS94bGluayI+CiAgICA8IS0tIEdlbmVyYXRvcjogU2tldGNoIDQ5LjMgKDUxMTY3KSAtIGh0dHA6Ly93d3cuYm9oZW1pYW5jb2RpbmcuY29tL3NrZXRjaCAtLT4KICAgIDx0aXRsZT7ljaHniYfljLrliIblibLlt6Y8L3RpdGxlPgogICAgPGRlc2M+Q3JlYXRlZCB3aXRoIFNrZXRjaC48L2Rlc2M+CiAgICA8ZGVmcz4KICAgICAgICA8cmFkaWFsR3JhZGllbnQgY3g9IjEwMCUiIGN5PSI1MCUiIGZ4PSIxMDAlIiBmeT0iNTAlIiByPSI5OC44MDMyODc2JSIgZ3JhZGllbnRUcmFuc2Zvcm09InRyYW5zbGF0ZSgxLjAwMDAwMCwwLjUwMDAwMCksc2NhbGUoMS4wMDAwMDAsMC4zMDAwMDApLHJvdGF0ZSgtMTc5Ljk5OTk5OCksc2NhbGUoMS4wMDAwMDAsMS42MzI1MTgpLHRyYW5zbGF0ZSgtMS4wMDAwMDAsLTAuNTAwMDAwKSIgaWQ9InJhZGlhbEdyYWRpZW50LTEiPgogICAgICAgICAgICA8c3RvcCBzdG9wLWNvbG9yPSIjMEMxMjFGIiBvZmZzZXQ9IjAlIj48L3N0b3A+CiAgICAgICAgICAgIDxzdG9wIHN0b3AtY29sb3I9IiMxQTI1MzgiIHN0b3Atb3BhY2l0eT0iMCIgb2Zmc2V0PSIxMDAlIj48L3N0b3A+CiAgICAgICAgPC9yYWRpYWxHcmFkaWVudD4KICAgIDwvZGVmcz4KICAgIDxnIGlkPSLpm7fnq57mioAyLjAtY29weSIgc3Ryb2tlPSJub25lIiBzdHJva2Utd2lkdGg9IjEiIGZpbGw9Im5vbmUiIGZpbGwtcnVsZT0iZXZlbm9kZCIgZmlsbC1vcGFjaXR5PSIwLjMiPgogICAgICAgIDxnIGlkPSJpY29u5YiH5Zu+IiB0cmFuc2Zvcm09InRyYW5zbGF0ZSgtMTEyLjAwMDAwMCwgLTE5NjUuMDAwMDAwKSIgZmlsbD0idXJsKCNyYWRpYWxHcmFkaWVudC0xKSI+CiAgICAgICAgICAgIDxyZWN0IGlkPSLljaHniYfljLrliIblibLlt6YiIHg9IjExMiIgeT0iMTk2NCIgd2lkdGg9IjI0IiBoZWlnaHQ9IjgwIj48L3JlY3Q+CiAgICAgICAgPC9nPgogICAgPC9nPgo8L3N2Zz4=" class="center-left">';
		if("已结束" == versus.status) {
			str += '			<div data-v-18da170e="" class="team-score"><div data-v-18da170e="">' + versus.leftTeamScore + '</div><div data-v-18da170e="" class="dash-symbol">-</div><div data-v-18da170e="">' + versus.rightTeamScore + '</div></div>';
		} else if("未比赛" == versus.status) {
			str += '			<div data-v-18da170e="" class="team-score"><div data-v-18da170e="">0</div><div data-v-18da170e="" class="dash-symbol">-</div><div data-v-18da170e="">0</div></div>';
		}
		str += '			<img data-v-18da170e="" src="data:image/svg+xml;base64,PD94bWwgdmVyc2lvbj0iMS4wIiBlbmNvZGluZz0iVVRGLTgiPz4KPHN2ZyB3aWR0aD0iMjRweCIgaGVpZ2h0PSI3OHB4IiB2aWV3Qm94PSIwIDAgMjQgNzgiIHZlcnNpb249IjEuMSIgeG1sbnM9Imh0dHA6Ly93d3cudzMub3JnLzIwMDAvc3ZnIiB4bWxuczp4bGluaz0iaHR0cDovL3d3dy53My5vcmcvMTk5OS94bGluayI+CiAgICA8IS0tIEdlbmVyYXRvcjogU2tldGNoIDQ5LjMgKDUxMTY3KSAtIGh0dHA6Ly93d3cuYm9oZW1pYW5jb2RpbmcuY29tL3NrZXRjaCAtLT4KICAgIDx0aXRsZT7ljaHniYfljLrliIblibLlj7M8L3RpdGxlPgogICAgPGRlc2M+Q3JlYXRlZCB3aXRoIFNrZXRjaC48L2Rlc2M+CiAgICA8ZGVmcz4KICAgICAgICA8cmFkaWFsR3JhZGllbnQgY3g9IjEwMCUiIGN5PSI1MCUiIGZ4PSIxMDAlIiBmeT0iNTAlIiByPSI5OC44MDMyODc2JSIgZ3JhZGllbnRUcmFuc2Zvcm09InRyYW5zbGF0ZSgxLjAwMDAwMCwwLjUwMDAwMCksc2NhbGUoMS4wMDAwMDAsMC4zMDAwMDApLHJvdGF0ZSgtMTc5Ljk5OTk5OCksc2NhbGUoMS4wMDAwMDAsMS42MzI1MTgpLHRyYW5zbGF0ZSgtMS4wMDAwMDAsLTAuNTAwMDAwKSIgaWQ9InJhZGlhbEdyYWRpZW50LTEiPgogICAgICAgICAgICA8c3RvcCBzdG9wLWNvbG9yPSIjMEMxMjFGIiBvZmZzZXQ9IjAlIj48L3N0b3A+CiAgICAgICAgICAgIDxzdG9wIHN0b3AtY29sb3I9IiMxQTI1MzgiIHN0b3Atb3BhY2l0eT0iMCIgb2Zmc2V0PSIxMDAlIj48L3N0b3A+CiAgICAgICAgPC9yYWRpYWxHcmFkaWVudD4KICAgIDwvZGVmcz4KICAgIDxnIGlkPSLpm7fnq57mioAyLjAtY29weSIgc3Ryb2tlPSJub25lIiBzdHJva2Utd2lkdGg9IjEiIGZpbGw9Im5vbmUiIGZpbGwtcnVsZT0iZXZlbm9kZCIgZmlsbC1vcGFjaXR5PSIwLjMiPgogICAgICAgIDxnIGlkPSJpY29u5YiH5Zu+IiB0cmFuc2Zvcm09InRyYW5zbGF0ZSgtMTc2LjAwMDAwMCwgLTE5NjUuMDAwMDAwKSIgZmlsbD0idXJsKCNyYWRpYWxHcmFkaWVudC0xKSI+CiAgICAgICAgICAgIDxyZWN0IGlkPSLljaHniYfljLrliIblibLlj7MiIHRyYW5zZm9ybT0idHJhbnNsYXRlKDE4OC4wMDAwMDAsIDIwMDQuMDAwMDAwKSBzY2FsZSgtMSwgMSkgdHJhbnNsYXRlKC0xODguMDAwMDAwLCAtMjAwNC4wMDAwMDApICIgeD0iMTc2IiB5PSIxOTY0IiB3aWR0aD0iMjQiIGhlaWdodD0iODAiPjwvcmVjdD4KICAgICAgICA8L2c+CiAgICA8L2c+Cjwvc3ZnPg==" class="center-right">';
		str += '		</div>';
		str += '		<div data-v-18da170e="" class="card-body-team"><img data-v-18da170e="" src="' + versus.rightTeamLogoUrl + '" class="team-logo"></div>';
		str += '	</section>';
		str += '	<div data-v-8d7d541a="" data-v-18da170e="" class="odds-group-title"><div data-v-8d7d541a="" class="empty-badge">&nbsp;</div><div data-v-8d7d541a="" class="title">获胜者</div></div>';
		str += '	<section data-v-18da170e="" class="card-footer">';
		str += '		<div data-v-18da170e="" class="card-odds-btn"><div data-v-ba6efc5c="" data-v-18da170e="" class="home-match-card-button btn-over"><div data-v-ba6efc5c="" class="button-dark-border"><div data-v-ba6efc5c="" class="button-content"><div data-v-ba6efc5c="" class="button-name">' + versus.leftTeamName + '</div></div></div></div></div>';
		if("已结束" == versus.status) {
			if(versus.result < 0) { //左方胜
				str += '		<div data-v-18da170e="" class="match-status"><div data-v-18da170e="" class="match-flag"><div data-v-18da170e="" class="flag win-flag"></div><div data-v-18da170e="" class="flag lose-flag"></div></div></div>';
			} else if(versus.result > 0) { //右方胜
				str += '		<div data-v-18da170e="" class="match-status"><div data-v-18da170e="" class="match-flag"><div data-v-18da170e="" class="flag lose-flag"></div><div data-v-18da170e="" class="flag win-flag"></div></div></div>';
			} else { //平
				str += '		<div data-v-18da170e="" class="match-status" style="font-size:16px;">平</div>';
			}
		} else if("未比赛" == versus.status) {
			str += '		<div data-v-18da170e="" class="match-status" style="font-size:16px;">比赛取消</div>';
		}
		str += '		<div data-v-18da170e="" class="card-odds-btn"><div data-v-ba6efc5c="" data-v-18da170e="" class="home-match-card-button btn-over"><div data-v-ba6efc5c="" class="button-dark-border"><div data-v-ba6efc5c="" class="button-content"><div data-v-ba6efc5c="" class="button-name">' + versus.rightTeamName + '</div></div></div></div></div>';
		str += '	</section>';
		str += '</div>';
	} else {
		str += '<div onclick="matchVersusClick(' + versus.id + ')" data-v-18da170e="" data-v-bf66ef20="" data-versusId="' + versus.id + '" class="home-match-card"' + (playType == null ? ' style="height:125px !important;"' : '') + ' data-leftTeamName="' + versus.leftTeamName + '" data-rightTeamName="' + versus.rightTeamName + '">';
		str += '	<section data-v-18da170e="" class="card-header">';
		str += '		<img data-v-18da170e="" src="' + (empty(versus.matchLogoUrl) ? versus.sportLogoUrl : versus.matchLogoUrl) + '" width="20px">';
		str += '		<div data-v-18da170e="" class="tournament-name">' + versus.sportName + '&nbsp;' + versus.matchName + '&nbsp;' + versus.name + '</div>';
		str += '		<div data-v-18da170e="" class="match-round">&nbsp;/&nbsp;bo' + versus.boCount + '</div>';
		if(versus.playTypeCount > 1) {
			str += '		<div data-v-18da170e="" class="play-count">' + ("+" + versus.playTypeCount) + '</div>';
		}
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
			str += '		<div data-v-8d7d541a="" class="title">' + versus.leftTeamName + '&nbsp;VS&nbsp;' + versus.rightTeamName + '&nbsp;' + playType.name + '</div>';
			str += '	</div>';
			str += '	<section data-v-18da170e="" class="card-footer playTypeId' + playType.id + '" data-playTypeId="' + playType.id + '" data-playTypeName="' + playType.name + '" data-leftGuessName="' + playType.leftGuessName + '" data-rightGuessName="' + playType.rightGuessName + '">';
			str += '		<div data-v-18da170e="" class="card-odds-btn" onclick="betClick(' + playType.id + ', true, event)">';
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
			str += '		<div data-v-18da170e="" class="card-odds-btn" onclick="betClick(' + playType.id + ', false, event)">';
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
	}
	return str;
};

//计算剩余时间
var getRemainingTime = function(remainingTime){
	if(remainingTime == null) {
		return "未知";
	}
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
		var dataPlayTypeId = $.trim($(this).attr("data-playTypeId"));
		if(!empty(dataPlayTypeId)) {
			playTypeId.push(dataPlayTypeId);
		}
	});
	if(playTypeId.length > 0) {
		loadData({
			"url" : "getBatchOddsAndPlayTypeStatus",
			"hideLoading" : true,
			"data" : {
				"playTypeId[]" : playTypeId
			},
			"success" : function(data){
				if(data.code == 100) {
					var resultList = data.result;
					for(var i=0; i<resultList.length; i++) {
						var obj = resultList[i];
						showOdds(obj.status, obj.leftOdds, obj.rightOdds, obj.playTypeId);
					}
				} else {
					m_toast(data.msg);
				}
			}
		});
	}
};

//显示赔率
var showOdds = function(status, leftOdds, rightOdds, playTypeId) {
	var e = $("section.playTypeId" + playTypeId);
	if(status) {
		e.find(".home-match-card-button").removeClass("btn-locked");

		var oldLeftOdds = oldLeftOddsArray[playTypeId];
		var leftOddsE = e.find(".leftOdds");
		leftOddsE.html(leftOdds.toFixed(2));
		oldLeftOddsArray[playTypeId] = leftOdds;
		if(!empty(oldLeftOdds)) {
			if(leftOdds > oldLeftOdds) { //左方赔率上升了
				oddsFlash(1, leftOddsE);
			} else if(leftOdds < oldLeftOdds) { //左方赔率下降了
				oddsFlash(-1, leftOddsE);
			} else { //赔率没变
				oddsFlash(0, leftOddsE);
			}
		}
		$("#numberInputDiv .betLeftOdds" + playTypeId).attr("data-odds", leftOdds);
		$("#numberInputDiv .betLeftOdds" + playTypeId).html("@" + leftOdds.toFixed(2));
		if(leftOdds != oldLeftOdds) {
			$("#numberInputDiv .betChange" + playTypeId).show();
			$("#numberInputDiv .betLeftOdds" + playTypeId).addClass("money-odds-change");
			var amount = $("#inputValueSpan").attr("data-value");
			if(!empty(amount)) {
				var returnAmount = parseFloat(amount) * leftOdds;
				if(returnAmount > 0) {
					$("#numberInputDiv .return-amount-left").html(returnAmount.toFixed(2));
				}
			}
		}

		var oldRightOdds = oldRightOddsArray[playTypeId];
		var rightOddsE = e.find(".rightOdds");
		rightOddsE.html(rightOdds.toFixed(2));
		oldRightOddsArray[playTypeId] = rightOdds;
		if(!empty(oldRightOdds)) {
			if(rightOdds > oldRightOdds) { //右方赔率上升了
				oddsFlash(1, rightOddsE);
			} else if(rightOdds < oldRightOdds) { //右方赔率下降了
				oddsFlash(-1, rightOddsE);
			} else { //赔率没变
				oddsFlash(0, rightOddsE);
			}
		}
		$("#numberInputDiv .betRightOdds" + playTypeId).attr("data-odds", rightOdds);
		$("#numberInputDiv .betRightOdds" + playTypeId).html("@" + rightOdds.toFixed(2));
		if(rightOdds != oldRightOdds) {
			$("#numberInputDiv .betChange" + playTypeId).show();
			$("#numberInputDiv .betRightOdds" + playTypeId).addClass("money-odds-change");
			var amount = $("#inputValueSpan").attr("data-value");
			if(!empty(amount)) {
				var returnAmount = parseFloat(amount) * rightOdds;
				if(returnAmount > 0) {
					$("#numberInputDiv .return-amount-right").html(returnAmount.toFixed(2));
				}
			}
		}
	} else {
		e.find(".home-match-card-button").addClass("btn-locked");
		e.find(".leftOdds").empty();
		e.find(".rightOdds").empty();
	}
};
//odds上升、下降闪亮警示i：大于0上升，小于0下降，等于0没变
var oddsFlash = function(i, e){
	var obj = e.parent().parent().parent().parent().parent();
	if(i > 0) {
		obj.removeClass("btn-odds-dropping");
		obj.addClass("btn-odds-rising");
	} else if(i < 0) {
		obj.removeClass("btn-odds-rising");
		obj.addClass("btn-odds-dropping");
	} else {
		obj.removeClass("btn-odds-rising");
		obj.removeClass("btn-odds-dropping");
	}
};

//下注点击事件direction：true为左，false为右
var betClick = function(playTypeId, direction, event){
	var e = $("section.playTypeId" + playTypeId);
	var leftTeamName = $.trim(e.parent().attr("data-leftTeamName"));
	var rightTeamName = $.trim(e.parent().attr("data-rightTeamName"));
	var leftE = $("section.playTypeId" + playTypeId + " .leftOdds");
	var rightE = $("section.playTypeId" + playTypeId + " .rightOdds");
	var leftBtn = leftE.parent().parent().parent().parent().parent();
	var rightBtn = rightE.parent().parent().parent().parent().parent();
	if(direction) { //左方
		if(!leftBtn.hasClass("btn-locked")) { //未被锁定
			$("div.home-match-card-button").removeClass("btn-selected");
			leftBtn.addClass("btn-selected");
			numberInputShow(leftTeamName, rightTeamName, e.parent().find(".tournament-name").html(), playTypeId, e.attr("data-playTypeName"), e.attr("data-leftGuessName"), e.attr("data-rightGuessName"), direction, oldLeftOddsArray[playTypeId], function(amount){
				bet(playTypeId, "LEFT", amount);
			});
		}
	} else { //右方
		if(!rightBtn.hasClass("btn-locked")) { //未被锁定
			$("div.home-match-card-button").removeClass("btn-selected");
			rightBtn.addClass("btn-selected");
			numberInputShow(leftTeamName, rightTeamName, e.parent().find(".tournament-name").html(), playTypeId, e.attr("data-playTypeName"), e.attr("data-leftGuessName"), e.attr("data-rightGuessName"), direction, oldRightOddsArray[playTypeId], function(amount){
				bet(playTypeId, "RIGHT", amount);
			});
		}
	}
	loadUserBalance();//加载用户余额
	event.stopPropagation();//阻止事件传递
};

//下注方法
var bet = function(playTypeId, betDirection, betAmount){
	if(betAmount > 0) {
		loadData({
			"url" : "user/bet",
			"data" : {
				"playTypeId" : playTypeId,
				"betDirection" : betDirection,
				"betAmount" : betAmount
			},
			"success" : function(data) {
				if(data.code == 100) {
					var matchVersus = data.result.matchVersus;
					var playType = data.result.playType;
					var bet = data.result.bet;
					betSuccess(matchVersus, playType, bet);
				} else if(data.code == 200) {
					m_confirm("您还未登录，请先登录", function(){
						window.location.href = "m/login.jsp";
					});
				} else {
					m_toast(data.msg);
				}
			}
		});
	} else {
		m_toast("请输入下注金额");
	}
};

//下注成功框
var betSuccess = function(matchVersus, playType, bet){
	var str = '';
	str += '<div data-v-60a57f0c="" class="vux-confirm order-confirm" id="betSuccessDiv">';
	str += '	<div class="vux-x-dialog">';
	str += '		<div class="weui-mask" style=""></div>';
	str += '		<div class="weui-dialog" style="">';
	str += '			<div class="weui-dialog__bd">';
	str += '				<div class="content">';
	str += '					<section class="header color-green"><div class="success-icon"></div><div>订单提交成功！</div></section>';
	str += '					<div id="vux-scroller-oezyh" style="max-height: 60vh; height:199px; touch-action: auto; user-select: none; -webkit-user-drag: none; -webkit-tap-highlight-color: rgba(0, 0, 0, 0); position: relative; overflow: hidden;">';
	str += '						<div class="xs-container" style="transform-origin: 0px 0px 0px; transform: translateX(0px) translateY(0px) translateZ(0px) scale(1, 1); transition: none 0s ease 0s;">';
	str += '							<div style="height:199px; transform-origin: 0px 0px 0px; transform: translate(0px, 0px) scale(1) translateZ(0px);">';
	str += '								<div class="order-item">';
	str += '								<div class="odds-item">';
	str += '										<div class="match-info">';
	str += '											<div class="odds-title"><div class="games-icon" style="background-image:url(\'' + matchVersus.sportLogoUrl + '\');"></div>' + matchVersus.sportName + '&nbsp;' + matchVersus.matchName + '&nbsp;' + matchVersus.name + '<div class="match-stage">' + playType.name + '</div></div>';
	str += '											<div class="odds-match">' + playType.leftGuessName + '&nbsp;-&nbsp;VS&nbsp;-&nbsp;' + playType.rightGuessName + '&nbsp;' + bet.createTime.substring(11, 16) + '</div>';
	var betGuessName = '';
	var odds = 0;
	if("LEFT" == bet.betDirection) {
		betGuessName = playType.leftGuessName;
		odds = bet.leftOdds;
	} else if("RIGHT" == bet.betDirection) {
		betGuessName = playType.rightGuessName;
		odds = bet.rightOdds;
	}
	str += '											<div style="margin-bottom:4px;">下注方：' + betGuessName + '</div>';
	str += '											<div>赔率：' + odds.toFixed(2) + '</div>';
	str += '										</div>';
	str += '									</div>';
	str += '									<div class="order-info order-title"><div>' + (playType.bo > 0 ? ('第' + playType.bo + '局') : '全局') + '</div><div class="order-success">提交成功</div></div>';
	str += '									<div class="order-info">';
	str += '										<div class="stake">投注金额：<span class="color-white">' + bet.betAmount.toFixed(2) + '</span></div>';
	str += '										<div>预计盈利：<span class="color-white">' + ((bet.betAmount * odds).toFixed(2)) + '</span></div>';
	str += '									</div>';
	str += '									<div class="order-note">您可以在“个人中心&nbsp;-&nbsp;投注记录”中留意订单状态</div>';
	str += '								</div>';
	str += '							</div>';
	str += '						</div>';
	str += '						<div class=" xs-fixed-container"></div>';
	str += '					</div>';
	str += '				</div>';
	str += '			</div>';
	str += '			<div class="weui-dialog__ft">';
	str += '				<a href="m/usercenter/betRecord.jsp" class="weui-dialog__btn weui-dialog__btn_default">投注记录</a>';
	str += '				<a href="javascript:;" onclick="betSuccessClose()" class="weui-dialog__btn weui-dialog__btn_primary">继续投注</a>';
	str += '			</div>';
	str += '		</div>';
	str += '	</div>';
	str += '</div>';
	$("#betSuccessDiv").remove();
	$("body").append(str);
};
//下注成功框关闭
var betSuccessClose = function(){
	$("#betSuccessDiv").remove();
	numberInputClose();
};

//加载用户余额
var loadUserBalance = function(callback){
	loadData({
		"url" : "user/getBalance",
		"hideLoading" : true,
		"success" : function(data) {
			if(data.code == 100) {
				updateBalance(data.result);
				isLogin = true;
			} else {
				updateBalance(0);
				isLogin = false;
			}
			if(callback != null) {
				callback(data);
			}
		}
	});
};

//更新余额方法
var updateBalance = function(balance){
	userBalance = balance;
	$("#userBalanceDiv").html(getMoneyStr(balance));
};

//更新未读信息方法
var getUnreadUserNoticeCount = function(){
	loadData({
		"url" : "user/getUnreadUserNoticeCount",
		"hideLoading" : true,
		"success" : function(data){
			if(data.code == 100) {
				if(data.result > 0) { //有未读信息
					$("li.notice-count").prepend('<div data-v-1db5fc32="" class="notice-badge"></div>');
				} else { //没有未读信息
					$("div.notice-badge").remove();
				}
			}
		}
	});
};
