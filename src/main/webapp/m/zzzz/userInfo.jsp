<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%><!DOCTYPE html>
<html>
<head>
<title>用户中心 - <%=com.yy.guess.util.Util.getConfigCom(application).getWebTitle()%></title>
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
						transform="rotate(148.449 20 20)">
					<animateTransform data-v-c96941ea="" attributeType="xml"
						attributeName="transform" type="rotate" from="0 20 20"
						to="360 20 20" dur="0.5s" repeatCount="indefinite"></animateTransform></path></svg>
			</div>
		</div>
		<nav data-v-1db5fc32="" class="app-header">
			<ul data-v-1db5fc32="">
				<li data-v-1db5fc32="" class="base-icon history-back"></li>
				<li data-v-1db5fc32="">个人资料</li>
				<li data-v-1db5fc32=""><a data-v-1db5fc32="" href="#/setting"
					class="base-icon account-setting"></a></li>
			</ul>
		</nav>
		<div class="weui-tab dark-view">
			<div id="vux_view_box_body"
				class="weui-tab__panel vux-fix-safari-overflow-scrolling">
				<div data-v-0df6a7f4="" class="personal-info router-view">
					<section data-v-0df6a7f4="" class="link-list">
						<div data-v-0df6a7f4="">
							<!---->
							<div class="weui-cells vux-no-group-title">
								<div data-v-0df6a7f4="" class="weui-cell user-name"
									style="height: 113px;">
									<div class="weui-cell__hd"></div>
									<div class="vux-cell-bd vux-cell-primary">
										<p>
											<label class="vux-label">下午好!</label>
										</p>
										<span class="vux-label-desc">yy3110044</span>
									</div>
									<div class="weui-cell__ft">
										<!---->
									</div>
								</div>
								<div data-v-0df6a7f4=""
									class="weui-cell vux-tap-active weui-cell_access">
									<div class="weui-cell__hd">
										<div data-v-0df6a7f4="" class="base-icon wallet-icon"></div>
									</div>
									<div class="vux-cell-bd vux-cell-primary">
										<p>
											<label class="vux-label">钱包</label>
										</p>
										<span class="vux-label-desc"></span>
									</div>
									<div class="weui-cell__ft">
										<p data-v-0df6a7f4="" class="wallet-lebal">
											<span data-v-0df6a7f4="">余额</span> <span data-v-0df6a7f4=""
												class="wallet-lebal-balance">&nbsp;¥ 0.00</span>
										</p>
										<!---->
									</div>
								</div>
							</div>
							<!---->
						</div>
						<div data-v-0df6a7f4="">
							<!---->
							<div class="weui-cells vux-no-group-title">
								<div data-v-0df6a7f4=""
									class="weui-cell vux-tap-active weui-cell_access">
									<div class="weui-cell__hd">
										<div data-v-0df6a7f4="" class="base-icon bettingrecord-icon"></div>
									</div>
									<div class="vux-cell-bd vux-cell-primary">
										<p>
											<label class="vux-label">投注记录</label>
										</p>
										<span class="vux-label-desc"></span>
									</div>
									<div class="weui-cell__ft">
										<!---->
									</div>
								</div>
								<div data-v-0df6a7f4=""
									class="weui-cell vux-tap-active weui-cell_access">
									<div class="weui-cell__hd">
										<div data-v-0df6a7f4="" class="notice-badge"></div>
										<div data-v-0df6a7f4="" class="base-icon notice-icon"></div>
									</div>
									<div class="vux-cell-bd vux-cell-primary">
										<p>
											<label class="vux-label">通知</label>
										</p>
										<span class="vux-label-desc"></span>
									</div>
									<div class="weui-cell__ft">
										<!---->
									</div>
								</div>
								<div data-v-0df6a7f4=""
									class="weui-cell vux-tap-active weui-cell_access">
									<div class="weui-cell__hd">
										<div data-v-0df6a7f4="" class="base-icon activity-icon"></div>
									</div>
									<div class="vux-cell-bd vux-cell-primary">
										<p>
											<label class="vux-label">活动</label>
										</p>
										<span class="vux-label-desc"></span>
									</div>
									<div class="weui-cell__ft">
										<!---->
									</div>
								</div>
							</div>
							<!---->
						</div>
						<div data-v-0df6a7f4="">
							<!---->
							<div class="weui-cells vux-no-group-title">
								<div data-v-0df6a7f4=""
									class="weui-cell vux-tap-active weui-cell_access">
									<div class="weui-cell__hd">
										<div data-v-0df6a7f4="" class="base-icon rule-icon"></div>
									</div>
									<div class="vux-cell-bd vux-cell-primary">
										<p>
											<label class="vux-label">玩法规则</label>
										</p>
										<span class="vux-label-desc"></span>
									</div>
									<div class="weui-cell__ft">
										<!---->
									</div>
								</div>
								<div data-v-0df6a7f4=""
									class="weui-cell vux-tap-active weui-cell_access">
									<div class="weui-cell__hd">
										<div data-v-0df6a7f4="" class="base-icon about-icon"></div>
									</div>
									<div class="vux-cell-bd vux-cell-primary">
										<p>
											<label class="vux-label">关于我们</label>
										</p>
										<span class="vux-label-desc"></span>
									</div>
									<div class="weui-cell__ft">
										<!---->
									</div>
								</div>
							</div>
							<!---->
						</div>
					</section>
					<section data-v-0df6a7f4="" class="button-group">
						<a data-v-0df6a7f4="" href="#/personal/invite" class="button">
							推荐 </a>
						<div data-v-0df6a7f4="" class="button">代理</div>
						<a data-v-e7bb725a="" data-v-0df6a7f4=""
							href="//www.xlbmama.com/chat/h5/index.html?sysNum=322d704743e04896b8a70524ae45127e"
							target="_blank" rel="noopener noreferrer"
							class="customer-service button"> 联系 </a>
					</section>
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
	<a class="vux-popup-mask" data-uuid=",vsmnj,5m6p2"
		href="javascript:void(0)"></a>
</body>
</html>