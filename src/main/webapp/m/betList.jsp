<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%><!DOCTYPE html>
<html>
<head>
<title>下注列表 - <%=com.yy.guess.util.Util.getConfigCom(application).getWebTitle()%></title>
<%@include file="/m/head-common.jsp"%>
<script src="m/js/betList.js"></script>
<script src="m/js/mescroll.min.js"></script>
<link href="m/js/mescroll.min.css" rel="stylesheet">
<script>
var mescroll = null;
$(document).ready(function(){
	$("#vux-scroller-60yre").height($(window).height() - 132);//设置高度

	loadAllSport();//加载项目
	//loadMatchVersus();//加载对阵

	mescroll = new MeScroll("vux-scroller-60yre", {
		"down" : {
			"use" : true,
			"auto" : false, //是否在初始化完毕之后自动执行下拉回调callback; 默认true
			"callback" : function(){
				alert("??");
			}
		},
		"up" : {
			"use" : true,
			"auto" : false, //是否在初始化时以上拉加载的方式自动加载第一页数据; 默认false
			"isBounce" : false, //此处禁止ios回弹
			"toTop" :{ //配置回到顶部按钮
				src : "http://www.lanrentuku.com/savepic/img/allimg/1206/5-120601155S5-50.png", //默认滚动到1000px显示,可配置offset修改
				offset : 1000
			},
			"callback" : function(){
				alert("????");
			}
		}
	});

	/*
	numberInputShow(function(amount){
		alert(amount);
	});
	*/
});
</script>
</head>
<body>
	<div id="app" class="">
		<nav data-v-1db5fc32="" class="app-header">
			<ul data-v-1db5fc32="">
				<li data-v-1db5fc32="">
					<div data-v-1db5fc32="" class="notice-badge"></div>
					<a data-v-1db5fc32="" href="" class="base-icon personal-info"></a>
				</li>
				<li data-v-1db5fc32="" class="home-logo"></li>
				<li data-v-1db5fc32="">
					<a data-v-e7bb725a="" data-v-1db5fc32="" href="<%=com.yy.guess.util.Util.getConfigCom(application).getCustomerServiceUrl()%>" rel="noopener noreferrer" class="customer-service base-icon service-link"></a>
				</li>
			</ul>
		</nav>
		
		<div class="weui-tab">
			<div id="vux_view_box_body" class="weui-tab__panel vux-fix-safari-overflow-scrolling">
				<div data-v-bf66ef20="" class="home-page router-view">
					<div data-v-de9ae73a="" data-v-bf66ef20="" class="home-header">
						<section data-v-de9ae73a="" class="filter-matches">
							<div data-v-de9ae73a="" class="vux-tab-wrap match-tab">
								<div class="vux-tab-container">
									<div class="vux-tab">
										<div data-v-de9ae73a="" onclick="tabBarChange(1, this)" class="vux-tab-item" style="border:none;color:rgb(186, 206, 241);">今日&nbsp;<span data-v-de9ae73a="" class="match-number"></span></div>
										<span data-v-de9ae73a="" class="column-line"></span>
										<div data-v-de9ae73a="" onclick="tabBarChange(2, this)" class="vux-tab-item vux-tab-selected" style="border: none; color: rgb(255, 255, 255);">滚盘&nbsp;<span data-v-de9ae73a="" class="match-number"></span></div>
										<span data-v-de9ae73a="" class="column-line"></span>
										<div data-v-de9ae73a="" onclick="tabBarChange(3, this)" class="vux-tab-item" style="border: none; color: rgb(186, 206, 241);">赛前&nbsp;<span data-v-de9ae73a="" class="match-number"></span></div>
										<span data-v-de9ae73a="" class="column-line"></span>
										<div data-v-de9ae73a="" onclick="tabBarChange(4, this)" class="vux-tab-item" style="border: none; color: rgb(186, 206, 241);">已结束</div>
										<span data-v-de9ae73a="" class="column-line"></span>
										<div class="vux-tab-ink-bar vux-tab-ink-bar-transition-backward" style="display:block;height:22px;background-color:transparent;left:25%;right:50%;"></div>
									</div>
								</div>
							</div>
							<div data-v-de9ae73a="" class="show-filter-games-btn" onclick="showSportSelect()"></div>
						</section>
						<section data-v-de9ae73a="" class="filter-games" style="display:none;">
							<div data-v-de9ae73a="" class="hide-filter-games-btn" style="visibility:hidden;">完成</div>
							<div data-v-de9ae73a="">筛选游戏</div>
							<div data-v-de9ae73a="" class="hide-filter-games-btn" onclick="sportSelectOk()"><div data-v-de9ae73a="" class="btn-content">✓</div></div>
						</section>
					</div>
					
					<div data-v-cd1e9d3c="" data-v-bf66ef20="">
						<div data-v-cd1e9d3c="" class="vux-popup-dialog games-picker vux-popup-top vux-popup-dialog vux-popup-dialog-mfqea" style="height:calc(100% - 92px);display:none;">
							<div data-v-cd1e9d3c="" class="vux-checker-box checker-content">
								<div data-v-cd1e9d3c="" onclick="sportSelect(0, this)" id="selected-allSport" class="default-checker-item selected-checker-item">
									<div data-v-cd1e9d3c="" style="height: 2px;">&nbsp;</div>
									<div data-v-cd1e9d3c="" class="games-info">
										<div data-v-cd1e9d3c="" class="games-icon all-games-icon"></div>
										<div data-v-cd1e9d3c="">全部</div>
									</div>
									<div data-v-cd1e9d3c="" class="selected-checker-light"></div>
								</div>
							</div>
						</div>
					</div>


					<div data-v-bf66ef20="" class="match-card-list">
						<section data-v-bf66ef20="" class="content-hearer">
							<div data-v-bf66ef20="" class="home-notice">
								<div data-v-bf66ef20="" class="notice-icon"></div>
								<div data-v-bf66ef20="" class="vux-marquee" style="height:16px;">
									<ul class="vux-marquee-box">
										<li data-v-bf66ef20="" class="notice-item"><div data-v-bf66ef20="">【请注意盘口中“第N次击杀”和“N杀”是不同玩法。】</div></li>
										<li data-v-bf66ef20="" class="notice-item"><div data-v-bf66ef20="">【投注时若遇到系统繁忙/网站很卡</div></li>
										<li data-v-bf66ef20="" class="notice-item"><div data-v-bf66ef20="">请先查注单是否已下注成功在进行二次投注.</div></li>
										<li data-v-bf66ef20="" class="notice-item"><div data-v-bf66ef20="">若发生重复投注一概不取消。】</div></li>
										<li data-v-bf66ef20="" class="notice-item"><div data-v-bf66ef20="">【原生app已发布，ios请联系客服重新下载安装。】</div></li>
										<li data-v-bf66ef20="" class="notice-item"><div data-v-bf66ef20="">【请注意盘口中“第N次击杀”和“N杀”是不同玩法。】</div></li>
									</ul>
								</div>
							</div>
						</section>

						<div data-v-bf66ef20="" id="vux-scroller-60yre" class="mescroll" style="touch-action:auto;user-select:none;-webkit-user-drag:none;-webkit-tap-highlight-color:rgba(0, 0, 0, 0);position:relative;overflow:scroll;">
							<div class="xs-container">
								<div data-v-bf66ef20="">
									<div data-v-bf66ef20="" id="betListContainer"></div>
								</div>
							</div>
						</div>

					</div>
				</div>
			</div>
		</div>

		<!--
		<div data-v-60a57f0c="" class="vux-confirm order-confirm">
			<div class="vux-x-dialog">
				<div class="weui-mask" style=""></div>
				<div class="weui-dialog" style="">
					<div class="weui-dialog__bd">
						<div class="content">
							<section class="header color-green">
								<div class="success-icon"></div>
								<div>订单提交成功！</div>
							</section>
							<div id="vux-scroller-oezyh"
								style="max-height: 60vh; height: 186px; touch-action: auto; user-select: none; -webkit-user-drag: none; -webkit-tap-highlight-color: rgba(0, 0, 0, 0); position: relative; overflow: hidden;">
								<div class="xs-container"
									style="transform-origin: 0px 0px 0px; transform: translateX(0px) translateY(0px) translateZ(0px) scale(1, 1); transition: none 0s ease 0s;">
									<div
										style="height: 186px; transform-origin: 0px 0px 0px; transform: translate(0px, 0px) scale(1) translateZ(0px);">
										<div class="order-item">
											<div class="odds-item">
												<div class="match-info">
													<div class="odds-title">
														<div class="games-icon"
															style="background-image: url(&quot;//yuanjududu.com//file/cb9287b9cbdc7414adeb287df1feeebb.svg&quot;);"></div>
														SNG
														<div class="match-stage">全场 赛前</div>
													</div>
													<div class="odds-match">TOP - VS - SNG 16:30</div>
													<div>赔率: 2.16</div>
												</div>
											</div>
											<div class="order-info order-title">
												<div>单场</div>
												<div class="order-success">提交成功</div>
											</div>
											<div class="order-info">
												<div class="stake">
													投注金额: <span class="color-white">10</span>
												</div>
												<div>
													盈利: <span class="color-white"> 21.6 </span>
												</div>
											</div>
											<div class="order-note">您的订单需要系统确认，请在“投注记录”留意订单状态</div>
										</div>
									</div>
								</div>
								<div class=" xs-fixed-container"></div>
							</div>
						</div>
					</div>
					<div class="weui-dialog__ft">
						<a href="javascript:;"
							class="weui-dialog__btn weui-dialog__btn_default">投注记录</a> <a
							href="javascript:;"
							class="weui-dialog__btn weui-dialog__btn_primary">继续投注</a>
					</div>
				</div>
			</div>
		</div>
		-->
		
	</div>


	
	<div data-v-bf66ef20="" class="home-page" style="display:none;">
		<div data-v-bf66ef20="" class="vux-popup-dialog base-popup vux-popup-bottom vux-popup-dialog vux-popup-dialog-bwpzr" style="height:auto;max-height:70vh;">
			<div class="popup-header">
				<div></div>
				<div class="center-title">选择比赛日期</div>
				<div class="click-close-btn hide-btn"></div>
			</div>
			<div data-v-bf66ef20="">
				<div data-v-bf66ef20="" class="popup-content" id="vux-scroller-vjk78" style="max-height: calc(70vh - 154px); height: 200px; touch-action: auto; user-select: none; -webkit-user-drag: none; -webkit-tap-highlight-color: rgba(0, 0, 0, 0); position: relative; overflow: hidden;">
					<div class="xs-container" style="transform-origin: 0px 0px 0px; transform: translate(0px, 0px) translateZ(0px);">
						<div data-v-bf66ef20="" class="date-list" style="height: 200px; transform-origin: 0px 0px 0px; transform: translate(0px, 0px) scale(1) translateZ(0px);">
							<div data-v-bf66ef20="" class="date-item selected-date-item">2018年09月06日 周四<span data-v-bf66ef20="" class="selected-date-icon"> ✓ </span></div>
							<div data-v-bf66ef20="" class="date-item">2018年09月07日 周四</div>
							<div data-v-bf66ef20="" class="date-item">2018年09月08日 周四</div>
							<div data-v-bf66ef20="" class="date-item">2018年09月09日 周四</div>
							<div data-v-bf66ef20="" class="date-item">2018年09月10日 周四</div>
						</div>
					</div>
					<div class=" xs-fixed-container"></div>
				</div>
				<div data-v-bf66ef20="" class="close-date-picker"></div>
			</div>
		</div>
	</div>
	
	
</body>
</html>