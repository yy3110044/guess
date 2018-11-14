/*全局参数*/
var itemIds = new Array();//项目id数组，为null或长度为零表示加载所有
var versusIndex = 2; //1、2、3、4
var versusDate = null; //index为3、4时需要此参数
var pageSize = 15;

var originalIntervalSecond = 60;
var intervalSecond = 60;

var mescroll = null;//scroll对象

//初始化数据方法
var initData = function(index, date, seconds){
	if(seconds != null) {
		originalIntervalSecond = seconds;
		intervalSecond = seconds;
	}
	
	$("#vux-scroller-60yre").height($(window).height() - 132);//设置页面高度
	loadAllItem(); //加载所有项目列表
	getUnreadUserNoticeCount(); //加载未读信息数量

	//初始化scroll对象
	mescroll = new MeScroll("vux-scroller-60yre", {
		"down" : {
			"use" : true,
			"auto" : false, //是否在初始化完毕之后自动执行下拉回调callback; 默认true
			"callback" : function(){
				loadVersus(pageSize, 1, true);
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
				loadVersus(pageSize, page.num + 1, true);
			}
		}
	});
	
	if(index == "1") {
		tabBarChange(1, date, $(".vux-tab-container .vux-tab-item").eq(0)[0]);
	} else if(index == "2") {
		tabBarChange(2, date, $(".vux-tab-container .vux-tab-item").eq(1)[0]);
	} else if(index == "3") {
		tabBarChange(3, date, $(".vux-tab-container .vux-tab-item").eq(2)[0]);
	} else if(index == "4") {
		tabBarChange(4, date, $(".vux-tab-container .vux-tab-item").eq(3)[0]);
	} else {
		tabBarChange(2, date, $(".vux-tab-container .vux-tab-item").eq(1)[0]);
	}
	
	setInterval("loadVersusInterval()", 1000); //间隔加载对阵
	setInterval("getUnreadUserNoticeCount();loadVersusOddsAndStatus();", originalIntervalSecond * 1000); //间隔未读信息数，和赔率信息
};

