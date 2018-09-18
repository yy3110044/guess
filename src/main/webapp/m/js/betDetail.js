//初始化
var initData = function(versusId){
	getMatchVersusAndPlayType(versusId);
};

//加载对阵信息
var getMatchVersusAndPlayType = function(versusId){
	loadData({
		"url" : "getMatchVersusAndPlayType",
		"data" : {"versusId" : versusId},
		"hideLoading" : true,
		"success" : function(data) {
			if(data.code == 100) {
				var versus = data.result.versus;
				var startTimeFormatStr = data.result.startTimeFormatStr;
				var ptListList = data.result.ptListList;
				
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
					boTitleStr += '<div data-v-31296f00="" onclick="boTitleClick(0)" class="vux-tab-item vux-tab-selected" style="border:none;color:rgb(255, 255, 255);">全场</div>';
					for(var i=1; i<=versus.boCount; i++) {
						boTitleStr += '<div data-v-31296f00="" onclick="boTitleClick(' + i + ')" class="vux-tab-item" style="border:none;color:rgb(186, 206, 241);">第' + i + '局</div>';
					}
					boTitleStr += '<div class="vux-tab-ink-bar vux-tab-ink-bar-transition-backward" style="display:block;height:22px;background-color:transparent;left:0%;right:78%;"></div>';
					boTitleStr += '</div>';
				} else {
					boTitleStr += '<div class="vux-tab">';
					boTitleStr += '<div data-v-31296f00="" onclick="boTitleClick(0)" class="vux-tab-item vux-tab-selected" style="border:none;color:rgb(255, 255, 255);">全场</div>';
					for(var i=1; i<=4; i++) {
						if(i <= versus.boCount) {
							boTitleStr += '<div data-v-31296f00="" onclick="boTitleClick(' + i + ')" class="vux-tab-item" style="border:none;color:rgb(186, 206, 241);">第' + i + '局</div>';
						} else {
							boTitleStr += '<div data-v-31296f00="" class="vux-tab-item" style="border:none;"></div>';
						}
					}
					boTitleStr += '<div class="vux-tab-ink-bar vux-tab-ink-bar-transition-backward" style="display:block;height:22px;background-color:transparent;left:0%;right:80%;"></div>';
					boTitleStr += '</div>';
				}
				$("#bo_title_div").html(boTitleStr);
				

				var playTypeStr = '';
				if(ptListList.length > 0) {
					for(var i=0; i<ptListList.length; i++) {
						var ptList = ptListList[i];
						if(ptList != null && ptList.length > 0) {
							playTypeStr += '<section data-v-31296f00="" class="betting-odds">';
							playTypeStr += '<div data-v-31296f00="" class="stage-title"><div data-v-31296f00="" class="stage-border"></div>' + (i > 0 ? ('第' + i + '局') : '全场') + '<div data-v-31296f00="" class="stage-border"></div></div>';
							for(var j=0; j<ptList.length; j++) {
								var obj = ptList[j];
								playTypeStr += '<div data-v-31296f00="" class="group-list">';
								playTypeStr += '	<div data-v-8d7d541a="" data-v-31296f00="" class="odds-group-title"><div data-v-8d7d541a="" class="empty-badge"></div><div data-v-8d7d541a="" class="title">' + obj.name + '</div></div>';
								playTypeStr += '	<div data-v-31296f00="" class="group-odds">';
								playTypeStr += '		<div data-v-31296f00="" class="odds-btn">';
								playTypeStr += '			<div data-v-549598f5="" data-v-31296f00="" class="home-match-card-button btn-odds-rising">';
								playTypeStr += '				<div data-v-549598f5="" class="button-dark-border">';
								playTypeStr += '					<div data-v-549598f5="" class="button-content btn-left">';
								playTypeStr += '						<div data-v-549598f5="" class="button-name">EDG</div>';
								playTypeStr += '						<div data-v-549598f5="" class="button-odds-content">';
								playTypeStr += '							<div data-v-549598f5="" class="odds-rising-icon"></div>';
								playTypeStr += '							<div data-v-549598f5="" class="odds-dropping-icon"></div>';
								playTypeStr += '							<div data-v-549598f5="" class="btn-odds"><span data-v-549598f5="">2.19</span></div>';
								playTypeStr += '						</div>';
								playTypeStr += '					</div>';
								playTypeStr += '				</div>';
								playTypeStr += '			</div>';
								playTypeStr += '		</div>';
								playTypeStr += '		<div data-v-31296f00="" class="odds-btn">';
								playTypeStr += '			<div data-v-549598f5="" data-v-31296f00="" class="home-match-card-button btn-odds-dropping btn-selected">';
								playTypeStr += '				<div data-v-549598f5="" class="button-dark-border">';
								playTypeStr += '					<div data-v-549598f5="" class="button-content btn-right">';
								playTypeStr += '						<div data-v-549598f5="" class="button-odds-content">';
								playTypeStr += '							<div data-v-549598f5="" class="btn-odds"><span data-v-549598f5="">1.62</span></div>';
								playTypeStr += '							<div data-v-549598f5="" class="odds-rising-icon"></div>';
								playTypeStr += '							<div data-v-549598f5="" class="odds-dropping-icon"></div>';
								playTypeStr += '						</div>';
								playTypeStr += '						<div data-v-549598f5="" class="button-name">RNG</div>';
								playTypeStr += '					</div>';
								playTypeStr += '				</div>';
								playTypeStr += '			</div>';
								playTypeStr += '		</div>';
								playTypeStr += '	</div>';
								playTypeStr += '</div>';
							}
							playTypeStr += '</section>';
						} else {
							//ptList为空
							playTypeStr += '<section data-v-31296f00="" class="betting-odds">';
							playTypeStr += '<div data-v-31296f00="" class="stage-title"><div data-v-31296f00="" class="stage-border"></div>' + (i > 0 ? ('第' + i + '局') : '全场') + '<div data-v-31296f00="" class="stage-border"></div></div>';
							playTypeStr += '</section>';
						}
					}
				} else {
					//ptListList为空
				}
				if(!empty(playTypeStr)) {
					playTypeStr += '<div data-v-76d57656="" class="betting-odds-bottom" style="height:' + ($(window).height() - 384) + 'px;"></div>';
				}
				$(".betting-odds .betting-odds-bottom").remove();
				$("#vux_view_box_body .router-view").append(playTypeStr);
			} else {
				m_toast(data.msg);
			}
		},
		"complete" : function(dtaa){
			//计算每个playTypeDiv的滚动值
			var scrollTop = 0;
			$("section.betting-odds").each(function(){
				var ts = $(this);
				ts.attr("data-scroll-top", scrollTop);
				var ptLength = ts.children(".group-list").length;
				if(ptLength > 0) {
					scrollTop += 80 * ptLength + 54;
				} else {
					scrollTop += 46;  
				}
			});
		}
	});
};

//标签切换
var boTitleChange = function(index) {
	var vuxTabItem = $("#bo_title_div .vux-tab-item");
	vuxTabItem.removeClass("vux-tab-selected");
	vuxTabItem.css("color", "rgb(186, 206, 241)");
	var currentItem = vuxTabItem.eq(index);
	currentItem.addClass("vux-tab-selected");
	currentItem.css("color", "rgb(255, 255, 255)");
	var step = 0;
	if($("#bo_title_div .vux-tab").hasClass("scrollable")) {
		step = 22;
	} else {
		step = 20;
	}
	$("#bo_title_div .vux-tab-ink-bar-transition-backward").css({"left" : (step * index) + "%", "right" : (100 - (step * (index + 1))) + "%"});
	
	var scrollable = $(".scrollable");
	var scrollableWidth = scrollable.width();
	scrollable.animate({"scrollLeft" : parseInt((index / 4), 10) * (scrollableWidth * 0.88)}, "fast");
};

//标签切换点击
var boTitleClick = function(index){
	boTitleChange(index);
	var scrollTop = $("section.betting-odds").eq(index).attr("data-scroll-top");
	$("#vux_view_box_body").animate({"scrollTop" : scrollTop}, "fast");
};