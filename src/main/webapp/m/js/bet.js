/*全局参数*/
var itemIds = null;//项目id数组，为null或长度为零表示加载所有
var versusIndex = 2; //1、2、3、4
var versusDate = null; //index为3、4时需要此参数

//初始化数据方法
var initData = function(intervalSeconds){
	$("#vux-scroller-60yre").height($(window).height() - 132);//设置页面高度
	loadAllItem(); //加载所有项目列表
	loadSystemNotice(); //加载系统公告
	getUnreadUserNoticeCount(); //加载未读信息数量
	loadVersus(); //加载竞猜列表
};

//加载versus
var loadVersus = function(){
	var str = '';
	str += 'itemIds：' + itemIds + "\n";
	str += 'versusIndex：' + versusIndex + "\n";
	str += 'versusDate：' + versusDate + "\n";
	alert(str);
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

//加载所有项目
var loadAllItem = function(){
	loadData({
		url : "v2/getAllItem",
		success : function(data){
			if(data.code == 100) {
				var list = data.result;
				var str = '';
				for(var i=0; i<list.length; i++) {
					var obj = list[i];
					str += '<div data-v-cd1e9d3c="" onclick="itemSelect(' + obj.id + ', this)" data-item-id="' + obj.id + '" class="vux-checker-item vux-tap-active default-checker-item selected-all-games">';
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

//滚动条变换、菜单切换
var tabBarChange = function(index, ts) {
	var e = $("div.vux-tab-ink-bar-transition-backward");
	$("div.vux-tab-item").removeClass("vux-tab-selected");
	$("div.vux-tab-item").css("color", "rgb(186, 206, 241)");

	$(ts).addClass("vux-tab-selected");
	$(ts).css("color", "rgb(255, 255, 255)");
	if(1 == index) {
		versusIndex = 1;
		date = null;
		loadSystemNotice(); //加载系统公告
		e.css("left", "0%");
		e.css("right", "75%");
	} else if(2 == index) {
		versusIndex = 2;
		date = null;
		loadSystemNotice(); //加载系统公告
		e.css("left", "25%");
		e.css("right", "50%");
	} else if(3 == index) {
		versusIndex = 3;
		showDatePicker(); //显示时间选择器
		e.css("left", "50%");
		e.css("right", "25%");
	} else if(4 == index) {
		versusIndex = 4;
		showDatePicker(); //显示时间选择器
		e.css("left", "75%");
		e.css("right", "0%");
	}
	loadVersus();
};


/*************************************系统公告相关*****************************************/
//加载系统公告
var loadSystemNotice = function() {
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
/*************************************系统公告相关*****************************************/


/************************************项目相关*****************************************/
//显示运动项目选择框
var showItemSelect = function(){
	$("section.filter-matches").hide();
	$("section.filter-games").show();
	$("div.vux-popup-dialog-mfqea").show();
};
//运动项目选择
var itemSelect = function(itemId, e){
	if(itemId > 0) {
		$("#selected-all-item").removeClass("selected-checker-item");
		$("div.vux-checker-item").removeClass("selected-all-games");
		$(e).toggleClass("selected-checker-item");
	} else { //选择了全部
		$("#selected-all-item").addClass("selected-checker-item");
		$("div.vux-checker-item").removeClass("selected-checker-item");
		$("div.vux-checker-item").addClass("selected-all-games");
	}
};
//确认选择
var itemSelectOk = function(){
	if($("#selected-all-item").hasClass("selected-checker-item")) {
		itemIds = null;
	} else {//全部
		itemIds = new Array();
		$("div.selected-checker-item").each(function(){
			itemIds.push($(this).attr("data-item-id"));
		});
	}
	closeItemSelect();
	loadVersus();
};
//运动项目选择
var itemSelect = function(itemId, e){
	if(itemId != null) {
		$("#selected-all-item").removeClass("selected-checker-item");
		$("div.vux-checker-item").removeClass("selected-all-games");
		$(e).toggleClass("selected-checker-item");
	} else { //选择了全部
		$("#selected-all-item").addClass("selected-checker-item");
		$("div.vux-checker-item").removeClass("selected-checker-item");
		$("div.vux-checker-item").addClass("selected-all-games");
	}
};
//关闭运动项目选择框
var closeItemSelect = function(){
	$("section.filter-games").hide();
	$("div.vux-popup-dialog-mfqea").hide();
	$("section.filter-matches").show();
};
/************************************项目相关*****************************************/


/*****************************************时间选取器*******************************************/
//显示时间选取器
var showDatePicker = function() {
	var millis = 0;
	if(3 == versusIndex) {
		millis = new Date().getTime() + 24 * 60 * 60 * 1000;
	} else {
		millis = new Date().getTime();
	}
	var dateStr = getDateStr(millis);
	var str = '';
	str += '<div data-v-bf66ef20="" class="home-date">';
	str += '	<div data-v-bf66ef20="" id="left-arrow-icon" class="arrow-icon' + (versusIndex == 3 ? ' arrow-left-dark' : ' arrow-left') + '" onclick="preDay()"></div>';
	str += '	<div data-v-bf66ef20="" class="calendar-center">';
	str += '		<div data-v-bf66ef20="" class="calendar-icon"></div>';
	str += '		<div data-v-bf66ef20="" data-dateStr2="' + dateStr.dateStr2 + '" data-millis="' + millis + '" class="dateStr">' + dateStr.dateStr1 + '</div>';
	str += '	</div>';
	str += '	<div data-v-bf66ef20="" id="right-arrow-icon" class="arrow-icon' + (versusIndex == 3 ? ' arrow-right' : ' arrow-right-dark') + '" onclick="nextDay()"></div>';
	str += '</div>';
	$("section.content-hearer").html(str);
	versusDate = dateStr.dateStr2;
};
var preDay = function(){//前一天
	var dateStrElement = $("section.content-hearer .home-date .dateStr");

	var nowDateStr2 = dateStrElement.attr("data-dateStr2");
	var nowMillis = parseInt(dateStrElement.attr("data-millis"), 10);
	
	var preDateStr = getDateStr(nowMillis - 24 * 60 * 60 * 1000);
	var preDateStr1 = preDateStr.dateStr1;
	var preDateStr2 = preDateStr.dateStr2;
	var preMillis = preDateStr.millis;

	if(3 == versusIndex) {
		var tomorrowDateStr = getDateStr(new Date().getTime() + 24 * 60 * 60 * 1000);
		if(preDateStr2 <= tomorrowDateStr.dateStr2) {
			$("section.content-hearer #left-arrow-icon").removeClass("arrow-left");
			$("section.content-hearer #left-arrow-icon").addClass("arrow-left-dark");
			dateStrElement.html(tomorrowDateStr.dateStr1);
			dateStrElement.attr("data-dateStr2", tomorrowDateStr.dateStr2);
			dateStrElement.attr("data-millis", tomorrowDateStr.millis);
			versusDate = tomorrowDateStr.dateStr2;
		} else {
			$("section.content-hearer #left-arrow-icon").removeClass("arrow-left-dark");
			$("section.content-hearer #left-arrow-icon").addClass("arrow-left");
			dateStrElement.html(preDateStr1);
			dateStrElement.attr("data-dateStr2", preDateStr2);
			dateStrElement.attr("data-millis", preMillis);
			versusDate = preDateStr2;
		}
	} else if(4 == versusIndex) {
		dateStrElement.html(preDateStr1);
		dateStrElement.attr("data-dateStr2", preDateStr2);
		dateStrElement.attr("data-millis", preMillis);
		$("section.content-hearer #right-arrow-icon").removeClass("arrow-right-dark");
		$("section.content-hearer #right-arrow-icon").addClass("arrow-right");
		versusDate = preDateStr2;
	}
	loadVersus();
};
var nextDay = function(){//后一天
	var dateStrElement = $("section.content-hearer .home-date .dateStr");

	var nowDateStr2 = dateStrElement.attr("data-dateStr2");
	var nowMillis = parseInt(dateStrElement.attr("data-millis"), 10);
	
	var nextDateStr = getDateStr(nowMillis + 24 * 60 * 60 * 1000);
	var nextDateStr1 = nextDateStr.dateStr1;
	var nextDateStr2 = nextDateStr.dateStr2;
	var nextMillis = nextDateStr.millis;

	if(3 == versusIndex) {
		dateStrElement.html(nextDateStr1);
		dateStrElement.attr("data-dateStr2", nextDateStr2);
		dateStrElement.attr("data-millis", nextMillis);
		$("section.content-hearer #left-arrow-icon").removeClass("arrow-left-dark");
		$("section.content-hearer #left-arrow-icon").addClass("arrow-left");
		versusDate = nextDateStr2;
	} else if(4 == versusIndex) {
		var todayDateStr = getDateStr(new Date().getTime());
		if(nextDateStr2 >= todayDateStr.dateStr2) {
			$("section.content-hearer #right-arrow-icon").removeClass("arrow-right");
			$("section.content-hearer #right-arrow-icon").addClass("arrow-right-dark");
			dateStrElement.html(todayDateStr.dateStr1);
			dateStrElement.attr("data-dateStr2", todayDateStr.dateStr2);
			dateStrElement.attr("data-millis", todayDateStr.millis);
			versusDate = todayDateStr.dateStr2;
		} else {
			$("section.content-hearer #right-arrow-icon").removeClass("arrow-right-dark");
			$("section.content-hearer #right-arrow-icon").addClass("arrow-right");
			dateStrElement.html(nextDateStr1);
			dateStrElement.attr("data-dateStr2", nextDateStr2);
			dateStrElement.attr("data-millis", nextMillis);
			versusDate = nextDateStr2;
		}
	}
	loadVersus();
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
		"dateStr1" : year + "年" + monthStr + "月" + dayStr + "日" + "&nbsp" + "周" + weekDayStr,
		"dateStr2" : year + "-" + monthStr + "-" + dayStr,
		"millis" : millis
	};
	return dateStr;
};
/*****************************************时间选取器*******************************************/