//加载versus
var loadVersus = function(pageSize, pageNo, hideLoading){
	loadData({
		"url" : "v2/versusListM",
		"data" : {
			"pageSize" : pageSize,
			"pageNo" : pageNo,
			"index" : versusIndex,
			"date" : versusDate,
			"itemIds[]" : itemIds
		},
		"success" : function(data) {
			if(data.code == 100) {
				var list = data.result.list;
				var page = data.result.page;
				
				var str = '';
				if(list.length > 0) {
					for(var i=0; i<list.length; i++) {
						var obj = list[i];
						var versus = obj.versus;
						var versusItemList = obj.versusItemList;
						var remainingTime = obj.remainingTime;
						str += getMatchVersusStr(versus, versusItemList, remainingTime);
					}
				} else {
					//结果为空
				}
				$("div.vux-tab-selected .match-number").html(page.rowCount);
				if(pageNo == 1) { //第一页清空
					if(mescroll != null) {
						mescroll.scrollTo(0); //滚动到顶部
						mescroll.setPageNum(1); //把页数重设为1
					}
					$("#betListContainer").empty();
				}
				$("#betListContainer").append(str);
				if(mescroll != null) {
					mescroll.endSuccess(page.pageSize, page.next);//在这里关闭加载提示
				}
			} else {
				m_toast(data.msg);
				if(mescroll != null) {
					mescroll.endErr();//在这里关闭加载提示
				}
			}
		},
		"hideLoading" : hideLoading,
		"complete" : function(data) {
			loadVersusOddsAndStatus(); //加载赔率以及状态
		},
		"error" : function(data) {
			if(mescroll != null) {
				mescroll.endErr();//在这里关闭加载提示
			}
		}
	});
};
var getMatchVersusStr = function(versus, versusItemList, remainingTime) {
	var str = '';
	if("未开始" == versus.status || "进行中" == versus.status) {
		str += '<div data-v-18da170e="" data-v-bf66ef20="" onclick="versusClick(' + versus.id + ')" class="home-match-card" style="height:auto !important;">';
		str += '	<section data-v-18da170e="" class="card-header">';
		str += '		<img data-v-18da170e="" src="' + versus.logoUrl + '" width="20px">';
		str += '		<div data-v-18da170e="" class="tournament-name">' + versus.name + '</div>';
		str += '		<div data-v-18da170e="" class="match-round"></div>';
		if(versus.childVersusCount > 0) {
			str += '		<div data-v-18da170e="" class="play-count">+' + versus.childVersusCount + '</div>';
		}
		str += '	</section>';
		
		if(versus.showTeamLogo) {
			str += '	<section data-v-18da170e="" class="card-body">';
			str += '		<div data-v-18da170e="" class="card-body-team"><img data-v-18da170e="" src="' + versus.leftTeamLogoUrl + '" class="team-logo"></div>';
			str += '		<div data-v-18da170e="" class="card-body-center">';
			str += '			<img data-v-18da170e="" src="data:image/svg+xml;base64,PD94bWwgdmVyc2lvbj0iMS4wIiBlbmNvZGluZz0iVVRGLTgiPz4KPHN2ZyB3aWR0aD0iMjRweCIgaGVpZ2h0PSI3OHB4IiB2aWV3Qm94PSIwIDAgMjQgNzgiIHZlcnNpb249IjEuMSIgeG1sbnM9Imh0dHA6Ly93d3cudzMub3JnLzIwMDAvc3ZnIiB4bWxuczp4bGluaz0iaHR0cDovL3d3dy53My5vcmcvMTk5OS94bGluayI+CiAgICA8IS0tIEdlbmVyYXRvcjogU2tldGNoIDQ5LjMgKDUxMTY3KSAtIGh0dHA6Ly93d3cuYm9oZW1pYW5jb2RpbmcuY29tL3NrZXRjaCAtLT4KICAgIDx0aXRsZT7ljaHniYfljLrliIblibLlt6Y8L3RpdGxlPgogICAgPGRlc2M+Q3JlYXRlZCB3aXRoIFNrZXRjaC48L2Rlc2M+CiAgICA8ZGVmcz4KICAgICAgICA8cmFkaWFsR3JhZGllbnQgY3g9IjEwMCUiIGN5PSI1MCUiIGZ4PSIxMDAlIiBmeT0iNTAlIiByPSI5OC44MDMyODc2JSIgZ3JhZGllbnRUcmFuc2Zvcm09InRyYW5zbGF0ZSgxLjAwMDAwMCwwLjUwMDAwMCksc2NhbGUoMS4wMDAwMDAsMC4zMDAwMDApLHJvdGF0ZSgtMTc5Ljk5OTk5OCksc2NhbGUoMS4wMDAwMDAsMS42MzI1MTgpLHRyYW5zbGF0ZSgtMS4wMDAwMDAsLTAuNTAwMDAwKSIgaWQ9InJhZGlhbEdyYWRpZW50LTEiPgogICAgICAgICAgICA8c3RvcCBzdG9wLWNvbG9yPSIjMEMxMjFGIiBvZmZzZXQ9IjAlIj48L3N0b3A+CiAgICAgICAgICAgIDxzdG9wIHN0b3AtY29sb3I9IiMxQTI1MzgiIHN0b3Atb3BhY2l0eT0iMCIgb2Zmc2V0PSIxMDAlIj48L3N0b3A+CiAgICAgICAgPC9yYWRpYWxHcmFkaWVudD4KICAgIDwvZGVmcz4KICAgIDxnIGlkPSLpm7fnq57mioAyLjAtY29weSIgc3Ryb2tlPSJub25lIiBzdHJva2Utd2lkdGg9IjEiIGZpbGw9Im5vbmUiIGZpbGwtcnVsZT0iZXZlbm9kZCIgZmlsbC1vcGFjaXR5PSIwLjMiPgogICAgICAgIDxnIGlkPSJpY29u5YiH5Zu+IiB0cmFuc2Zvcm09InRyYW5zbGF0ZSgtMTEyLjAwMDAwMCwgLTE5NjUuMDAwMDAwKSIgZmlsbD0idXJsKCNyYWRpYWxHcmFkaWVudC0xKSI+CiAgICAgICAgICAgIDxyZWN0IGlkPSLljaHniYfljLrliIblibLlt6YiIHg9IjExMiIgeT0iMTk2NCIgd2lkdGg9IjI0IiBoZWlnaHQ9IjgwIj48L3JlY3Q+CiAgICAgICAgPC9nPgogICAgPC9nPgo8L3N2Zz4=" class="center-left">';
			if(versus.showTeamScore) {
				str += '			<div data-v-18da170e="" class="team-score"><div data-v-18da170e="">' + versus.leftTeamScore + '</div><div data-v-18da170e="" class="dash-symbol">-</div><div data-v-18da170e="">' + versus.rightTeamScore + '</div></div>';
			} else {
				str += '			<div data-v-18da170e="" class="team-score"><div data-v-18da170e=""></div><div data-v-18da170e="" class="dash-symbol">VS</div><div data-v-18da170e=""></div></div>';
			}
			str += '			<img data-v-18da170e="" src="data:image/svg+xml;base64,PD94bWwgdmVyc2lvbj0iMS4wIiBlbmNvZGluZz0iVVRGLTgiPz4KPHN2ZyB3aWR0aD0iMjRweCIgaGVpZ2h0PSI3OHB4IiB2aWV3Qm94PSIwIDAgMjQgNzgiIHZlcnNpb249IjEuMSIgeG1sbnM9Imh0dHA6Ly93d3cudzMub3JnLzIwMDAvc3ZnIiB4bWxuczp4bGluaz0iaHR0cDovL3d3dy53My5vcmcvMTk5OS94bGluayI+CiAgICA8IS0tIEdlbmVyYXRvcjogU2tldGNoIDQ5LjMgKDUxMTY3KSAtIGh0dHA6Ly93d3cuYm9oZW1pYW5jb2RpbmcuY29tL3NrZXRjaCAtLT4KICAgIDx0aXRsZT7ljaHniYfljLrliIblibLlj7M8L3RpdGxlPgogICAgPGRlc2M+Q3JlYXRlZCB3aXRoIFNrZXRjaC48L2Rlc2M+CiAgICA8ZGVmcz4KICAgICAgICA8cmFkaWFsR3JhZGllbnQgY3g9IjEwMCUiIGN5PSI1MCUiIGZ4PSIxMDAlIiBmeT0iNTAlIiByPSI5OC44MDMyODc2JSIgZ3JhZGllbnRUcmFuc2Zvcm09InRyYW5zbGF0ZSgxLjAwMDAwMCwwLjUwMDAwMCksc2NhbGUoMS4wMDAwMDAsMC4zMDAwMDApLHJvdGF0ZSgtMTc5Ljk5OTk5OCksc2NhbGUoMS4wMDAwMDAsMS42MzI1MTgpLHRyYW5zbGF0ZSgtMS4wMDAwMDAsLTAuNTAwMDAwKSIgaWQ9InJhZGlhbEdyYWRpZW50LTEiPgogICAgICAgICAgICA8c3RvcCBzdG9wLWNvbG9yPSIjMEMxMjFGIiBvZmZzZXQ9IjAlIj48L3N0b3A+CiAgICAgICAgICAgIDxzdG9wIHN0b3AtY29sb3I9IiMxQTI1MzgiIHN0b3Atb3BhY2l0eT0iMCIgb2Zmc2V0PSIxMDAlIj48L3N0b3A+CiAgICAgICAgPC9yYWRpYWxHcmFkaWVudD4KICAgIDwvZGVmcz4KICAgIDxnIGlkPSLpm7fnq57mioAyLjAtY29weSIgc3Ryb2tlPSJub25lIiBzdHJva2Utd2lkdGg9IjEiIGZpbGw9Im5vbmUiIGZpbGwtcnVsZT0iZXZlbm9kZCIgZmlsbC1vcGFjaXR5PSIwLjMiPgogICAgICAgIDxnIGlkPSJpY29u5YiH5Zu+IiB0cmFuc2Zvcm09InRyYW5zbGF0ZSgtMTc2LjAwMDAwMCwgLTE5NjUuMDAwMDAwKSIgZmlsbD0idXJsKCNyYWRpYWxHcmFkaWVudC0xKSI+CiAgICAgICAgICAgIDxyZWN0IGlkPSLljaHniYfljLrliIblibLlj7MiIHRyYW5zZm9ybT0idHJhbnNsYXRlKDE4OC4wMDAwMDAsIDIwMDQuMDAwMDAwKSBzY2FsZSgtMSwgMSkgdHJhbnNsYXRlKC0xODguMDAwMDAwLCAtMjAwNC4wMDAwMDApICIgeD0iMTc2IiB5PSIxOTY0IiB3aWR0aD0iMjQiIGhlaWdodD0iODAiPjwvcmVjdD4KICAgICAgICA8L2c+CiAgICA8L2c+Cjwvc3ZnPg==" class="center-right">';
			str += '		</div>';
			str += '		<div data-v-18da170e="" class="card-body-team"><img data-v-18da170e="" src="' + versus.rightTeamLogoUrl + '" class="team-logo"></div>';
			str += '	</section>';
		}
		
		
		str += '	<div data-v-8d7d541a="" data-v-18da170e="" class="odds-group-title">';
		str += '		<div data-v-8d7d541a="" class="empty-badge">&nbsp;</div>';
		str += '		<div data-v-8d7d541a="" class="title">';
		if("未开始" == versus.status) {
			str += '<span style="color:#758bb5;">即将开始</span>&nbsp;&nbsp;<span style="color:#ffffff;">' + getRemainingTimeStr(remainingTime) + '后</span>';
		} else if("进行中" == versus.status) {
			if(versus.betPause) {
				str += '<span style="color:#758bb5;">下注已暂停</span>';
			} else {
				str += '<span style="color:#758bb5;">已进行了</span>&nbsp;&nbsp;<span style="color:#ffffff;">' + getRemainingTimeStr(remainingTime) + '</span>';
			}
		}
		str += '		</div>';
		str += '		<div style="position:absolute;right:15px;color:#758bb5;">' + versus.itemName + '</div>';
		str += '	</div>';
		
		for(var i=0; i<versusItemList.length; i++) {
			var versusItem = versusItemList[i];
			if(i % 2 == 0) {
				str += '	<section data-v-18da170e="" class="card-footer">';
			}
			str += '		<div data-v-18da170e="" onclick="versusItemClick(' + versusItem.id + ', event)" class="card-odds-btn versus-item versus-item-' + versusItem.id + '" data-versus-item-id="' + versusItem.id + '">';
			str += '			<div data-v-ba6efc5c="" data-v-18da170e="" class="home-match-card-button">';
			str += '				<div data-v-ba6efc5c="" class="button-dark-border">';
			str += '					<div data-v-ba6efc5c="" class="button-content">';
			str += '						<div data-v-ba6efc5c="" class="button-name">' + versusItem.name + '</div>';
			str += '						<div data-v-ba6efc5c="" class="button-odds-content">';
			str += '							<div data-v-ba6efc5c="" class="odds-rising-icon"></div>';
			str += '							<div data-v-ba6efc5c="" class="btn-odds"><span data-v-ba6efc5c="" class="odds"></span></div>';
			str += '							<div data-v-ba6efc5c="" class="odds-dropping-icon"></div>';
			str += '						</div>';
			str += '					</div>';
			str += '				</div>';
			str += '			</div>';
			str += '		</div>';
			if(i == 0) { //状态
				str += '		<div data-v-18da170e="" class="match-status">';
				str += '			<div data-v-18da170e="" class="' + (versus.status == '进行中' ? 'match-is-live' : 'match-is-early') + '">';
				str += '				<div data-v-18da170e="" class="status-icon ' + (versus.status == '进行中' ? 'live-icon' : 'early-icon') + '"></div>';
				str += '				<div data-v-18da170e="" class="match-status-text">' + versus.status + '</div>';
				str += '			</div>';
				str += '		</div>';
			}
			if((i % 2 != 0) || (versusItemList.length - 1 == i)) {
				str += '	</section>';
			}
			
		}
		str += '</div>';
	} else if("已结束" == versus.status || "流局" == versus.status) {
		str += '<div data-v-18da170e="" data-v-bf66ef20="" onclick="versusClick(' + versus.id + ')" class="home-match-card" style="height:auto !important;">';
		str += '	<section data-v-18da170e="" class="card-header">';
		str += '		<img data-v-18da170e="" src="' + versus.logoUrl + '" width="20px">';
		str += '		<div data-v-18da170e="" class="tournament-name">' + versus.name + '</div>';
		str += '		<div data-v-18da170e="" class="match-round"></div>';
		if(versus.childVersusCount > 0) {
			str += '		<div data-v-18da170e="" class="play-count">+' + versus.childVersusCount + '</div>';
		}
		str += '	</section>';
		
		if(versus.showTeamLogo) {
			str += '	<section data-v-18da170e="" class="card-body">';
			str += '		<div data-v-18da170e="" class="card-body-team"><img data-v-18da170e="" src="' + versus.leftTeamLogoUrl + '" class="team-logo"></div>';
			str += '		<div data-v-18da170e="" class="card-body-center">';
			str += '			<img data-v-18da170e="" src="data:image/svg+xml;base64,PD94bWwgdmVyc2lvbj0iMS4wIiBlbmNvZGluZz0iVVRGLTgiPz4KPHN2ZyB3aWR0aD0iMjRweCIgaGVpZ2h0PSI3OHB4IiB2aWV3Qm94PSIwIDAgMjQgNzgiIHZlcnNpb249IjEuMSIgeG1sbnM9Imh0dHA6Ly93d3cudzMub3JnLzIwMDAvc3ZnIiB4bWxuczp4bGluaz0iaHR0cDovL3d3dy53My5vcmcvMTk5OS94bGluayI+CiAgICA8IS0tIEdlbmVyYXRvcjogU2tldGNoIDQ5LjMgKDUxMTY3KSAtIGh0dHA6Ly93d3cuYm9oZW1pYW5jb2RpbmcuY29tL3NrZXRjaCAtLT4KICAgIDx0aXRsZT7ljaHniYfljLrliIblibLlt6Y8L3RpdGxlPgogICAgPGRlc2M+Q3JlYXRlZCB3aXRoIFNrZXRjaC48L2Rlc2M+CiAgICA8ZGVmcz4KICAgICAgICA8cmFkaWFsR3JhZGllbnQgY3g9IjEwMCUiIGN5PSI1MCUiIGZ4PSIxMDAlIiBmeT0iNTAlIiByPSI5OC44MDMyODc2JSIgZ3JhZGllbnRUcmFuc2Zvcm09InRyYW5zbGF0ZSgxLjAwMDAwMCwwLjUwMDAwMCksc2NhbGUoMS4wMDAwMDAsMC4zMDAwMDApLHJvdGF0ZSgtMTc5Ljk5OTk5OCksc2NhbGUoMS4wMDAwMDAsMS42MzI1MTgpLHRyYW5zbGF0ZSgtMS4wMDAwMDAsLTAuNTAwMDAwKSIgaWQ9InJhZGlhbEdyYWRpZW50LTEiPgogICAgICAgICAgICA8c3RvcCBzdG9wLWNvbG9yPSIjMEMxMjFGIiBvZmZzZXQ9IjAlIj48L3N0b3A+CiAgICAgICAgICAgIDxzdG9wIHN0b3AtY29sb3I9IiMxQTI1MzgiIHN0b3Atb3BhY2l0eT0iMCIgb2Zmc2V0PSIxMDAlIj48L3N0b3A+CiAgICAgICAgPC9yYWRpYWxHcmFkaWVudD4KICAgIDwvZGVmcz4KICAgIDxnIGlkPSLpm7fnq57mioAyLjAtY29weSIgc3Ryb2tlPSJub25lIiBzdHJva2Utd2lkdGg9IjEiIGZpbGw9Im5vbmUiIGZpbGwtcnVsZT0iZXZlbm9kZCIgZmlsbC1vcGFjaXR5PSIwLjMiPgogICAgICAgIDxnIGlkPSJpY29u5YiH5Zu+IiB0cmFuc2Zvcm09InRyYW5zbGF0ZSgtMTEyLjAwMDAwMCwgLTE5NjUuMDAwMDAwKSIgZmlsbD0idXJsKCNyYWRpYWxHcmFkaWVudC0xKSI+CiAgICAgICAgICAgIDxyZWN0IGlkPSLljaHniYfljLrliIblibLlt6YiIHg9IjExMiIgeT0iMTk2NCIgd2lkdGg9IjI0IiBoZWlnaHQ9IjgwIj48L3JlY3Q+CiAgICAgICAgPC9nPgogICAgPC9nPgo8L3N2Zz4=" class="center-left">';
			if(versus.showTeamScore) {
				str += '			<div data-v-18da170e="" class="team-score"><div data-v-18da170e="">' + versus.leftTeamScore + '</div><div data-v-18da170e="" class="dash-symbol">-</div><div data-v-18da170e="">' + versus.rightTeamScore + '</div></div>';
			} else {
				str += '			<div data-v-18da170e="" class="team-score"><div data-v-18da170e=""></div><div data-v-18da170e="" class="dash-symbol">VS</div><div data-v-18da170e=""></div></div>';
			}
			str += '			<img data-v-18da170e="" src="data:image/svg+xml;base64,PD94bWwgdmVyc2lvbj0iMS4wIiBlbmNvZGluZz0iVVRGLTgiPz4KPHN2ZyB3aWR0aD0iMjRweCIgaGVpZ2h0PSI3OHB4IiB2aWV3Qm94PSIwIDAgMjQgNzgiIHZlcnNpb249IjEuMSIgeG1sbnM9Imh0dHA6Ly93d3cudzMub3JnLzIwMDAvc3ZnIiB4bWxuczp4bGluaz0iaHR0cDovL3d3dy53My5vcmcvMTk5OS94bGluayI+CiAgICA8IS0tIEdlbmVyYXRvcjogU2tldGNoIDQ5LjMgKDUxMTY3KSAtIGh0dHA6Ly93d3cuYm9oZW1pYW5jb2RpbmcuY29tL3NrZXRjaCAtLT4KICAgIDx0aXRsZT7ljaHniYfljLrliIblibLlj7M8L3RpdGxlPgogICAgPGRlc2M+Q3JlYXRlZCB3aXRoIFNrZXRjaC48L2Rlc2M+CiAgICA8ZGVmcz4KICAgICAgICA8cmFkaWFsR3JhZGllbnQgY3g9IjEwMCUiIGN5PSI1MCUiIGZ4PSIxMDAlIiBmeT0iNTAlIiByPSI5OC44MDMyODc2JSIgZ3JhZGllbnRUcmFuc2Zvcm09InRyYW5zbGF0ZSgxLjAwMDAwMCwwLjUwMDAwMCksc2NhbGUoMS4wMDAwMDAsMC4zMDAwMDApLHJvdGF0ZSgtMTc5Ljk5OTk5OCksc2NhbGUoMS4wMDAwMDAsMS42MzI1MTgpLHRyYW5zbGF0ZSgtMS4wMDAwMDAsLTAuNTAwMDAwKSIgaWQ9InJhZGlhbEdyYWRpZW50LTEiPgogICAgICAgICAgICA8c3RvcCBzdG9wLWNvbG9yPSIjMEMxMjFGIiBvZmZzZXQ9IjAlIj48L3N0b3A+CiAgICAgICAgICAgIDxzdG9wIHN0b3AtY29sb3I9IiMxQTI1MzgiIHN0b3Atb3BhY2l0eT0iMCIgb2Zmc2V0PSIxMDAlIj48L3N0b3A+CiAgICAgICAgPC9yYWRpYWxHcmFkaWVudD4KICAgIDwvZGVmcz4KICAgIDxnIGlkPSLpm7fnq57mioAyLjAtY29weSIgc3Ryb2tlPSJub25lIiBzdHJva2Utd2lkdGg9IjEiIGZpbGw9Im5vbmUiIGZpbGwtcnVsZT0iZXZlbm9kZCIgZmlsbC1vcGFjaXR5PSIwLjMiPgogICAgICAgIDxnIGlkPSJpY29u5YiH5Zu+IiB0cmFuc2Zvcm09InRyYW5zbGF0ZSgtMTc2LjAwMDAwMCwgLTE5NjUuMDAwMDAwKSIgZmlsbD0idXJsKCNyYWRpYWxHcmFkaWVudC0xKSI+CiAgICAgICAgICAgIDxyZWN0IGlkPSLljaHniYfljLrliIblibLlj7MiIHRyYW5zZm9ybT0idHJhbnNsYXRlKDE4OC4wMDAwMDAsIDIwMDQuMDAwMDAwKSBzY2FsZSgtMSwgMSkgdHJhbnNsYXRlKC0xODguMDAwMDAwLCAtMjAwNC4wMDAwMDApICIgeD0iMTc2IiB5PSIxOTY0IiB3aWR0aD0iMjQiIGhlaWdodD0iODAiPjwvcmVjdD4KICAgICAgICA8L2c+CiAgICA8L2c+Cjwvc3ZnPg==" class="center-right">';
			str += '		</div>';
			str += '		<div data-v-18da170e="" class="card-body-team"><img data-v-18da170e="" src="' + versus.rightTeamLogoUrl + '" class="team-logo"></div>';
			str += '	</section>';
		}
		
		str += '	<div data-v-8d7d541a="" data-v-18da170e="" class="odds-group-title"><div data-v-8d7d541a="" class="empty-badge">&nbsp;</div><div data-v-8d7d541a="" class="title" style="color:#758bb5;">' + versus.itemName + '</div></div>';
		
		for(var i=0; i<versusItemList.length; i++) {
			var versusItem = versusItemList[i];
			var result = "";
			if("流局" == versus.status) {
				result = "liu-flag";
			} else if ("已结束" == versus.status) {
				if(versus.resultItemId == versusItem.id) {
					result = "win-flag";
				} else {
					result = "lose-flag";
				}
			}
			if(i % 2 == 0) {
				str += '<section data-v-18da170e="" class="card-footer">';
				str += '	<div data-v-18da170e="" class="card-odds-btn">';
				str += '		<div data-v-ba6efc5c="" data-v-18da170e="" class="home-match-card-button btn-over">';
				str += '			<div data-v-ba6efc5c="" class="button-dark-border">';
				str += '				<div data-v-ba6efc5c="" class="button-content"><div data-v-ba6efc5c="" class="button-name">' + versusItem.name + '</div></div>';
				str += '			</div>';
				str += '		</div>';
				str += '	</div>';
				str += '	<div data-v-18da170e="" class="match-status">';
				str += '		<div data-v-18da170e="" class="match-flag">';
				str += '			<div data-v-18da170e="" class="flag ' + result + '"></div>';
			}
			if(i % 2 != 0) {
				str += '			<div data-v-18da170e="" class="flag ' + result + '"></div>';
				str += '		</div>';
				str += '	</div>';
				str += '	<div data-v-18da170e="" class="card-odds-btn">';
				str += '		<div data-v-ba6efc5c="" data-v-18da170e="" class="home-match-card-button btn-over">';
				str += '			<div data-v-ba6efc5c="" class="button-dark-border">';
				str += '				<div data-v-ba6efc5c="" class="button-content"><div data-v-ba6efc5c="" class="button-name">' + versusItem.name + '</div></div>';
				str += '			</div>';
				str += '		</div>';
				str += '	</div>';
				str += '</section>';
			}
			if(i % 2 == 0 && (versusItemList.length - 1 == i)) {
				str += '			<div data-v-18da170e="" class="flag"></div>';
				str += '		</div>';
				str += '	</div>';
				str += '	<div data-v-18da170e="" class="card-odds-btn" style="visibility:hidden;">';
				str += '		<div data-v-ba6efc5c="" data-v-18da170e="" class="home-match-card-button btn-over">';
				str += '			<div data-v-ba6efc5c="" class="button-dark-border">';
				str += '				<div data-v-ba6efc5c="" class="button-content"><div data-v-ba6efc5c="" class="button-name"></div></div>';
				str += '			</div>';
				str += '		</div>';
				str += '	</div>';
				str += '</section>';
			}
		}
		str += '</div>';
	}
	return str;
};
//竞猜点击事件
var versusClick = function(versusId) {
	window.location.href = "m/betDetail.jsp?versusId=" + versusId + "&index=" + versusIndex + "&date=" + (empty(versusDate) ? "" : versusDate);
};
//竞猜项点击事件
var versusItemClick = function(versusItemId, event) {
	var btnE = $("div.versus-item-" + versusItemId + " div.home-match-card-button");
	if(!btnE.hasClass("btn-locked")) {
		if(btnE.hasClass("btn-selected")) {
			numberInputClose();
			$("div.versus-item div.btn-selected").removeClass("btn-selected");
		} else {
			numberInputOpen(versusItemId);//打开下注框
			$("div.versus-item div.btn-selected").removeClass("btn-selected");
			btnE.addClass("btn-selected");
		}
	}
	event.stopPropagation();//阻止事件传递
};

