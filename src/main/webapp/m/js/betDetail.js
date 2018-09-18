//用户余额
var userBalance = 0;
var isLogin = false; //是否登陆

//初始化
var initData = function(versusId, intervalSeconds){
	getMatchVersusAndPlayType(versusId);
	setInterval("loadOddsAndPlayTypeStatus()", (intervalSeconds * 1000) / 2);
	loadUserBalance();
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
				
				$("#vux_view_box_body .info-title img").attr("src", empty(versus.matchLogoUrl) ? versus.sportLogoUrl : versus.matchLogoUrl);
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
				} else if("已结束" == versus.status) {
					str += '<div data-v-31296f00="" class="status-over">';
					str += '	<div data-v-31296f00="" class="score">' + versus.leftTeamScore + '</div>';
					str += '	<div data-v-31296f00="" class="is-over">';
					var dates = startTimeFormatStr.split(" ");
					str += '		<div data-v-31296f00="" class="over-date">' + dates[0] + '</div>';
					str += '		<div data-v-31296f00="">' + dates[1] + '</div>';
					str += '	</div>';
					str += '	<div data-v-31296f00="" class="score">' + versus.rightTeamScore + '</div>';
					str += '</div>';
					str += '<div data-v-31296f00="" class="is-over">' + versus.status + '</div>';
				} else if("未比赛" == versus.status) {
					str += '<div data-v-31296f00="" class="status-over">';
					str += '	<div data-v-31296f00="" class="is-over">';
					str += '		<div data-v-31296f00="" class="match-date">' + startTimeFormatStr + '</div>';
					str += '		<div data-v-31296f00="" class="match-time">' + versus.startTime.substring(11, 16) + '</div>';
					str += '	</div>';
					str += '</div>';
					str += '<div data-v-31296f00="" class="is-over">' + versus.status + '</div>';
				} else if("未开始" == versus.status) {
					str += '<div data-v-31296f00="" class="status-early">';
					str += '	<div data-v-31296f00="" class="is-early">';
					str += '		<div data-v-31296f00="" class="match-date">' + startTimeFormatStr + '</div>';
					str += '		<div data-v-31296f00="" class="match-time">' + versus.startTime.substring(11, 16) + '</div>';
					str += '	</div>';
					str += '</div>';
					str += '<div data-v-31296f00="" class="is-raedy">' + versus.status + '</div>';
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
								if(obj.guessStart) { //开启了竞猜
									playTypeStr += '<div data-v-31296f00="" class="group-list play-type-id' + obj.id + '" data-play-type-name="' + obj.name + '" data-right-guess-name="' + obj.rightGuessName + '" data-left-guess-name="' + obj.leftGuessName + '" data-play-type-id="' + obj.id + '">';
									playTypeStr += '	<div data-v-8d7d541a="" data-v-31296f00="" class="odds-group-title"><div data-v-8d7d541a="" class="empty-badge"></div><div data-v-8d7d541a="" class="title">' + obj.name + '</div></div>';
									playTypeStr += '	<div data-v-31296f00="" class="group-odds">';
									playTypeStr += '		<div data-v-31296f00="" class="odds-btn">';
									playTypeStr += '			<div data-v-549598f5="" data-v-31296f00="" onclick="betClick(' + obj.id + ', \'LEFT\', this)" class="left-odds home-match-card-button">';
									playTypeStr += '				<div data-v-549598f5="" class="button-dark-border">';
									playTypeStr += '					<div data-v-549598f5="" class="button-content btn-left">';
									playTypeStr += '						<div data-v-549598f5="" class="button-name">' + obj.leftGuessName + '</div>';
									playTypeStr += '						<div data-v-549598f5="" class="button-odds-content">';
									playTypeStr += '							<div data-v-549598f5="" class="odds-rising-icon"></div>';
									playTypeStr += '							<div data-v-549598f5="" class="odds-dropping-icon"></div>';
									playTypeStr += '							<div data-v-549598f5="" class="btn-odds"><span data-v-549598f5=""></span></div>';
									playTypeStr += '						</div>';
									playTypeStr += '					</div>';
									playTypeStr += '				</div>';
									playTypeStr += '			</div>';
									playTypeStr += '		</div>';
									playTypeStr += '		<div data-v-31296f00="" class="odds-btn">';
									playTypeStr += '			<div data-v-549598f5="" data-v-31296f00="" onclick="betClick(' + obj.id + ', \'RIGHT\', this)" class="right-odds home-match-card-button">';
									playTypeStr += '				<div data-v-549598f5="" class="button-dark-border">';
									playTypeStr += '					<div data-v-549598f5="" class="button-content btn-right">';
									playTypeStr += '						<div data-v-549598f5="" class="button-odds-content">';
									playTypeStr += '							<div data-v-549598f5="" class="btn-odds"><span data-v-549598f5=""></span></div>';
									playTypeStr += '							<div data-v-549598f5="" class="odds-rising-icon"></div>';
									playTypeStr += '							<div data-v-549598f5="" class="odds-dropping-icon"></div>';
									playTypeStr += '						</div>';
									playTypeStr += '						<div data-v-549598f5="" class="button-name">' + obj.rightGuessName + '</div>';
									playTypeStr += '					</div>';
									playTypeStr += '				</div>';
									playTypeStr += '			</div>';
									playTypeStr += '		</div>';
									playTypeStr += '	</div>';
									playTypeStr += '</div>';
								} else { //兑猜已结束
									if("已结束" == obj.status) {
										playTypeStr += '<div data-v-31296f00="" class="group-list">';
										playTypeStr += '	<div data-v-8d7d541a="" data-v-31296f00="" class="odds-group-title"><div data-v-8d7d541a="" class="empty-badge"></div><div data-v-8d7d541a="" class="title">' + obj.name + '</div></div>';
										playTypeStr += '	<div data-v-31296f00="" class="group-odds">';
										playTypeStr += '		<div data-v-31296f00="" class="odds-btn">';
										playTypeStr += '			<div data-v-549598f5="" data-v-31296f00="" class="home-match-card-button btn-over">';
										playTypeStr += '				<div data-v-549598f5="" class="button-dark-border">';
										playTypeStr += '					<div data-v-549598f5="" class="button-content btn-left">';
										playTypeStr += '						<div data-v-549598f5="" class="button-name">' + obj.leftGuessName + '</div>';
										var leftResult = '', rightResult = '';
										if(obj.result > 0) {
											leftResult = "lose-icon";
											rightResult = "win-icon";
										} else if(obj.result < 0) {
											leftResult = "win-icon";
											rightResult = "lose-icon";
										} else {
											leftResult = "ping";
											rightResult = "ping";
										}
										playTypeStr += '						<div data-v-549598f5="" class="' + leftResult + '"></div>';
										playTypeStr += '					</div>';
										playTypeStr += '				</div>';
										playTypeStr += '			</div>';
										playTypeStr += '		</div>';
										playTypeStr += '		<div data-v-31296f00="" class="odds-btn">';
										playTypeStr += '			<div data-v-549598f5="" data-v-31296f00="" class="home-match-card-button btn-over">';
										playTypeStr += '				<div data-v-549598f5="" class="button-dark-border">';
										playTypeStr += '					<div data-v-549598f5="" class="button-content btn-right">';
										playTypeStr += '						<div data-v-549598f5="" class="' + rightResult + '"></div>';
										playTypeStr += '						<div data-v-549598f5="" class="button-name">' + obj.rightGuessName + '</div>';
										playTypeStr += '					</div>';
										playTypeStr += '				</div>';
										playTypeStr += '			</div>';
										playTypeStr += '		</div>';
										playTypeStr += '	</div>';
										playTypeStr += '</div>';
									} else if("未比赛" == obj.status) {
										//未比赛
									}
								}
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
			loadOddsAndPlayTypeStatus();//加载赔率
		}
	});
};

