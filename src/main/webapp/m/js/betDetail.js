var initData = function(versusId){
	loadMatchVersus(versusId);
};

//加载对阵信息
var loadMatchVersus = function(versusId){
	loadData({
		"url" : "getMatchVersusAndVersusBo",
		"data" : {"versusId" : versusId},
		"hideLoading" : true,
		"success" : function(data) {
			if(data.code == 100) {
				var versus = data.result.versus;
				var boList = data.result.boList;
				var startTimeFormatStr = data.result.startTimeFormatStr;
				
				$("#vux_view_box_body .info-title img").attr("src", versus.matchLogoUrl);
				$("#vux_view_box_body .info-title .tournament-name").html(versus.sportName + "&nbsp;" + versus.matchName + "&nbsp;" + versus.name);
				$("#vux_view_box_body .info-title .match-round").html('&nbsp;/&nbsp;bo' + versus.boCount);
				$("#vux_view_box_body .info-team .left-team img").attr("src", versus.leftTeamLogoUrl);
				$("#vux_view_box_body .info-team .left-team .team-name").html(versus.leftTeamName);
				var str = '';
				if("进行中" == versus.status) {
					str += '<div data-v-31296f00="" class="status-live">';
					str += '	<div data-v-31296f00="" class="score">' + versus.leftTeamScore + '</div>';
					str += '	<div data-v-31296f00="" class="in-play">' + versus.status + '</div>';
					str += '	<div data-v-31296f00="" class="score">' + versus.rightTeamScore + '</div>';
					str += '</div>';
					str += '<div data-v-31296f00="" class="is-live">';
					str += '	<div data-v-31296f00="" class="stream-icon"></div>';
					str += '	<div data-v-31296f00="">直播</div>';
					str += '</div>';
				} else {
					str += '<div data-v-31296f00="" class="status-early">';
					str += '	<div data-v-31296f00="" class="is-early">';
					str += '		<div data-v-31296f00="" class="match-date">' + startTimeFormatStr + '</div>';
					str += '		<div data-v-31296f00="" class="match-time">' + versus.startTime.substring(11, 16) + '</div>';
					str += '	</div>';
					str += '</div>';
					str += '<div data-v-31296f00="" class="' + (versus.status == '未开始' ? 'is-raedy' : 'is-over') + '">' + versus.status + '</div>';
				}
				$("#vux_view_box_body .info-team .betting-status").html(str);
				$("#vux_view_box_body .info-team .right-team img").attr("src", versus.rightTeamLogoUrl);
				$("#vux_view_box_body .info-team .right-team .team-name").html(versus.rightTeamName);
				
				var boTitleStr = '';
				if(versus.boCount > 4) {
					boTitleStr += '<div class="vux-tab scrollable">';
					boTitleStr += '<div data-v-31296f00="" onclick="boTitleClick(' + versus.id + ', 0, this)" class="vux-tab-item vux-tab-selected" style="border:none;color:rgb(255, 255, 255);">全场</div>';
					for(var i=1; i<=versus.boCount; i++) {
						boTitleStr += '<div data-v-31296f00="" onclick="boTitleClick(' + versus.id + ', ' + i + ', this)" class="vux-tab-item" style="border:none;color:rgb(186, 206, 241);">第' + i + '局</div>';
					}
					boTitleStr += '<div class="vux-tab-ink-bar vux-tab-ink-bar-transition-backward" style="display:block;height:22px;background-color:transparent;left:0%;right:78%;"></div>';
					boTitleStr += '</div>';
				} else {
					boTitleStr += '<div class="vux-tab">';
					boTitleStr += '<div data-v-31296f00="" onclick="boTitleClick(' + versus.id + ', 0, this)" class="vux-tab-item vux-tab-selected" style="border:none;color:rgb(255, 255, 255);">全场</div>';
					for(var i=1; i<=4; i++) {
						if(i <= versus.boCount) {
							boTitleStr += '<div data-v-31296f00="" onclick="boTitleClick(' + versus.id + ', ' + i + ', this)" class="vux-tab-item" style="border:none;color:rgb(186, 206, 241);">第' + i + '局</div>';
						} else {
							boTitleStr += '<div data-v-31296f00="" class="vux-tab-item" style="border:none;"></div>';
						}
					}
					boTitleStr += '<div class="vux-tab-ink-bar vux-tab-ink-bar-transition-backward" style="display:block;height:22px;background-color:transparent;left:0%;right:80%;"></div>';
					boTitleStr += '</div>';
				}
				$("#bo_title_div").html(boTitleStr);
			} else {
				m_toast(data.msg);
			}
		}
	});
};

//加载玩法
var loadPlayType = function(versusId, bo){
	loadData({
		"url" : "getPlayTypeList",
		"data" : {
			"versusId" : versusId,
			"bo" : bo
		},
		"hideLoading" : true,
		"success" : function(data){
			if(data.code == 100) {
				var ptList = data.result;
				
			} else {
				m_toast(data.msg);
			}
		}
	});
};

//标签切换点击
var boTitleClick = function(versusId, index, e){
	m_toast(versusId + "，" + index);
	var parent = $(e).parent();
	parent.children(".vux-tab-item").removeClass("vux-tab-selected");
	parent.children(".vux-tab-item").css("color", "rgb(186, 206, 241)");
	$(e).addClass("vux-tab-selected");
	$(e).css("color", "rgb(255, 255, 255)");
	var step = 0;
	if(parent.hasClass("scrollable")) {
		step = 22;
	} else {
		step = 20;
	}
	parent.children(".vux-tab-ink-bar-transition-backward").css("left", (step * index) + "%");
	parent.children(".vux-tab-ink-bar-transition-backward").css("right", (100 - (step * (index + 1))) + "%");
};