/**********************************************下注框相关方法******************************************************************/
//打开下注框方法
var numberInputOpen = function(versusItemId) {
	numberInputShow(); //先显示下注框
	loadData({
		"url" : "v2/getVersusAndVersusItemByVersusItemId",
		"data" : {"versusItemId" : versusItemId},
		"hideLoading" : true,
		"success" : function(data) {
			if(data.code == 100) {
				numberInputDataAdd(data.result.versus, data.result.versusItem, data.result.odds, data.result.balance);
			} else {
				m_toast(data.msg);
			}
		}
	});
};
//下注框关闭方法
var numberInputClose = function() {
	numberInputDataClean();//先清除数据
	numberInputHide();//隐藏下注框
	$("div.versus-item div.btn-selected").removeClass("btn-selected");
};
//下注框填充数据方法
var numberInputDataAdd = function(versus, versusItem, odds, balance) {
	$("#numberInputDiv").attr("data-versus-id", versus.id);
	$("#numberInputDiv").attr("data-versus-item-id", versusItem.id);
	$("#numberInputDiv .remove-all").html(versus.name);
	$("#numberInputDiv #userBalanceDiv").html("¥" + formatNumber(balance));
	$("#numberInputDiv #userBalanceDiv").attr("data-balance", balance);
	$("#numberInputDiv #userBalanceDiv").attr("data-bet-amount-min", versus.betAmountMin);
	$("#numberInputDiv #userBalanceDiv").attr("data-bet-amount-max", versus.betAmountMax);
	$("#numberInputDiv .odds-name").html(versusItem.name);
	$("#numberInputDiv .money-odds").html("赔率&nbsp;" + formatNumber(odds));
	$("#numberInputDiv .money-odds").attr("data-odds", odds);
	$("#numberInputDiv .money-odds").attr("data-current-versus-id", versusItem.id);
	$("#numberInputDiv .return-amount").html("¥0.00");
	$("#numberInputDiv .bet-slip-pop-note").hide();
	$("#numberInputDiv .money-odds").removeClass("money-odds-change");
	calculateAndShowOdds();//计算并显示赔率
};
//下注框数据清除方法
var numberInputDataClean = function() {
	$("#numberInputDiv").attr("data-versus-id", "");
	$("#numberInputDiv").attr("data-versus-item-id", "");
	$("#numberInputDiv .remove-all").empty();
	$("#numberInputDiv #userBalanceDiv").empty();
	$("#numberInputDiv #userBalanceDiv").attr("data-balance", "");
	$("#numberInputDiv #userBalanceDiv").attr("data-bet-amount-min", "");
	$("#numberInputDiv #userBalanceDiv").attr("data-bet-amount-max", "");
	$("#numberInputDiv .odds-name").empty();
	$("#numberInputDiv .money-odds").empty();
	$("#numberInputDiv .money-odds").attr("data-odds", "");
	$("#numberInputDiv .money-odds").attr("data-current-versus-id", "");
	$("#numberInputDiv .return-amount").empty();
	$("#numberInputDiv .bet-slip-pop-note").hide();
	$("#numberInputDiv .money-odds").removeClass("money-odds-change");
};
//下注框显示方法
var numberInputShow = function() {
	$("#numberInputDiv").slideDown();
};
//下注框隐藏方法
var numberInputHide = function() {
	$("#numberInputDiv").slideUp();
};
//输入方法
var numberInput = function(str) {
	var userBalance = parseFloat($("#numberInputDiv #userBalanceDiv").attr("data-balance"));
	var betAmountMin = parseFloat($("#numberInputDiv #userBalanceDiv").attr("data-bet-amount-min"));
	var betAmountMax = parseFloat($("#numberInputDiv #userBalanceDiv").attr("data-bet-amount-max"));
	
	var inputValueSpan = $("#numberInputDiv #inputValueSpan");
	var value = $.trim(inputValueSpan.attr("data-value"));
	if("ok" == str) {//下注
		if(empty(value)) {
			m_toast("请输入下注金额");
		} else {
			loadData({
				"url" : "user/v2/bet",
				"data" : {
					"versusId" : $("#numberInputDiv").attr("data-versus-id"),
					"versusItemId" : $("#numberInputDiv").attr("data-versus-item-id"),
					"betAmount" : value
				},
				"success" : function(data) {
					if(data.code == 100) { //下注成功
						var bet = data.result.bet;
						var versus = data.result.versus;
						var versusItem = data.result.versusItem;
						betSuccessOpen(versus, versusItem, bet);
					} else if(data.code == 106) { //余额不足
						m_confirm("您的余额不足，是否前往充值？", function(){
							window.location.href = 'm/usercenter/wallet/index.jsp';
						});
					} else if(data.code == 200) { //未登陆
						m_confirm("您还未登录，请先登录", function(){
							window.location.href = "m/login.jsp";
						});
					} else {
						m_toast(data.msg);
					}
				}
			});
		}
	} else if("max" == str) {
		var tmp = parseInt((userBalance < betAmountMax ? userBalance : betAmountMax), 10);
		if(tmp > 999999) {
			tmp = 999999;
		}
		value = "" + tmp;
	} else if("x" == str) {
		if(!empty(value)) {
			value = value.substring(0, value.length - 1);
		}
	} else {
		if(value.length < 6) {
			value = value + str;
		}
	}
	if(!empty(value)) {
		var amount = parseInt(value, 10);
		if(amount > userBalance) {
			inputValueSpan.parent().addClass("stake-input-over");
		} else {
			inputValueSpan.parent().removeClass("stake-input-over");
		}
		inputValueSpan.attr("class", "input-text");
		inputValueSpan.html(amount);
		inputValueSpan.attr("data-value", amount);
		calculateAndShowOdds();//计算并显示赔率
	} else {
		inputValueSpan.parent().removeClass("stake-input-over");
		inputValueSpan.attr("class", "input-placeholder");
		$("#numberInputDiv .return-amount").html("¥0.00");
		inputValueSpan.html("输入金额");
		inputValueSpan.attr("data-value", "");
	}
}
//下注成功页打开
var betSuccessOpen = function(versus, versusItem, bet) {
	$("#betSuccessDiv .versus-logo-url").css("background-image", "url('" + versus.logoUrl + "')");
	$("#betSuccessDiv .versus-name").html(versus.name);
	$("#betSuccessDiv .versus-item-name").html(versusItem.name);
	$("#betSuccessDiv .bet-amount").html("¥" + formatNumber(bet.betAmount));
	$("#betSuccessDiv .bet-odds").html(formatNumber(bet.odds));
	$("#betSuccessDiv .bet-bonus").html("¥" + formatNumber(bet.betAmount * bet.odds));
	$("#betSuccessDiv .bet-time").html(bet.createTime);
	$("#betSuccessDiv .item-name").html(versus.itemName);
	$("#betSuccessDiv").show();
};
//下注成功页关闭
var betSuccessClose = function(){
	$("#betSuccessDiv .versus-logo-url").css("background-image", "");
	$("#betSuccessDiv .versus-name").html("");
	$("#betSuccessDiv .versus-item-name").html("");
	$("#betSuccessDiv .bet-amount").html("");
	$("#betSuccessDiv .bet-odds").html("");
	$("#betSuccessDiv .bet-bonus").html("");
	$("#betSuccessDiv .bet-time").html("");
	$("#betSuccessDiv .item-name").html("");
	$("#numberInputDiv #inputValueSpan").attr("class", "input-placeholder");
	$("#numberInputDiv #inputValueSpan").html("输入金额");
	$("#numberInputDiv #inputValueSpan").attr("data-value", "");
	$("#betSuccessDiv").hide();
	numberInputClose();//关闭下注框
};
//计算赔率
var calculateAndShowOdds = function() {
	var odds = $.trim($("#numberInputDiv .money-odds").attr("data-odds"));
	var amount = $.trim($("#numberInputDiv #inputValueSpan").attr("data-value"));
	if(!empty(odds) && !empty(amount)) {
		var oddsValue = parseFloat(odds) * parseFloat(amount);
		$("#numberInputDiv .return-amount").html("¥" + formatNumber(oddsValue));
	} else {
		$("#numberInputDiv .return-amount").html("¥0.00");
	}
};
//检查numberInputDivOdds
var checkNumberInputDivOdds = function(obj) {
	var oddsE = $("#numberInputDiv .money-odds");
	if(oddsE.attr("data-current-versus-id") == obj.versusItemId) {
		if(parseFloat(oddsE.attr("data-odds")) != obj.odds) {//赔率发生成变化
			oddsE.addClass("money-odds-change");
			oddsE.html("赔率&nbsp;" + formatNumber(obj.odds));
			oddsE.attr("data-odds", obj.odds);
			$("#numberInputDiv .bet-slip-pop-note").show();
			calculateAndShowOdds();//计算赔率
		}
	}
};
/**********************************************下注框相关方法******************************************************************/

