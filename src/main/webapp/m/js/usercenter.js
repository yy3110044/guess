$(document).ready(function(){
	loadData({"url" : "isLoginBySession","hideLoading" : true,"success" : function(data){if(!data.result) {window.location.href = "m/login.jsp?msg=" + encodeURI("您还未登录，请先登录");}}});
	var href = window.location.href;
	var subindex = href.indexOf("/m/usercenter");
	var currentUrl = href.substring(subindex + 14);
	var lastIndex = currentUrl.indexOf("?");
	if(lastIndex > 0) {
		currentUrl = currentUrl.substring(0, lastIndex);
	}
	switch(currentUrl) {
	/*********************************菜单页***************************************/
	case "menu.jsp":
		loadData({
			"url" : "user/getUnreadUserNoticeCount",
			"hideLoading" : true,
			"success" : function(data){
				if(data.code == 100) {
					if(data.result > 0) { //有未读信息
						$("div.notice-icon").before('<div data-v-0df6a7f4="" class="notice-badge"></div>');
					} else { //没有未读信息
						$("div.notice-badge").remove();
					}
				} else {
					m_toast(data.msg);
				}
			}
		});
		loadData({
			"url" : "user/getUserInfo",
			"hideLoading" : true,
			"success" : function(data){
				if(data.code == 100) {
					$("div.user-name span.vux-label-desc").html(data.result.userName);
					$("span.wallet-lebal-balance").html("&nbsp;¥" + data.result.balance.toFixed(2));
				} else {
					m_toast(data.msg);
				}
			}
		});
		break;

	/***********************************投注记录页***************************************/
	case "betRecord.jsp":
		$("#vux-scroller-6vidl").height($(window).height() - 92);//设置滚动div高度
		var mescroll = null;
		var loadBetList = function(end, pageNo, hideLoading){
			loadData({
				"url" : "user/betList",
				"data" : {"end" : end, "pageNo" : pageNo},
				"hideLoading" : hideLoading,
				"success" : function(data){
					var list = data.result.list;
					var page = data.result.page;
					
					var str = '';
					if(list.length > 0) {
						for(var i=0; i<list.length; i++) {
							var obj = list[i];
							if("已下注" == obj.status) {
								str += '<div data-v-1545e424="" class="record-card bet-id-' + obj.id + ' versus-id-' + obj.versusId + ' play-type-id-' + obj.playTypeId + '">';
								str += '	<div data-v-1545e424="" class="order-detail">';
								str += '		<div data-v-1545e424="" class="detail-header">';
								str += '			<div data-v-1545e424="" class="header-title-left">';
								str += '				<img data-v-1545e424="" src="" class="game-icon">';
								str += '				<span data-v-1545e424="" class="title"></span>';
								str += '			</div>';
								str += '			<div data-v-1545e424=""><span data-v-1545e424="">' + (obj.bo > 0 ? '第' + obj.bo + '局' : '全场') + '</span><span data-v-1545e424=""></span></div>';
								str += '		</div>';
								str += '		<div data-v-1545e424="" class="header-hr"></div>';
								str += '		<div data-v-1545e424="" class="result-flag"></div>';
								str += '		<div data-v-1545e424="" class="order-content">';
								str += '			<div data-v-1545e424="" class="content-list">';
								str += '				<div data-v-1545e424="" class="list-text team"></div>';
								str += '				<div data-v-1545e424="" class="list-text bet-direction" data-bet-direction="' + obj.betDirection + '"></div>';
								str += '				<div data-v-1545e424="" class="list-text start-time"></div>';
								var odds = 0;
								if("LEFT" == obj.betDirection) {
									odds = obj.leftOdds;
								} else if("RIGHT" == obj.betDirection) {
									odds = obj.rightOdds;
								}
								str += '				<div data-v-1545e424="" class="list-text">赔率：' + odds.toFixed(2) + '</div>';
								str += '			</div>';
								str += '		</div>';
								str += '	</div>';
								str += '	<section data-v-1545e424="" class="order-info">';
								str += '		<div data-v-1545e424="" class="parlay-title"><span data-v-1545e424="">' + (obj.bo > 0 ? '第' + obj.bo + '局' : '全场') + '</span><span data-v-1545e424="" class="odds-status order-open">' + (obj.status == '已下注' ? '未结算' : obj.status) + '</span></div>';
								str += '		<div data-v-1545e424="" class="info-content">';
								str += '			<div data-v-1545e424="" class="bet-amount">投注金额：<span data-v-1545e424="" class="stake">' + obj.betAmount.toFixed(2) + '</span></div>';
								str += '			<div data-v-1545e424="" class="profit">预计盈利：<span data-v-1545e424="" class="bonus-win">' + (odds * obj.betAmount).toFixed(2) + '</span></div>';
								str += '		</div>';
								str += '		<div data-v-1545e424="" style="height: 18px;"></div>';
								str += '		<div data-v-1545e424="" class="info-content"><div data-v-1545e424="">订单号：' + obj.orderNumber + '</div><div data-v-1545e424="">' + obj.createTime + '</div></div>';
								str += '	</section>';
								str += '</div>';
							} else {
								str += '<div data-v-1545e424="" class="record-card bet-id-' + obj.id + ' versus-id-' + obj.versusId + ' play-type-id-' + obj.playTypeId + '">';
								str += '	<div data-v-1545e424="" class="order-detail">';
								str += '		<div data-v-1545e424="" class="detail-header">';
								str += '			<div data-v-1545e424="" class="header-title-left">';
								str += '				<img data-v-1545e424="" src="" class="game-icon">';
								str += '				<span data-v-1545e424="" class="title"></span>';
								str += '			</div>';
								str += '			<div data-v-1545e424=""><span data-v-1545e424="">' + (obj.bo > 0 ? '第' + obj.bo + '局' : '全场') + '</span><span data-v-1545e424=""></span></div>';
								str += '		</div>';
								str += '		<div data-v-1545e424="" class="header-hr"></div>';
								var flag = '';
								if("已结算" == obj.status) {
									flag = ' win-flag';
								} else if("未猜中" == obj.status) {
									flag = ' lose-flag';
								}
								str += '		<div data-v-1545e424="" class="result-flag' + flag + '"></div>';
								str += '		<div data-v-1545e424="" class="order-content">';
								str += '			<div data-v-1545e424="" class="content-list">';
								str += '				<div data-v-1545e424="" class="list-text team"></div>';
								str += '				<div data-v-1545e424="" class="list-text bet-direction" data-bet-direction="' + obj.betDirection + '"></div>';
								str += '				<div data-v-1545e424="" class="list-text start-time"></div>';
								var odds = 0;
								if("LEFT" == obj.betDirection) {
									odds = obj.leftOdds;
								} else if("RIGHT" == obj.betDirection) {
									odds = obj.rightOdds;
								}
								str += '				<div data-v-1545e424="" class="list-text">赔率：' + odds.toFixed(2) + '</div>';
								str += '			</div>';
								str += '		</div>';
								str += '	</div>';
								str += '	<section data-v-1545e424="" class="order-info">';
								str += '		<div data-v-1545e424="" class="parlay-title"><span data-v-1545e424="">' + (obj.bo > 0 ? '第' + obj.bo + '局' : '全场') + '</span><span data-v-1545e424="" class="odds-status order-close">' + obj.status + '</span></div>';
								str += '		<div data-v-1545e424="" class="info-content">';
								str += '			<div data-v-1545e424="" class="bet-amount">投注金额：<span data-v-1545e424="" class="stake">' + obj.betAmount.toFixed(2) + '</span></div>';
								if("已结算" == obj.status) {
									str += '			<div data-v-1545e424="" class="profit">实际盈利：<span data-v-1545e424="" class="bonus-win">' + obj.realPayBonus.toFixed(2) + '</span></div>';
								} else if("未猜中" == obj.status) {
									str += '			<div data-v-1545e424="" class="profit">实际盈利：<span data-v-1545e424="" class="bonus-win">0.00</span></div>';
								} else if("已退回" == obj.status) {
									str += '			<div data-v-1545e424="" class="profit">退回金额：<span data-v-1545e424="" class="bonus-win">' + obj.betAmount.toFixed(2) + '</span></div>';
								}
								str += '		</div>';
								str += '		<div data-v-1545e424="" style="height:18px;"></div>';
								str += '		<div data-v-1545e424="" class="info-content"><div data-v-1545e424="">订单号：' + obj.orderNumber + '</div><div data-v-1545e424="">' + obj.createTime + '</div></div>';
								str += '	</section>';
								str += '</div>';
							}
						}
					} else {
						if($("div.vux-tab-container .vux-tab-selected").index() == 0) {
							str += '<div data-v-1545e424="" class="empty-note" style="padding-top:15px;padding-bottom:15px;min-height:30px">日前没有任何投注记录。<a href="m/index.jsp">前往投注</a></div>';
						} else {
							str += '<div data-v-1545e424="" class="empty-note" style="padding-top:15px;padding-bottom:15px;min-height:30px">没有更多记录了...</div>';
						}
					}
					
					if(pageNo == 1) { //第一页清空
						if(mescroll != null) {
							mescroll.scrollTo(0); //滚动到顶部
							mescroll.setPageNum(1); //把页数重设为1
						}
						$("#record-card-container").empty();
					}
					
					$("#record-card-container").append(str);
					
					if(mescroll != null) {
						mescroll.endSuccess(page.pageSize, page.next);//在这里关闭加载提示
					}
				},
				"complete" : function(data) {
					var versusList = data.result.versusList;
					var playTypeList = data.result.playTypeList;
					if(versusList != null && versusList.length > 0) {
						for(var i=0; i<versusList.length; i++) {
							var obj = versusList[i];
							var e = $("div.versus-id-" + obj.id);
							e.find(".header-title-left img").attr("src", empty(obj.matchLogoUrl) ? obj.sportLogoUrl : obj.matchLogoUrl);
							e.find(".header-title-left span").html(obj.sportName + "&nbsp;" + obj.matchName + "&nbsp;" + obj.name);
							e.find(".team").html("对阵队伍：" + obj.leftTeamName + "&nbsp;VS&nbsp;" + obj.rightTeamName);
							e.find(".start-time").html("开始时间：" + obj.startTime);
						}
					}
					if(playTypeList != null && playTypeList.length > 0) {
						for(var i=0; i<playTypeList.length; i++) {
							var obj = playTypeList[i];
							var e = $("div.play-type-id-" + obj.id);
							var bde = e.find(".bet-direction");
							var betDirection = $.trim(bde.attr("data-bet-direction"));
							if("LEFT" == betDirection) {
								bde.html("下注方：" + obj.name + '&nbsp;<span style="color:white;">' + obj.leftGuessName + '</span>');
							} else if("RIGHT" == betDirection) {
								bde.html("下注方：" + obj.name + '&nbsp;<span style="color:white;">' + obj.rightGuessName + '</span>');
							}
						}
					}
				},
				"error" : function() {
					if(mescroll != null) {
						mescroll.endErr();
					}
				}
			});
		};
		$("div.vux-tab-container .vux-tab-item").click(function(){
			$("div.vux-tab-container .vux-tab-item").removeClass("vux-tab-selected");
			$("div.vux-tab-container .vux-tab-item").css("color", "rgb(186, 206, 241)");
			$(this).addClass("vux-tab-selected");
			$(this).css("color", "rgb(255, 255, 255)");
			if($(this).index() == 0) {
				$("div.vux-tab-container .vux-tab-ink-bar").css({"left" : "0%", "right" : "50%"});
				loadBetList(false, 1, false);
			} else if($(this).index() == 1) {
				$("div.vux-tab-container .vux-tab-ink-bar").css({"left" : "50%", "right" : "0%"});
				loadBetList(true, 1, false);
			}
		});
		//滚动
		mescroll = new MeScroll("vux-scroller-6vidl", {
			"down" : {
				"use" : true,
				"auto" : false,
				"callback" : function(){
					loadBetList($("div.vux-tab-container .vux-tab-selected").index() == 1, 1, true);
				}
			},
			"up" : {
				"use" : true,
				"auto" : false,
				"isBounce" : false,
				"htmlNodata" : '<div data-v-1545e424="" class="empty-note">没有更多记录了...</div>',
				"callback" : function(page){
					loadBetList($("div.vux-tab-container .vux-tab-selected").index() == 1, page.num + 1, true);
				}
			}
		});
		loadBetList(false, 1, false);
		break;
		
	/***********************************用户通知页***************************************/
	case "notice.jsp":
		var mescroll = null;
		var loadUserNoticeList = function(pageNo, hideLoading) {
			loadData({
				"url" : "user/userNoticeList",
				"data" : {"pageNo" : pageNo},
				"hideLoading" : hideLoading,
				"success" : function(data) {
					if(data.code == 100) {
						var list = data.result.list;
						var page = data.result.page;
						
						var str = '';
						if(list != null && list.length > 0) {
							for(var i=0; i<list.length; i++) {
								var obj = list[i];
								str += '<section data-v-6a2bb1cf="" class="notice-content" data-notice-id="' + obj.id + '">';
								str += '	<div data-v-6a2bb1cf="" class="content-title">';
								str += '		<div data-v-6a2bb1cf="" class="notice-icon"></div>';
								if(obj.hadRead) {
									str += '		<div data-v-6a2bb1cf="">' + obj.title + '</div>';
								} else {
									str += '		<div data-v-6a2bb1cf="" style="color:rgb(255,255,255);">' + obj.title + '</div>';
								}
								str += '		<div data-v-6a2bb1cf="" class="notice-time">' + obj.createTime + '</div>';
								str += '	</div>';
								str += '</section>';
							}
						}

						if(pageNo == 1) { //第一页清空
							if(mescroll != null) {
								mescroll.scrollTo(0); //滚动到顶部
								mescroll.setPageNum(1); //把页数重设为1
							}
							$("#vux_view_box_body .notice-page").empty();
						}
						
						$("#vux_view_box_body .notice-page").append(str);
						
						if(mescroll != null) {
							mescroll.endSuccess(page.pageSize, page.next);//在这里关闭加载提示
						}
					} else {
						m_toast(data.msg);
					}
					if(mescroll != null) {
						mescroll.endErr();//在这里关闭加载提示
					}
				},
				"complete" : function(){
					$("section.notice-content").click(function(){
						window.location.href = "m/usercenter/noticeDetail.jsp?noticeId=" + $(this).attr("data-notice-id");
					});
				},
				"error" : function() {
					if(mescroll != null) {
						mescroll.endErr();
					}
				}
			});
		};
		mescroll = new MeScroll("vux_view_box_body", {
			"down" : {
				"use" : true,
				"auto" : false,
				"callback" : function(){
					loadUserNoticeList(1, true);
				}
			},
			"up" : {
				"use" : true,
				"auto" : false,
				"isBounce" : false,
				"htmlNodata" : '没有更多消息了...',
				"callback" : function(page){
					loadUserNoticeList(page.num + 1, true);
				}
			}
		});
		loadUserNoticeList(1, false);
		break;

	/***********************************用户详情页***************************************/
	case "noticeDetail.jsp":
		loadData({
			"url" : "user/userNoticeDetail",
			"data" : {"noticeId" : noticeId},
			"hideLoading" : true,
			"success" : function(data) {
				if(data.code == 100) {
					$("#vux_view_box_body .notice-time").html(data.result.createTime);
					$("#vux_view_box_body .card-header").html(data.result.title);
					if(data.result.systemNotice) {//系统信息去掉缩进
						$("#vux_view_box_body .card-body").css("text-indent", "");
					}
					$("#vux_view_box_body .card-body").html(data.result.content);
				} else {
					m_toast(data.msg);
				}
			}
		});
		break;
		
	/***********************************设置首页***************************************/
	case "setting/index.jsp":
		$("#logout").click(function(){
			loadData({
				"url" : "userLogout",
				"success" : function(data) {
					if(data.code == 100) {
						window.location.href = "m/login.jsp?msg=" + encodeURI("您已成功退出");
					}
				}
			});
		});
		
		loadData({
			"url" : "user/getUserInfo",
			"hideLoading" : true,
			"success" : function(data) {
				if(data.code == 100) {
					var obj = data.result;
					$("#realName .weui-cell__ft .cell-text").html(obj.realName);
					if(!obj.realNameLock) {
						$("#realName").addClass("vux-tap-active weui-cell_access");
						$("#realName").click(function(){
							window.location.href = "m/usercenter/setting/realNameModify.jsp";
						});
					}
				}
			}
		});
		break;
	/***********************************真实姓名设置页***************************************/
	case "setting/realNameModify.jsp":
		loadData({
			"url" : "user/getUserInfo",
			"hideLoading" : true,
			"success" : function(data) {
				if(data.code == 100) {
					if(!empty(data.result.realName)) {
						$("#realName").val(data.result.realName);
						$(".button-content").parent().parent().removeClass("base-button-disabled");
					}
				}
			}
		});
		var realNameInput = function(){
			var e = $("#realName");
			var realName = $.trim(e.val());
			e.val(realName);
			if(empty(realName)) {
				$(".button-content").parent().parent().addClass("base-button-disabled");
			} else {
				$(".button-content").parent().parent().removeClass("base-button-disabled");
			}
		};
		$("#realName").keyup(realNameInput);
		$("#realName").blur(realNameInput);
		$("#realName").focus(realNameInput);
		$("#realName").click(realNameInput);
		$(".button-content").click(function(){
			var realName = $.trim($("#realName").val());
			if(empty(realName)) {
				m_toast("请输入真实姓名");
				return;
			}
			loadData({
				"url" : "user/updateRealName",
				"data" : {"realName" : realName},
				"hideLoading" : true,
				"success" : function(data){
					if(data.code == 100) {
						window.location.href = "m/usercenter/setting/index.jsp";
					}
				}
			});
		});
		break;
	}
});