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
					for(var i=0; i<list.length; i++) {
						var obj = list[i];
						str += '<div data-v-1545e424="" class="record-card">';
						str += '	<div data-v-1545e424="" class="order-detail">';
						str += '		<div data-v-1545e424="" class="detail-header">';
						str += '			<div data-v-1545e424="" class="header-title-left">';
						str += '				<img data-v-1545e424="" src="//yuanjududu.com//file/98c6eb475bf90d035c0d6b7f31fd59d0.svg" class="game-icon">';
						str += '				<span data-v-1545e424="" class="title">Red Reserve 获胜者</span>';
						str += '			</div>';
						str += '			<div data-v-1545e424=""><span data-v-1545e424="">' + (obj.bo > 0 ? '第' + obj.bo + '局' : '全场') + '</span> <span data-v-1545e424=""></span></div>';
						str += '		</div>';
						str += '		<div data-v-1545e424="" class="header-hr"></div>';
						str += '		<div data-v-1545e424="" class="result-flag"></div>';
						str += '		<div data-v-1545e424="" class="order-content">';
						str += '			<div data-v-1545e424="" class="content-list">';
						str += '				<div data-v-1545e424="" class="list-text">3DMAX - VS - Red Reserve</div>';
						str += '				<div data-v-1545e424="" class="list-text">开始时间:2018-09-03 18:14:00</div>';
						str += '				<div data-v-1545e424="" class="list-text">赔率: 1.91</div>';
						str += '			</div>';
						str += '		</div>';
						str += '	</div>';
						str += '	<section data-v-1545e424="" class="order-info">';
						str += '		<div data-v-1545e424="" class="parlay-title"><span data-v-1545e424="">单场</span> <span data-v-1545e424="" class="odds-status order-open">未结算</span></div>';
						str += '		<div data-v-1545e424="" class="info-content">';
						str += '			<div data-v-1545e424="" class="bet-amount">投注金额:<span data-v-1545e424="" class="stake">20.00</span></div>';
						str += '			<div data-v-1545e424="" class="profit">盈利<span data-v-1545e424="" class="bonus-win"> 38.20</span></div>';
						str += '		</div>';
						str += '		<div data-v-1545e424="" style="height: 18px;"></div>';
						str += '		<div data-v-1545e424="" class="info-content"><div data-v-1545e424="">订单号: 4effd6231698d63337</div><div data-v-1545e424="">2018-09-03 18:37:09</div></div>';
						str += '	</section>';
						str += '</div>';
					}
					if(empty(str)) {
						str += '<div data-v-1545e424="" class="empty-note" style="padding-top:15px;padding-bottom:15px;min-height:30px">您还没有任何投注记录。<a href="m/index.jsp">前往投注</a></div>';
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
		
	/**************************************************************************/
	}
});