//加载竞猜状态以及赔率
var loadVersusOddsAndStatus = function() {
	var versusItemIds = new Array();
	$("div.versus-item").each(function(){
		var versusItemId = $.trim($(this).attr("data-versus-item-id"));
		if(!empty(versusItemId)) {
			versusItemIds.push(versusItemId);
		}
	});
	if(versusItemIds.length > 0) {
		loadData({
			"url" : "v2/getOddsAndStatus",
			"hideLoading" : true,
			"data" : {"versusItemIds[]" : versusItemIds},
			"success" : function(data) {
				if(data.code == 100) {
					var list = data.result;
					for(var i=0; i<list.length; i++) {
						var obj = list[i];
						showOddsAndStatus(list[i], $("div.versus-item-" + obj.versusItemId));
						checkNumberInputDivOdds(list[i]);
					}
				} else {
					m_toast(data.msg);
				}
			}
		});
	}
};
//显示赔率
var versusItemOddsArray = new Array(); //赔率数组
var showOddsAndStatus = function(obj, e) {
	if(obj == null || obj.pause) { //对象为空，或者下注暂停了
		e.find(".home-match-card-button").addClass("btn-locked");
		e.find(".odds").empty();
		e.removeClass("btn-odds-dropping");
		e.removeClass("btn-odds-rising");
	} else {
		e.find(".home-match-card-button").removeClass("btn-locked");
		var oddsSpan = e.find(".odds");
		var oldOdds = versusItemOddsArray["versusItem" + obj.versusItemId];
		if(oldOdds == null || oldOdds == obj.odds) { //赔率没变或者第一次加载赔率
			oddsSpan.html(formatNumber(obj.odds));
			e.removeClass("btn-odds-dropping");
			e.removeClass("btn-odds-rising");
		} else {
			if(obj.odds > oldOdds) { //赔率涨了
				oddsSpan.html(formatNumber(obj.odds));
				e.removeClass("btn-odds-dropping");
				e.addClass("btn-odds-rising");
			} else if(obj.odds < oldOdds) { //赔率跌了
				oddsSpan.html(formatNumber(obj.odds));
				e.removeClass("btn-odds-rising");
				e.addClass("btn-odds-dropping");
			}
		}
		versusItemOddsArray["versusItem" + obj.versusItemId] = obj.odds;
	}
};

