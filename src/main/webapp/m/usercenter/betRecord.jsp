<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%><!DOCTYPE html>
<html>
<head>
<title>投注记录 - <%=com.yy.guess.util.Util.getConfigCom(application).getWebTitle()%></title>
<%@include file="/m/head-common.jsp"%>
<script src="m/js/mescroll.min.js"></script>
<script src="m/js/usercenter.js"></script>
<link href="m/js/mescroll.min.css" rel="stylesheet">
<style type="text/css">
#vux-scroller-6vidl::-webkit-scrollbar{display:none;width:0;height:0;}
</style>
</head>
<body>
	<div id="app">
		<nav data-v-1db5fc32="" class="app-header">
			<ul data-v-1db5fc32="">
				<li data-v-1db5fc32="" onclick="window.location.href='m/usercenter/menu.jsp'" class="base-icon history-back"></li>
				<li data-v-1db5fc32="">投注记录</li>
				<li data-v-1db5fc32="" class="base-icon"></li>
			</ul>
		</nav>
		<div class="weui-tab">
			<div id="vux_view_box_body" class="weui-tab__panel vux-fix-safari-overflow-scrolling">
				<div data-v-1545e424="" class="betting-record-page router-view">
					<section data-v-1545e424="">
						<div data-v-1545e424="" class="vux-tab-wrap">
							<div class="vux-tab-container">
								<div class="vux-tab">
									<div data-v-1545e424="" class="vux-tab-item vux-tab-selected" style="border:none;color:rgb(255, 255, 255);">未结算</div>
									<div data-v-1545e424="" class="vux-tab-item" style="border:none;color:rgb(186, 206, 241);">已结算</div>
									<div class="vux-tab-ink-bar vux-tab-ink-bar-transition-backward" style="display:block;height:22px;background-color:transparent;left:0%;right:50%;"></div>
								</div>
							</div>
						</div>
					</section>
					
					<div data-v-1545e424="" id="vux-scroller-6vidl" class="mescroll" style="touch-action:auto;user-select:none;-webkit-user-drag:none;-webkit-tap-highlight-color:rgba(0, 0, 0, 0);position:relative;overflow:scroll;">
						<div class="xs-container" style="transform-origin: 0px 0px 0px; transform: translateY(0px) translateZ(0px);">
							<div data-v-1545e424="" id="record-card-container" style="transform-origin: 0px 0px 0px; transform: translate(0px, 0px) scale(1) translateZ(0px);padding-bottom:4px;">
							
							
							
							<!--  
								<div data-v-1545e424="" class="record-card">
									<div data-v-1545e424="" class="order-detail">
										<div data-v-1545e424="" class="detail-header">
											<div data-v-1545e424="" class="header-title-left">
												<img data-v-1545e424="" src="" class="game-icon">
												<span data-v-1545e424="" class="title">Athletico Esport 获胜者</span>
											</div>
											<div data-v-1545e424=""><span data-v-1545e424="">全场</span> <span data-v-1545e424="">赛前</span></div>
										</div>
										<div data-v-1545e424="" class="header-hr"></div>
										<div data-v-1545e424="" class="result-flag win-flag"></div>
										<div data-v-1545e424="" class="order-content">
											<div data-v-1545e424="" class="content-list">
												<div data-v-1545e424="" class="list-text">Athletico Esport - VS - SaveBuyBackPlz</div>
												<div data-v-1545e424="" class="list-text">开始时间:2018-09-03 19:20:00</div>
												<div data-v-1545e424="" class="list-text">赔率: 1.27</div>
											</div>
										</div>
									</div>
									<section data-v-1545e424="" class="order-info">
										<div data-v-1545e424="" class="parlay-title"><span data-v-1545e424="">单场</span><span data-v-1545e424="" class="odds-status order-close">已结算 </span></div>
										<div data-v-1545e424="" class="info-content">
											<div data-v-1545e424="" class="bet-amount">投注金额: <span data-v-1545e424="" class="stake">10.00</span></div>
											<div data-v-1545e424="" class="profit">盈利 <span data-v-1545e424="" class="bonus-win"> 12.70</span></div>
										</div>
										<div data-v-1545e424="" style="height:18px;"></div>
										<div data-v-1545e424="" class="info-content"><div data-v-1545e424="">订单号: 4f0108a7a698d63283</div><div data-v-1545e424="">2018-09-03 18:58:05</div></div>
									</section>
								</div>
							-->
							
							
							
							
							</div>
						</div>
						<div class=" xs-fixed-container"></div>
					</div>
				</div>
			</div>
		</div>
	</div>
</body>
</html>