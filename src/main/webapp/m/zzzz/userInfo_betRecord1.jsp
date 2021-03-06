<%@ page language="java" contentType="text/html;charset=UTF-8"
	pageEncoding="UTF-8"%><!DOCTYPE html>
<html>
<head>
<title>投注记录 - <%=com.yy.guess.util.Util.getConfigCom(application).getWebTitle()%></title>
<%@include file="/m/head-common.jsp"%>
</head>
<body>
	<noscript>
		<strong>請啟用JavaScript已继续。</strong><br>
		<h5>iOS > 设置 > Safari浏览器 > 高级 > JavaScript</h5>
		<h5>Chrome > 设置 > 网站设置 > JavaScript</h5>
	</noscript>
	<div id="app" class="">
		<!---->
		<!---->
		<!---->
		<div class="loading-bkg" style="display: none;">
			<div data-v-c96941ea="" class="loading">
				<svg data-v-c96941ea="" version="1.1" id="loader-1"
					xmlns="http://www.w3.org/2000/svg"
					xmlns:xlink="http://www.w3.org/1999/xlink" x="0px" y="0px"
					width="40px" height="40px" viewBox="0 0 40 40"
					enable-background="new 0 0 40 40" xml:space="preserve">
					<path data-v-c96941ea="" opacity="0.2" fill="#000"
						d="M20.201,5.169c-8.254,0-14.946,6.692-14.946,14.946c0,8.255,6.692,14.946,14.946,14.946
  s14.946-6.691,14.946-14.946C35.146,11.861,28.455,5.169,20.201,5.169z M20.201,31.749c-6.425,0-11.634-5.208-11.634-11.634
  c0-6.425,5.209-11.634,11.634-11.634c6.425,0,11.633,5.209,11.633,11.634C31.834,26.541,26.626,31.749,20.201,31.749z"></path> <path
						data-v-c96941ea="" fill="#000"
						d="M26.013,10.047l1.654-2.866c-2.198-1.272-4.743-2.012-7.466-2.012h0v3.312h0
  C22.32,8.481,24.301,9.057,26.013,10.047z"
						transform="rotate(258.803 20 20)">
					<animateTransform data-v-c96941ea="" attributeType="xml"
						attributeName="transform" type="rotate" from="0 20 20"
						to="360 20 20" dur="0.5s" repeatCount="indefinite"></animateTransform></path></svg>
			</div>
		</div>
		<nav data-v-1db5fc32="" class="app-header">
			<ul data-v-1db5fc32="">
				<li data-v-1db5fc32="" class="base-icon history-back"></li>
				<li data-v-1db5fc32="">投注记录</li>
				<li data-v-1db5fc32="" class="base-icon"></li>
			</ul>
		</nav>
		<div class="weui-tab">
			<div id="vux_view_box_body"
				class="weui-tab__panel vux-fix-safari-overflow-scrolling">
				<div data-v-1545e424="" class="betting-record-page router-view">
					<section data-v-1545e424="">
						<div data-v-1545e424="" class="vux-tab-wrap">
							<div class="vux-tab-container">
								<div class="vux-tab">
									<div data-v-1545e424="" class="vux-tab-item vux-tab-selected"
										style="border: none; color: rgb(255, 255, 255);">
										未结算
										<!---->
									</div>
									<div data-v-1545e424="" class="vux-tab-item"
										style="border: none; color: rgb(186, 206, 241);">
										已结算
										<!---->
									</div>
									<div
										class="vux-tab-ink-bar vux-tab-ink-bar-transition-backward"
										style="display: block; height: 22px; background-color: transparent; left: 0%; right: 50%;">
										<!---->
									</div>
								</div>
							</div>
						</div>
					</section>
					<div data-v-1545e424="" id="vux-scroller-6vidl"
						style="height: 795px; touch-action: auto; user-select: none; -webkit-user-drag: none; -webkit-tap-highlight-color: rgba(0, 0, 0, 0); position: relative; overflow: hidden;">
						<div class="xs-container"
							style="transform-origin: 0px 0px 0px; transform: translateY(0px) translateZ(0px);">
							<div data-v-1545e424=""
								style="transform-origin: 0px 0px 0px; transform: translate(0px, 0px) scale(1) translateZ(0px);">
								<div data-v-1545e424="" class="record-card">
									<div data-v-1545e424="" class="order-detail">
										<div data-v-1545e424="" class="detail-header">
											<div data-v-1545e424="" class="header-title-left">
												<img data-v-1545e424=""
													src="//yuanjududu.com//file/98c6eb475bf90d035c0d6b7f31fd59d0.svg"
													class="game-icon"> <span data-v-1545e424=""
													class="title">Red Reserve 获胜者</span>
											</div>
											<div data-v-1545e424="">
												<span data-v-1545e424="">全场</span> <span data-v-1545e424="">滚盘</span>
											</div>
										</div>
										<div data-v-1545e424="" class="header-hr"></div>
										<div data-v-1545e424="" class="result-flag"></div>
										<div data-v-1545e424="" class="order-content">
											<div data-v-1545e424="" class="content-list">
												<div data-v-1545e424="" class="list-text">3DMAX - VS -
													Red Reserve</div>
												<div data-v-1545e424="" class="list-text">开始时间:
													2018-09-03 18:14:00</div>
												<div data-v-1545e424="" class="list-text">赔率: 1.91</div>
												<!---->
											</div>
										</div>
									</div>
									<section data-v-1545e424="" class="order-info">
										<div data-v-1545e424="" class="parlay-title">
											<span data-v-1545e424="">单场</span> <span data-v-1545e424=""
												class="odds-status order-open">未结算 </span>
										</div>
										<div data-v-1545e424="" class="info-content">
											<div data-v-1545e424="" class="bet-amount">
												投注金额: <span data-v-1545e424="" class="stake">20.00</span>
											</div>
											<div data-v-1545e424="" class="profit">
												盈利 <span data-v-1545e424="" class="bonus-win"> 38.20
												</span>
											</div>
										</div>
										<div data-v-1545e424="" style="height: 18px;"></div>
										<div data-v-1545e424="" class="info-content">
											<div data-v-1545e424="">订单号: 4effd6231698d63337</div>
											<div data-v-1545e424="">2018-09-03 18:37:09</div>
										</div>
									</section>
								</div>
							</div>
							<!---->
							<!---->
						</div>
						<div class=" xs-fixed-container"></div>
					</div>
				</div>
			</div>
		</div>
		<!---->
		<!---->
	</div>
	<script type="text/javascript" async=""
		src="https://www.google-analytics.com/analytics.js"></script>
	<script async=""
		src="https://www.googletagmanager.com/gtag/js?id=UA-115025704-1"></script>
	<script>
		window.dataLayer = window.dataLayer || []

		function gtag() {
			dataLayer.push(arguments)
		}
		gtag('js', new Date())

		gtag('config', 'UA-115025704-1')
		window.addEventListener('load', function() {
			setTimeout(function() {
				window.scrollTo(0, 1)
			}, 10)
		})
	</script>
	<script type="text/javascript"
		src="static/js/manifest.569709e9b6416c4decb5.js"></script>
	<script type="text/javascript"
		src="static/js/vendor.a457f24991fca5f2ac72.js"></script>
	<script type="text/javascript"
		src="static/js/app.025d194ca9a0fd517ef4.js"></script>
	<div class="vux-alert">
		<div class="vux-x-dialog">
			<div class="weui-mask" style="display: none;"></div>
			<div class="weui-dialog" style="display: none;">
				<div class="weui-dialog__hd">
					<strong class="weui-dialog__title"></strong>
				</div>
				<div class="weui-dialog__bd">
					<div></div>
				</div>
				<div class="weui-dialog__ft">
					<a href="javascript:;"
						class="weui-dialog__btn weui-dialog__btn_primary">确定</a>
				</div>
			</div>
		</div>
	</div>
	<div class="vux-confirm">
		<div class="vux-x-dialog">
			<div class="weui-mask" style="display: none;"></div>
			<div class="weui-dialog" style="display: none;">
				<!---->
				<div class="weui-dialog__bd">
					<div></div>
				</div>
				<div class="weui-dialog__ft">
					<a href="javascript:;"
						class="weui-dialog__btn weui-dialog__btn_default">取消</a> <a
						href="javascript:;"
						class="weui-dialog__btn weui-dialog__btn_primary">确定</a>
				</div>
			</div>
		</div>
	</div>
	<div class="vux-toast">
		<div class="weui-mask_transparent" style="display: none;"></div>
		<div class="weui-toast weui-toast_success"
			style="width: 7.6em; display: none;">
			<i class="weui-icon-success-no-circle weui-icon_toast"></i>
			<p class="weui-toast__content"></p>
		</div>
	</div>
	<div data-v-cd2dfd02="" class="base-alert v-transfer-dom">
		<div data-v-cd2dfd02="" class="vux-x-dialog">
			<div class="weui-mask" style="display: none;"></div>
			<div class="weui-dialog"
				style="background: transparent; display: none;">
				<div data-v-cd2dfd02="" class="alert-content">
					<div data-v-cd2dfd02="" class="warning"></div>
					<div data-v-cd2dfd02="" class="alert-text"></div>
					<div data-v-cd2dfd02="" class="alert-hr"></div>
					<div data-v-cd2dfd02="" class="alert-btn">确认</div>
				</div>
			</div>
		</div>
	</div>
	<a class="vux-popup-mask" data-uuid=",qj7x3,kctx1"
		href="javascript:void(0)" style="z-index: -1;"></a>
</body>
</html>