//计算剩余时间字符串
var getRemainingTimeStr = function(remainingTime){
	if(remainingTime == null) {
		return "";
	}
	remainingTime = Math.abs(remainingTime);
	if(remainingTime <= 0) {
		return "0秒";
	} else if(remainingTime > 0 && remainingTime < 60000) { //小于一分(60秒)
		return parseInt(remainingTime / 1000) + "秒";
	} else if(remainingTime >= 60000 && remainingTime < 3600000) { //大于一分小于1小时(60分)
		return parseInt(remainingTime / 1000 / 60) + "分钟";
	} else if(remainingTime >= 3600000 && remainingTime < 86400000) { //大于1小时小于一天(24小时)
		return parseInt(remainingTime / 1000 / 60 / 60) + "小时";
	} else { //大于等于一天
		return parseInt(remainingTime / 1000 / 60 / 60 / 24) + "天";
	}
};

//间隔加载对阵方法
var loadVersusInterval = function() {
	if(!($("#numberInputDiv").is(":hidden"))) { //如果打开了输入框，则不计时
		return;
	}
	if(intervalSecond > 0) {
		intervalSecond --;
	} else {
		loadVersus(pageSize, 1, true);
		intervalSecond = originalIntervalSecond;
	}
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
					str += '<div data-v-cd1e9d3c="" onclick="itemSelect(' + obj.id + ', this)" data-item-id="' + obj.id + '" class="guess-item vux-checker-item vux-tap-active default-checker-item selected-all-games">';
					str += '	<div data-v-cd1e9d3c="" style="height:2px;">&nbsp;</div>';
					str += '	<div data-v-cd1e9d3c="" class="games-info">';
					str += '		<div data-v-cd1e9d3c="" class="games-icon" style="background-image: url(\'' + obj.logoUrl + '\');"></div>';
					str += '		<div data-v-cd1e9d3c="">' + obj.name + '</div>';
					str += '	</div>';
					str += '	<div data-v-cd1e9d3c="" class="selected-checker-light"></div>';
					str += '</div>';
				}
				$("div.guess-item").remove();
				$("div.checker-content").append(str);
			}
		}
	});
};