//betClick
var betClick = function(playTypeId, direction, e){
	if($(e).hasClass("btn-locked")) {//锁定了
		return;
	}
	$(".btn-selected").removeClass("btn-selected");
	$(e).addClass("btn-selected");
	
	var pte = $(".play-type-id" + playTypeId);
	var leftTeamName = $("#vux_view_box_body .info-team .left-team .team-name").html();
	var rightTeamName = $("#vux_view_box_body .info-team .right-team .team-name").html();
	var matchName = $("#vux_view_box_body .info-title .tournament-name").html();
	var playTypeName = pte.attr("data-play-type-name");
	var leftGuessName = pte.attr("data-left-guess-name");
	var rightGuessName = pte.attr("data-right-guess-name");
	if("LEFT" == direction) {
		numberInputShow(leftTeamName, rightTeamName, matchName, playTypeId, playTypeName, leftGuessName, rightGuessName, true, parseFloat(pte.find(".left-odds").attr("data-odds")), function(amount){
			bet(playTypeId, "LEFT", amount);
		});
	} else if("RIGHT" == direction) {
		numberInputShow(leftTeamName, rightTeamName, matchName, playTypeId, playTypeName, leftGuessName, rightGuessName, false, parseFloat(pte.find(".right-odds").attr("data-odds")), function(amount){
			bet(playTypeId, "RIGHT", amount);
		});
	}
	loadUserBalance();//加载用户余额
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
	str += '									<div class="order-note">您可以在“投注记录”中留意订单状态</div>';
	str += '								</div>';
	str += '							</div>';
	str += '						</div>';
	str += '						<div class=" xs-fixed-container"></div>';
	str += '					</div>';
	str += '				</div>';
	str += '			</div>';
	str += '			<div class="weui-dialog__ft">';
	str += '				<a href="javascript:;" class="weui-dialog__btn weui-dialog__btn_default">投注记录</a>';
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

//加载赔率以及状态
var loadOddsAndPlayTypeStatus = function() {
	var playTypeId = new Array();
	$("div.group-list").each(function(){
		var dataPlayTypeId = $.trim($(this).attr("data-play-type-id"));
		if(!empty(dataPlayTypeId)) {
			playTypeId.push(dataPlayTypeId);
		}
	});
	if(playTypeId.length > 0) {
		loadData({
			"url" : "getBatchOddsAndPlayTypeStatus",
			"hideLoading" : true,
			"data" : {"playTypeId[]" : playTypeId},
			"success" : function(data) {
				if(data.code == 100) {
					var list = data.result;
					if(list != null && list.length > 0) {
						for(var i=0; i<list.length; i++) {
							var obj = list[i];
							showOdds(obj.status, obj.leftOdds, obj.rightOdds, obj.playTypeId);
						}
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
	var e = $("div.play-type-id" + playTypeId);
	if(status) {
		e.find(".home-match-card-button").removeClass("btn-locked");
		e.find(".left-odds .btn-odds span").html(leftOdds.toFixed(2));
		e.find(".right-odds .btn-odds span").html(rightOdds.toFixed(2));
		
		var oldLeftOdds = $.trim(e.find(".left-odds").attr("data-odds"));
		e.find(".left-odds").attr("data-odds", leftOdds);
		if(!empty(oldLeftOdds)) {
			var oldLeftOddsFloat = parseFloat(oldLeftOdds);
			if(leftOdds > oldLeftOdds) { //左方赔率上升了
				oddsFlash(1, e.find(".left-odds"));
			} else if(leftOdds < oldLeftOdds) { //左方赔率下降了
				oddsFlash(-1, e.find(".left-odds"));
			} else { //左方赔率没变
				oddsFlash(0, e.find(".left-odds"));
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
		

		var oldRightOdds = $.trim(e.find(".right-odds").attr("data-odds"));
		e.find(".right-odds").attr("data-odds", rightOdds);
		if(!empty(oldRightOdds)) {
			var oldRightOddsFloat = parseFloat(oldRightOdds);
			if(rightOdds > oldRightOdds) {
				oddsFlash(1, e.find(".right-odds"));
			} else if(rightOdds < oldRightOdds) {
				oddsFlash(-1, e.find(".right-odds"));
			} else {
				oddsFlash(0, e.find(".right-odds"));
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
		e.find(".home-match-card-button").removeClass("btn-odds-rising");
		e.find(".home-match-card-button").removeClass("btn-odds-dropping");
		e.find(".btn-odds span").empty();
	}
};

//odds上升、下降闪亮警示i：大于0上升，小于0下降，等于0没变
var oddsFlash = function(i, e){
	if(i > 0) {
		e.removeClass("btn-odds-dropping");
		e.addClass("btn-odds-rising");
	} else if(i < 0) {
		e.removeClass("btn-odds-rising");
		e.addClass("btn-odds-dropping");
	} else {
		e.removeClass("btn-odds-rising");
		e.removeClass("btn-odds-dropping");
	}
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
	$("div.btn-selected").removeClass("btn-selected");
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
	$("#userBalanceDiv").html(balance.toFixed(2));
};