//滚动条变换、菜单切换
var tabBarChange = function(index, date, ts) {
	var e = $("div.vux-tab-ink-bar-transition-backward");
	$("div.vux-tab-item").removeClass("vux-tab-selected");
	$("div.vux-tab-item").css("color", "rgb(186, 206, 241)");

	$(ts).addClass("vux-tab-selected");
	$(ts).css("color", "rgb(255, 255, 255)");
	if(1 == index) {
		versusIndex = 1;
		versusDate = null;
		loadSystemNotice(); //加载系统公告
		e.css("left", "0%");
		e.css("right", "75%");
	} else if(2 == index) {
		versusIndex = 2;
		versusDate = null;
		loadSystemNotice(); //加载系统公告
		e.css("left", "25%");
		e.css("right", "50%");
	} else if(3 == index) {
		versusIndex = 3;
		showDatePicker(); //显示时间选择器
		if(!empty(date)) {
			versusDate = date;
		}
		e.css("left", "50%");
		e.css("right", "25%");
	} else if(4 == index) {
		versusIndex = 4;
		showDatePicker(); //显示时间选择器
		if(!empty(date)) {
			versusDate = date;
		}
		e.css("left", "75%");
		e.css("right", "0%");
	}
	loadVersus(pageSize, 1, false);
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
		itemIds = new Array();
	} else {//全部
		itemIds = new Array();
		$("div.selected-checker-item").each(function(){
			itemIds.push($(this).attr("data-item-id"));
		});
	}
	closeItemSelect();
	loadVersus(pageSize, 1, false);
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
	loadVersus(pageSize, 1, false);
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
	loadVersus(pageSize, 1, false);
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


/*****************************************betDetail*******************************************/
//初始化
var betDetailInit = function(versusId, seconds) {
	loadData({
		"url" : "v2/getVersusAndChildVersusByVersusId",
		"data" : {"versusId" : versusId},
		"success" : function(data) {
			if(data.code == 100) {
				var versus = data.result.versus;
				var childVersusList = data.result.childVersusList;
				fillVersusData(versus, childVersusList);
			} else {
				m_toast(data.msg);
			}
		},
		"complete" : function(data) {
			loadVersusOddsAndStatus(); //加载赔率以及状态
		}
	});
	setInterval("loadVersusOddsAndStatus();", seconds * 1000); //间隔加载赔率信息
};
//填充数据
var fillVersusData = function(versus, childVersusList) {
	$("#vux_view_box_body .betting-page").append(getVersusStr(versus));
	if(childVersusList.length > 0) {
		$("#vux_view_box_body .betting-page").append('<section data-v-31296f00="" class="betting-odds"><div data-v-31296f00="" class="stage-title"><div data-v-31296f00="" class="stage-border"></div>相关竞猜<div data-v-31296f00="" class="stage-border"></div></div></section>');
		for(var i=0; i<childVersusList.length; i++) {
			$("#vux_view_box_body .betting-page").append(getVersusStr(childVersusList[i]));
		}
	}
};
var getVersusStr = function(versus) {
	var str = '';
	if("未开始" == versus.versus.status || "进行中" == versus.versus.status) {
		str += '<section data-v-31296f00="" class="betting-odds">';
		str += '	<section data-v-31296f00="" class="info-title">';
		str += '		<img data-v-31296f00="" src="' + versus.versus.logoUrl + '" width="20px">';
		str += '		<div data-v-31296f00="" class="tournament-name">' + versus.versus.name + '</div>';
		if("未开始" == versus.versus.status) {
			str += '		<div data-v-31296f00="" class="match-round" style="color:#2197f4;">' + versus.versus.status + '</div>';
		} else if("进行中" == versus.versus.status) {
			str += '		<div data-v-31296f00="" class="match-round" style="color:#1ffdfa;">' + versus.versus.status + '</div>';
		} else if("已结束" == versus.versus.status) {
			str += '		<div data-v-31296f00="" class="match-round">' + versus.versus.status + '</div>';
		} else if("流局" == versus.versus.status) {
			str += '		<div data-v-31296f00="" class="match-round">' + versus.versus.status + '</div>';
		} else {
			str += '		<div data-v-31296f00="" class="match-round">' + versus.versus.status + '</div>';
		}
		str += '	</section>';
		str += '	<div data-v-31296f00="" class="group-list">';
		str += '		<div data-v-8d7d541a="" data-v-31296f00="" class="odds-group-title">';
		str += '			<div data-v-8d7d541a="" class="empty-badge"></div>';
		str += '			<div data-v-8d7d541a="" class="title" style="color:#758bb5;">' + versus.versus.itemName + '</div>';
		str += '		</div>';
		
		for(var i=0; i<versus.versusItemList.length; i++) {//竞猜项
			var versusItem = versus.versusItemList[i];
			if(i % 2 == 0) {
				str += '<div data-v-31296f00="" class="group-odds">';
				str += '	<div data-v-31296f00="" onclick="versusItemClick(' + versusItem.id + ', event)" class="odds-btn versus-item versus-item-' + versusItem.id + '" data-versus-item-id="' + versusItem.id + '">';
				str += '		<div data-v-549598f5="" data-v-31296f00="" class="home-match-card-button">';
				str += '			<div data-v-549598f5="" class="button-dark-border">';
				str += '				<div data-v-549598f5="" class="button-content btn-left">';
				str += '					<div data-v-549598f5="" class="button-name">' + versusItem.name + '</div>';
				str += '					<div data-v-549598f5="" class="button-odds-content">';
				str += '						<div data-v-549598f5="" class="odds-rising-icon"></div>';
				str += '						<div data-v-549598f5="" class="odds-dropping-icon"></div>';
				str += '						<div data-v-549598f5="" class="btn-odds"><span data-v-549598f5="" class="odds"></span></div>';
				str += '					</div>';
				str += '				</div>';
				str += '			</div>';
				str += '		</div>';
				str += '	</div>';
			}
			
			if(i % 2 != 0) {
				str += '	<div data-v-31296f00="" onclick="versusItemClick(' + versusItem.id + ', event)" class="odds-btn versus-item versus-item-' + versusItem.id + '" data-versus-item-id="' + versusItem.id + '">';
				str += '		<div data-v-549598f5="" data-v-31296f00="" class="home-match-card-button">';
				str += '			<div data-v-549598f5="" class="button-dark-border">';
				str += '				<div data-v-549598f5="" class="button-content btn-right">';
				str += '					<div data-v-549598f5="" class="button-odds-content">';
				str += '						<div data-v-549598f5="" class="btn-odds"><span data-v-549598f5="" class="odds"></span></div>';
				str += '						<div data-v-549598f5="" class="odds-rising-icon"></div>';
				str += '						<div data-v-549598f5="" class="odds-dropping-icon"></div>';
				str += '					</div>';
				str += '					<div data-v-549598f5="" class="button-name">' + versusItem.name + '</div>';
				str += '				</div>';
				str += '			</div>';
				str += '		</div>';
				str += '	</div>';
				str += '</div>';
			}
			
			if((i % 2 == 0) && (versus.versusItemList.length - 1 == i)) {
				str += '	<div data-v-31296f00="" class="odds-btn" style="visibility:hidden;">';
				str += '		<div data-v-549598f5="" data-v-31296f00="" class="home-match-card-button">';
				str += '			<div data-v-549598f5="" class="button-dark-border">';
				str += '				<div data-v-549598f5="" class="button-content btn-right">';
				str += '					<div data-v-549598f5="" class="button-odds-content">';
				str += '						<div data-v-549598f5="" class="btn-odds"><span data-v-549598f5=""></span></div>';
				str += '						<div data-v-549598f5="" class="odds-rising-icon"></div>';
				str += '						<div data-v-549598f5="" class="odds-dropping-icon"></div>';
				str += '					</div>';
				str += '					<div data-v-549598f5="" class="button-name"></div>';
				str += '				</div>';
				str += '			</div>';
				str += '		</div>';
				str += '	</div>';
				str += '</div>';
			}
		}
		
		str += '	</div>';
		str += '</section>';
	} else if("已结束" == versus.versus.status || "流局" == versus.versus.status) {
		str += '<section data-v-31296f00="" class="betting-odds">';
		str += '	<section data-v-31296f00="" class="info-title">';
		str += '		<img data-v-31296f00="" src="' + versus.versus.logoUrl + '" width="20px">';
		str += '		<div data-v-31296f00="" class="tournament-name">' + versus.versus.name + '</div>';
		if("未开始" == versus.versus.status) {
			str += '		<div data-v-31296f00="" class="match-round" style="color:#2197f4;">' + versus.versus.status + '</div>';
		} else if("进行中" == versus.versus.status) {
			str += '		<div data-v-31296f00="" class="match-round" style="color:#1ffdfa;">' + versus.versus.status + '</div>';
		} else if("已结束" == versus.versus.status) {
			str += '		<div data-v-31296f00="" class="match-round">' + versus.versus.status + '</div>';
		} else if("流局" == versus.versus.status) {
			str += '		<div data-v-31296f00="" class="match-round">' + versus.versus.status + '</div>';
		} else {
			str += '		<div data-v-31296f00="" class="match-round">' + versus.versus.status + '</div>';
		}
		str += '	</section>';
		str += '	<div data-v-31296f00="" class="group-list">';
		str += '		<div data-v-8d7d541a="" data-v-31296f00="" class="odds-group-title">';
		str += '			<div data-v-8d7d541a="" class="empty-badge"></div>';
		str += '			<div data-v-8d7d541a="" class="title" style="color:#758bb5;">' + versus.versus.itemName + '</div>';
		str += '		</div>';
		for(var i=0; i<versus.versusItemList.length; i++) {//竞猜项
			var versusItem = versus.versusItemList[i];
			var resultClass = "";
			if(versus.versus.status == "流局") {
				resultClass = "liu-icon";
			} else {
				if(versus.versus.resultItemId == versusItem.id) {
					resultClass = "win-icon";
				} else {
					resultClass = "lose-icon";
				}
			}
			if(i % 2 == 0) {
				str += '<div data-v-31296f00="" class="group-odds">';
				str += '	<div data-v-31296f00="" class="odds-btn">';
				str += '		<div data-v-549598f5="" data-v-31296f00="" class="home-match-card-button btn-over">';
				str += '			<div data-v-549598f5="" class="button-dark-border">';
				str += '				<div data-v-549598f5="" class="button-content btn-left">';
				str += '					<div data-v-549598f5="" class="button-name">' + versusItem.name + '</div>';
				str += '					<div data-v-549598f5="" class="' + resultClass + '"></div>';
				str += '				</div>';
				str += '			</div>';
				str += '		</div>';
				str += '	</div>';
			}
			if(i % 2 != 0) {
				str += '	<div data-v-31296f00="" class="odds-btn">';
				str += '		<div data-v-549598f5="" data-v-31296f00="" class="home-match-card-button btn-over">';
				str += '			<div data-v-549598f5="" class="button-dark-border">';
				str += '				<div data-v-549598f5="" class="button-content btn-right">';
				str += '					<div data-v-549598f5="" class="' + resultClass + '"></div>';
				str += '					<div data-v-549598f5="" class="button-name">' + versusItem.name + '</div>';
				str += '				</div>';
				str += '			</div>';
				str += '		</div>';
				str += '	</div>';
				str += '</div>';
			}
			if((i % 2 == 0) && (versus.versusItemList.length - 1 == i)) {
				str += '	<div data-v-31296f00="" class="odds-btn" style="visibility:hidden;">';
				str += '		<div data-v-549598f5="" data-v-31296f00="" class="home-match-card-button btn-over">';
				str += '			<div data-v-549598f5="" class="button-dark-border">';
				str += '				<div data-v-549598f5="" class="button-content btn-right">';
				str += '					<div data-v-549598f5="" class=""></div>';
				str += '					<div data-v-549598f5="" class="button-name"></div>';
				str += '				</div>';
				str += '			</div>';
				str += '		</div>';
				str += '	</div>';
				str += '</div>';
			}
		}
		str += '	</div>';
		str += '</section>';
	}
	return str;
};
/*****************************************betDetail*******************************************/