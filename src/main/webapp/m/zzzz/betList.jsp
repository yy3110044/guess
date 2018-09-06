<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%><!DOCTYPE html>
<html>
<head>
<title>下注列表 - <%=com.yy.guess.util.Util.getConfigCom(application).getWebTitle()%></title>
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
						transform="rotate(5.02128 20 20)">
					<animateTransform data-v-c96941ea="" attributeType="xml"
						attributeName="transform" type="rotate" from="0 20 20"
						to="360 20 20" dur="0.5s" repeatCount="indefinite"></animateTransform></path></svg>
			</div>
		</div>
		<nav data-v-1db5fc32="" class="app-header">
			<ul data-v-1db5fc32="">
				<li data-v-1db5fc32="">
					<!----> <a data-v-1db5fc32="" href="#/personal"
					class="base-icon personal-info"></a>
				</li>
				<li data-v-1db5fc32="" class="home-logo"></li>
				<li data-v-1db5fc32=""><a data-v-e7bb725a="" data-v-1db5fc32=""
					href="//www.xlbmama.com/chat/h5/index.html?sysNum=322d704743e04896b8a70524ae45127e"
					target="_blank" rel="noopener noreferrer"
					class="customer-service base-icon service-link"> </a></li>
			</ul>
		</nav>
		<div class="weui-tab">
			<div id="vux_view_box_body"
				class="weui-tab__panel vux-fix-safari-overflow-scrolling">
				<div data-v-bf66ef20="" class="home-page router-view">
					<div data-v-de9ae73a="" data-v-bf66ef20="" class="home-header">
						<section data-v-de9ae73a="" class="filter-matches">
							<div data-v-de9ae73a="" class="vux-tab-wrap match-tab">
								<div class="vux-tab-container">
									<div class="vux-tab">
										<div data-v-de9ae73a="" class="vux-tab-item vux-tab-selected"
											style="border: none; color: rgb(255, 255, 255);">
											今日 <span data-v-de9ae73a="" class="match-number">17</span>
											<!---->
										</div>
										<span data-v-de9ae73a="" class="column-line"></span>
										<div data-v-de9ae73a="" class="vux-tab-item"
											style="border: none; color: rgb(186, 206, 241);">
											滚盘 <span data-v-de9ae73a="" class="match-number">0</span>
											<!---->
										</div>
										<span data-v-de9ae73a="" class="column-line"></span>
										<div data-v-de9ae73a="" class="vux-tab-item"
											style="border: none; color: rgb(186, 206, 241);">
											赛前 <span data-v-de9ae73a="" class="match-number">57</span>
											<!---->
										</div>
										<span data-v-de9ae73a="" class="column-line"></span>
										<div data-v-de9ae73a="" class="vux-tab-item"
											style="border: none; color: rgb(186, 206, 241);">
											已结束
											<!---->
										</div>
										<span data-v-de9ae73a="" class="column-line"></span>
										<div
											class="vux-tab-ink-bar vux-tab-ink-bar-transition-backward"
											style="display: block; height: 22px; background-color: transparent; left: 0%; right: 75%;">
											<!---->
										</div>
									</div>
								</div>
							</div>
							<div data-v-de9ae73a="" class="show-filter-games-btn"></div>
						</section>
						<section data-v-de9ae73a="" class="filter-games"
							style="display: none;">
							<div data-v-de9ae73a="" class="hide-filter-games-btn"
								style="visibility: hidden;">完成</div>
							<div data-v-de9ae73a="">筛选游戏</div>
							<div data-v-de9ae73a="" class="hide-filter-games-btn">
								<div data-v-de9ae73a="" class="btn-content">✓</div>
							</div>
						</section>
					</div>
					<div data-v-cd1e9d3c="" data-v-bf66ef20="">
						<div data-v-cd1e9d3c=""
							class="vux-popup-dialog games-picker vux-popup-top vux-popup-dialog vux-popup-dialog-mfqea"
							style="height: calc(100% - 92px); display: none;">
							<div data-v-cd1e9d3c="" class="vux-checker-box checker-content">
								<div data-v-cd1e9d3c=""
									class="default-checker-item selected-checker-item">
									<div data-v-cd1e9d3c="" style="height: 2px;">&nbsp;</div>
									<div data-v-cd1e9d3c="" class="games-info">
										<div data-v-cd1e9d3c="" class="games-icon all-games-icon"></div>
										<div data-v-cd1e9d3c="">全部</div>
									</div>
									<div data-v-cd1e9d3c="" class="selected-checker-light"></div>
								</div>
								<div data-v-cd1e9d3c=""
									class="vux-checker-item vux-tap-active default-checker-item selected-all-games">
									<div data-v-cd1e9d3c="" style="height: 2px;">&nbsp;</div>
									<div data-v-cd1e9d3c="" class="games-info">
										<div data-v-cd1e9d3c="" class="games-icon"
											style="background-image: url(&quot;//yuanjududu.com//file/d511f1c87538e99ca914ef559dfa68ba.svg&quot;);"></div>
										<div data-v-cd1e9d3c="">DOTA2</div>
									</div>
									<div data-v-cd1e9d3c="" class="selected-checker-light"></div>
								</div>
								<div data-v-cd1e9d3c=""
									class="vux-checker-item vux-tap-active default-checker-item selected-all-games">
									<div data-v-cd1e9d3c="" style="height: 2px;">&nbsp;</div>
									<div data-v-cd1e9d3c="" class="games-info">
										<div data-v-cd1e9d3c="" class="games-icon"
											style="background-image: url(&quot;//yuanjududu.com//file/98c6eb475bf90d035c0d6b7f31fd59d0.svg&quot;);"></div>
										<div data-v-cd1e9d3c="">CSGO</div>
									</div>
									<div data-v-cd1e9d3c="" class="selected-checker-light"></div>
								</div>
								<div data-v-cd1e9d3c=""
									class="vux-checker-item vux-tap-active default-checker-item selected-all-games">
									<div data-v-cd1e9d3c="" style="height: 2px;">&nbsp;</div>
									<div data-v-cd1e9d3c="" class="games-info">
										<div data-v-cd1e9d3c="" class="games-icon"
											style="background-image: url(&quot;//yuanjududu.com//file/cb9287b9cbdc7414adeb287df1feeebb.svg&quot;);"></div>
										<div data-v-cd1e9d3c="">英雄联盟</div>
									</div>
									<div data-v-cd1e9d3c="" class="selected-checker-light"></div>
								</div>
								<div data-v-cd1e9d3c=""
									class="vux-checker-item vux-tap-active default-checker-item selected-all-games">
									<div data-v-cd1e9d3c="" style="height: 2px;">&nbsp;</div>
									<div data-v-cd1e9d3c="" class="games-info">
										<div data-v-cd1e9d3c="" class="games-icon"
											style="background-image: url(&quot;//yuanjududu.com//file/aebc1f0c88b9eab27a72511d0e1a9d8e.svg&quot;);"></div>
										<div data-v-cd1e9d3c="">王者荣耀</div>
									</div>
									<div data-v-cd1e9d3c="" class="selected-checker-light"></div>
								</div>
								<div data-v-cd1e9d3c=""
									class="vux-checker-item vux-tap-active default-checker-item selected-all-games">
									<div data-v-cd1e9d3c="" style="height: 2px;">&nbsp;</div>
									<div data-v-cd1e9d3c="" class="games-info">
										<div data-v-cd1e9d3c="" class="games-icon"
											style="background-image: url(&quot;//yuanjududu.com//file/a95bc328b06d816f3bbe02f54f96e28b.svg&quot;);"></div>
										<div data-v-cd1e9d3c="">NBA2K</div>
									</div>
									<div data-v-cd1e9d3c="" class="selected-checker-light"></div>
								</div>
								<div data-v-cd1e9d3c=""
									class="vux-checker-item vux-tap-active default-checker-item selected-all-games">
									<div data-v-cd1e9d3c="" style="height: 2px;">&nbsp;</div>
									<div data-v-cd1e9d3c="" class="games-info">
										<div data-v-cd1e9d3c="" class="games-icon"
											style="background-image: url(&quot;//yuanjududu.com//file/13b49eb1b56bf525db89b23feab1d886.svg&quot;);"></div>
										<div data-v-cd1e9d3c="">使命召唤</div>
									</div>
									<div data-v-cd1e9d3c="" class="selected-checker-light"></div>
								</div>
								<div data-v-cd1e9d3c=""
									class="vux-checker-item vux-tap-active default-checker-item selected-all-games">
									<div data-v-cd1e9d3c="" style="height: 2px;">&nbsp;</div>
									<div data-v-cd1e9d3c="" class="games-info">
										<div data-v-cd1e9d3c="" class="games-icon"
											style="background-image: url(&quot;//yuanjududu.com//file/baa7d68694149d7385d1374c31bd070d.svg&quot;);"></div>
										<div data-v-cd1e9d3c="">守望先锋</div>
									</div>
									<div data-v-cd1e9d3c="" class="selected-checker-light"></div>
								</div>
								<div data-v-cd1e9d3c=""
									class="vux-checker-item vux-tap-active default-checker-item selected-all-games">
									<div data-v-cd1e9d3c="" style="height: 2px;">&nbsp;</div>
									<div data-v-cd1e9d3c="" class="games-info">
										<div data-v-cd1e9d3c="" class="games-icon"
											style="background-image: url(&quot;//yuanjududu.com//file/2f657b4e0d2854ce02cd7220e002981f.svg&quot;);"></div>
										<div data-v-cd1e9d3c="">星际争霸II</div>
									</div>
									<div data-v-cd1e9d3c="" class="selected-checker-light"></div>
								</div>
								<div data-v-cd1e9d3c=""
									class="vux-checker-item vux-tap-active default-checker-item selected-all-games">
									<div data-v-cd1e9d3c="" style="height: 2px;">&nbsp;</div>
									<div data-v-cd1e9d3c="" class="games-info">
										<div data-v-cd1e9d3c="" class="games-icon"
											style="background-image: url(&quot;//yuanjududu.com//file/d738248012c8b89a1bc91b16b04174ea.svg&quot;);"></div>
										<div data-v-cd1e9d3c="">火箭联盟</div>
									</div>
									<div data-v-cd1e9d3c="" class="selected-checker-light"></div>
								</div>
								<div data-v-cd1e9d3c=""
									class="vux-checker-item vux-tap-active default-checker-item selected-all-games">
									<div data-v-cd1e9d3c="" style="height: 2px;">&nbsp;</div>
									<div data-v-cd1e9d3c="" class="games-info">
										<div data-v-cd1e9d3c="" class="games-icon"
											style="background-image: url(&quot;//yuanjududu.com//file/eb8b6c6d7f3c5a78cf74cf3dc0af3cbd.svg&quot;);"></div>
										<div data-v-cd1e9d3c="">风暴英雄</div>
									</div>
									<div data-v-cd1e9d3c="" class="selected-checker-light"></div>
								</div>
								<div data-v-cd1e9d3c=""
									class="vux-checker-item vux-tap-active default-checker-item selected-all-games">
									<div data-v-cd1e9d3c="" style="height: 2px;">&nbsp;</div>
									<div data-v-cd1e9d3c="" class="games-info">
										<div data-v-cd1e9d3c="" class="games-icon"
											style="background-image: url(&quot;//yuanjududu.com//file/7f688259752eb88b5a0100b7f8fae06d.svg&quot;);"></div>
										<div data-v-cd1e9d3c="">魔兽争霸3</div>
									</div>
									<div data-v-cd1e9d3c="" class="selected-checker-light"></div>
								</div>
								<div data-v-cd1e9d3c=""
									class="vux-checker-item vux-tap-active default-checker-item selected-all-games">
									<div data-v-cd1e9d3c="" style="height: 2px;">&nbsp;</div>
									<div data-v-cd1e9d3c="" class="games-info">
										<div data-v-cd1e9d3c="" class="games-icon"
											style="background-image: url(&quot;//yuanjududu.com//file/386a7711f9ceadab739c2d58a3f45b5f.svg&quot;);"></div>
										<div data-v-cd1e9d3c="">绝地求生</div>
									</div>
									<div data-v-cd1e9d3c="" class="selected-checker-light"></div>
								</div>
								<div data-v-cd1e9d3c=""
									class="vux-checker-item vux-tap-active default-checker-item selected-all-games">
									<div data-v-cd1e9d3c="" style="height: 2px;">&nbsp;</div>
									<div data-v-cd1e9d3c="" class="games-info">
										<div data-v-cd1e9d3c="" class="games-icon"
											style="background-image: url(&quot;//yuanjududu.com//file/bcdfb2b7a95d5b0598c5cfb9ac92a661.svg&quot;);"></div>
										<div data-v-cd1e9d3c="">炉石传说</div>
									</div>
									<div data-v-cd1e9d3c="" class="selected-checker-light"></div>
								</div>
								<div data-v-cd1e9d3c=""
									class="vux-checker-item vux-tap-active default-checker-item selected-all-games">
									<div data-v-cd1e9d3c="" style="height: 2px;">&nbsp;</div>
									<div data-v-cd1e9d3c="" class="games-info">
										<div data-v-cd1e9d3c="" class="games-icon"
											style="background-image: url(&quot;//yuanjududu.com//file/cd05d085f112a5bf8375894d5c7ecb19.svg&quot;);"></div>
										<div data-v-cd1e9d3c="">足球</div>
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
								<div data-v-bf66ef20="" class="vux-marquee"
									style="height: 16px;">
									<ul class="vux-marquee-box"
										style="transform: translate3d(0px, -64px, 0px); transition: transform 300ms ease 0s;">
										<li data-v-bf66ef20="" class="notice-item"><div
												data-v-bf66ef20="">【请注意盘口中“第N次击杀”和“N杀”是不同玩法。】</div></li>
										<li data-v-bf66ef20="" class="notice-item"><div
												data-v-bf66ef20="">【投注时若遇到系统繁忙/网站很卡</div></li>
										<li data-v-bf66ef20="" class="notice-item"><div
												data-v-bf66ef20="">请先查注单是否已下注成功在进行二次投注.</div></li>
										<li data-v-bf66ef20="" class="notice-item"><div
												data-v-bf66ef20="">若发生重复投注一概不取消。】</div></li>
										<li data-v-bf66ef20="" class="notice-item"><div
												data-v-bf66ef20="">【原生app已发布，ios请联系客服重新下载安装。】</div></li>
										<li data-v-bf66ef20="" class="notice-item"><div
												data-v-bf66ef20="">【请注意盘口中“第N次击杀”和“N杀”是不同玩法。】</div></li>
									</ul>
								</div>
							</div>
						</section>
						<section data-v-bf66ef20="" class="loading-bkg"
							style="display: none;">
							<div data-v-c96941ea="" data-v-bf66ef20="" class="loading">
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
										transform="rotate(5.02128 20 20)">
									<animateTransform data-v-c96941ea="" attributeType="xml"
										attributeName="transform" type="rotate" from="0 20 20"
										to="360 20 20" dur="0.5s" repeatCount="indefinite"></animateTransform></path></svg>
							</div>
						</section>
						<div data-v-bf66ef20="" id="vux-scroller-60yre"
							style="height: 755px; touch-action: auto; user-select: none; -webkit-user-drag: none; -webkit-tap-highlight-color: rgba(0, 0, 0, 0); position: relative; overflow: hidden;">
							<div class="xs-container"
								style="transform-origin: 0px 0px 0px; transform: translateX(0px) translateY(0px) translateZ(0px) scale(1, 1); transition: none 0s ease 0s;">
								<div data-v-bf66ef20=""
									style="transform-origin: 0px 0px 0px; transform: translate(0px, 0px) scale(1) translateZ(0px);">
									<span data-v-bf66ef20=""><div data-v-18da170e=""
											data-v-bf66ef20="" class="home-match-card">
											<section data-v-18da170e="" class="card-header">
												<img data-v-18da170e=""
													src="//yuanjududu.com//file/98c6eb475bf90d035c0d6b7f31fd59d0.svg"
													width="20px">
												<div data-v-18da170e="" class="tournament-name">震中杯
													EPICENTER 2018</div>
												<div data-v-18da170e="" class="match-round">&nbsp;/
													bo3</div>
												<div data-v-18da170e="" class="play-count">+25</div>
											</section>
											<section data-v-18da170e="" class="card-body">
												<div data-v-18da170e="" class="card-body-team">
													<img data-v-18da170e=""
														src="//yuanjududu.com//file/3f6ee3d22a5473a0f4460e04deb31c67.png"
														class="team-logo">
												</div>
												<div data-v-18da170e="" class="card-body-center">
													<img data-v-18da170e=""
														src="data:image/svg+xml;base64,PD94bWwgdmVyc2lvbj0iMS4wIiBlbmNvZGluZz0iVVRGLTgiPz4KPHN2ZyB3aWR0aD0iMjRweCIgaGVpZ2h0PSI3OHB4IiB2aWV3Qm94PSIwIDAgMjQgNzgiIHZlcnNpb249IjEuMSIgeG1sbnM9Imh0dHA6Ly93d3cudzMub3JnLzIwMDAvc3ZnIiB4bWxuczp4bGluaz0iaHR0cDovL3d3dy53My5vcmcvMTk5OS94bGluayI+CiAgICA8IS0tIEdlbmVyYXRvcjogU2tldGNoIDQ5LjMgKDUxMTY3KSAtIGh0dHA6Ly93d3cuYm9oZW1pYW5jb2RpbmcuY29tL3NrZXRjaCAtLT4KICAgIDx0aXRsZT7ljaHniYfljLrliIblibLlt6Y8L3RpdGxlPgogICAgPGRlc2M+Q3JlYXRlZCB3aXRoIFNrZXRjaC48L2Rlc2M+CiAgICA8ZGVmcz4KICAgICAgICA8cmFkaWFsR3JhZGllbnQgY3g9IjEwMCUiIGN5PSI1MCUiIGZ4PSIxMDAlIiBmeT0iNTAlIiByPSI5OC44MDMyODc2JSIgZ3JhZGllbnRUcmFuc2Zvcm09InRyYW5zbGF0ZSgxLjAwMDAwMCwwLjUwMDAwMCksc2NhbGUoMS4wMDAwMDAsMC4zMDAwMDApLHJvdGF0ZSgtMTc5Ljk5OTk5OCksc2NhbGUoMS4wMDAwMDAsMS42MzI1MTgpLHRyYW5zbGF0ZSgtMS4wMDAwMDAsLTAuNTAwMDAwKSIgaWQ9InJhZGlhbEdyYWRpZW50LTEiPgogICAgICAgICAgICA8c3RvcCBzdG9wLWNvbG9yPSIjMEMxMjFGIiBvZmZzZXQ9IjAlIj48L3N0b3A+CiAgICAgICAgICAgIDxzdG9wIHN0b3AtY29sb3I9IiMxQTI1MzgiIHN0b3Atb3BhY2l0eT0iMCIgb2Zmc2V0PSIxMDAlIj48L3N0b3A+CiAgICAgICAgPC9yYWRpYWxHcmFkaWVudD4KICAgIDwvZGVmcz4KICAgIDxnIGlkPSLpm7fnq57mioAyLjAtY29weSIgc3Ryb2tlPSJub25lIiBzdHJva2Utd2lkdGg9IjEiIGZpbGw9Im5vbmUiIGZpbGwtcnVsZT0iZXZlbm9kZCIgZmlsbC1vcGFjaXR5PSIwLjMiPgogICAgICAgIDxnIGlkPSJpY29u5YiH5Zu+IiB0cmFuc2Zvcm09InRyYW5zbGF0ZSgtMTEyLjAwMDAwMCwgLTE5NjUuMDAwMDAwKSIgZmlsbD0idXJsKCNyYWRpYWxHcmFkaWVudC0xKSI+CiAgICAgICAgICAgIDxyZWN0IGlkPSLljaHniYfljLrliIblibLlt6YiIHg9IjExMiIgeT0iMTk2NCIgd2lkdGg9IjI0IiBoZWlnaHQ9IjgwIj48L3JlY3Q+CiAgICAgICAgPC9nPgogICAgPC9nPgo8L3N2Zz4="
														class="center-left">
													<div data-v-18da170e="" class="start-time">18:10</div>
													<img data-v-18da170e=""
														src="data:image/svg+xml;base64,PD94bWwgdmVyc2lvbj0iMS4wIiBlbmNvZGluZz0iVVRGLTgiPz4KPHN2ZyB3aWR0aD0iMjRweCIgaGVpZ2h0PSI3OHB4IiB2aWV3Qm94PSIwIDAgMjQgNzgiIHZlcnNpb249IjEuMSIgeG1sbnM9Imh0dHA6Ly93d3cudzMub3JnLzIwMDAvc3ZnIiB4bWxuczp4bGluaz0iaHR0cDovL3d3dy53My5vcmcvMTk5OS94bGluayI+CiAgICA8IS0tIEdlbmVyYXRvcjogU2tldGNoIDQ5LjMgKDUxMTY3KSAtIGh0dHA6Ly93d3cuYm9oZW1pYW5jb2RpbmcuY29tL3NrZXRjaCAtLT4KICAgIDx0aXRsZT7ljaHniYfljLrliIblibLlj7M8L3RpdGxlPgogICAgPGRlc2M+Q3JlYXRlZCB3aXRoIFNrZXRjaC48L2Rlc2M+CiAgICA8ZGVmcz4KICAgICAgICA8cmFkaWFsR3JhZGllbnQgY3g9IjEwMCUiIGN5PSI1MCUiIGZ4PSIxMDAlIiBmeT0iNTAlIiByPSI5OC44MDMyODc2JSIgZ3JhZGllbnRUcmFuc2Zvcm09InRyYW5zbGF0ZSgxLjAwMDAwMCwwLjUwMDAwMCksc2NhbGUoMS4wMDAwMDAsMC4zMDAwMDApLHJvdGF0ZSgtMTc5Ljk5OTk5OCksc2NhbGUoMS4wMDAwMDAsMS42MzI1MTgpLHRyYW5zbGF0ZSgtMS4wMDAwMDAsLTAuNTAwMDAwKSIgaWQ9InJhZGlhbEdyYWRpZW50LTEiPgogICAgICAgICAgICA8c3RvcCBzdG9wLWNvbG9yPSIjMEMxMjFGIiBvZmZzZXQ9IjAlIj48L3N0b3A+CiAgICAgICAgICAgIDxzdG9wIHN0b3AtY29sb3I9IiMxQTI1MzgiIHN0b3Atb3BhY2l0eT0iMCIgb2Zmc2V0PSIxMDAlIj48L3N0b3A+CiAgICAgICAgPC9yYWRpYWxHcmFkaWVudD4KICAgIDwvZGVmcz4KICAgIDxnIGlkPSLpm7fnq57mioAyLjAtY29weSIgc3Ryb2tlPSJub25lIiBzdHJva2Utd2lkdGg9IjEiIGZpbGw9Im5vbmUiIGZpbGwtcnVsZT0iZXZlbm9kZCIgZmlsbC1vcGFjaXR5PSIwLjMiPgogICAgICAgIDxnIGlkPSJpY29u5YiH5Zu+IiB0cmFuc2Zvcm09InRyYW5zbGF0ZSgtMTc2LjAwMDAwMCwgLTE5NjUuMDAwMDAwKSIgZmlsbD0idXJsKCNyYWRpYWxHcmFkaWVudC0xKSI+CiAgICAgICAgICAgIDxyZWN0IGlkPSLljaHniYfljLrliIblibLlj7MiIHRyYW5zZm9ybT0idHJhbnNsYXRlKDE4OC4wMDAwMDAsIDIwMDQuMDAwMDAwKSBzY2FsZSgtMSwgMSkgdHJhbnNsYXRlKC0xODguMDAwMDAwLCAtMjAwNC4wMDAwMDApICIgeD0iMTc2IiB5PSIxOTY0IiB3aWR0aD0iMjQiIGhlaWdodD0iODAiPjwvcmVjdD4KICAgICAgICA8L2c+CiAgICA8L2c+Cjwvc3ZnPg=="
														class="center-right">
												</div>
												<div data-v-18da170e="" class="card-body-team">
													<img data-v-18da170e=""
														src="//yuanjududu.com//file/1c8b7b613eefd276a83219b668722c23.png"
														class="team-logo">
												</div>
											</section>
											<div data-v-8d7d541a="" data-v-18da170e=""
												class="odds-group-title">
												<div data-v-8d7d541a="" class="empty-badge">&nbsp;</div>
												<div data-v-8d7d541a="" class="title">获胜者</div>
											</div>
											<section data-v-18da170e="" class="card-footer">
												<div data-v-18da170e="" class="card-odds-btn">
													<div data-v-ba6efc5c="" data-v-18da170e=""
														class="home-match-card-button">
														<div data-v-ba6efc5c="" class="button-dark-border">
															<div data-v-ba6efc5c="" class="button-content">
																<div data-v-ba6efc5c="" class="button-name">3DMAX</div>
																<div data-v-ba6efc5c="" class="button-odds-content">
																	<div data-v-ba6efc5c="" class="odds-rising-icon"></div>
																	<div data-v-ba6efc5c="" class="btn-odds">
																		<span data-v-ba6efc5c="">2.26</span>
																	</div>
																	<div data-v-ba6efc5c="" class="odds-dropping-icon"></div>
																</div>
															</div>
														</div>
													</div>
												</div>
												<div data-v-18da170e="" class="match-status">
													<div data-v-18da170e="" class="match-is-early">
														<div data-v-18da170e="" class="status-icon early-icon"></div>
														<div data-v-18da170e="" class="match-status-text">未开始</div>
													</div>
												</div>
												<div data-v-18da170e="" class="card-odds-btn">
													<div data-v-ba6efc5c="" data-v-18da170e=""
														class="home-match-card-button">
														<div data-v-ba6efc5c="" class="button-dark-border">
															<div data-v-ba6efc5c="" class="button-content">
																<div data-v-ba6efc5c="" class="button-name">Red
																	Reserve</div>
																<div data-v-ba6efc5c="" class="button-odds-content">
																	<div data-v-ba6efc5c="" class="odds-rising-icon"></div>
																	<div data-v-ba6efc5c="" class="btn-odds">
																		<span data-v-ba6efc5c="">1.58</span>
																	</div>
																	<div data-v-ba6efc5c="" class="odds-dropping-icon"></div>
																</div>
															</div>
														</div>
													</div>
												</div>
											</section>
										</div>
										<div data-v-18da170e="" data-v-bf66ef20=""
											class="home-match-card">
											<section data-v-18da170e="" class="card-header">
												<img data-v-18da170e=""
													src="//yuanjududu.com//file/d511f1c87538e99ca914ef559dfa68ba.svg"
													width="20px">
												<div data-v-18da170e="" class="tournament-name">ESL
													ANZ Championship</div>
												<div data-v-18da170e="" class="match-round">&nbsp;/
													bo1</div>
												<div data-v-18da170e="" class="play-count">+2</div>
											</section>
											<section data-v-18da170e="" class="card-body">
												<div data-v-18da170e="" class="card-body-team">
													<img data-v-18da170e=""
														src="//yuanjududu.com//file/1672db3ae01e54f06cce4dc44ec6ec7a.png"
														class="team-logo">
												</div>
												<div data-v-18da170e="" class="card-body-center">
													<img data-v-18da170e=""
														src="data:image/svg+xml;base64,PD94bWwgdmVyc2lvbj0iMS4wIiBlbmNvZGluZz0iVVRGLTgiPz4KPHN2ZyB3aWR0aD0iMjRweCIgaGVpZ2h0PSI3OHB4IiB2aWV3Qm94PSIwIDAgMjQgNzgiIHZlcnNpb249IjEuMSIgeG1sbnM9Imh0dHA6Ly93d3cudzMub3JnLzIwMDAvc3ZnIiB4bWxuczp4bGluaz0iaHR0cDovL3d3dy53My5vcmcvMTk5OS94bGluayI+CiAgICA8IS0tIEdlbmVyYXRvcjogU2tldGNoIDQ5LjMgKDUxMTY3KSAtIGh0dHA6Ly93d3cuYm9oZW1pYW5jb2RpbmcuY29tL3NrZXRjaCAtLT4KICAgIDx0aXRsZT7ljaHniYfljLrliIblibLlt6Y8L3RpdGxlPgogICAgPGRlc2M+Q3JlYXRlZCB3aXRoIFNrZXRjaC48L2Rlc2M+CiAgICA8ZGVmcz4KICAgICAgICA8cmFkaWFsR3JhZGllbnQgY3g9IjEwMCUiIGN5PSI1MCUiIGZ4PSIxMDAlIiBmeT0iNTAlIiByPSI5OC44MDMyODc2JSIgZ3JhZGllbnRUcmFuc2Zvcm09InRyYW5zbGF0ZSgxLjAwMDAwMCwwLjUwMDAwMCksc2NhbGUoMS4wMDAwMDAsMC4zMDAwMDApLHJvdGF0ZSgtMTc5Ljk5OTk5OCksc2NhbGUoMS4wMDAwMDAsMS42MzI1MTgpLHRyYW5zbGF0ZSgtMS4wMDAwMDAsLTAuNTAwMDAwKSIgaWQ9InJhZGlhbEdyYWRpZW50LTEiPgogICAgICAgICAgICA8c3RvcCBzdG9wLWNvbG9yPSIjMEMxMjFGIiBvZmZzZXQ9IjAlIj48L3N0b3A+CiAgICAgICAgICAgIDxzdG9wIHN0b3AtY29sb3I9IiMxQTI1MzgiIHN0b3Atb3BhY2l0eT0iMCIgb2Zmc2V0PSIxMDAlIj48L3N0b3A+CiAgICAgICAgPC9yYWRpYWxHcmFkaWVudD4KICAgIDwvZGVmcz4KICAgIDxnIGlkPSLpm7fnq57mioAyLjAtY29weSIgc3Ryb2tlPSJub25lIiBzdHJva2Utd2lkdGg9IjEiIGZpbGw9Im5vbmUiIGZpbGwtcnVsZT0iZXZlbm9kZCIgZmlsbC1vcGFjaXR5PSIwLjMiPgogICAgICAgIDxnIGlkPSJpY29u5YiH5Zu+IiB0cmFuc2Zvcm09InRyYW5zbGF0ZSgtMTEyLjAwMDAwMCwgLTE5NjUuMDAwMDAwKSIgZmlsbD0idXJsKCNyYWRpYWxHcmFkaWVudC0xKSI+CiAgICAgICAgICAgIDxyZWN0IGlkPSLljaHniYfljLrliIblibLlt6YiIHg9IjExMiIgeT0iMTk2NCIgd2lkdGg9IjI0IiBoZWlnaHQ9IjgwIj48L3JlY3Q+CiAgICAgICAgPC9nPgogICAgPC9nPgo8L3N2Zz4="
														class="center-left">
													<div data-v-18da170e="" class="start-time">18:30</div>
													<img data-v-18da170e=""
														src="data:image/svg+xml;base64,PD94bWwgdmVyc2lvbj0iMS4wIiBlbmNvZGluZz0iVVRGLTgiPz4KPHN2ZyB3aWR0aD0iMjRweCIgaGVpZ2h0PSI3OHB4IiB2aWV3Qm94PSIwIDAgMjQgNzgiIHZlcnNpb249IjEuMSIgeG1sbnM9Imh0dHA6Ly93d3cudzMub3JnLzIwMDAvc3ZnIiB4bWxuczp4bGluaz0iaHR0cDovL3d3dy53My5vcmcvMTk5OS94bGluayI+CiAgICA8IS0tIEdlbmVyYXRvcjogU2tldGNoIDQ5LjMgKDUxMTY3KSAtIGh0dHA6Ly93d3cuYm9oZW1pYW5jb2RpbmcuY29tL3NrZXRjaCAtLT4KICAgIDx0aXRsZT7ljaHniYfljLrliIblibLlj7M8L3RpdGxlPgogICAgPGRlc2M+Q3JlYXRlZCB3aXRoIFNrZXRjaC48L2Rlc2M+CiAgICA8ZGVmcz4KICAgICAgICA8cmFkaWFsR3JhZGllbnQgY3g9IjEwMCUiIGN5PSI1MCUiIGZ4PSIxMDAlIiBmeT0iNTAlIiByPSI5OC44MDMyODc2JSIgZ3JhZGllbnRUcmFuc2Zvcm09InRyYW5zbGF0ZSgxLjAwMDAwMCwwLjUwMDAwMCksc2NhbGUoMS4wMDAwMDAsMC4zMDAwMDApLHJvdGF0ZSgtMTc5Ljk5OTk5OCksc2NhbGUoMS4wMDAwMDAsMS42MzI1MTgpLHRyYW5zbGF0ZSgtMS4wMDAwMDAsLTAuNTAwMDAwKSIgaWQ9InJhZGlhbEdyYWRpZW50LTEiPgogICAgICAgICAgICA8c3RvcCBzdG9wLWNvbG9yPSIjMEMxMjFGIiBvZmZzZXQ9IjAlIj48L3N0b3A+CiAgICAgICAgICAgIDxzdG9wIHN0b3AtY29sb3I9IiMxQTI1MzgiIHN0b3Atb3BhY2l0eT0iMCIgb2Zmc2V0PSIxMDAlIj48L3N0b3A+CiAgICAgICAgPC9yYWRpYWxHcmFkaWVudD4KICAgIDwvZGVmcz4KICAgIDxnIGlkPSLpm7fnq57mioAyLjAtY29weSIgc3Ryb2tlPSJub25lIiBzdHJva2Utd2lkdGg9IjEiIGZpbGw9Im5vbmUiIGZpbGwtcnVsZT0iZXZlbm9kZCIgZmlsbC1vcGFjaXR5PSIwLjMiPgogICAgICAgIDxnIGlkPSJpY29u5YiH5Zu+IiB0cmFuc2Zvcm09InRyYW5zbGF0ZSgtMTc2LjAwMDAwMCwgLTE5NjUuMDAwMDAwKSIgZmlsbD0idXJsKCNyYWRpYWxHcmFkaWVudC0xKSI+CiAgICAgICAgICAgIDxyZWN0IGlkPSLljaHniYfljLrliIblibLlj7MiIHRyYW5zZm9ybT0idHJhbnNsYXRlKDE4OC4wMDAwMDAsIDIwMDQuMDAwMDAwKSBzY2FsZSgtMSwgMSkgdHJhbnNsYXRlKC0xODguMDAwMDAwLCAtMjAwNC4wMDAwMDApICIgeD0iMTc2IiB5PSIxOTY0IiB3aWR0aD0iMjQiIGhlaWdodD0iODAiPjwvcmVjdD4KICAgICAgICA8L2c+CiAgICA8L2c+Cjwvc3ZnPg=="
														class="center-right">
												</div>
												<div data-v-18da170e="" class="card-body-team">
													<img data-v-18da170e=""
														src="//yuanjududu.com//file/2c1bc68e92c4b9f12feb1fe0095bfef1.png"
														class="team-logo">
												</div>
											</section>
											<div data-v-8d7d541a="" data-v-18da170e=""
												class="odds-group-title">
												<div data-v-8d7d541a="" class="empty-badge">&nbsp;</div>
												<div data-v-8d7d541a="" class="title">获胜者</div>
											</div>
											<section data-v-18da170e="" class="card-footer">
												<div data-v-18da170e="" class="card-odds-btn">
													<div data-v-ba6efc5c="" data-v-18da170e=""
														class="home-match-card-button">
														<div data-v-ba6efc5c="" class="button-dark-border">
															<div data-v-ba6efc5c="" class="button-content">
																<div data-v-ba6efc5c="" class="button-name">Athletico
																	Esport</div>
																<div data-v-ba6efc5c="" class="button-odds-content">
																	<div data-v-ba6efc5c="" class="odds-rising-icon"></div>
																	<div data-v-ba6efc5c="" class="btn-odds">
																		<span data-v-ba6efc5c="">1.20</span>
																	</div>
																	<div data-v-ba6efc5c="" class="odds-dropping-icon"></div>
																</div>
															</div>
														</div>
													</div>
												</div>
												<div data-v-18da170e="" class="match-status">
													<div data-v-18da170e="" class="match-is-early">
														<div data-v-18da170e="" class="status-icon early-icon"></div>
														<div data-v-18da170e="" class="match-status-text">未开始</div>
													</div>
												</div>
												<div data-v-18da170e="" class="card-odds-btn">
													<div data-v-ba6efc5c="" data-v-18da170e=""
														class="home-match-card-button btn-selected">
														<div data-v-ba6efc5c="" class="button-dark-border">
															<div data-v-ba6efc5c="" class="button-content">
																<div data-v-ba6efc5c="" class="button-name">SaveBuyBackPlz</div>
																<div data-v-ba6efc5c="" class="button-odds-content">
																	<div data-v-ba6efc5c="" class="odds-rising-icon"></div>
																	<div data-v-ba6efc5c="" class="btn-odds">
																		<span data-v-ba6efc5c="">3.97</span>
																	</div>
																	<div data-v-ba6efc5c="" class="odds-dropping-icon"></div>
																</div>
															</div>
														</div>
													</div>
												</div>
											</section>
										</div>
										<div data-v-18da170e="" data-v-bf66ef20=""
											class="home-match-card">
											<section data-v-18da170e="" class="card-header">
												<img data-v-18da170e=""
													src="//yuanjududu.com//file/98c6eb475bf90d035c0d6b7f31fd59d0.svg"
													width="20px">
												<div data-v-18da170e="" class="tournament-name">GG.B
													Summer</div>
												<div data-v-18da170e="" class="match-round">&nbsp;/
													bo3</div>
												<div data-v-18da170e="" class="play-count">+25</div>
											</section>
											<section data-v-18da170e="" class="card-body">
												<div data-v-18da170e="" class="card-body-team">
													<img data-v-18da170e=""
														src="//yuanjududu.com//file/bbdf67d662dbd7f24709c803fa248c52.png"
														class="team-logo">
												</div>
												<div data-v-18da170e="" class="card-body-center">
													<img data-v-18da170e=""
														src="data:image/svg+xml;base64,PD94bWwgdmVyc2lvbj0iMS4wIiBlbmNvZGluZz0iVVRGLTgiPz4KPHN2ZyB3aWR0aD0iMjRweCIgaGVpZ2h0PSI3OHB4IiB2aWV3Qm94PSIwIDAgMjQgNzgiIHZlcnNpb249IjEuMSIgeG1sbnM9Imh0dHA6Ly93d3cudzMub3JnLzIwMDAvc3ZnIiB4bWxuczp4bGluaz0iaHR0cDovL3d3dy53My5vcmcvMTk5OS94bGluayI+CiAgICA8IS0tIEdlbmVyYXRvcjogU2tldGNoIDQ5LjMgKDUxMTY3KSAtIGh0dHA6Ly93d3cuYm9oZW1pYW5jb2RpbmcuY29tL3NrZXRjaCAtLT4KICAgIDx0aXRsZT7ljaHniYfljLrliIblibLlt6Y8L3RpdGxlPgogICAgPGRlc2M+Q3JlYXRlZCB3aXRoIFNrZXRjaC48L2Rlc2M+CiAgICA8ZGVmcz4KICAgICAgICA8cmFkaWFsR3JhZGllbnQgY3g9IjEwMCUiIGN5PSI1MCUiIGZ4PSIxMDAlIiBmeT0iNTAlIiByPSI5OC44MDMyODc2JSIgZ3JhZGllbnRUcmFuc2Zvcm09InRyYW5zbGF0ZSgxLjAwMDAwMCwwLjUwMDAwMCksc2NhbGUoMS4wMDAwMDAsMC4zMDAwMDApLHJvdGF0ZSgtMTc5Ljk5OTk5OCksc2NhbGUoMS4wMDAwMDAsMS42MzI1MTgpLHRyYW5zbGF0ZSgtMS4wMDAwMDAsLTAuNTAwMDAwKSIgaWQ9InJhZGlhbEdyYWRpZW50LTEiPgogICAgICAgICAgICA8c3RvcCBzdG9wLWNvbG9yPSIjMEMxMjFGIiBvZmZzZXQ9IjAlIj48L3N0b3A+CiAgICAgICAgICAgIDxzdG9wIHN0b3AtY29sb3I9IiMxQTI1MzgiIHN0b3Atb3BhY2l0eT0iMCIgb2Zmc2V0PSIxMDAlIj48L3N0b3A+CiAgICAgICAgPC9yYWRpYWxHcmFkaWVudD4KICAgIDwvZGVmcz4KICAgIDxnIGlkPSLpm7fnq57mioAyLjAtY29weSIgc3Ryb2tlPSJub25lIiBzdHJva2Utd2lkdGg9IjEiIGZpbGw9Im5vbmUiIGZpbGwtcnVsZT0iZXZlbm9kZCIgZmlsbC1vcGFjaXR5PSIwLjMiPgogICAgICAgIDxnIGlkPSJpY29u5YiH5Zu+IiB0cmFuc2Zvcm09InRyYW5zbGF0ZSgtMTEyLjAwMDAwMCwgLTE5NjUuMDAwMDAwKSIgZmlsbD0idXJsKCNyYWRpYWxHcmFkaWVudC0xKSI+CiAgICAgICAgICAgIDxyZWN0IGlkPSLljaHniYfljLrliIblibLlt6YiIHg9IjExMiIgeT0iMTk2NCIgd2lkdGg9IjI0IiBoZWlnaHQ9IjgwIj48L3JlY3Q+CiAgICAgICAgPC9nPgogICAgPC9nPgo8L3N2Zz4="
														class="center-left">
													<div data-v-18da170e="" class="start-time">19:00</div>
													<img data-v-18da170e=""
														src="data:image/svg+xml;base64,PD94bWwgdmVyc2lvbj0iMS4wIiBlbmNvZGluZz0iVVRGLTgiPz4KPHN2ZyB3aWR0aD0iMjRweCIgaGVpZ2h0PSI3OHB4IiB2aWV3Qm94PSIwIDAgMjQgNzgiIHZlcnNpb249IjEuMSIgeG1sbnM9Imh0dHA6Ly93d3cudzMub3JnLzIwMDAvc3ZnIiB4bWxuczp4bGluaz0iaHR0cDovL3d3dy53My5vcmcvMTk5OS94bGluayI+CiAgICA8IS0tIEdlbmVyYXRvcjogU2tldGNoIDQ5LjMgKDUxMTY3KSAtIGh0dHA6Ly93d3cuYm9oZW1pYW5jb2RpbmcuY29tL3NrZXRjaCAtLT4KICAgIDx0aXRsZT7ljaHniYfljLrliIblibLlj7M8L3RpdGxlPgogICAgPGRlc2M+Q3JlYXRlZCB3aXRoIFNrZXRjaC48L2Rlc2M+CiAgICA8ZGVmcz4KICAgICAgICA8cmFkaWFsR3JhZGllbnQgY3g9IjEwMCUiIGN5PSI1MCUiIGZ4PSIxMDAlIiBmeT0iNTAlIiByPSI5OC44MDMyODc2JSIgZ3JhZGllbnRUcmFuc2Zvcm09InRyYW5zbGF0ZSgxLjAwMDAwMCwwLjUwMDAwMCksc2NhbGUoMS4wMDAwMDAsMC4zMDAwMDApLHJvdGF0ZSgtMTc5Ljk5OTk5OCksc2NhbGUoMS4wMDAwMDAsMS42MzI1MTgpLHRyYW5zbGF0ZSgtMS4wMDAwMDAsLTAuNTAwMDAwKSIgaWQ9InJhZGlhbEdyYWRpZW50LTEiPgogICAgICAgICAgICA8c3RvcCBzdG9wLWNvbG9yPSIjMEMxMjFGIiBvZmZzZXQ9IjAlIj48L3N0b3A+CiAgICAgICAgICAgIDxzdG9wIHN0b3AtY29sb3I9IiMxQTI1MzgiIHN0b3Atb3BhY2l0eT0iMCIgb2Zmc2V0PSIxMDAlIj48L3N0b3A+CiAgICAgICAgPC9yYWRpYWxHcmFkaWVudD4KICAgIDwvZGVmcz4KICAgIDxnIGlkPSLpm7fnq57mioAyLjAtY29weSIgc3Ryb2tlPSJub25lIiBzdHJva2Utd2lkdGg9IjEiIGZpbGw9Im5vbmUiIGZpbGwtcnVsZT0iZXZlbm9kZCIgZmlsbC1vcGFjaXR5PSIwLjMiPgogICAgICAgIDxnIGlkPSJpY29u5YiH5Zu+IiB0cmFuc2Zvcm09InRyYW5zbGF0ZSgtMTc2LjAwMDAwMCwgLTE5NjUuMDAwMDAwKSIgZmlsbD0idXJsKCNyYWRpYWxHcmFkaWVudC0xKSI+CiAgICAgICAgICAgIDxyZWN0IGlkPSLljaHniYfljLrliIblibLlj7MiIHRyYW5zZm9ybT0idHJhbnNsYXRlKDE4OC4wMDAwMDAsIDIwMDQuMDAwMDAwKSBzY2FsZSgtMSwgMSkgdHJhbnNsYXRlKC0xODguMDAwMDAwLCAtMjAwNC4wMDAwMDApICIgeD0iMTc2IiB5PSIxOTY0IiB3aWR0aD0iMjQiIGhlaWdodD0iODAiPjwvcmVjdD4KICAgICAgICA8L2c+CiAgICA8L2c+Cjwvc3ZnPg=="
														class="center-right">
												</div>
												<div data-v-18da170e="" class="card-body-team">
													<img data-v-18da170e=""
														src="//yuanjududu.com//file/c0af9c4713b9fcc7f931482e2bd028c0.png"
														class="team-logo">
												</div>
											</section>
											<div data-v-8d7d541a="" data-v-18da170e=""
												class="odds-group-title">
												<div data-v-8d7d541a="" class="empty-badge">&nbsp;</div>
												<div data-v-8d7d541a="" class="title">获胜者</div>
											</div>
											<section data-v-18da170e="" class="card-footer">
												<div data-v-18da170e="" class="card-odds-btn">
													<div data-v-ba6efc5c="" data-v-18da170e=""
														class="home-match-card-button">
														<div data-v-ba6efc5c="" class="button-dark-border">
															<div data-v-ba6efc5c="" class="button-content">
																<div data-v-ba6efc5c="" class="button-name">BOOT-d[S]</div>
																<div data-v-ba6efc5c="" class="button-odds-content">
																	<div data-v-ba6efc5c="" class="odds-rising-icon"></div>
																	<div data-v-ba6efc5c="" class="btn-odds">
																		<span data-v-ba6efc5c="">2.46</span>
																	</div>
																	<div data-v-ba6efc5c="" class="odds-dropping-icon"></div>
																</div>
															</div>
														</div>
													</div>
												</div>
												<div data-v-18da170e="" class="match-status">
													<div data-v-18da170e="" class="match-is-early">
														<div data-v-18da170e="" class="status-icon early-icon"></div>
														<div data-v-18da170e="" class="match-status-text">未开始</div>
													</div>
												</div>
												<div data-v-18da170e="" class="card-odds-btn">
													<div data-v-ba6efc5c="" data-v-18da170e=""
														class="home-match-card-button">
														<div data-v-ba6efc5c="" class="button-dark-border">
															<div data-v-ba6efc5c="" class="button-content">
																<div data-v-ba6efc5c="" class="button-name">CyberZen</div>
																<div data-v-ba6efc5c="" class="button-odds-content">
																	<div data-v-ba6efc5c="" class="odds-rising-icon"></div>
																	<div data-v-ba6efc5c="" class="btn-odds">
																		<span data-v-ba6efc5c="">1.50</span>
																	</div>
																	<div data-v-ba6efc5c="" class="odds-dropping-icon"></div>
																</div>
															</div>
														</div>
													</div>
												</div>
											</section>
										</div>
										<div data-v-18da170e="" data-v-bf66ef20=""
											class="home-match-card">
											<section data-v-18da170e="" class="card-header">
												<img data-v-18da170e=""
													src="//yuanjududu.com//file/98c6eb475bf90d035c0d6b7f31fd59d0.svg"
													width="20px">
												<div data-v-18da170e="" class="tournament-name">
													CyberGamer Premier League</div>
												<div data-v-18da170e="" class="match-round">&nbsp;/
													bo1</div>
												<div data-v-18da170e="" class="play-count">+11</div>
											</section>
											<section data-v-18da170e="" class="card-body">
												<div data-v-18da170e="" class="card-body-team">
													<img data-v-18da170e=""
														src="//yuanjududu.com//file/5f24ee1e1b59d7b4c70eadc92ad6713a.png"
														class="team-logo">
												</div>
												<div data-v-18da170e="" class="card-body-center">
													<img data-v-18da170e=""
														src="data:image/svg+xml;base64,PD94bWwgdmVyc2lvbj0iMS4wIiBlbmNvZGluZz0iVVRGLTgiPz4KPHN2ZyB3aWR0aD0iMjRweCIgaGVpZ2h0PSI3OHB4IiB2aWV3Qm94PSIwIDAgMjQgNzgiIHZlcnNpb249IjEuMSIgeG1sbnM9Imh0dHA6Ly93d3cudzMub3JnLzIwMDAvc3ZnIiB4bWxuczp4bGluaz0iaHR0cDovL3d3dy53My5vcmcvMTk5OS94bGluayI+CiAgICA8IS0tIEdlbmVyYXRvcjogU2tldGNoIDQ5LjMgKDUxMTY3KSAtIGh0dHA6Ly93d3cuYm9oZW1pYW5jb2RpbmcuY29tL3NrZXRjaCAtLT4KICAgIDx0aXRsZT7ljaHniYfljLrliIblibLlt6Y8L3RpdGxlPgogICAgPGRlc2M+Q3JlYXRlZCB3aXRoIFNrZXRjaC48L2Rlc2M+CiAgICA8ZGVmcz4KICAgICAgICA8cmFkaWFsR3JhZGllbnQgY3g9IjEwMCUiIGN5PSI1MCUiIGZ4PSIxMDAlIiBmeT0iNTAlIiByPSI5OC44MDMyODc2JSIgZ3JhZGllbnRUcmFuc2Zvcm09InRyYW5zbGF0ZSgxLjAwMDAwMCwwLjUwMDAwMCksc2NhbGUoMS4wMDAwMDAsMC4zMDAwMDApLHJvdGF0ZSgtMTc5Ljk5OTk5OCksc2NhbGUoMS4wMDAwMDAsMS42MzI1MTgpLHRyYW5zbGF0ZSgtMS4wMDAwMDAsLTAuNTAwMDAwKSIgaWQ9InJhZGlhbEdyYWRpZW50LTEiPgogICAgICAgICAgICA8c3RvcCBzdG9wLWNvbG9yPSIjMEMxMjFGIiBvZmZzZXQ9IjAlIj48L3N0b3A+CiAgICAgICAgICAgIDxzdG9wIHN0b3AtY29sb3I9IiMxQTI1MzgiIHN0b3Atb3BhY2l0eT0iMCIgb2Zmc2V0PSIxMDAlIj48L3N0b3A+CiAgICAgICAgPC9yYWRpYWxHcmFkaWVudD4KICAgIDwvZGVmcz4KICAgIDxnIGlkPSLpm7fnq57mioAyLjAtY29weSIgc3Ryb2tlPSJub25lIiBzdHJva2Utd2lkdGg9IjEiIGZpbGw9Im5vbmUiIGZpbGwtcnVsZT0iZXZlbm9kZCIgZmlsbC1vcGFjaXR5PSIwLjMiPgogICAgICAgIDxnIGlkPSJpY29u5YiH5Zu+IiB0cmFuc2Zvcm09InRyYW5zbGF0ZSgtMTEyLjAwMDAwMCwgLTE5NjUuMDAwMDAwKSIgZmlsbD0idXJsKCNyYWRpYWxHcmFkaWVudC0xKSI+CiAgICAgICAgICAgIDxyZWN0IGlkPSLljaHniYfljLrliIblibLlt6YiIHg9IjExMiIgeT0iMTk2NCIgd2lkdGg9IjI0IiBoZWlnaHQ9IjgwIj48L3JlY3Q+CiAgICAgICAgPC9nPgogICAgPC9nPgo8L3N2Zz4="
														class="center-left">
													<div data-v-18da170e="" class="start-time">19:00</div>
													<img data-v-18da170e=""
														src="data:image/svg+xml;base64,PD94bWwgdmVyc2lvbj0iMS4wIiBlbmNvZGluZz0iVVRGLTgiPz4KPHN2ZyB3aWR0aD0iMjRweCIgaGVpZ2h0PSI3OHB4IiB2aWV3Qm94PSIwIDAgMjQgNzgiIHZlcnNpb249IjEuMSIgeG1sbnM9Imh0dHA6Ly93d3cudzMub3JnLzIwMDAvc3ZnIiB4bWxuczp4bGluaz0iaHR0cDovL3d3dy53My5vcmcvMTk5OS94bGluayI+CiAgICA8IS0tIEdlbmVyYXRvcjogU2tldGNoIDQ5LjMgKDUxMTY3KSAtIGh0dHA6Ly93d3cuYm9oZW1pYW5jb2RpbmcuY29tL3NrZXRjaCAtLT4KICAgIDx0aXRsZT7ljaHniYfljLrliIblibLlj7M8L3RpdGxlPgogICAgPGRlc2M+Q3JlYXRlZCB3aXRoIFNrZXRjaC48L2Rlc2M+CiAgICA8ZGVmcz4KICAgICAgICA8cmFkaWFsR3JhZGllbnQgY3g9IjEwMCUiIGN5PSI1MCUiIGZ4PSIxMDAlIiBmeT0iNTAlIiByPSI5OC44MDMyODc2JSIgZ3JhZGllbnRUcmFuc2Zvcm09InRyYW5zbGF0ZSgxLjAwMDAwMCwwLjUwMDAwMCksc2NhbGUoMS4wMDAwMDAsMC4zMDAwMDApLHJvdGF0ZSgtMTc5Ljk5OTk5OCksc2NhbGUoMS4wMDAwMDAsMS42MzI1MTgpLHRyYW5zbGF0ZSgtMS4wMDAwMDAsLTAuNTAwMDAwKSIgaWQ9InJhZGlhbEdyYWRpZW50LTEiPgogICAgICAgICAgICA8c3RvcCBzdG9wLWNvbG9yPSIjMEMxMjFGIiBvZmZzZXQ9IjAlIj48L3N0b3A+CiAgICAgICAgICAgIDxzdG9wIHN0b3AtY29sb3I9IiMxQTI1MzgiIHN0b3Atb3BhY2l0eT0iMCIgb2Zmc2V0PSIxMDAlIj48L3N0b3A+CiAgICAgICAgPC9yYWRpYWxHcmFkaWVudD4KICAgIDwvZGVmcz4KICAgIDxnIGlkPSLpm7fnq57mioAyLjAtY29weSIgc3Ryb2tlPSJub25lIiBzdHJva2Utd2lkdGg9IjEiIGZpbGw9Im5vbmUiIGZpbGwtcnVsZT0iZXZlbm9kZCIgZmlsbC1vcGFjaXR5PSIwLjMiPgogICAgICAgIDxnIGlkPSJpY29u5YiH5Zu+IiB0cmFuc2Zvcm09InRyYW5zbGF0ZSgtMTc2LjAwMDAwMCwgLTE5NjUuMDAwMDAwKSIgZmlsbD0idXJsKCNyYWRpYWxHcmFkaWVudC0xKSI+CiAgICAgICAgICAgIDxyZWN0IGlkPSLljaHniYfljLrliIblibLlj7MiIHRyYW5zZm9ybT0idHJhbnNsYXRlKDE4OC4wMDAwMDAsIDIwMDQuMDAwMDAwKSBzY2FsZSgtMSwgMSkgdHJhbnNsYXRlKC0xODguMDAwMDAwLCAtMjAwNC4wMDAwMDApICIgeD0iMTc2IiB5PSIxOTY0IiB3aWR0aD0iMjQiIGhlaWdodD0iODAiPjwvcmVjdD4KICAgICAgICA8L2c+CiAgICA8L2c+Cjwvc3ZnPg=="
														class="center-right">
												</div>
												<div data-v-18da170e="" class="card-body-team">
													<img data-v-18da170e=""
														src="//yuanjududu.com//file/1952dbbe66ef83060b1651d3028449b3.png"
														class="team-logo">
												</div>
											</section>
											<div data-v-8d7d541a="" data-v-18da170e=""
												class="odds-group-title">
												<div data-v-8d7d541a="" class="empty-badge">&nbsp;</div>
												<div data-v-8d7d541a="" class="title">获胜者</div>
											</div>
											<section data-v-18da170e="" class="card-footer">
												<div data-v-18da170e="" class="card-odds-btn">
													<div data-v-ba6efc5c="" data-v-18da170e=""
														class="home-match-card-button">
														<div data-v-ba6efc5c="" class="button-dark-border">
															<div data-v-ba6efc5c="" class="button-content">
																<div data-v-ba6efc5c="" class="button-name">madlikewizards</div>
																<div data-v-ba6efc5c="" class="button-odds-content">
																	<div data-v-ba6efc5c="" class="odds-rising-icon"></div>
																	<div data-v-ba6efc5c="" class="btn-odds">
																		<span data-v-ba6efc5c="">2.99</span>
																	</div>
																	<div data-v-ba6efc5c="" class="odds-dropping-icon"></div>
																</div>
															</div>
														</div>
													</div>
												</div>
												<div data-v-18da170e="" class="match-status">
													<div data-v-18da170e="" class="match-is-early">
														<div data-v-18da170e="" class="status-icon early-icon"></div>
														<div data-v-18da170e="" class="match-status-text">未开始</div>
													</div>
												</div>
												<div data-v-18da170e="" class="card-odds-btn">
													<div data-v-ba6efc5c="" data-v-18da170e=""
														class="home-match-card-button">
														<div data-v-ba6efc5c="" class="button-dark-border">
															<div data-v-ba6efc5c="" class="button-content">
																<div data-v-ba6efc5c="" class="button-name">SYF</div>
																<div data-v-ba6efc5c="" class="button-odds-content">
																	<div data-v-ba6efc5c="" class="odds-rising-icon"></div>
																	<div data-v-ba6efc5c="" class="btn-odds">
																		<span data-v-ba6efc5c="">1.35</span>
																	</div>
																	<div data-v-ba6efc5c="" class="odds-dropping-icon"></div>
																</div>
															</div>
														</div>
													</div>
												</div>
											</section>
										</div>
										<div data-v-18da170e="" data-v-bf66ef20=""
											class="home-match-card">
											<section data-v-18da170e="" class="card-header">
												<img data-v-18da170e=""
													src="//yuanjududu.com//file/d511f1c87538e99ca914ef559dfa68ba.svg"
													width="20px">
												<div data-v-18da170e="" class="tournament-name">
													Gladiator Cup</div>
												<div data-v-18da170e="" class="match-round">&nbsp;/
													bo2</div>
												<div data-v-18da170e="" class="play-count">+3</div>
											</section>
											<section data-v-18da170e="" class="card-body">
												<div data-v-18da170e="" class="card-body-team">
													<img data-v-18da170e=""
														src="//yuanjududu.com//file/cb325d9de1141a760903bbab2d1adc6a.png"
														class="team-logo">
												</div>
												<div data-v-18da170e="" class="card-body-center">
													<img data-v-18da170e=""
														src="data:image/svg+xml;base64,PD94bWwgdmVyc2lvbj0iMS4wIiBlbmNvZGluZz0iVVRGLTgiPz4KPHN2ZyB3aWR0aD0iMjRweCIgaGVpZ2h0PSI3OHB4IiB2aWV3Qm94PSIwIDAgMjQgNzgiIHZlcnNpb249IjEuMSIgeG1sbnM9Imh0dHA6Ly93d3cudzMub3JnLzIwMDAvc3ZnIiB4bWxuczp4bGluaz0iaHR0cDovL3d3dy53My5vcmcvMTk5OS94bGluayI+CiAgICA8IS0tIEdlbmVyYXRvcjogU2tldGNoIDQ5LjMgKDUxMTY3KSAtIGh0dHA6Ly93d3cuYm9oZW1pYW5jb2RpbmcuY29tL3NrZXRjaCAtLT4KICAgIDx0aXRsZT7ljaHniYfljLrliIblibLlt6Y8L3RpdGxlPgogICAgPGRlc2M+Q3JlYXRlZCB3aXRoIFNrZXRjaC48L2Rlc2M+CiAgICA8ZGVmcz4KICAgICAgICA8cmFkaWFsR3JhZGllbnQgY3g9IjEwMCUiIGN5PSI1MCUiIGZ4PSIxMDAlIiBmeT0iNTAlIiByPSI5OC44MDMyODc2JSIgZ3JhZGllbnRUcmFuc2Zvcm09InRyYW5zbGF0ZSgxLjAwMDAwMCwwLjUwMDAwMCksc2NhbGUoMS4wMDAwMDAsMC4zMDAwMDApLHJvdGF0ZSgtMTc5Ljk5OTk5OCksc2NhbGUoMS4wMDAwMDAsMS42MzI1MTgpLHRyYW5zbGF0ZSgtMS4wMDAwMDAsLTAuNTAwMDAwKSIgaWQ9InJhZGlhbEdyYWRpZW50LTEiPgogICAgICAgICAgICA8c3RvcCBzdG9wLWNvbG9yPSIjMEMxMjFGIiBvZmZzZXQ9IjAlIj48L3N0b3A+CiAgICAgICAgICAgIDxzdG9wIHN0b3AtY29sb3I9IiMxQTI1MzgiIHN0b3Atb3BhY2l0eT0iMCIgb2Zmc2V0PSIxMDAlIj48L3N0b3A+CiAgICAgICAgPC9yYWRpYWxHcmFkaWVudD4KICAgIDwvZGVmcz4KICAgIDxnIGlkPSLpm7fnq57mioAyLjAtY29weSIgc3Ryb2tlPSJub25lIiBzdHJva2Utd2lkdGg9IjEiIGZpbGw9Im5vbmUiIGZpbGwtcnVsZT0iZXZlbm9kZCIgZmlsbC1vcGFjaXR5PSIwLjMiPgogICAgICAgIDxnIGlkPSJpY29u5YiH5Zu+IiB0cmFuc2Zvcm09InRyYW5zbGF0ZSgtMTEyLjAwMDAwMCwgLTE5NjUuMDAwMDAwKSIgZmlsbD0idXJsKCNyYWRpYWxHcmFkaWVudC0xKSI+CiAgICAgICAgICAgIDxyZWN0IGlkPSLljaHniYfljLrliIblibLlt6YiIHg9IjExMiIgeT0iMTk2NCIgd2lkdGg9IjI0IiBoZWlnaHQ9IjgwIj48L3JlY3Q+CiAgICAgICAgPC9nPgogICAgPC9nPgo8L3N2Zz4="
														class="center-left">
													<div data-v-18da170e="" class="start-time">19:00</div>
													<img data-v-18da170e=""
														src="data:image/svg+xml;base64,PD94bWwgdmVyc2lvbj0iMS4wIiBlbmNvZGluZz0iVVRGLTgiPz4KPHN2ZyB3aWR0aD0iMjRweCIgaGVpZ2h0PSI3OHB4IiB2aWV3Qm94PSIwIDAgMjQgNzgiIHZlcnNpb249IjEuMSIgeG1sbnM9Imh0dHA6Ly93d3cudzMub3JnLzIwMDAvc3ZnIiB4bWxuczp4bGluaz0iaHR0cDovL3d3dy53My5vcmcvMTk5OS94bGluayI+CiAgICA8IS0tIEdlbmVyYXRvcjogU2tldGNoIDQ5LjMgKDUxMTY3KSAtIGh0dHA6Ly93d3cuYm9oZW1pYW5jb2RpbmcuY29tL3NrZXRjaCAtLT4KICAgIDx0aXRsZT7ljaHniYfljLrliIblibLlj7M8L3RpdGxlPgogICAgPGRlc2M+Q3JlYXRlZCB3aXRoIFNrZXRjaC48L2Rlc2M+CiAgICA8ZGVmcz4KICAgICAgICA8cmFkaWFsR3JhZGllbnQgY3g9IjEwMCUiIGN5PSI1MCUiIGZ4PSIxMDAlIiBmeT0iNTAlIiByPSI5OC44MDMyODc2JSIgZ3JhZGllbnRUcmFuc2Zvcm09InRyYW5zbGF0ZSgxLjAwMDAwMCwwLjUwMDAwMCksc2NhbGUoMS4wMDAwMDAsMC4zMDAwMDApLHJvdGF0ZSgtMTc5Ljk5OTk5OCksc2NhbGUoMS4wMDAwMDAsMS42MzI1MTgpLHRyYW5zbGF0ZSgtMS4wMDAwMDAsLTAuNTAwMDAwKSIgaWQ9InJhZGlhbEdyYWRpZW50LTEiPgogICAgICAgICAgICA8c3RvcCBzdG9wLWNvbG9yPSIjMEMxMjFGIiBvZmZzZXQ9IjAlIj48L3N0b3A+CiAgICAgICAgICAgIDxzdG9wIHN0b3AtY29sb3I9IiMxQTI1MzgiIHN0b3Atb3BhY2l0eT0iMCIgb2Zmc2V0PSIxMDAlIj48L3N0b3A+CiAgICAgICAgPC9yYWRpYWxHcmFkaWVudD4KICAgIDwvZGVmcz4KICAgIDxnIGlkPSLpm7fnq57mioAyLjAtY29weSIgc3Ryb2tlPSJub25lIiBzdHJva2Utd2lkdGg9IjEiIGZpbGw9Im5vbmUiIGZpbGwtcnVsZT0iZXZlbm9kZCIgZmlsbC1vcGFjaXR5PSIwLjMiPgogICAgICAgIDxnIGlkPSJpY29u5YiH5Zu+IiB0cmFuc2Zvcm09InRyYW5zbGF0ZSgtMTc2LjAwMDAwMCwgLTE5NjUuMDAwMDAwKSIgZmlsbD0idXJsKCNyYWRpYWxHcmFkaWVudC0xKSI+CiAgICAgICAgICAgIDxyZWN0IGlkPSLljaHniYfljLrliIblibLlj7MiIHRyYW5zZm9ybT0idHJhbnNsYXRlKDE4OC4wMDAwMDAsIDIwMDQuMDAwMDAwKSBzY2FsZSgtMSwgMSkgdHJhbnNsYXRlKC0xODguMDAwMDAwLCAtMjAwNC4wMDAwMDApICIgeD0iMTc2IiB5PSIxOTY0IiB3aWR0aD0iMjQiIGhlaWdodD0iODAiPjwvcmVjdD4KICAgICAgICA8L2c+CiAgICA8L2c+Cjwvc3ZnPg=="
														class="center-right">
												</div>
												<div data-v-18da170e="" class="card-body-team">
													<img data-v-18da170e=""
														src="//yuanjududu.com//file/61c3dbca060a36b1286adf540cf9fcd0.png"
														class="team-logo">
												</div>
											</section>
											<div data-v-8d7d541a="" data-v-18da170e=""
												class="odds-group-title">
												<div data-v-8d7d541a="" class="empty-badge">&nbsp;</div>
												<div data-v-8d7d541a="" class="title">获胜者</div>
											</div>
											<section data-v-18da170e="" class="card-footer">
												<div data-v-18da170e="" class="card-odds-btn">
													<div data-v-ba6efc5c="" data-v-18da170e=""
														class="home-match-card-button btn-locked">
														<div data-v-ba6efc5c="" class="button-dark-border">
															<div data-v-ba6efc5c="" class="button-content">
																<div data-v-ba6efc5c="" class="button-name">NB.Y</div>
																<div data-v-ba6efc5c="" class="button-odds-content">
																	<div data-v-ba6efc5c="" class="odds-rising-icon"></div>
																	<div data-v-ba6efc5c="" class="btn-odds">
																		<!---->
																	</div>
																	<div data-v-ba6efc5c="" class="odds-dropping-icon"></div>
																</div>
															</div>
														</div>
													</div>
												</div>
												<div data-v-18da170e="" class="match-status">
													<div data-v-18da170e="" class="match-is-early">
														<div data-v-18da170e="" class="status-icon early-icon"></div>
														<div data-v-18da170e="" class="match-status-text">未开始</div>
													</div>
												</div>
												<div data-v-18da170e="" class="card-odds-btn">
													<div data-v-ba6efc5c="" data-v-18da170e=""
														class="home-match-card-button btn-locked">
														<div data-v-ba6efc5c="" class="button-dark-border">
															<div data-v-ba6efc5c="" class="button-content">
																<div data-v-ba6efc5c="" class="button-name">Avalon</div>
																<div data-v-ba6efc5c="" class="button-odds-content">
																	<div data-v-ba6efc5c="" class="odds-rising-icon"></div>
																	<div data-v-ba6efc5c="" class="btn-odds">
																		<!---->
																	</div>
																	<div data-v-ba6efc5c="" class="odds-dropping-icon"></div>
																</div>
															</div>
														</div>
													</div>
												</div>
											</section>
										</div>
										<div data-v-18da170e="" data-v-bf66ef20=""
											class="home-match-card">
											<section data-v-18da170e="" class="card-header">
												<img data-v-18da170e=""
													src="//yuanjududu.com//file/eb8b6c6d7f3c5a78cf74cf3dc0af3cbd.svg"
													width="20px">
												<div data-v-18da170e="" class="tournament-name">
													黄金风暴联赛</div>
												<div data-v-18da170e="" class="match-round">&nbsp;/
													bo2</div>
												<div data-v-18da170e="" class="play-count">+1</div>
											</section>
											<section data-v-18da170e="" class="card-body">
												<div data-v-18da170e="" class="card-body-team">
													<img data-v-18da170e=""
														src="//yuanjududu.com//file/105853defb2cebb0be3f13f4df83bd2d.png"
														class="team-logo">
												</div>
												<div data-v-18da170e="" class="card-body-center">
													<img data-v-18da170e=""
														src="data:image/svg+xml;base64,PD94bWwgdmVyc2lvbj0iMS4wIiBlbmNvZGluZz0iVVRGLTgiPz4KPHN2ZyB3aWR0aD0iMjRweCIgaGVpZ2h0PSI3OHB4IiB2aWV3Qm94PSIwIDAgMjQgNzgiIHZlcnNpb249IjEuMSIgeG1sbnM9Imh0dHA6Ly93d3cudzMub3JnLzIwMDAvc3ZnIiB4bWxuczp4bGluaz0iaHR0cDovL3d3dy53My5vcmcvMTk5OS94bGluayI+CiAgICA8IS0tIEdlbmVyYXRvcjogU2tldGNoIDQ5LjMgKDUxMTY3KSAtIGh0dHA6Ly93d3cuYm9oZW1pYW5jb2RpbmcuY29tL3NrZXRjaCAtLT4KICAgIDx0aXRsZT7ljaHniYfljLrliIblibLlt6Y8L3RpdGxlPgogICAgPGRlc2M+Q3JlYXRlZCB3aXRoIFNrZXRjaC48L2Rlc2M+CiAgICA8ZGVmcz4KICAgICAgICA8cmFkaWFsR3JhZGllbnQgY3g9IjEwMCUiIGN5PSI1MCUiIGZ4PSIxMDAlIiBmeT0iNTAlIiByPSI5OC44MDMyODc2JSIgZ3JhZGllbnRUcmFuc2Zvcm09InRyYW5zbGF0ZSgxLjAwMDAwMCwwLjUwMDAwMCksc2NhbGUoMS4wMDAwMDAsMC4zMDAwMDApLHJvdGF0ZSgtMTc5Ljk5OTk5OCksc2NhbGUoMS4wMDAwMDAsMS42MzI1MTgpLHRyYW5zbGF0ZSgtMS4wMDAwMDAsLTAuNTAwMDAwKSIgaWQ9InJhZGlhbEdyYWRpZW50LTEiPgogICAgICAgICAgICA8c3RvcCBzdG9wLWNvbG9yPSIjMEMxMjFGIiBvZmZzZXQ9IjAlIj48L3N0b3A+CiAgICAgICAgICAgIDxzdG9wIHN0b3AtY29sb3I9IiMxQTI1MzgiIHN0b3Atb3BhY2l0eT0iMCIgb2Zmc2V0PSIxMDAlIj48L3N0b3A+CiAgICAgICAgPC9yYWRpYWxHcmFkaWVudD4KICAgIDwvZGVmcz4KICAgIDxnIGlkPSLpm7fnq57mioAyLjAtY29weSIgc3Ryb2tlPSJub25lIiBzdHJva2Utd2lkdGg9IjEiIGZpbGw9Im5vbmUiIGZpbGwtcnVsZT0iZXZlbm9kZCIgZmlsbC1vcGFjaXR5PSIwLjMiPgogICAgICAgIDxnIGlkPSJpY29u5YiH5Zu+IiB0cmFuc2Zvcm09InRyYW5zbGF0ZSgtMTEyLjAwMDAwMCwgLTE5NjUuMDAwMDAwKSIgZmlsbD0idXJsKCNyYWRpYWxHcmFkaWVudC0xKSI+CiAgICAgICAgICAgIDxyZWN0IGlkPSLljaHniYfljLrliIblibLlt6YiIHg9IjExMiIgeT0iMTk2NCIgd2lkdGg9IjI0IiBoZWlnaHQ9IjgwIj48L3JlY3Q+CiAgICAgICAgPC9nPgogICAgPC9nPgo8L3N2Zz4="
														class="center-left">
													<div data-v-18da170e="" class="start-time">19:15</div>
													<img data-v-18da170e=""
														src="data:image/svg+xml;base64,PD94bWwgdmVyc2lvbj0iMS4wIiBlbmNvZGluZz0iVVRGLTgiPz4KPHN2ZyB3aWR0aD0iMjRweCIgaGVpZ2h0PSI3OHB4IiB2aWV3Qm94PSIwIDAgMjQgNzgiIHZlcnNpb249IjEuMSIgeG1sbnM9Imh0dHA6Ly93d3cudzMub3JnLzIwMDAvc3ZnIiB4bWxuczp4bGluaz0iaHR0cDovL3d3dy53My5vcmcvMTk5OS94bGluayI+CiAgICA8IS0tIEdlbmVyYXRvcjogU2tldGNoIDQ5LjMgKDUxMTY3KSAtIGh0dHA6Ly93d3cuYm9oZW1pYW5jb2RpbmcuY29tL3NrZXRjaCAtLT4KICAgIDx0aXRsZT7ljaHniYfljLrliIblibLlj7M8L3RpdGxlPgogICAgPGRlc2M+Q3JlYXRlZCB3aXRoIFNrZXRjaC48L2Rlc2M+CiAgICA8ZGVmcz4KICAgICAgICA8cmFkaWFsR3JhZGllbnQgY3g9IjEwMCUiIGN5PSI1MCUiIGZ4PSIxMDAlIiBmeT0iNTAlIiByPSI5OC44MDMyODc2JSIgZ3JhZGllbnRUcmFuc2Zvcm09InRyYW5zbGF0ZSgxLjAwMDAwMCwwLjUwMDAwMCksc2NhbGUoMS4wMDAwMDAsMC4zMDAwMDApLHJvdGF0ZSgtMTc5Ljk5OTk5OCksc2NhbGUoMS4wMDAwMDAsMS42MzI1MTgpLHRyYW5zbGF0ZSgtMS4wMDAwMDAsLTAuNTAwMDAwKSIgaWQ9InJhZGlhbEdyYWRpZW50LTEiPgogICAgICAgICAgICA8c3RvcCBzdG9wLWNvbG9yPSIjMEMxMjFGIiBvZmZzZXQ9IjAlIj48L3N0b3A+CiAgICAgICAgICAgIDxzdG9wIHN0b3AtY29sb3I9IiMxQTI1MzgiIHN0b3Atb3BhY2l0eT0iMCIgb2Zmc2V0PSIxMDAlIj48L3N0b3A+CiAgICAgICAgPC9yYWRpYWxHcmFkaWVudD4KICAgIDwvZGVmcz4KICAgIDxnIGlkPSLpm7fnq57mioAyLjAtY29weSIgc3Ryb2tlPSJub25lIiBzdHJva2Utd2lkdGg9IjEiIGZpbGw9Im5vbmUiIGZpbGwtcnVsZT0iZXZlbm9kZCIgZmlsbC1vcGFjaXR5PSIwLjMiPgogICAgICAgIDxnIGlkPSJpY29u5YiH5Zu+IiB0cmFuc2Zvcm09InRyYW5zbGF0ZSgtMTc2LjAwMDAwMCwgLTE5NjUuMDAwMDAwKSIgZmlsbD0idXJsKCNyYWRpYWxHcmFkaWVudC0xKSI+CiAgICAgICAgICAgIDxyZWN0IGlkPSLljaHniYfljLrliIblibLlj7MiIHRyYW5zZm9ybT0idHJhbnNsYXRlKDE4OC4wMDAwMDAsIDIwMDQuMDAwMDAwKSBzY2FsZSgtMSwgMSkgdHJhbnNsYXRlKC0xODguMDAwMDAwLCAtMjAwNC4wMDAwMDApICIgeD0iMTc2IiB5PSIxOTY0IiB3aWR0aD0iMjQiIGhlaWdodD0iODAiPjwvcmVjdD4KICAgICAgICA8L2c+CiAgICA8L2c+Cjwvc3ZnPg=="
														class="center-right">
												</div>
												<div data-v-18da170e="" class="card-body-team">
													<img data-v-18da170e=""
														src="//yuanjududu.com//file/e0188fdfed0c43e5c1f8ae63fdda898b.png"
														class="team-logo">
												</div>
											</section>
											<div data-v-8d7d541a="" data-v-18da170e=""
												class="odds-group-title">
												<div data-v-8d7d541a="" class="empty-badge">&nbsp;</div>
												<div data-v-8d7d541a="" class="title">获胜者</div>
											</div>
											<section data-v-18da170e="" class="card-footer">
												<div data-v-18da170e="" class="card-odds-btn">
													<div data-v-ba6efc5c="" data-v-18da170e=""
														class="home-match-card-button btn-locked">
														<div data-v-ba6efc5c="" class="button-dark-border">
															<div data-v-ba6efc5c="" class="button-content">
																<div data-v-ba6efc5c="" class="button-name">ONE</div>
																<div data-v-ba6efc5c="" class="button-odds-content">
																	<div data-v-ba6efc5c="" class="odds-rising-icon"></div>
																	<div data-v-ba6efc5c="" class="btn-odds">
																		<!---->
																	</div>
																	<div data-v-ba6efc5c="" class="odds-dropping-icon"></div>
																</div>
															</div>
														</div>
													</div>
												</div>
												<div data-v-18da170e="" class="match-status">
													<div data-v-18da170e="" class="match-is-early">
														<div data-v-18da170e="" class="status-icon early-icon"></div>
														<div data-v-18da170e="" class="match-status-text">未开始</div>
													</div>
												</div>
												<div data-v-18da170e="" class="card-odds-btn">
													<div data-v-ba6efc5c="" data-v-18da170e=""
														class="home-match-card-button btn-locked">
														<div data-v-ba6efc5c="" class="button-dark-border">
															<div data-v-ba6efc5c="" class="button-content">
																<div data-v-ba6efc5c="" class="button-name">KT</div>
																<div data-v-ba6efc5c="" class="button-odds-content">
																	<div data-v-ba6efc5c="" class="odds-rising-icon"></div>
																	<div data-v-ba6efc5c="" class="btn-odds">
																		<!---->
																	</div>
																	<div data-v-ba6efc5c="" class="odds-dropping-icon"></div>
																</div>
															</div>
														</div>
													</div>
												</div>
											</section>
										</div>
										<div data-v-18da170e="" data-v-bf66ef20=""
											class="home-match-card">
											<section data-v-18da170e="" class="card-header">
												<img data-v-18da170e=""
													src="//yuanjududu.com//file/d511f1c87538e99ca914ef559dfa68ba.svg"
													width="20px">
												<div data-v-18da170e="" class="tournament-name">ESL
													ANZ Championship</div>
												<div data-v-18da170e="" class="match-round">&nbsp;/
													bo1</div>
												<div data-v-18da170e="" class="play-count">+2</div>
											</section>
											<section data-v-18da170e="" class="card-body">
												<div data-v-18da170e="" class="card-body-team">
													<img data-v-18da170e=""
														src="//yuanjududu.com//file/2c1bc68e92c4b9f12feb1fe0095bfef1.png"
														class="team-logo">
												</div>
												<div data-v-18da170e="" class="card-body-center">
													<img data-v-18da170e=""
														src="data:image/svg+xml;base64,PD94bWwgdmVyc2lvbj0iMS4wIiBlbmNvZGluZz0iVVRGLTgiPz4KPHN2ZyB3aWR0aD0iMjRweCIgaGVpZ2h0PSI3OHB4IiB2aWV3Qm94PSIwIDAgMjQgNzgiIHZlcnNpb249IjEuMSIgeG1sbnM9Imh0dHA6Ly93d3cudzMub3JnLzIwMDAvc3ZnIiB4bWxuczp4bGluaz0iaHR0cDovL3d3dy53My5vcmcvMTk5OS94bGluayI+CiAgICA8IS0tIEdlbmVyYXRvcjogU2tldGNoIDQ5LjMgKDUxMTY3KSAtIGh0dHA6Ly93d3cuYm9oZW1pYW5jb2RpbmcuY29tL3NrZXRjaCAtLT4KICAgIDx0aXRsZT7ljaHniYfljLrliIblibLlt6Y8L3RpdGxlPgogICAgPGRlc2M+Q3JlYXRlZCB3aXRoIFNrZXRjaC48L2Rlc2M+CiAgICA8ZGVmcz4KICAgICAgICA8cmFkaWFsR3JhZGllbnQgY3g9IjEwMCUiIGN5PSI1MCUiIGZ4PSIxMDAlIiBmeT0iNTAlIiByPSI5OC44MDMyODc2JSIgZ3JhZGllbnRUcmFuc2Zvcm09InRyYW5zbGF0ZSgxLjAwMDAwMCwwLjUwMDAwMCksc2NhbGUoMS4wMDAwMDAsMC4zMDAwMDApLHJvdGF0ZSgtMTc5Ljk5OTk5OCksc2NhbGUoMS4wMDAwMDAsMS42MzI1MTgpLHRyYW5zbGF0ZSgtMS4wMDAwMDAsLTAuNTAwMDAwKSIgaWQ9InJhZGlhbEdyYWRpZW50LTEiPgogICAgICAgICAgICA8c3RvcCBzdG9wLWNvbG9yPSIjMEMxMjFGIiBvZmZzZXQ9IjAlIj48L3N0b3A+CiAgICAgICAgICAgIDxzdG9wIHN0b3AtY29sb3I9IiMxQTI1MzgiIHN0b3Atb3BhY2l0eT0iMCIgb2Zmc2V0PSIxMDAlIj48L3N0b3A+CiAgICAgICAgPC9yYWRpYWxHcmFkaWVudD4KICAgIDwvZGVmcz4KICAgIDxnIGlkPSLpm7fnq57mioAyLjAtY29weSIgc3Ryb2tlPSJub25lIiBzdHJva2Utd2lkdGg9IjEiIGZpbGw9Im5vbmUiIGZpbGwtcnVsZT0iZXZlbm9kZCIgZmlsbC1vcGFjaXR5PSIwLjMiPgogICAgICAgIDxnIGlkPSJpY29u5YiH5Zu+IiB0cmFuc2Zvcm09InRyYW5zbGF0ZSgtMTEyLjAwMDAwMCwgLTE5NjUuMDAwMDAwKSIgZmlsbD0idXJsKCNyYWRpYWxHcmFkaWVudC0xKSI+CiAgICAgICAgICAgIDxyZWN0IGlkPSLljaHniYfljLrliIblibLlt6YiIHg9IjExMiIgeT0iMTk2NCIgd2lkdGg9IjI0IiBoZWlnaHQ9IjgwIj48L3JlY3Q+CiAgICAgICAgPC9nPgogICAgPC9nPgo8L3N2Zz4="
														class="center-left">
													<div data-v-18da170e="" class="start-time">19:45</div>
													<img data-v-18da170e=""
														src="data:image/svg+xml;base64,PD94bWwgdmVyc2lvbj0iMS4wIiBlbmNvZGluZz0iVVRGLTgiPz4KPHN2ZyB3aWR0aD0iMjRweCIgaGVpZ2h0PSI3OHB4IiB2aWV3Qm94PSIwIDAgMjQgNzgiIHZlcnNpb249IjEuMSIgeG1sbnM9Imh0dHA6Ly93d3cudzMub3JnLzIwMDAvc3ZnIiB4bWxuczp4bGluaz0iaHR0cDovL3d3dy53My5vcmcvMTk5OS94bGluayI+CiAgICA8IS0tIEdlbmVyYXRvcjogU2tldGNoIDQ5LjMgKDUxMTY3KSAtIGh0dHA6Ly93d3cuYm9oZW1pYW5jb2RpbmcuY29tL3NrZXRjaCAtLT4KICAgIDx0aXRsZT7ljaHniYfljLrliIblibLlj7M8L3RpdGxlPgogICAgPGRlc2M+Q3JlYXRlZCB3aXRoIFNrZXRjaC48L2Rlc2M+CiAgICA8ZGVmcz4KICAgICAgICA8cmFkaWFsR3JhZGllbnQgY3g9IjEwMCUiIGN5PSI1MCUiIGZ4PSIxMDAlIiBmeT0iNTAlIiByPSI5OC44MDMyODc2JSIgZ3JhZGllbnRUcmFuc2Zvcm09InRyYW5zbGF0ZSgxLjAwMDAwMCwwLjUwMDAwMCksc2NhbGUoMS4wMDAwMDAsMC4zMDAwMDApLHJvdGF0ZSgtMTc5Ljk5OTk5OCksc2NhbGUoMS4wMDAwMDAsMS42MzI1MTgpLHRyYW5zbGF0ZSgtMS4wMDAwMDAsLTAuNTAwMDAwKSIgaWQ9InJhZGlhbEdyYWRpZW50LTEiPgogICAgICAgICAgICA8c3RvcCBzdG9wLWNvbG9yPSIjMEMxMjFGIiBvZmZzZXQ9IjAlIj48L3N0b3A+CiAgICAgICAgICAgIDxzdG9wIHN0b3AtY29sb3I9IiMxQTI1MzgiIHN0b3Atb3BhY2l0eT0iMCIgb2Zmc2V0PSIxMDAlIj48L3N0b3A+CiAgICAgICAgPC9yYWRpYWxHcmFkaWVudD4KICAgIDwvZGVmcz4KICAgIDxnIGlkPSLpm7fnq57mioAyLjAtY29weSIgc3Ryb2tlPSJub25lIiBzdHJva2Utd2lkdGg9IjEiIGZpbGw9Im5vbmUiIGZpbGwtcnVsZT0iZXZlbm9kZCIgZmlsbC1vcGFjaXR5PSIwLjMiPgogICAgICAgIDxnIGlkPSJpY29u5YiH5Zu+IiB0cmFuc2Zvcm09InRyYW5zbGF0ZSgtMTc2LjAwMDAwMCwgLTE5NjUuMDAwMDAwKSIgZmlsbD0idXJsKCNyYWRpYWxHcmFkaWVudC0xKSI+CiAgICAgICAgICAgIDxyZWN0IGlkPSLljaHniYfljLrliIblibLlj7MiIHRyYW5zZm9ybT0idHJhbnNsYXRlKDE4OC4wMDAwMDAsIDIwMDQuMDAwMDAwKSBzY2FsZSgtMSwgMSkgdHJhbnNsYXRlKC0xODguMDAwMDAwLCAtMjAwNC4wMDAwMDApICIgeD0iMTc2IiB5PSIxOTY0IiB3aWR0aD0iMjQiIGhlaWdodD0iODAiPjwvcmVjdD4KICAgICAgICA8L2c+CiAgICA8L2c+Cjwvc3ZnPg=="
														class="center-right">
												</div>
												<div data-v-18da170e="" class="card-body-team">
													<img data-v-18da170e=""
														src="//yuanjududu.com//file/1672db3ae01e54f06cce4dc44ec6ec7a.png"
														class="team-logo">
												</div>
											</section>
											<div data-v-8d7d541a="" data-v-18da170e=""
												class="odds-group-title">
												<div data-v-8d7d541a="" class="empty-badge">&nbsp;</div>
												<div data-v-8d7d541a="" class="title">获胜者</div>
											</div>
											<section data-v-18da170e="" class="card-footer">
												<div data-v-18da170e="" class="card-odds-btn">
													<div data-v-ba6efc5c="" data-v-18da170e=""
														class="home-match-card-button">
														<div data-v-ba6efc5c="" class="button-dark-border">
															<div data-v-ba6efc5c="" class="button-content">
																<div data-v-ba6efc5c="" class="button-name">SaveBuyBackPlz</div>
																<div data-v-ba6efc5c="" class="button-odds-content">
																	<div data-v-ba6efc5c="" class="odds-rising-icon"></div>
																	<div data-v-ba6efc5c="" class="btn-odds">
																		<span data-v-ba6efc5c="">3.38</span>
																	</div>
																	<div data-v-ba6efc5c="" class="odds-dropping-icon"></div>
																</div>
															</div>
														</div>
													</div>
												</div>
												<div data-v-18da170e="" class="match-status">
													<div data-v-18da170e="" class="match-is-early">
														<div data-v-18da170e="" class="status-icon early-icon"></div>
														<div data-v-18da170e="" class="match-status-text">未开始</div>
													</div>
												</div>
												<div data-v-18da170e="" class="card-odds-btn">
													<div data-v-ba6efc5c="" data-v-18da170e=""
														class="home-match-card-button">
														<div data-v-ba6efc5c="" class="button-dark-border">
															<div data-v-ba6efc5c="" class="button-content">
																<div data-v-ba6efc5c="" class="button-name">Athletico
																	Esport</div>
																<div data-v-ba6efc5c="" class="button-odds-content">
																	<div data-v-ba6efc5c="" class="odds-rising-icon"></div>
																	<div data-v-ba6efc5c="" class="btn-odds">
																		<span data-v-ba6efc5c="">1.27</span>
																	</div>
																	<div data-v-ba6efc5c="" class="odds-dropping-icon"></div>
																</div>
															</div>
														</div>
													</div>
												</div>
											</section>
										</div>
										<div data-v-18da170e="" data-v-bf66ef20=""
											class="home-match-card">
											<section data-v-18da170e="" class="card-header">
												<img data-v-18da170e=""
													src="//yuanjududu.com//file/98c6eb475bf90d035c0d6b7f31fd59d0.svg"
													width="20px">
												<div data-v-18da170e="" class="tournament-name">
													CyberGamer Premier League</div>
												<div data-v-18da170e="" class="match-round">&nbsp;/
													bo1</div>
												<div data-v-18da170e="" class="play-count">+11</div>
											</section>
											<section data-v-18da170e="" class="card-body">
												<div data-v-18da170e="" class="card-body-team">
													<img data-v-18da170e=""
														src="//yuanjududu.com//file/1952dbbe66ef83060b1651d3028449b3.png"
														class="team-logo">
												</div>
												<div data-v-18da170e="" class="card-body-center">
													<img data-v-18da170e=""
														src="data:image/svg+xml;base64,PD94bWwgdmVyc2lvbj0iMS4wIiBlbmNvZGluZz0iVVRGLTgiPz4KPHN2ZyB3aWR0aD0iMjRweCIgaGVpZ2h0PSI3OHB4IiB2aWV3Qm94PSIwIDAgMjQgNzgiIHZlcnNpb249IjEuMSIgeG1sbnM9Imh0dHA6Ly93d3cudzMub3JnLzIwMDAvc3ZnIiB4bWxuczp4bGluaz0iaHR0cDovL3d3dy53My5vcmcvMTk5OS94bGluayI+CiAgICA8IS0tIEdlbmVyYXRvcjogU2tldGNoIDQ5LjMgKDUxMTY3KSAtIGh0dHA6Ly93d3cuYm9oZW1pYW5jb2RpbmcuY29tL3NrZXRjaCAtLT4KICAgIDx0aXRsZT7ljaHniYfljLrliIblibLlt6Y8L3RpdGxlPgogICAgPGRlc2M+Q3JlYXRlZCB3aXRoIFNrZXRjaC48L2Rlc2M+CiAgICA8ZGVmcz4KICAgICAgICA8cmFkaWFsR3JhZGllbnQgY3g9IjEwMCUiIGN5PSI1MCUiIGZ4PSIxMDAlIiBmeT0iNTAlIiByPSI5OC44MDMyODc2JSIgZ3JhZGllbnRUcmFuc2Zvcm09InRyYW5zbGF0ZSgxLjAwMDAwMCwwLjUwMDAwMCksc2NhbGUoMS4wMDAwMDAsMC4zMDAwMDApLHJvdGF0ZSgtMTc5Ljk5OTk5OCksc2NhbGUoMS4wMDAwMDAsMS42MzI1MTgpLHRyYW5zbGF0ZSgtMS4wMDAwMDAsLTAuNTAwMDAwKSIgaWQ9InJhZGlhbEdyYWRpZW50LTEiPgogICAgICAgICAgICA8c3RvcCBzdG9wLWNvbG9yPSIjMEMxMjFGIiBvZmZzZXQ9IjAlIj48L3N0b3A+CiAgICAgICAgICAgIDxzdG9wIHN0b3AtY29sb3I9IiMxQTI1MzgiIHN0b3Atb3BhY2l0eT0iMCIgb2Zmc2V0PSIxMDAlIj48L3N0b3A+CiAgICAgICAgPC9yYWRpYWxHcmFkaWVudD4KICAgIDwvZGVmcz4KICAgIDxnIGlkPSLpm7fnq57mioAyLjAtY29weSIgc3Ryb2tlPSJub25lIiBzdHJva2Utd2lkdGg9IjEiIGZpbGw9Im5vbmUiIGZpbGwtcnVsZT0iZXZlbm9kZCIgZmlsbC1vcGFjaXR5PSIwLjMiPgogICAgICAgIDxnIGlkPSJpY29u5YiH5Zu+IiB0cmFuc2Zvcm09InRyYW5zbGF0ZSgtMTEyLjAwMDAwMCwgLTE5NjUuMDAwMDAwKSIgZmlsbD0idXJsKCNyYWRpYWxHcmFkaWVudC0xKSI+CiAgICAgICAgICAgIDxyZWN0IGlkPSLljaHniYfljLrliIblibLlt6YiIHg9IjExMiIgeT0iMTk2NCIgd2lkdGg9IjI0IiBoZWlnaHQ9IjgwIj48L3JlY3Q+CiAgICAgICAgPC9nPgogICAgPC9nPgo8L3N2Zz4="
														class="center-left">
													<div data-v-18da170e="" class="start-time">20:00</div>
													<img data-v-18da170e=""
														src="data:image/svg+xml;base64,PD94bWwgdmVyc2lvbj0iMS4wIiBlbmNvZGluZz0iVVRGLTgiPz4KPHN2ZyB3aWR0aD0iMjRweCIgaGVpZ2h0PSI3OHB4IiB2aWV3Qm94PSIwIDAgMjQgNzgiIHZlcnNpb249IjEuMSIgeG1sbnM9Imh0dHA6Ly93d3cudzMub3JnLzIwMDAvc3ZnIiB4bWxuczp4bGluaz0iaHR0cDovL3d3dy53My5vcmcvMTk5OS94bGluayI+CiAgICA8IS0tIEdlbmVyYXRvcjogU2tldGNoIDQ5LjMgKDUxMTY3KSAtIGh0dHA6Ly93d3cuYm9oZW1pYW5jb2RpbmcuY29tL3NrZXRjaCAtLT4KICAgIDx0aXRsZT7ljaHniYfljLrliIblibLlj7M8L3RpdGxlPgogICAgPGRlc2M+Q3JlYXRlZCB3aXRoIFNrZXRjaC48L2Rlc2M+CiAgICA8ZGVmcz4KICAgICAgICA8cmFkaWFsR3JhZGllbnQgY3g9IjEwMCUiIGN5PSI1MCUiIGZ4PSIxMDAlIiBmeT0iNTAlIiByPSI5OC44MDMyODc2JSIgZ3JhZGllbnRUcmFuc2Zvcm09InRyYW5zbGF0ZSgxLjAwMDAwMCwwLjUwMDAwMCksc2NhbGUoMS4wMDAwMDAsMC4zMDAwMDApLHJvdGF0ZSgtMTc5Ljk5OTk5OCksc2NhbGUoMS4wMDAwMDAsMS42MzI1MTgpLHRyYW5zbGF0ZSgtMS4wMDAwMDAsLTAuNTAwMDAwKSIgaWQ9InJhZGlhbEdyYWRpZW50LTEiPgogICAgICAgICAgICA8c3RvcCBzdG9wLWNvbG9yPSIjMEMxMjFGIiBvZmZzZXQ9IjAlIj48L3N0b3A+CiAgICAgICAgICAgIDxzdG9wIHN0b3AtY29sb3I9IiMxQTI1MzgiIHN0b3Atb3BhY2l0eT0iMCIgb2Zmc2V0PSIxMDAlIj48L3N0b3A+CiAgICAgICAgPC9yYWRpYWxHcmFkaWVudD4KICAgIDwvZGVmcz4KICAgIDxnIGlkPSLpm7fnq57mioAyLjAtY29weSIgc3Ryb2tlPSJub25lIiBzdHJva2Utd2lkdGg9IjEiIGZpbGw9Im5vbmUiIGZpbGwtcnVsZT0iZXZlbm9kZCIgZmlsbC1vcGFjaXR5PSIwLjMiPgogICAgICAgIDxnIGlkPSJpY29u5YiH5Zu+IiB0cmFuc2Zvcm09InRyYW5zbGF0ZSgtMTc2LjAwMDAwMCwgLTE5NjUuMDAwMDAwKSIgZmlsbD0idXJsKCNyYWRpYWxHcmFkaWVudC0xKSI+CiAgICAgICAgICAgIDxyZWN0IGlkPSLljaHniYfljLrliIblibLlj7MiIHRyYW5zZm9ybT0idHJhbnNsYXRlKDE4OC4wMDAwMDAsIDIwMDQuMDAwMDAwKSBzY2FsZSgtMSwgMSkgdHJhbnNsYXRlKC0xODguMDAwMDAwLCAtMjAwNC4wMDAwMDApICIgeD0iMTc2IiB5PSIxOTY0IiB3aWR0aD0iMjQiIGhlaWdodD0iODAiPjwvcmVjdD4KICAgICAgICA8L2c+CiAgICA8L2c+Cjwvc3ZnPg=="
														class="center-right">
												</div>
												<div data-v-18da170e="" class="card-body-team">
													<img data-v-18da170e=""
														src="//yuanjududu.com//file/5f24ee1e1b59d7b4c70eadc92ad6713a.png"
														class="team-logo">
												</div>
											</section>
											<div data-v-8d7d541a="" data-v-18da170e=""
												class="odds-group-title">
												<div data-v-8d7d541a="" class="empty-badge">&nbsp;</div>
												<div data-v-8d7d541a="" class="title">获胜者</div>
											</div>
											<section data-v-18da170e="" class="card-footer">
												<div data-v-18da170e="" class="card-odds-btn">
													<div data-v-ba6efc5c="" data-v-18da170e=""
														class="home-match-card-button">
														<div data-v-ba6efc5c="" class="button-dark-border">
															<div data-v-ba6efc5c="" class="button-content">
																<div data-v-ba6efc5c="" class="button-name">SYF</div>
																<div data-v-ba6efc5c="" class="button-odds-content">
																	<div data-v-ba6efc5c="" class="odds-rising-icon"></div>
																	<div data-v-ba6efc5c="" class="btn-odds">
																		<span data-v-ba6efc5c="">1.35</span>
																	</div>
																	<div data-v-ba6efc5c="" class="odds-dropping-icon"></div>
																</div>
															</div>
														</div>
													</div>
												</div>
												<div data-v-18da170e="" class="match-status">
													<div data-v-18da170e="" class="match-is-early">
														<div data-v-18da170e="" class="status-icon early-icon"></div>
														<div data-v-18da170e="" class="match-status-text">未开始</div>
													</div>
												</div>
												<div data-v-18da170e="" class="card-odds-btn">
													<div data-v-ba6efc5c="" data-v-18da170e=""
														class="home-match-card-button">
														<div data-v-ba6efc5c="" class="button-dark-border">
															<div data-v-ba6efc5c="" class="button-content">
																<div data-v-ba6efc5c="" class="button-name">madlikewizards</div>
																<div data-v-ba6efc5c="" class="button-odds-content">
																	<div data-v-ba6efc5c="" class="odds-rising-icon"></div>
																	<div data-v-ba6efc5c="" class="btn-odds">
																		<span data-v-ba6efc5c="">2.99</span>
																	</div>
																	<div data-v-ba6efc5c="" class="odds-dropping-icon"></div>
																</div>
															</div>
														</div>
													</div>
												</div>
											</section>
										</div>
										<div data-v-18da170e="" data-v-bf66ef20=""
											class="home-match-card">
											<section data-v-18da170e="" class="card-header">
												<img data-v-18da170e=""
													src="//yuanjududu.com//file/eb8b6c6d7f3c5a78cf74cf3dc0af3cbd.svg"
													width="20px">
												<div data-v-18da170e="" class="tournament-name">
													黄金风暴联赛</div>
												<div data-v-18da170e="" class="match-round">&nbsp;/
													bo2</div>
												<div data-v-18da170e="" class="play-count">+1</div>
											</section>
											<section data-v-18da170e="" class="card-body">
												<div data-v-18da170e="" class="card-body-team">
													<img data-v-18da170e=""
														src="//yuanjududu.com//file/e0bdf53e780b2f669751f9baa7814465.png"
														class="team-logo">
												</div>
												<div data-v-18da170e="" class="card-body-center">
													<img data-v-18da170e=""
														src="data:image/svg+xml;base64,PD94bWwgdmVyc2lvbj0iMS4wIiBlbmNvZGluZz0iVVRGLTgiPz4KPHN2ZyB3aWR0aD0iMjRweCIgaGVpZ2h0PSI3OHB4IiB2aWV3Qm94PSIwIDAgMjQgNzgiIHZlcnNpb249IjEuMSIgeG1sbnM9Imh0dHA6Ly93d3cudzMub3JnLzIwMDAvc3ZnIiB4bWxuczp4bGluaz0iaHR0cDovL3d3dy53My5vcmcvMTk5OS94bGluayI+CiAgICA8IS0tIEdlbmVyYXRvcjogU2tldGNoIDQ5LjMgKDUxMTY3KSAtIGh0dHA6Ly93d3cuYm9oZW1pYW5jb2RpbmcuY29tL3NrZXRjaCAtLT4KICAgIDx0aXRsZT7ljaHniYfljLrliIblibLlt6Y8L3RpdGxlPgogICAgPGRlc2M+Q3JlYXRlZCB3aXRoIFNrZXRjaC48L2Rlc2M+CiAgICA8ZGVmcz4KICAgICAgICA8cmFkaWFsR3JhZGllbnQgY3g9IjEwMCUiIGN5PSI1MCUiIGZ4PSIxMDAlIiBmeT0iNTAlIiByPSI5OC44MDMyODc2JSIgZ3JhZGllbnRUcmFuc2Zvcm09InRyYW5zbGF0ZSgxLjAwMDAwMCwwLjUwMDAwMCksc2NhbGUoMS4wMDAwMDAsMC4zMDAwMDApLHJvdGF0ZSgtMTc5Ljk5OTk5OCksc2NhbGUoMS4wMDAwMDAsMS42MzI1MTgpLHRyYW5zbGF0ZSgtMS4wMDAwMDAsLTAuNTAwMDAwKSIgaWQ9InJhZGlhbEdyYWRpZW50LTEiPgogICAgICAgICAgICA8c3RvcCBzdG9wLWNvbG9yPSIjMEMxMjFGIiBvZmZzZXQ9IjAlIj48L3N0b3A+CiAgICAgICAgICAgIDxzdG9wIHN0b3AtY29sb3I9IiMxQTI1MzgiIHN0b3Atb3BhY2l0eT0iMCIgb2Zmc2V0PSIxMDAlIj48L3N0b3A+CiAgICAgICAgPC9yYWRpYWxHcmFkaWVudD4KICAgIDwvZGVmcz4KICAgIDxnIGlkPSLpm7fnq57mioAyLjAtY29weSIgc3Ryb2tlPSJub25lIiBzdHJva2Utd2lkdGg9IjEiIGZpbGw9Im5vbmUiIGZpbGwtcnVsZT0iZXZlbm9kZCIgZmlsbC1vcGFjaXR5PSIwLjMiPgogICAgICAgIDxnIGlkPSJpY29u5YiH5Zu+IiB0cmFuc2Zvcm09InRyYW5zbGF0ZSgtMTEyLjAwMDAwMCwgLTE5NjUuMDAwMDAwKSIgZmlsbD0idXJsKCNyYWRpYWxHcmFkaWVudC0xKSI+CiAgICAgICAgICAgIDxyZWN0IGlkPSLljaHniYfljLrliIblibLlt6YiIHg9IjExMiIgeT0iMTk2NCIgd2lkdGg9IjI0IiBoZWlnaHQ9IjgwIj48L3JlY3Q+CiAgICAgICAgPC9nPgogICAgPC9nPgo8L3N2Zz4="
														class="center-left">
													<div data-v-18da170e="" class="start-time">20:30</div>
													<img data-v-18da170e=""
														src="data:image/svg+xml;base64,PD94bWwgdmVyc2lvbj0iMS4wIiBlbmNvZGluZz0iVVRGLTgiPz4KPHN2ZyB3aWR0aD0iMjRweCIgaGVpZ2h0PSI3OHB4IiB2aWV3Qm94PSIwIDAgMjQgNzgiIHZlcnNpb249IjEuMSIgeG1sbnM9Imh0dHA6Ly93d3cudzMub3JnLzIwMDAvc3ZnIiB4bWxuczp4bGluaz0iaHR0cDovL3d3dy53My5vcmcvMTk5OS94bGluayI+CiAgICA8IS0tIEdlbmVyYXRvcjogU2tldGNoIDQ5LjMgKDUxMTY3KSAtIGh0dHA6Ly93d3cuYm9oZW1pYW5jb2RpbmcuY29tL3NrZXRjaCAtLT4KICAgIDx0aXRsZT7ljaHniYfljLrliIblibLlj7M8L3RpdGxlPgogICAgPGRlc2M+Q3JlYXRlZCB3aXRoIFNrZXRjaC48L2Rlc2M+CiAgICA8ZGVmcz4KICAgICAgICA8cmFkaWFsR3JhZGllbnQgY3g9IjEwMCUiIGN5PSI1MCUiIGZ4PSIxMDAlIiBmeT0iNTAlIiByPSI5OC44MDMyODc2JSIgZ3JhZGllbnRUcmFuc2Zvcm09InRyYW5zbGF0ZSgxLjAwMDAwMCwwLjUwMDAwMCksc2NhbGUoMS4wMDAwMDAsMC4zMDAwMDApLHJvdGF0ZSgtMTc5Ljk5OTk5OCksc2NhbGUoMS4wMDAwMDAsMS42MzI1MTgpLHRyYW5zbGF0ZSgtMS4wMDAwMDAsLTAuNTAwMDAwKSIgaWQ9InJhZGlhbEdyYWRpZW50LTEiPgogICAgICAgICAgICA8c3RvcCBzdG9wLWNvbG9yPSIjMEMxMjFGIiBvZmZzZXQ9IjAlIj48L3N0b3A+CiAgICAgICAgICAgIDxzdG9wIHN0b3AtY29sb3I9IiMxQTI1MzgiIHN0b3Atb3BhY2l0eT0iMCIgb2Zmc2V0PSIxMDAlIj48L3N0b3A+CiAgICAgICAgPC9yYWRpYWxHcmFkaWVudD4KICAgIDwvZGVmcz4KICAgIDxnIGlkPSLpm7fnq57mioAyLjAtY29weSIgc3Ryb2tlPSJub25lIiBzdHJva2Utd2lkdGg9IjEiIGZpbGw9Im5vbmUiIGZpbGwtcnVsZT0iZXZlbm9kZCIgZmlsbC1vcGFjaXR5PSIwLjMiPgogICAgICAgIDxnIGlkPSJpY29u5YiH5Zu+IiB0cmFuc2Zvcm09InRyYW5zbGF0ZSgtMTc2LjAwMDAwMCwgLTE5NjUuMDAwMDAwKSIgZmlsbD0idXJsKCNyYWRpYWxHcmFkaWVudC0xKSI+CiAgICAgICAgICAgIDxyZWN0IGlkPSLljaHniYfljLrliIblibLlj7MiIHRyYW5zZm9ybT0idHJhbnNsYXRlKDE4OC4wMDAwMDAsIDIwMDQuMDAwMDAwKSBzY2FsZSgtMSwgMSkgdHJhbnNsYXRlKC0xODguMDAwMDAwLCAtMjAwNC4wMDAwMDApICIgeD0iMTc2IiB5PSIxOTY0IiB3aWR0aD0iMjQiIGhlaWdodD0iODAiPjwvcmVjdD4KICAgICAgICA8L2c+CiAgICA8L2c+Cjwvc3ZnPg=="
														class="center-right">
												</div>
												<div data-v-18da170e="" class="card-body-team">
													<img data-v-18da170e=""
														src="//yuanjududu.com//file/475c879928dcfdbecc7ca540dbce541d.png"
														class="team-logo">
												</div>
											</section>
											<div data-v-8d7d541a="" data-v-18da170e=""
												class="odds-group-title">
												<div data-v-8d7d541a="" class="empty-badge">&nbsp;</div>
												<div data-v-8d7d541a="" class="title">获胜者</div>
											</div>
											<section data-v-18da170e="" class="card-footer">
												<div data-v-18da170e="" class="card-odds-btn">
													<div data-v-ba6efc5c="" data-v-18da170e=""
														class="home-match-card-button btn-locked">
														<div data-v-ba6efc5c="" class="button-dark-border">
															<div data-v-ba6efc5c="" class="button-content">
																<div data-v-ba6efc5c="" class="button-name">AT</div>
																<div data-v-ba6efc5c="" class="button-odds-content">
																	<div data-v-ba6efc5c="" class="odds-rising-icon"></div>
																	<div data-v-ba6efc5c="" class="btn-odds">
																		<!---->
																	</div>
																	<div data-v-ba6efc5c="" class="odds-dropping-icon"></div>
																</div>
															</div>
														</div>
													</div>
												</div>
												<div data-v-18da170e="" class="match-status">
													<div data-v-18da170e="" class="match-is-early">
														<div data-v-18da170e="" class="status-icon early-icon"></div>
														<div data-v-18da170e="" class="match-status-text">未开始</div>
													</div>
												</div>
												<div data-v-18da170e="" class="card-odds-btn">
													<div data-v-ba6efc5c="" data-v-18da170e=""
														class="home-match-card-button btn-locked">
														<div data-v-ba6efc5c="" class="button-dark-border">
															<div data-v-ba6efc5c="" class="button-content">
																<div data-v-ba6efc5c="" class="button-name">TN</div>
																<div data-v-ba6efc5c="" class="button-odds-content">
																	<div data-v-ba6efc5c="" class="odds-rising-icon"></div>
																	<div data-v-ba6efc5c="" class="btn-odds">
																		<!---->
																	</div>
																	<div data-v-ba6efc5c="" class="odds-dropping-icon"></div>
																</div>
															</div>
														</div>
													</div>
												</div>
											</section>
										</div>
										<div data-v-18da170e="" data-v-bf66ef20=""
											class="home-match-card">
											<section data-v-18da170e="" class="card-header">
												<img data-v-18da170e=""
													src="//yuanjududu.com//file/98c6eb475bf90d035c0d6b7f31fd59d0.svg"
													width="20px">
												<div data-v-18da170e="" class="tournament-name">震中杯
													EPICENTER 2018</div>
												<div data-v-18da170e="" class="match-round">&nbsp;/
													bo3</div>
												<div data-v-18da170e="" class="play-count">+25</div>
											</section>
											<section data-v-18da170e="" class="card-body">
												<div data-v-18da170e="" class="card-body-team">
													<img data-v-18da170e=""
														src="//yuanjududu.com//file/c8e57671ebfb35c3eb16a9243302e1c0.png"
														class="team-logo">
												</div>
												<div data-v-18da170e="" class="card-body-center">
													<img data-v-18da170e=""
														src="data:image/svg+xml;base64,PD94bWwgdmVyc2lvbj0iMS4wIiBlbmNvZGluZz0iVVRGLTgiPz4KPHN2ZyB3aWR0aD0iMjRweCIgaGVpZ2h0PSI3OHB4IiB2aWV3Qm94PSIwIDAgMjQgNzgiIHZlcnNpb249IjEuMSIgeG1sbnM9Imh0dHA6Ly93d3cudzMub3JnLzIwMDAvc3ZnIiB4bWxuczp4bGluaz0iaHR0cDovL3d3dy53My5vcmcvMTk5OS94bGluayI+CiAgICA8IS0tIEdlbmVyYXRvcjogU2tldGNoIDQ5LjMgKDUxMTY3KSAtIGh0dHA6Ly93d3cuYm9oZW1pYW5jb2RpbmcuY29tL3NrZXRjaCAtLT4KICAgIDx0aXRsZT7ljaHniYfljLrliIblibLlt6Y8L3RpdGxlPgogICAgPGRlc2M+Q3JlYXRlZCB3aXRoIFNrZXRjaC48L2Rlc2M+CiAgICA8ZGVmcz4KICAgICAgICA8cmFkaWFsR3JhZGllbnQgY3g9IjEwMCUiIGN5PSI1MCUiIGZ4PSIxMDAlIiBmeT0iNTAlIiByPSI5OC44MDMyODc2JSIgZ3JhZGllbnRUcmFuc2Zvcm09InRyYW5zbGF0ZSgxLjAwMDAwMCwwLjUwMDAwMCksc2NhbGUoMS4wMDAwMDAsMC4zMDAwMDApLHJvdGF0ZSgtMTc5Ljk5OTk5OCksc2NhbGUoMS4wMDAwMDAsMS42MzI1MTgpLHRyYW5zbGF0ZSgtMS4wMDAwMDAsLTAuNTAwMDAwKSIgaWQ9InJhZGlhbEdyYWRpZW50LTEiPgogICAgICAgICAgICA8c3RvcCBzdG9wLWNvbG9yPSIjMEMxMjFGIiBvZmZzZXQ9IjAlIj48L3N0b3A+CiAgICAgICAgICAgIDxzdG9wIHN0b3AtY29sb3I9IiMxQTI1MzgiIHN0b3Atb3BhY2l0eT0iMCIgb2Zmc2V0PSIxMDAlIj48L3N0b3A+CiAgICAgICAgPC9yYWRpYWxHcmFkaWVudD4KICAgIDwvZGVmcz4KICAgIDxnIGlkPSLpm7fnq57mioAyLjAtY29weSIgc3Ryb2tlPSJub25lIiBzdHJva2Utd2lkdGg9IjEiIGZpbGw9Im5vbmUiIGZpbGwtcnVsZT0iZXZlbm9kZCIgZmlsbC1vcGFjaXR5PSIwLjMiPgogICAgICAgIDxnIGlkPSJpY29u5YiH5Zu+IiB0cmFuc2Zvcm09InRyYW5zbGF0ZSgtMTEyLjAwMDAwMCwgLTE5NjUuMDAwMDAwKSIgZmlsbD0idXJsKCNyYWRpYWxHcmFkaWVudC0xKSI+CiAgICAgICAgICAgIDxyZWN0IGlkPSLljaHniYfljLrliIblibLlt6YiIHg9IjExMiIgeT0iMTk2NCIgd2lkdGg9IjI0IiBoZWlnaHQ9IjgwIj48L3JlY3Q+CiAgICAgICAgPC9nPgogICAgPC9nPgo8L3N2Zz4="
														class="center-left">
													<div data-v-18da170e="" class="start-time">21:00</div>
													<img data-v-18da170e=""
														src="data:image/svg+xml;base64,PD94bWwgdmVyc2lvbj0iMS4wIiBlbmNvZGluZz0iVVRGLTgiPz4KPHN2ZyB3aWR0aD0iMjRweCIgaGVpZ2h0PSI3OHB4IiB2aWV3Qm94PSIwIDAgMjQgNzgiIHZlcnNpb249IjEuMSIgeG1sbnM9Imh0dHA6Ly93d3cudzMub3JnLzIwMDAvc3ZnIiB4bWxuczp4bGluaz0iaHR0cDovL3d3dy53My5vcmcvMTk5OS94bGluayI+CiAgICA8IS0tIEdlbmVyYXRvcjogU2tldGNoIDQ5LjMgKDUxMTY3KSAtIGh0dHA6Ly93d3cuYm9oZW1pYW5jb2RpbmcuY29tL3NrZXRjaCAtLT4KICAgIDx0aXRsZT7ljaHniYfljLrliIblibLlj7M8L3RpdGxlPgogICAgPGRlc2M+Q3JlYXRlZCB3aXRoIFNrZXRjaC48L2Rlc2M+CiAgICA8ZGVmcz4KICAgICAgICA8cmFkaWFsR3JhZGllbnQgY3g9IjEwMCUiIGN5PSI1MCUiIGZ4PSIxMDAlIiBmeT0iNTAlIiByPSI5OC44MDMyODc2JSIgZ3JhZGllbnRUcmFuc2Zvcm09InRyYW5zbGF0ZSgxLjAwMDAwMCwwLjUwMDAwMCksc2NhbGUoMS4wMDAwMDAsMC4zMDAwMDApLHJvdGF0ZSgtMTc5Ljk5OTk5OCksc2NhbGUoMS4wMDAwMDAsMS42MzI1MTgpLHRyYW5zbGF0ZSgtMS4wMDAwMDAsLTAuNTAwMDAwKSIgaWQ9InJhZGlhbEdyYWRpZW50LTEiPgogICAgICAgICAgICA8c3RvcCBzdG9wLWNvbG9yPSIjMEMxMjFGIiBvZmZzZXQ9IjAlIj48L3N0b3A+CiAgICAgICAgICAgIDxzdG9wIHN0b3AtY29sb3I9IiMxQTI1MzgiIHN0b3Atb3BhY2l0eT0iMCIgb2Zmc2V0PSIxMDAlIj48L3N0b3A+CiAgICAgICAgPC9yYWRpYWxHcmFkaWVudD4KICAgIDwvZGVmcz4KICAgIDxnIGlkPSLpm7fnq57mioAyLjAtY29weSIgc3Ryb2tlPSJub25lIiBzdHJva2Utd2lkdGg9IjEiIGZpbGw9Im5vbmUiIGZpbGwtcnVsZT0iZXZlbm9kZCIgZmlsbC1vcGFjaXR5PSIwLjMiPgogICAgICAgIDxnIGlkPSJpY29u5YiH5Zu+IiB0cmFuc2Zvcm09InRyYW5zbGF0ZSgtMTc2LjAwMDAwMCwgLTE5NjUuMDAwMDAwKSIgZmlsbD0idXJsKCNyYWRpYWxHcmFkaWVudC0xKSI+CiAgICAgICAgICAgIDxyZWN0IGlkPSLljaHniYfljLrliIblibLlj7MiIHRyYW5zZm9ybT0idHJhbnNsYXRlKDE4OC4wMDAwMDAsIDIwMDQuMDAwMDAwKSBzY2FsZSgtMSwgMSkgdHJhbnNsYXRlKC0xODguMDAwMDAwLCAtMjAwNC4wMDAwMDApICIgeD0iMTc2IiB5PSIxOTY0IiB3aWR0aD0iMjQiIGhlaWdodD0iODAiPjwvcmVjdD4KICAgICAgICA8L2c+CiAgICA8L2c+Cjwvc3ZnPg=="
														class="center-right">
												</div>
												<div data-v-18da170e="" class="card-body-team">
													<img data-v-18da170e=""
														src="//yuanjududu.com//file/7582b1f0256d4bcc6fdb18687e9f4b9d.png"
														class="team-logo">
												</div>
											</section>
											<div data-v-8d7d541a="" data-v-18da170e=""
												class="odds-group-title">
												<div data-v-8d7d541a="" class="empty-badge">&nbsp;</div>
												<div data-v-8d7d541a="" class="title">获胜者</div>
											</div>
											<section data-v-18da170e="" class="card-footer">
												<div data-v-18da170e="" class="card-odds-btn">
													<div data-v-ba6efc5c="" data-v-18da170e=""
														class="home-match-card-button">
														<div data-v-ba6efc5c="" class="button-dark-border">
															<div data-v-ba6efc5c="" class="button-content">
																<div data-v-ba6efc5c="" class="button-name">AGO</div>
																<div data-v-ba6efc5c="" class="button-odds-content">
																	<div data-v-ba6efc5c="" class="odds-rising-icon"></div>
																	<div data-v-ba6efc5c="" class="btn-odds">
																		<span data-v-ba6efc5c="">1.45</span>
																	</div>
																	<div data-v-ba6efc5c="" class="odds-dropping-icon"></div>
																</div>
															</div>
														</div>
													</div>
												</div>
												<div data-v-18da170e="" class="match-status">
													<div data-v-18da170e="" class="match-is-early">
														<div data-v-18da170e="" class="status-icon early-icon"></div>
														<div data-v-18da170e="" class="match-status-text">未开始</div>
													</div>
												</div>
												<div data-v-18da170e="" class="card-odds-btn">
													<div data-v-ba6efc5c="" data-v-18da170e=""
														class="home-match-card-button">
														<div data-v-ba6efc5c="" class="button-dark-border">
															<div data-v-ba6efc5c="" class="button-content">
																<div data-v-ba6efc5c="" class="button-name">Windigo</div>
																<div data-v-ba6efc5c="" class="button-odds-content">
																	<div data-v-ba6efc5c="" class="odds-rising-icon"></div>
																	<div data-v-ba6efc5c="" class="btn-odds">
																		<span data-v-ba6efc5c="">2.60</span>
																	</div>
																	<div data-v-ba6efc5c="" class="odds-dropping-icon"></div>
																</div>
															</div>
														</div>
													</div>
												</div>
											</section>
										</div>
										<div data-v-18da170e="" data-v-bf66ef20=""
											class="home-match-card">
											<section data-v-18da170e="" class="card-header">
												<img data-v-18da170e=""
													src="//yuanjududu.com//file/d511f1c87538e99ca914ef559dfa68ba.svg"
													width="20px">
												<div data-v-18da170e="" class="tournament-name">
													SUNRISE CUP</div>
												<div data-v-18da170e="" class="match-round">&nbsp;/
													bo3</div>
												<div data-v-18da170e="" class="play-count">+4</div>
											</section>
											<section data-v-18da170e="" class="card-body">
												<div data-v-18da170e="" class="card-body-team">
													<img data-v-18da170e=""
														src="//yuanjududu.com//file/5e02a422ff7c3c00f5da2bb572c38142.png"
														class="team-logo">
												</div>
												<div data-v-18da170e="" class="card-body-center">
													<img data-v-18da170e=""
														src="data:image/svg+xml;base64,PD94bWwgdmVyc2lvbj0iMS4wIiBlbmNvZGluZz0iVVRGLTgiPz4KPHN2ZyB3aWR0aD0iMjRweCIgaGVpZ2h0PSI3OHB4IiB2aWV3Qm94PSIwIDAgMjQgNzgiIHZlcnNpb249IjEuMSIgeG1sbnM9Imh0dHA6Ly93d3cudzMub3JnLzIwMDAvc3ZnIiB4bWxuczp4bGluaz0iaHR0cDovL3d3dy53My5vcmcvMTk5OS94bGluayI+CiAgICA8IS0tIEdlbmVyYXRvcjogU2tldGNoIDQ5LjMgKDUxMTY3KSAtIGh0dHA6Ly93d3cuYm9oZW1pYW5jb2RpbmcuY29tL3NrZXRjaCAtLT4KICAgIDx0aXRsZT7ljaHniYfljLrliIblibLlt6Y8L3RpdGxlPgogICAgPGRlc2M+Q3JlYXRlZCB3aXRoIFNrZXRjaC48L2Rlc2M+CiAgICA8ZGVmcz4KICAgICAgICA8cmFkaWFsR3JhZGllbnQgY3g9IjEwMCUiIGN5PSI1MCUiIGZ4PSIxMDAlIiBmeT0iNTAlIiByPSI5OC44MDMyODc2JSIgZ3JhZGllbnRUcmFuc2Zvcm09InRyYW5zbGF0ZSgxLjAwMDAwMCwwLjUwMDAwMCksc2NhbGUoMS4wMDAwMDAsMC4zMDAwMDApLHJvdGF0ZSgtMTc5Ljk5OTk5OCksc2NhbGUoMS4wMDAwMDAsMS42MzI1MTgpLHRyYW5zbGF0ZSgtMS4wMDAwMDAsLTAuNTAwMDAwKSIgaWQ9InJhZGlhbEdyYWRpZW50LTEiPgogICAgICAgICAgICA8c3RvcCBzdG9wLWNvbG9yPSIjMEMxMjFGIiBvZmZzZXQ9IjAlIj48L3N0b3A+CiAgICAgICAgICAgIDxzdG9wIHN0b3AtY29sb3I9IiMxQTI1MzgiIHN0b3Atb3BhY2l0eT0iMCIgb2Zmc2V0PSIxMDAlIj48L3N0b3A+CiAgICAgICAgPC9yYWRpYWxHcmFkaWVudD4KICAgIDwvZGVmcz4KICAgIDxnIGlkPSLpm7fnq57mioAyLjAtY29weSIgc3Ryb2tlPSJub25lIiBzdHJva2Utd2lkdGg9IjEiIGZpbGw9Im5vbmUiIGZpbGwtcnVsZT0iZXZlbm9kZCIgZmlsbC1vcGFjaXR5PSIwLjMiPgogICAgICAgIDxnIGlkPSJpY29u5YiH5Zu+IiB0cmFuc2Zvcm09InRyYW5zbGF0ZSgtMTEyLjAwMDAwMCwgLTE5NjUuMDAwMDAwKSIgZmlsbD0idXJsKCNyYWRpYWxHcmFkaWVudC0xKSI+CiAgICAgICAgICAgIDxyZWN0IGlkPSLljaHniYfljLrliIblibLlt6YiIHg9IjExMiIgeT0iMTk2NCIgd2lkdGg9IjI0IiBoZWlnaHQ9IjgwIj48L3JlY3Q+CiAgICAgICAgPC9nPgogICAgPC9nPgo8L3N2Zz4="
														class="center-left">
													<div data-v-18da170e="" class="start-time">21:00</div>
													<img data-v-18da170e=""
														src="data:image/svg+xml;base64,PD94bWwgdmVyc2lvbj0iMS4wIiBlbmNvZGluZz0iVVRGLTgiPz4KPHN2ZyB3aWR0aD0iMjRweCIgaGVpZ2h0PSI3OHB4IiB2aWV3Qm94PSIwIDAgMjQgNzgiIHZlcnNpb249IjEuMSIgeG1sbnM9Imh0dHA6Ly93d3cudzMub3JnLzIwMDAvc3ZnIiB4bWxuczp4bGluaz0iaHR0cDovL3d3dy53My5vcmcvMTk5OS94bGluayI+CiAgICA8IS0tIEdlbmVyYXRvcjogU2tldGNoIDQ5LjMgKDUxMTY3KSAtIGh0dHA6Ly93d3cuYm9oZW1pYW5jb2RpbmcuY29tL3NrZXRjaCAtLT4KICAgIDx0aXRsZT7ljaHniYfljLrliIblibLlj7M8L3RpdGxlPgogICAgPGRlc2M+Q3JlYXRlZCB3aXRoIFNrZXRjaC48L2Rlc2M+CiAgICA8ZGVmcz4KICAgICAgICA8cmFkaWFsR3JhZGllbnQgY3g9IjEwMCUiIGN5PSI1MCUiIGZ4PSIxMDAlIiBmeT0iNTAlIiByPSI5OC44MDMyODc2JSIgZ3JhZGllbnRUcmFuc2Zvcm09InRyYW5zbGF0ZSgxLjAwMDAwMCwwLjUwMDAwMCksc2NhbGUoMS4wMDAwMDAsMC4zMDAwMDApLHJvdGF0ZSgtMTc5Ljk5OTk5OCksc2NhbGUoMS4wMDAwMDAsMS42MzI1MTgpLHRyYW5zbGF0ZSgtMS4wMDAwMDAsLTAuNTAwMDAwKSIgaWQ9InJhZGlhbEdyYWRpZW50LTEiPgogICAgICAgICAgICA8c3RvcCBzdG9wLWNvbG9yPSIjMEMxMjFGIiBvZmZzZXQ9IjAlIj48L3N0b3A+CiAgICAgICAgICAgIDxzdG9wIHN0b3AtY29sb3I9IiMxQTI1MzgiIHN0b3Atb3BhY2l0eT0iMCIgb2Zmc2V0PSIxMDAlIj48L3N0b3A+CiAgICAgICAgPC9yYWRpYWxHcmFkaWVudD4KICAgIDwvZGVmcz4KICAgIDxnIGlkPSLpm7fnq57mioAyLjAtY29weSIgc3Ryb2tlPSJub25lIiBzdHJva2Utd2lkdGg9IjEiIGZpbGw9Im5vbmUiIGZpbGwtcnVsZT0iZXZlbm9kZCIgZmlsbC1vcGFjaXR5PSIwLjMiPgogICAgICAgIDxnIGlkPSJpY29u5YiH5Zu+IiB0cmFuc2Zvcm09InRyYW5zbGF0ZSgtMTc2LjAwMDAwMCwgLTE5NjUuMDAwMDAwKSIgZmlsbD0idXJsKCNyYWRpYWxHcmFkaWVudC0xKSI+CiAgICAgICAgICAgIDxyZWN0IGlkPSLljaHniYfljLrliIblibLlj7MiIHRyYW5zZm9ybT0idHJhbnNsYXRlKDE4OC4wMDAwMDAsIDIwMDQuMDAwMDAwKSBzY2FsZSgtMSwgMSkgdHJhbnNsYXRlKC0xODguMDAwMDAwLCAtMjAwNC4wMDAwMDApICIgeD0iMTc2IiB5PSIxOTY0IiB3aWR0aD0iMjQiIGhlaWdodD0iODAiPjwvcmVjdD4KICAgICAgICA8L2c+CiAgICA8L2c+Cjwvc3ZnPg=="
														class="center-right">
												</div>
												<div data-v-18da170e="" class="card-body-team">
													<img data-v-18da170e=""
														src="//yuanjududu.com//file/886f3b2c8d47277cf20edd978bc9aa7a.png"
														class="team-logo">
												</div>
											</section>
											<div data-v-8d7d541a="" data-v-18da170e=""
												class="odds-group-title">
												<div data-v-8d7d541a="" class="empty-badge">&nbsp;</div>
												<div data-v-8d7d541a="" class="title">获胜者</div>
											</div>
											<section data-v-18da170e="" class="card-footer">
												<div data-v-18da170e="" class="card-odds-btn">
													<div data-v-ba6efc5c="" data-v-18da170e=""
														class="home-match-card-button">
														<div data-v-ba6efc5c="" class="button-dark-border">
															<div data-v-ba6efc5c="" class="button-content">
																<div data-v-ba6efc5c="" class="button-name">Question
																	Mark</div>
																<div data-v-ba6efc5c="" class="button-odds-content">
																	<div data-v-ba6efc5c="" class="odds-rising-icon"></div>
																	<div data-v-ba6efc5c="" class="btn-odds">
																		<span data-v-ba6efc5c="">1.58</span>
																	</div>
																	<div data-v-ba6efc5c="" class="odds-dropping-icon"></div>
																</div>
															</div>
														</div>
													</div>
												</div>
												<div data-v-18da170e="" class="match-status">
													<div data-v-18da170e="" class="match-is-early">
														<div data-v-18da170e="" class="status-icon early-icon"></div>
														<div data-v-18da170e="" class="match-status-text">未开始</div>
													</div>
												</div>
												<div data-v-18da170e="" class="card-odds-btn">
													<div data-v-ba6efc5c="" data-v-18da170e=""
														class="home-match-card-button">
														<div data-v-ba6efc5c="" class="button-dark-border">
															<div data-v-ba6efc5c="" class="button-content">
																<div data-v-ba6efc5c="" class="button-name">Digital
																	Company</div>
																<div data-v-ba6efc5c="" class="button-odds-content">
																	<div data-v-ba6efc5c="" class="odds-rising-icon"></div>
																	<div data-v-ba6efc5c="" class="btn-odds">
																		<span data-v-ba6efc5c="">2.21</span>
																	</div>
																	<div data-v-ba6efc5c="" class="odds-dropping-icon"></div>
																</div>
															</div>
														</div>
													</div>
												</div>
											</section>
										</div>
										<div data-v-18da170e="" data-v-bf66ef20=""
											class="home-match-card">
											<section data-v-18da170e="" class="card-header">
												<img data-v-18da170e=""
													src="//yuanjududu.com//file/2f657b4e0d2854ce02cd7220e002981f.svg"
													width="20px">
												<div data-v-18da170e="" class="tournament-name">
													Onpoong大师赛</div>
												<div data-v-18da170e="" class="match-round">&nbsp;/
													bo7</div>
												<div data-v-18da170e="" class="play-count">+1</div>
											</section>
											<section data-v-18da170e="" class="card-body">
												<div data-v-18da170e="" class="card-body-team">
													<img data-v-18da170e=""
														src="//yuanjududu.com//file/fba3e90ff5f85a0e057d94a1ef559de6.png"
														class="team-logo">
												</div>
												<div data-v-18da170e="" class="card-body-center">
													<img data-v-18da170e=""
														src="data:image/svg+xml;base64,PD94bWwgdmVyc2lvbj0iMS4wIiBlbmNvZGluZz0iVVRGLTgiPz4KPHN2ZyB3aWR0aD0iMjRweCIgaGVpZ2h0PSI3OHB4IiB2aWV3Qm94PSIwIDAgMjQgNzgiIHZlcnNpb249IjEuMSIgeG1sbnM9Imh0dHA6Ly93d3cudzMub3JnLzIwMDAvc3ZnIiB4bWxuczp4bGluaz0iaHR0cDovL3d3dy53My5vcmcvMTk5OS94bGluayI+CiAgICA8IS0tIEdlbmVyYXRvcjogU2tldGNoIDQ5LjMgKDUxMTY3KSAtIGh0dHA6Ly93d3cuYm9oZW1pYW5jb2RpbmcuY29tL3NrZXRjaCAtLT4KICAgIDx0aXRsZT7ljaHniYfljLrliIblibLlt6Y8L3RpdGxlPgogICAgPGRlc2M+Q3JlYXRlZCB3aXRoIFNrZXRjaC48L2Rlc2M+CiAgICA8ZGVmcz4KICAgICAgICA8cmFkaWFsR3JhZGllbnQgY3g9IjEwMCUiIGN5PSI1MCUiIGZ4PSIxMDAlIiBmeT0iNTAlIiByPSI5OC44MDMyODc2JSIgZ3JhZGllbnRUcmFuc2Zvcm09InRyYW5zbGF0ZSgxLjAwMDAwMCwwLjUwMDAwMCksc2NhbGUoMS4wMDAwMDAsMC4zMDAwMDApLHJvdGF0ZSgtMTc5Ljk5OTk5OCksc2NhbGUoMS4wMDAwMDAsMS42MzI1MTgpLHRyYW5zbGF0ZSgtMS4wMDAwMDAsLTAuNTAwMDAwKSIgaWQ9InJhZGlhbEdyYWRpZW50LTEiPgogICAgICAgICAgICA8c3RvcCBzdG9wLWNvbG9yPSIjMEMxMjFGIiBvZmZzZXQ9IjAlIj48L3N0b3A+CiAgICAgICAgICAgIDxzdG9wIHN0b3AtY29sb3I9IiMxQTI1MzgiIHN0b3Atb3BhY2l0eT0iMCIgb2Zmc2V0PSIxMDAlIj48L3N0b3A+CiAgICAgICAgPC9yYWRpYWxHcmFkaWVudD4KICAgIDwvZGVmcz4KICAgIDxnIGlkPSLpm7fnq57mioAyLjAtY29weSIgc3Ryb2tlPSJub25lIiBzdHJva2Utd2lkdGg9IjEiIGZpbGw9Im5vbmUiIGZpbGwtcnVsZT0iZXZlbm9kZCIgZmlsbC1vcGFjaXR5PSIwLjMiPgogICAgICAgIDxnIGlkPSJpY29u5YiH5Zu+IiB0cmFuc2Zvcm09InRyYW5zbGF0ZSgtMTEyLjAwMDAwMCwgLTE5NjUuMDAwMDAwKSIgZmlsbD0idXJsKCNyYWRpYWxHcmFkaWVudC0xKSI+CiAgICAgICAgICAgIDxyZWN0IGlkPSLljaHniYfljLrliIblibLlt6YiIHg9IjExMiIgeT0iMTk2NCIgd2lkdGg9IjI0IiBoZWlnaHQ9IjgwIj48L3JlY3Q+CiAgICAgICAgPC9nPgogICAgPC9nPgo8L3N2Zz4="
														class="center-left">
													<div data-v-18da170e="" class="start-time">21:00</div>
													<img data-v-18da170e=""
														src="data:image/svg+xml;base64,PD94bWwgdmVyc2lvbj0iMS4wIiBlbmNvZGluZz0iVVRGLTgiPz4KPHN2ZyB3aWR0aD0iMjRweCIgaGVpZ2h0PSI3OHB4IiB2aWV3Qm94PSIwIDAgMjQgNzgiIHZlcnNpb249IjEuMSIgeG1sbnM9Imh0dHA6Ly93d3cudzMub3JnLzIwMDAvc3ZnIiB4bWxuczp4bGluaz0iaHR0cDovL3d3dy53My5vcmcvMTk5OS94bGluayI+CiAgICA8IS0tIEdlbmVyYXRvcjogU2tldGNoIDQ5LjMgKDUxMTY3KSAtIGh0dHA6Ly93d3cuYm9oZW1pYW5jb2RpbmcuY29tL3NrZXRjaCAtLT4KICAgIDx0aXRsZT7ljaHniYfljLrliIblibLlj7M8L3RpdGxlPgogICAgPGRlc2M+Q3JlYXRlZCB3aXRoIFNrZXRjaC48L2Rlc2M+CiAgICA8ZGVmcz4KICAgICAgICA8cmFkaWFsR3JhZGllbnQgY3g9IjEwMCUiIGN5PSI1MCUiIGZ4PSIxMDAlIiBmeT0iNTAlIiByPSI5OC44MDMyODc2JSIgZ3JhZGllbnRUcmFuc2Zvcm09InRyYW5zbGF0ZSgxLjAwMDAwMCwwLjUwMDAwMCksc2NhbGUoMS4wMDAwMDAsMC4zMDAwMDApLHJvdGF0ZSgtMTc5Ljk5OTk5OCksc2NhbGUoMS4wMDAwMDAsMS42MzI1MTgpLHRyYW5zbGF0ZSgtMS4wMDAwMDAsLTAuNTAwMDAwKSIgaWQ9InJhZGlhbEdyYWRpZW50LTEiPgogICAgICAgICAgICA8c3RvcCBzdG9wLWNvbG9yPSIjMEMxMjFGIiBvZmZzZXQ9IjAlIj48L3N0b3A+CiAgICAgICAgICAgIDxzdG9wIHN0b3AtY29sb3I9IiMxQTI1MzgiIHN0b3Atb3BhY2l0eT0iMCIgb2Zmc2V0PSIxMDAlIj48L3N0b3A+CiAgICAgICAgPC9yYWRpYWxHcmFkaWVudD4KICAgIDwvZGVmcz4KICAgIDxnIGlkPSLpm7fnq57mioAyLjAtY29weSIgc3Ryb2tlPSJub25lIiBzdHJva2Utd2lkdGg9IjEiIGZpbGw9Im5vbmUiIGZpbGwtcnVsZT0iZXZlbm9kZCIgZmlsbC1vcGFjaXR5PSIwLjMiPgogICAgICAgIDxnIGlkPSJpY29u5YiH5Zu+IiB0cmFuc2Zvcm09InRyYW5zbGF0ZSgtMTc2LjAwMDAwMCwgLTE5NjUuMDAwMDAwKSIgZmlsbD0idXJsKCNyYWRpYWxHcmFkaWVudC0xKSI+CiAgICAgICAgICAgIDxyZWN0IGlkPSLljaHniYfljLrliIblibLlj7MiIHRyYW5zZm9ybT0idHJhbnNsYXRlKDE4OC4wMDAwMDAsIDIwMDQuMDAwMDAwKSBzY2FsZSgtMSwgMSkgdHJhbnNsYXRlKC0xODguMDAwMDAwLCAtMjAwNC4wMDAwMDApICIgeD0iMTc2IiB5PSIxOTY0IiB3aWR0aD0iMjQiIGhlaWdodD0iODAiPjwvcmVjdD4KICAgICAgICA8L2c+CiAgICA8L2c+Cjwvc3ZnPg=="
														class="center-right">
												</div>
												<div data-v-18da170e="" class="card-body-team">
													<img data-v-18da170e=""
														src="//yuanjududu.com//file/0be89c2d02d38076606b5d5f268b00b7.png"
														class="team-logo">
												</div>
											</section>
											<div data-v-8d7d541a="" data-v-18da170e=""
												class="odds-group-title">
												<div data-v-8d7d541a="" class="empty-badge">&nbsp;</div>
												<div data-v-8d7d541a="" class="title">获胜者</div>
											</div>
											<section data-v-18da170e="" class="card-footer">
												<div data-v-18da170e="" class="card-odds-btn">
													<div data-v-ba6efc5c="" data-v-18da170e=""
														class="home-match-card-button">
														<div data-v-ba6efc5c="" class="button-dark-border">
															<div data-v-ba6efc5c="" class="button-content">
																<div data-v-ba6efc5c="" class="button-name">TY</div>
																<div data-v-ba6efc5c="" class="button-odds-content">
																	<div data-v-ba6efc5c="" class="odds-rising-icon"></div>
																	<div data-v-ba6efc5c="" class="btn-odds">
																		<span data-v-ba6efc5c="">1.68</span>
																	</div>
																	<div data-v-ba6efc5c="" class="odds-dropping-icon"></div>
																</div>
															</div>
														</div>
													</div>
												</div>
												<div data-v-18da170e="" class="match-status">
													<div data-v-18da170e="" class="match-is-early">
														<div data-v-18da170e="" class="status-icon early-icon"></div>
														<div data-v-18da170e="" class="match-status-text">未开始</div>
													</div>
												</div>
												<div data-v-18da170e="" class="card-odds-btn">
													<div data-v-ba6efc5c="" data-v-18da170e=""
														class="home-match-card-button">
														<div data-v-ba6efc5c="" class="button-dark-border">
															<div data-v-ba6efc5c="" class="button-content">
																<div data-v-ba6efc5c="" class="button-name">Classic</div>
																<div data-v-ba6efc5c="" class="button-odds-content">
																	<div data-v-ba6efc5c="" class="odds-rising-icon"></div>
																	<div data-v-ba6efc5c="" class="btn-odds">
																		<span data-v-ba6efc5c="">2.08</span>
																	</div>
																	<div data-v-ba6efc5c="" class="odds-dropping-icon"></div>
																</div>
															</div>
														</div>
													</div>
												</div>
											</section>
										</div>
										<div data-v-18da170e="" data-v-bf66ef20=""
											class="home-match-card">
											<section data-v-18da170e="" class="card-header">
												<img data-v-18da170e=""
													src="//yuanjududu.com//file/eb8b6c6d7f3c5a78cf74cf3dc0af3cbd.svg"
													width="20px">
												<div data-v-18da170e="" class="tournament-name">
													黄金风暴联赛</div>
												<div data-v-18da170e="" class="match-round">&nbsp;/
													bo2</div>
												<div data-v-18da170e="" class="play-count">+1</div>
											</section>
											<section data-v-18da170e="" class="card-body">
												<div data-v-18da170e="" class="card-body-team">
													<img data-v-18da170e=""
														src="//yuanjududu.com//file/99a9dc22f33577555adf667701bff8ad.png"
														class="team-logo">
												</div>
												<div data-v-18da170e="" class="card-body-center">
													<img data-v-18da170e=""
														src="data:image/svg+xml;base64,PD94bWwgdmVyc2lvbj0iMS4wIiBlbmNvZGluZz0iVVRGLTgiPz4KPHN2ZyB3aWR0aD0iMjRweCIgaGVpZ2h0PSI3OHB4IiB2aWV3Qm94PSIwIDAgMjQgNzgiIHZlcnNpb249IjEuMSIgeG1sbnM9Imh0dHA6Ly93d3cudzMub3JnLzIwMDAvc3ZnIiB4bWxuczp4bGluaz0iaHR0cDovL3d3dy53My5vcmcvMTk5OS94bGluayI+CiAgICA8IS0tIEdlbmVyYXRvcjogU2tldGNoIDQ5LjMgKDUxMTY3KSAtIGh0dHA6Ly93d3cuYm9oZW1pYW5jb2RpbmcuY29tL3NrZXRjaCAtLT4KICAgIDx0aXRsZT7ljaHniYfljLrliIblibLlt6Y8L3RpdGxlPgogICAgPGRlc2M+Q3JlYXRlZCB3aXRoIFNrZXRjaC48L2Rlc2M+CiAgICA8ZGVmcz4KICAgICAgICA8cmFkaWFsR3JhZGllbnQgY3g9IjEwMCUiIGN5PSI1MCUiIGZ4PSIxMDAlIiBmeT0iNTAlIiByPSI5OC44MDMyODc2JSIgZ3JhZGllbnRUcmFuc2Zvcm09InRyYW5zbGF0ZSgxLjAwMDAwMCwwLjUwMDAwMCksc2NhbGUoMS4wMDAwMDAsMC4zMDAwMDApLHJvdGF0ZSgtMTc5Ljk5OTk5OCksc2NhbGUoMS4wMDAwMDAsMS42MzI1MTgpLHRyYW5zbGF0ZSgtMS4wMDAwMDAsLTAuNTAwMDAwKSIgaWQ9InJhZGlhbEdyYWRpZW50LTEiPgogICAgICAgICAgICA8c3RvcCBzdG9wLWNvbG9yPSIjMEMxMjFGIiBvZmZzZXQ9IjAlIj48L3N0b3A+CiAgICAgICAgICAgIDxzdG9wIHN0b3AtY29sb3I9IiMxQTI1MzgiIHN0b3Atb3BhY2l0eT0iMCIgb2Zmc2V0PSIxMDAlIj48L3N0b3A+CiAgICAgICAgPC9yYWRpYWxHcmFkaWVudD4KICAgIDwvZGVmcz4KICAgIDxnIGlkPSLpm7fnq57mioAyLjAtY29weSIgc3Ryb2tlPSJub25lIiBzdHJva2Utd2lkdGg9IjEiIGZpbGw9Im5vbmUiIGZpbGwtcnVsZT0iZXZlbm9kZCIgZmlsbC1vcGFjaXR5PSIwLjMiPgogICAgICAgIDxnIGlkPSJpY29u5YiH5Zu+IiB0cmFuc2Zvcm09InRyYW5zbGF0ZSgtMTEyLjAwMDAwMCwgLTE5NjUuMDAwMDAwKSIgZmlsbD0idXJsKCNyYWRpYWxHcmFkaWVudC0xKSI+CiAgICAgICAgICAgIDxyZWN0IGlkPSLljaHniYfljLrliIblibLlt6YiIHg9IjExMiIgeT0iMTk2NCIgd2lkdGg9IjI0IiBoZWlnaHQ9IjgwIj48L3JlY3Q+CiAgICAgICAgPC9nPgogICAgPC9nPgo8L3N2Zz4="
														class="center-left">
													<div data-v-18da170e="" class="start-time">21:45</div>
													<img data-v-18da170e=""
														src="data:image/svg+xml;base64,PD94bWwgdmVyc2lvbj0iMS4wIiBlbmNvZGluZz0iVVRGLTgiPz4KPHN2ZyB3aWR0aD0iMjRweCIgaGVpZ2h0PSI3OHB4IiB2aWV3Qm94PSIwIDAgMjQgNzgiIHZlcnNpb249IjEuMSIgeG1sbnM9Imh0dHA6Ly93d3cudzMub3JnLzIwMDAvc3ZnIiB4bWxuczp4bGluaz0iaHR0cDovL3d3dy53My5vcmcvMTk5OS94bGluayI+CiAgICA8IS0tIEdlbmVyYXRvcjogU2tldGNoIDQ5LjMgKDUxMTY3KSAtIGh0dHA6Ly93d3cuYm9oZW1pYW5jb2RpbmcuY29tL3NrZXRjaCAtLT4KICAgIDx0aXRsZT7ljaHniYfljLrliIblibLlj7M8L3RpdGxlPgogICAgPGRlc2M+Q3JlYXRlZCB3aXRoIFNrZXRjaC48L2Rlc2M+CiAgICA8ZGVmcz4KICAgICAgICA8cmFkaWFsR3JhZGllbnQgY3g9IjEwMCUiIGN5PSI1MCUiIGZ4PSIxMDAlIiBmeT0iNTAlIiByPSI5OC44MDMyODc2JSIgZ3JhZGllbnRUcmFuc2Zvcm09InRyYW5zbGF0ZSgxLjAwMDAwMCwwLjUwMDAwMCksc2NhbGUoMS4wMDAwMDAsMC4zMDAwMDApLHJvdGF0ZSgtMTc5Ljk5OTk5OCksc2NhbGUoMS4wMDAwMDAsMS42MzI1MTgpLHRyYW5zbGF0ZSgtMS4wMDAwMDAsLTAuNTAwMDAwKSIgaWQ9InJhZGlhbEdyYWRpZW50LTEiPgogICAgICAgICAgICA8c3RvcCBzdG9wLWNvbG9yPSIjMEMxMjFGIiBvZmZzZXQ9IjAlIj48L3N0b3A+CiAgICAgICAgICAgIDxzdG9wIHN0b3AtY29sb3I9IiMxQTI1MzgiIHN0b3Atb3BhY2l0eT0iMCIgb2Zmc2V0PSIxMDAlIj48L3N0b3A+CiAgICAgICAgPC9yYWRpYWxHcmFkaWVudD4KICAgIDwvZGVmcz4KICAgIDxnIGlkPSLpm7fnq57mioAyLjAtY29weSIgc3Ryb2tlPSJub25lIiBzdHJva2Utd2lkdGg9IjEiIGZpbGw9Im5vbmUiIGZpbGwtcnVsZT0iZXZlbm9kZCIgZmlsbC1vcGFjaXR5PSIwLjMiPgogICAgICAgIDxnIGlkPSJpY29u5YiH5Zu+IiB0cmFuc2Zvcm09InRyYW5zbGF0ZSgtMTc2LjAwMDAwMCwgLTE5NjUuMDAwMDAwKSIgZmlsbD0idXJsKCNyYWRpYWxHcmFkaWVudC0xKSI+CiAgICAgICAgICAgIDxyZWN0IGlkPSLljaHniYfljLrliIblibLlj7MiIHRyYW5zZm9ybT0idHJhbnNsYXRlKDE4OC4wMDAwMDAsIDIwMDQuMDAwMDAwKSBzY2FsZSgtMSwgMSkgdHJhbnNsYXRlKC0xODguMDAwMDAwLCAtMjAwNC4wMDAwMDApICIgeD0iMTc2IiB5PSIxOTY0IiB3aWR0aD0iMjQiIGhlaWdodD0iODAiPjwvcmVjdD4KICAgICAgICA8L2c+CiAgICA8L2c+Cjwvc3ZnPg=="
														class="center-right">
												</div>
												<div data-v-18da170e="" class="card-body-team">
													<img data-v-18da170e=""
														src="//yuanjududu.com//file/6c161356782670675c428768d2f3cebe.png"
														class="team-logo">
												</div>
											</section>
											<div data-v-8d7d541a="" data-v-18da170e=""
												class="odds-group-title">
												<div data-v-8d7d541a="" class="empty-badge">&nbsp;</div>
												<div data-v-8d7d541a="" class="title">获胜者</div>
											</div>
											<section data-v-18da170e="" class="card-footer">
												<div data-v-18da170e="" class="card-odds-btn">
													<div data-v-ba6efc5c="" data-v-18da170e=""
														class="home-match-card-button btn-locked">
														<div data-v-ba6efc5c="" class="button-dark-border">
															<div data-v-ba6efc5c="" class="button-content">
																<div data-v-ba6efc5c="" class="button-name">CE</div>
																<div data-v-ba6efc5c="" class="button-odds-content">
																	<div data-v-ba6efc5c="" class="odds-rising-icon"></div>
																	<div data-v-ba6efc5c="" class="btn-odds">
																		<!---->
																	</div>
																	<div data-v-ba6efc5c="" class="odds-dropping-icon"></div>
																</div>
															</div>
														</div>
													</div>
												</div>
												<div data-v-18da170e="" class="match-status">
													<div data-v-18da170e="" class="match-is-early">
														<div data-v-18da170e="" class="status-icon early-icon"></div>
														<div data-v-18da170e="" class="match-status-text">未开始</div>
													</div>
												</div>
												<div data-v-18da170e="" class="card-odds-btn">
													<div data-v-ba6efc5c="" data-v-18da170e=""
														class="home-match-card-button btn-locked">
														<div data-v-ba6efc5c="" class="button-dark-border">
															<div data-v-ba6efc5c="" class="button-content">
																<div data-v-ba6efc5c="" class="button-name">RPG</div>
																<div data-v-ba6efc5c="" class="button-odds-content">
																	<div data-v-ba6efc5c="" class="odds-rising-icon"></div>
																	<div data-v-ba6efc5c="" class="btn-odds">
																		<!---->
																	</div>
																	<div data-v-ba6efc5c="" class="odds-dropping-icon"></div>
																</div>
															</div>
														</div>
													</div>
												</div>
											</section>
										</div>
										<div data-v-18da170e="" data-v-bf66ef20=""
											class="home-match-card">
											<section data-v-18da170e="" class="card-header">
												<img data-v-18da170e=""
													src="//yuanjududu.com//file/98c6eb475bf90d035c0d6b7f31fd59d0.svg"
													width="20px">
												<div data-v-18da170e="" class="tournament-name">
													Kalashnikov CUP</div>
												<div data-v-18da170e="" class="match-round">&nbsp;/
													bo1</div>
												<div data-v-18da170e="" class="play-count">+11</div>
											</section>
											<section data-v-18da170e="" class="card-body">
												<div data-v-18da170e="" class="card-body-team">
													<img data-v-18da170e=""
														src="//yuanjududu.com//file/cfb802c760936ae9a5a8e232c4e3cdec.png"
														class="team-logo">
												</div>
												<div data-v-18da170e="" class="card-body-center">
													<img data-v-18da170e=""
														src="data:image/svg+xml;base64,PD94bWwgdmVyc2lvbj0iMS4wIiBlbmNvZGluZz0iVVRGLTgiPz4KPHN2ZyB3aWR0aD0iMjRweCIgaGVpZ2h0PSI3OHB4IiB2aWV3Qm94PSIwIDAgMjQgNzgiIHZlcnNpb249IjEuMSIgeG1sbnM9Imh0dHA6Ly93d3cudzMub3JnLzIwMDAvc3ZnIiB4bWxuczp4bGluaz0iaHR0cDovL3d3dy53My5vcmcvMTk5OS94bGluayI+CiAgICA8IS0tIEdlbmVyYXRvcjogU2tldGNoIDQ5LjMgKDUxMTY3KSAtIGh0dHA6Ly93d3cuYm9oZW1pYW5jb2RpbmcuY29tL3NrZXRjaCAtLT4KICAgIDx0aXRsZT7ljaHniYfljLrliIblibLlt6Y8L3RpdGxlPgogICAgPGRlc2M+Q3JlYXRlZCB3aXRoIFNrZXRjaC48L2Rlc2M+CiAgICA8ZGVmcz4KICAgICAgICA8cmFkaWFsR3JhZGllbnQgY3g9IjEwMCUiIGN5PSI1MCUiIGZ4PSIxMDAlIiBmeT0iNTAlIiByPSI5OC44MDMyODc2JSIgZ3JhZGllbnRUcmFuc2Zvcm09InRyYW5zbGF0ZSgxLjAwMDAwMCwwLjUwMDAwMCksc2NhbGUoMS4wMDAwMDAsMC4zMDAwMDApLHJvdGF0ZSgtMTc5Ljk5OTk5OCksc2NhbGUoMS4wMDAwMDAsMS42MzI1MTgpLHRyYW5zbGF0ZSgtMS4wMDAwMDAsLTAuNTAwMDAwKSIgaWQ9InJhZGlhbEdyYWRpZW50LTEiPgogICAgICAgICAgICA8c3RvcCBzdG9wLWNvbG9yPSIjMEMxMjFGIiBvZmZzZXQ9IjAlIj48L3N0b3A+CiAgICAgICAgICAgIDxzdG9wIHN0b3AtY29sb3I9IiMxQTI1MzgiIHN0b3Atb3BhY2l0eT0iMCIgb2Zmc2V0PSIxMDAlIj48L3N0b3A+CiAgICAgICAgPC9yYWRpYWxHcmFkaWVudD4KICAgIDwvZGVmcz4KICAgIDxnIGlkPSLpm7fnq57mioAyLjAtY29weSIgc3Ryb2tlPSJub25lIiBzdHJva2Utd2lkdGg9IjEiIGZpbGw9Im5vbmUiIGZpbGwtcnVsZT0iZXZlbm9kZCIgZmlsbC1vcGFjaXR5PSIwLjMiPgogICAgICAgIDxnIGlkPSJpY29u5YiH5Zu+IiB0cmFuc2Zvcm09InRyYW5zbGF0ZSgtMTEyLjAwMDAwMCwgLTE5NjUuMDAwMDAwKSIgZmlsbD0idXJsKCNyYWRpYWxHcmFkaWVudC0xKSI+CiAgICAgICAgICAgIDxyZWN0IGlkPSLljaHniYfljLrliIblibLlt6YiIHg9IjExMiIgeT0iMTk2NCIgd2lkdGg9IjI0IiBoZWlnaHQ9IjgwIj48L3JlY3Q+CiAgICAgICAgPC9nPgogICAgPC9nPgo8L3N2Zz4="
														class="center-left">
													<div data-v-18da170e="" class="start-time">22:00</div>
													<img data-v-18da170e=""
														src="data:image/svg+xml;base64,PD94bWwgdmVyc2lvbj0iMS4wIiBlbmNvZGluZz0iVVRGLTgiPz4KPHN2ZyB3aWR0aD0iMjRweCIgaGVpZ2h0PSI3OHB4IiB2aWV3Qm94PSIwIDAgMjQgNzgiIHZlcnNpb249IjEuMSIgeG1sbnM9Imh0dHA6Ly93d3cudzMub3JnLzIwMDAvc3ZnIiB4bWxuczp4bGluaz0iaHR0cDovL3d3dy53My5vcmcvMTk5OS94bGluayI+CiAgICA8IS0tIEdlbmVyYXRvcjogU2tldGNoIDQ5LjMgKDUxMTY3KSAtIGh0dHA6Ly93d3cuYm9oZW1pYW5jb2RpbmcuY29tL3NrZXRjaCAtLT4KICAgIDx0aXRsZT7ljaHniYfljLrliIblibLlj7M8L3RpdGxlPgogICAgPGRlc2M+Q3JlYXRlZCB3aXRoIFNrZXRjaC48L2Rlc2M+CiAgICA8ZGVmcz4KICAgICAgICA8cmFkaWFsR3JhZGllbnQgY3g9IjEwMCUiIGN5PSI1MCUiIGZ4PSIxMDAlIiBmeT0iNTAlIiByPSI5OC44MDMyODc2JSIgZ3JhZGllbnRUcmFuc2Zvcm09InRyYW5zbGF0ZSgxLjAwMDAwMCwwLjUwMDAwMCksc2NhbGUoMS4wMDAwMDAsMC4zMDAwMDApLHJvdGF0ZSgtMTc5Ljk5OTk5OCksc2NhbGUoMS4wMDAwMDAsMS42MzI1MTgpLHRyYW5zbGF0ZSgtMS4wMDAwMDAsLTAuNTAwMDAwKSIgaWQ9InJhZGlhbEdyYWRpZW50LTEiPgogICAgICAgICAgICA8c3RvcCBzdG9wLWNvbG9yPSIjMEMxMjFGIiBvZmZzZXQ9IjAlIj48L3N0b3A+CiAgICAgICAgICAgIDxzdG9wIHN0b3AtY29sb3I9IiMxQTI1MzgiIHN0b3Atb3BhY2l0eT0iMCIgb2Zmc2V0PSIxMDAlIj48L3N0b3A+CiAgICAgICAgPC9yYWRpYWxHcmFkaWVudD4KICAgIDwvZGVmcz4KICAgIDxnIGlkPSLpm7fnq57mioAyLjAtY29weSIgc3Ryb2tlPSJub25lIiBzdHJva2Utd2lkdGg9IjEiIGZpbGw9Im5vbmUiIGZpbGwtcnVsZT0iZXZlbm9kZCIgZmlsbC1vcGFjaXR5PSIwLjMiPgogICAgICAgIDxnIGlkPSJpY29u5YiH5Zu+IiB0cmFuc2Zvcm09InRyYW5zbGF0ZSgtMTc2LjAwMDAwMCwgLTE5NjUuMDAwMDAwKSIgZmlsbD0idXJsKCNyYWRpYWxHcmFkaWVudC0xKSI+CiAgICAgICAgICAgIDxyZWN0IGlkPSLljaHniYfljLrliIblibLlj7MiIHRyYW5zZm9ybT0idHJhbnNsYXRlKDE4OC4wMDAwMDAsIDIwMDQuMDAwMDAwKSBzY2FsZSgtMSwgMSkgdHJhbnNsYXRlKC0xODguMDAwMDAwLCAtMjAwNC4wMDAwMDApICIgeD0iMTc2IiB5PSIxOTY0IiB3aWR0aD0iMjQiIGhlaWdodD0iODAiPjwvcmVjdD4KICAgICAgICA8L2c+CiAgICA8L2c+Cjwvc3ZnPg=="
														class="center-right">
												</div>
												<div data-v-18da170e="" class="card-body-team">
													<img data-v-18da170e=""
														src="//yuanjududu.com//file/4b0842c8613684c92ce1dec49db73149.png"
														class="team-logo">
												</div>
											</section>
											<div data-v-8d7d541a="" data-v-18da170e=""
												class="odds-group-title">
												<div data-v-8d7d541a="" class="empty-badge">&nbsp;</div>
												<div data-v-8d7d541a="" class="title">获胜者</div>
											</div>
											<section data-v-18da170e="" class="card-footer">
												<div data-v-18da170e="" class="card-odds-btn">
													<div data-v-ba6efc5c="" data-v-18da170e=""
														class="home-match-card-button">
														<div data-v-ba6efc5c="" class="button-dark-border">
															<div data-v-ba6efc5c="" class="button-content">
																<div data-v-ba6efc5c="" class="button-name">LDLC</div>
																<div data-v-ba6efc5c="" class="button-odds-content">
																	<div data-v-ba6efc5c="" class="odds-rising-icon"></div>
																	<div data-v-ba6efc5c="" class="btn-odds">
																		<span data-v-ba6efc5c="">1.44</span>
																	</div>
																	<div data-v-ba6efc5c="" class="odds-dropping-icon"></div>
																</div>
															</div>
														</div>
													</div>
												</div>
												<div data-v-18da170e="" class="match-status">
													<div data-v-18da170e="" class="match-is-early">
														<div data-v-18da170e="" class="status-icon early-icon"></div>
														<div data-v-18da170e="" class="match-status-text">未开始</div>
													</div>
												</div>
												<div data-v-18da170e="" class="card-odds-btn">
													<div data-v-ba6efc5c="" data-v-18da170e=""
														class="home-match-card-button">
														<div data-v-ba6efc5c="" class="button-dark-border">
															<div data-v-ba6efc5c="" class="button-content">
																<div data-v-ba6efc5c="" class="button-name">Tempo
																	Storm</div>
																<div data-v-ba6efc5c="" class="button-odds-content">
																	<div data-v-ba6efc5c="" class="odds-rising-icon"></div>
																	<div data-v-ba6efc5c="" class="btn-odds">
																		<span data-v-ba6efc5c="">2.63</span>
																	</div>
																	<div data-v-ba6efc5c="" class="odds-dropping-icon"></div>
																</div>
															</div>
														</div>
													</div>
												</div>
											</section>
										</div>
										<div data-v-18da170e="" data-v-bf66ef20=""
											class="home-match-card">
											<section data-v-18da170e="" class="card-header">
												<img data-v-18da170e=""
													src="//yuanjududu.com//file/2f657b4e0d2854ce02cd7220e002981f.svg"
													width="20px">
												<div data-v-18da170e="" class="tournament-name">
													Onpoong大师赛</div>
												<div data-v-18da170e="" class="match-round">&nbsp;/
													bo7</div>
												<div data-v-18da170e="" class="play-count">+1</div>
											</section>
											<section data-v-18da170e="" class="card-body">
												<div data-v-18da170e="" class="card-body-team">
													<img data-v-18da170e=""
														src="//yuanjududu.com//file/fbbe8d83b03c3a3248b2db43f47cefa5.png"
														class="team-logo">
												</div>
												<div data-v-18da170e="" class="card-body-center">
													<img data-v-18da170e=""
														src="data:image/svg+xml;base64,PD94bWwgdmVyc2lvbj0iMS4wIiBlbmNvZGluZz0iVVRGLTgiPz4KPHN2ZyB3aWR0aD0iMjRweCIgaGVpZ2h0PSI3OHB4IiB2aWV3Qm94PSIwIDAgMjQgNzgiIHZlcnNpb249IjEuMSIgeG1sbnM9Imh0dHA6Ly93d3cudzMub3JnLzIwMDAvc3ZnIiB4bWxuczp4bGluaz0iaHR0cDovL3d3dy53My5vcmcvMTk5OS94bGluayI+CiAgICA8IS0tIEdlbmVyYXRvcjogU2tldGNoIDQ5LjMgKDUxMTY3KSAtIGh0dHA6Ly93d3cuYm9oZW1pYW5jb2RpbmcuY29tL3NrZXRjaCAtLT4KICAgIDx0aXRsZT7ljaHniYfljLrliIblibLlt6Y8L3RpdGxlPgogICAgPGRlc2M+Q3JlYXRlZCB3aXRoIFNrZXRjaC48L2Rlc2M+CiAgICA8ZGVmcz4KICAgICAgICA8cmFkaWFsR3JhZGllbnQgY3g9IjEwMCUiIGN5PSI1MCUiIGZ4PSIxMDAlIiBmeT0iNTAlIiByPSI5OC44MDMyODc2JSIgZ3JhZGllbnRUcmFuc2Zvcm09InRyYW5zbGF0ZSgxLjAwMDAwMCwwLjUwMDAwMCksc2NhbGUoMS4wMDAwMDAsMC4zMDAwMDApLHJvdGF0ZSgtMTc5Ljk5OTk5OCksc2NhbGUoMS4wMDAwMDAsMS42MzI1MTgpLHRyYW5zbGF0ZSgtMS4wMDAwMDAsLTAuNTAwMDAwKSIgaWQ9InJhZGlhbEdyYWRpZW50LTEiPgogICAgICAgICAgICA8c3RvcCBzdG9wLWNvbG9yPSIjMEMxMjFGIiBvZmZzZXQ9IjAlIj48L3N0b3A+CiAgICAgICAgICAgIDxzdG9wIHN0b3AtY29sb3I9IiMxQTI1MzgiIHN0b3Atb3BhY2l0eT0iMCIgb2Zmc2V0PSIxMDAlIj48L3N0b3A+CiAgICAgICAgPC9yYWRpYWxHcmFkaWVudD4KICAgIDwvZGVmcz4KICAgIDxnIGlkPSLpm7fnq57mioAyLjAtY29weSIgc3Ryb2tlPSJub25lIiBzdHJva2Utd2lkdGg9IjEiIGZpbGw9Im5vbmUiIGZpbGwtcnVsZT0iZXZlbm9kZCIgZmlsbC1vcGFjaXR5PSIwLjMiPgogICAgICAgIDxnIGlkPSJpY29u5YiH5Zu+IiB0cmFuc2Zvcm09InRyYW5zbGF0ZSgtMTEyLjAwMDAwMCwgLTE5NjUuMDAwMDAwKSIgZmlsbD0idXJsKCNyYWRpYWxHcmFkaWVudC0xKSI+CiAgICAgICAgICAgIDxyZWN0IGlkPSLljaHniYfljLrliIblibLlt6YiIHg9IjExMiIgeT0iMTk2NCIgd2lkdGg9IjI0IiBoZWlnaHQ9IjgwIj48L3JlY3Q+CiAgICAgICAgPC9nPgogICAgPC9nPgo8L3N2Zz4="
														class="center-left">
													<div data-v-18da170e="" class="start-time">22:00</div>
													<img data-v-18da170e=""
														src="data:image/svg+xml;base64,PD94bWwgdmVyc2lvbj0iMS4wIiBlbmNvZGluZz0iVVRGLTgiPz4KPHN2ZyB3aWR0aD0iMjRweCIgaGVpZ2h0PSI3OHB4IiB2aWV3Qm94PSIwIDAgMjQgNzgiIHZlcnNpb249IjEuMSIgeG1sbnM9Imh0dHA6Ly93d3cudzMub3JnLzIwMDAvc3ZnIiB4bWxuczp4bGluaz0iaHR0cDovL3d3dy53My5vcmcvMTk5OS94bGluayI+CiAgICA8IS0tIEdlbmVyYXRvcjogU2tldGNoIDQ5LjMgKDUxMTY3KSAtIGh0dHA6Ly93d3cuYm9oZW1pYW5jb2RpbmcuY29tL3NrZXRjaCAtLT4KICAgIDx0aXRsZT7ljaHniYfljLrliIblibLlj7M8L3RpdGxlPgogICAgPGRlc2M+Q3JlYXRlZCB3aXRoIFNrZXRjaC48L2Rlc2M+CiAgICA8ZGVmcz4KICAgICAgICA8cmFkaWFsR3JhZGllbnQgY3g9IjEwMCUiIGN5PSI1MCUiIGZ4PSIxMDAlIiBmeT0iNTAlIiByPSI5OC44MDMyODc2JSIgZ3JhZGllbnRUcmFuc2Zvcm09InRyYW5zbGF0ZSgxLjAwMDAwMCwwLjUwMDAwMCksc2NhbGUoMS4wMDAwMDAsMC4zMDAwMDApLHJvdGF0ZSgtMTc5Ljk5OTk5OCksc2NhbGUoMS4wMDAwMDAsMS42MzI1MTgpLHRyYW5zbGF0ZSgtMS4wMDAwMDAsLTAuNTAwMDAwKSIgaWQ9InJhZGlhbEdyYWRpZW50LTEiPgogICAgICAgICAgICA8c3RvcCBzdG9wLWNvbG9yPSIjMEMxMjFGIiBvZmZzZXQ9IjAlIj48L3N0b3A+CiAgICAgICAgICAgIDxzdG9wIHN0b3AtY29sb3I9IiMxQTI1MzgiIHN0b3Atb3BhY2l0eT0iMCIgb2Zmc2V0PSIxMDAlIj48L3N0b3A+CiAgICAgICAgPC9yYWRpYWxHcmFkaWVudD4KICAgIDwvZGVmcz4KICAgIDxnIGlkPSLpm7fnq57mioAyLjAtY29weSIgc3Ryb2tlPSJub25lIiBzdHJva2Utd2lkdGg9IjEiIGZpbGw9Im5vbmUiIGZpbGwtcnVsZT0iZXZlbm9kZCIgZmlsbC1vcGFjaXR5PSIwLjMiPgogICAgICAgIDxnIGlkPSJpY29u5YiH5Zu+IiB0cmFuc2Zvcm09InRyYW5zbGF0ZSgtMTc2LjAwMDAwMCwgLTE5NjUuMDAwMDAwKSIgZmlsbD0idXJsKCNyYWRpYWxHcmFkaWVudC0xKSI+CiAgICAgICAgICAgIDxyZWN0IGlkPSLljaHniYfljLrliIblibLlj7MiIHRyYW5zZm9ybT0idHJhbnNsYXRlKDE4OC4wMDAwMDAsIDIwMDQuMDAwMDAwKSBzY2FsZSgtMSwgMSkgdHJhbnNsYXRlKC0xODguMDAwMDAwLCAtMjAwNC4wMDAwMDApICIgeD0iMTc2IiB5PSIxOTY0IiB3aWR0aD0iMjQiIGhlaWdodD0iODAiPjwvcmVjdD4KICAgICAgICA8L2c+CiAgICA8L2c+Cjwvc3ZnPg=="
														class="center-right">
												</div>
												<div data-v-18da170e="" class="card-body-team">
													<img data-v-18da170e=""
														src="//yuanjududu.com//file/44a50f272668953c8d41c79536a2b3a2.png"
														class="team-logo">
												</div>
											</section>
											<div data-v-8d7d541a="" data-v-18da170e=""
												class="odds-group-title">
												<div data-v-8d7d541a="" class="empty-badge">&nbsp;</div>
												<div data-v-8d7d541a="" class="title">获胜者</div>
											</div>
											<section data-v-18da170e="" class="card-footer">
												<div data-v-18da170e="" class="card-odds-btn">
													<div data-v-ba6efc5c="" data-v-18da170e=""
														class="home-match-card-button">
														<div data-v-ba6efc5c="" class="button-dark-border">
															<div data-v-ba6efc5c="" class="button-content">
																<div data-v-ba6efc5c="" class="button-name">Solar</div>
																<div data-v-ba6efc5c="" class="button-odds-content">
																	<div data-v-ba6efc5c="" class="odds-rising-icon"></div>
																	<div data-v-ba6efc5c="" class="btn-odds">
																		<span data-v-ba6efc5c="">1.50</span>
																	</div>
																	<div data-v-ba6efc5c="" class="odds-dropping-icon"></div>
																</div>
															</div>
														</div>
													</div>
												</div>
												<div data-v-18da170e="" class="match-status">
													<div data-v-18da170e="" class="match-is-early">
														<div data-v-18da170e="" class="status-icon early-icon"></div>
														<div data-v-18da170e="" class="match-status-text">未开始</div>
													</div>
												</div>
												<div data-v-18da170e="" class="card-odds-btn">
													<div data-v-ba6efc5c="" data-v-18da170e=""
														class="home-match-card-button">
														<div data-v-ba6efc5c="" class="button-dark-border">
															<div data-v-ba6efc5c="" class="button-content">
																<div data-v-ba6efc5c="" class="button-name">Zest</div>
																<div data-v-ba6efc5c="" class="button-odds-content">
																	<div data-v-ba6efc5c="" class="odds-rising-icon"></div>
																	<div data-v-ba6efc5c="" class="btn-odds">
																		<span data-v-ba6efc5c="">2.45</span>
																	</div>
																	<div data-v-ba6efc5c="" class="odds-dropping-icon"></div>
																</div>
															</div>
														</div>
													</div>
												</div>
											</section>
										</div>
										<div data-v-18da170e="" data-v-bf66ef20=""
											class="home-match-card">
											<section data-v-18da170e="" class="card-header">
												<img data-v-18da170e=""
													src="//yuanjududu.com//file/98c6eb475bf90d035c0d6b7f31fd59d0.svg"
													width="20px">
												<div data-v-18da170e="" class="tournament-name">GG.B
													Summer</div>
												<div data-v-18da170e="" class="match-round">&nbsp;/
													bo3</div>
												<div data-v-18da170e="" class="play-count">+25</div>
											</section>
											<section data-v-18da170e="" class="card-body">
												<div data-v-18da170e="" class="card-body-team">
													<img data-v-18da170e=""
														src="//yuanjududu.com//file/65acf076cb2b9584b428c23f771a29a9.png"
														class="team-logo">
												</div>
												<div data-v-18da170e="" class="card-body-center">
													<img data-v-18da170e=""
														src="data:image/svg+xml;base64,PD94bWwgdmVyc2lvbj0iMS4wIiBlbmNvZGluZz0iVVRGLTgiPz4KPHN2ZyB3aWR0aD0iMjRweCIgaGVpZ2h0PSI3OHB4IiB2aWV3Qm94PSIwIDAgMjQgNzgiIHZlcnNpb249IjEuMSIgeG1sbnM9Imh0dHA6Ly93d3cudzMub3JnLzIwMDAvc3ZnIiB4bWxuczp4bGluaz0iaHR0cDovL3d3dy53My5vcmcvMTk5OS94bGluayI+CiAgICA8IS0tIEdlbmVyYXRvcjogU2tldGNoIDQ5LjMgKDUxMTY3KSAtIGh0dHA6Ly93d3cuYm9oZW1pYW5jb2RpbmcuY29tL3NrZXRjaCAtLT4KICAgIDx0aXRsZT7ljaHniYfljLrliIblibLlt6Y8L3RpdGxlPgogICAgPGRlc2M+Q3JlYXRlZCB3aXRoIFNrZXRjaC48L2Rlc2M+CiAgICA8ZGVmcz4KICAgICAgICA8cmFkaWFsR3JhZGllbnQgY3g9IjEwMCUiIGN5PSI1MCUiIGZ4PSIxMDAlIiBmeT0iNTAlIiByPSI5OC44MDMyODc2JSIgZ3JhZGllbnRUcmFuc2Zvcm09InRyYW5zbGF0ZSgxLjAwMDAwMCwwLjUwMDAwMCksc2NhbGUoMS4wMDAwMDAsMC4zMDAwMDApLHJvdGF0ZSgtMTc5Ljk5OTk5OCksc2NhbGUoMS4wMDAwMDAsMS42MzI1MTgpLHRyYW5zbGF0ZSgtMS4wMDAwMDAsLTAuNTAwMDAwKSIgaWQ9InJhZGlhbEdyYWRpZW50LTEiPgogICAgICAgICAgICA8c3RvcCBzdG9wLWNvbG9yPSIjMEMxMjFGIiBvZmZzZXQ9IjAlIj48L3N0b3A+CiAgICAgICAgICAgIDxzdG9wIHN0b3AtY29sb3I9IiMxQTI1MzgiIHN0b3Atb3BhY2l0eT0iMCIgb2Zmc2V0PSIxMDAlIj48L3N0b3A+CiAgICAgICAgPC9yYWRpYWxHcmFkaWVudD4KICAgIDwvZGVmcz4KICAgIDxnIGlkPSLpm7fnq57mioAyLjAtY29weSIgc3Ryb2tlPSJub25lIiBzdHJva2Utd2lkdGg9IjEiIGZpbGw9Im5vbmUiIGZpbGwtcnVsZT0iZXZlbm9kZCIgZmlsbC1vcGFjaXR5PSIwLjMiPgogICAgICAgIDxnIGlkPSJpY29u5YiH5Zu+IiB0cmFuc2Zvcm09InRyYW5zbGF0ZSgtMTEyLjAwMDAwMCwgLTE5NjUuMDAwMDAwKSIgZmlsbD0idXJsKCNyYWRpYWxHcmFkaWVudC0xKSI+CiAgICAgICAgICAgIDxyZWN0IGlkPSLljaHniYfljLrliIblibLlt6YiIHg9IjExMiIgeT0iMTk2NCIgd2lkdGg9IjI0IiBoZWlnaHQ9IjgwIj48L3JlY3Q+CiAgICAgICAgPC9nPgogICAgPC9nPgo8L3N2Zz4="
														class="center-left">
													<div data-v-18da170e="" class="start-time">23:00</div>
													<img data-v-18da170e=""
														src="data:image/svg+xml;base64,PD94bWwgdmVyc2lvbj0iMS4wIiBlbmNvZGluZz0iVVRGLTgiPz4KPHN2ZyB3aWR0aD0iMjRweCIgaGVpZ2h0PSI3OHB4IiB2aWV3Qm94PSIwIDAgMjQgNzgiIHZlcnNpb249IjEuMSIgeG1sbnM9Imh0dHA6Ly93d3cudzMub3JnLzIwMDAvc3ZnIiB4bWxuczp4bGluaz0iaHR0cDovL3d3dy53My5vcmcvMTk5OS94bGluayI+CiAgICA8IS0tIEdlbmVyYXRvcjogU2tldGNoIDQ5LjMgKDUxMTY3KSAtIGh0dHA6Ly93d3cuYm9oZW1pYW5jb2RpbmcuY29tL3NrZXRjaCAtLT4KICAgIDx0aXRsZT7ljaHniYfljLrliIblibLlj7M8L3RpdGxlPgogICAgPGRlc2M+Q3JlYXRlZCB3aXRoIFNrZXRjaC48L2Rlc2M+CiAgICA8ZGVmcz4KICAgICAgICA8cmFkaWFsR3JhZGllbnQgY3g9IjEwMCUiIGN5PSI1MCUiIGZ4PSIxMDAlIiBmeT0iNTAlIiByPSI5OC44MDMyODc2JSIgZ3JhZGllbnRUcmFuc2Zvcm09InRyYW5zbGF0ZSgxLjAwMDAwMCwwLjUwMDAwMCksc2NhbGUoMS4wMDAwMDAsMC4zMDAwMDApLHJvdGF0ZSgtMTc5Ljk5OTk5OCksc2NhbGUoMS4wMDAwMDAsMS42MzI1MTgpLHRyYW5zbGF0ZSgtMS4wMDAwMDAsLTAuNTAwMDAwKSIgaWQ9InJhZGlhbEdyYWRpZW50LTEiPgogICAgICAgICAgICA8c3RvcCBzdG9wLWNvbG9yPSIjMEMxMjFGIiBvZmZzZXQ9IjAlIj48L3N0b3A+CiAgICAgICAgICAgIDxzdG9wIHN0b3AtY29sb3I9IiMxQTI1MzgiIHN0b3Atb3BhY2l0eT0iMCIgb2Zmc2V0PSIxMDAlIj48L3N0b3A+CiAgICAgICAgPC9yYWRpYWxHcmFkaWVudD4KICAgIDwvZGVmcz4KICAgIDxnIGlkPSLpm7fnq57mioAyLjAtY29weSIgc3Ryb2tlPSJub25lIiBzdHJva2Utd2lkdGg9IjEiIGZpbGw9Im5vbmUiIGZpbGwtcnVsZT0iZXZlbm9kZCIgZmlsbC1vcGFjaXR5PSIwLjMiPgogICAgICAgIDxnIGlkPSJpY29u5YiH5Zu+IiB0cmFuc2Zvcm09InRyYW5zbGF0ZSgtMTc2LjAwMDAwMCwgLTE5NjUuMDAwMDAwKSIgZmlsbD0idXJsKCNyYWRpYWxHcmFkaWVudC0xKSI+CiAgICAgICAgICAgIDxyZWN0IGlkPSLljaHniYfljLrliIblibLlj7MiIHRyYW5zZm9ybT0idHJhbnNsYXRlKDE4OC4wMDAwMDAsIDIwMDQuMDAwMDAwKSBzY2FsZSgtMSwgMSkgdHJhbnNsYXRlKC0xODguMDAwMDAwLCAtMjAwNC4wMDAwMDApICIgeD0iMTc2IiB5PSIxOTY0IiB3aWR0aD0iMjQiIGhlaWdodD0iODAiPjwvcmVjdD4KICAgICAgICA8L2c+CiAgICA8L2c+Cjwvc3ZnPg=="
														class="center-right">
												</div>
												<div data-v-18da170e="" class="card-body-team">
													<img data-v-18da170e=""
														src="//yuanjududu.com//file/3843bd3bc0236cf17d8965cce9ee443b.png"
														class="team-logo">
												</div>
											</section>
											<div data-v-8d7d541a="" data-v-18da170e=""
												class="odds-group-title">
												<div data-v-8d7d541a="" class="empty-badge">&nbsp;</div>
												<div data-v-8d7d541a="" class="title">获胜者</div>
											</div>
											<section data-v-18da170e="" class="card-footer">
												<div data-v-18da170e="" class="card-odds-btn">
													<div data-v-ba6efc5c="" data-v-18da170e=""
														class="home-match-card-button">
														<div data-v-ba6efc5c="" class="button-dark-border">
															<div data-v-ba6efc5c="" class="button-content">
																<div data-v-ba6efc5c="" class="button-name">ALTERNATE
																	aTTaX</div>
																<div data-v-ba6efc5c="" class="button-odds-content">
																	<div data-v-ba6efc5c="" class="odds-rising-icon"></div>
																	<div data-v-ba6efc5c="" class="btn-odds">
																		<span data-v-ba6efc5c="">1.47</span>
																	</div>
																	<div data-v-ba6efc5c="" class="odds-dropping-icon"></div>
																</div>
															</div>
														</div>
													</div>
												</div>
												<div data-v-18da170e="" class="match-status">
													<div data-v-18da170e="" class="match-is-early">
														<div data-v-18da170e="" class="status-icon early-icon"></div>
														<div data-v-18da170e="" class="match-status-text">未开始</div>
													</div>
												</div>
												<div data-v-18da170e="" class="card-odds-btn">
													<div data-v-ba6efc5c="" data-v-18da170e=""
														class="home-match-card-button">
														<div data-v-ba6efc5c="" class="button-dark-border">
															<div data-v-ba6efc5c="" class="button-content">
																<div data-v-ba6efc5c="" class="button-name">forZe</div>
																<div data-v-ba6efc5c="" class="button-odds-content">
																	<div data-v-ba6efc5c="" class="odds-rising-icon"></div>
																	<div data-v-ba6efc5c="" class="btn-odds">
																		<span data-v-ba6efc5c="">2.53</span>
																	</div>
																	<div data-v-ba6efc5c="" class="odds-dropping-icon"></div>
																</div>
															</div>
														</div>
													</div>
												</div>
											</section>
										</div>
										<div data-v-18da170e="" data-v-bf66ef20=""
											class="home-match-card">
											<section data-v-18da170e="" class="card-header">
												<img data-v-18da170e=""
													src="//yuanjududu.com//file/98c6eb475bf90d035c0d6b7f31fd59d0.svg"
													width="20px">
												<div data-v-18da170e="" class="tournament-name">
													Kalashnikov CUP</div>
												<div data-v-18da170e="" class="match-round">&nbsp;/
													bo1</div>
												<div data-v-18da170e="" class="play-count">+11</div>
											</section>
											<section data-v-18da170e="" class="card-body">
												<div data-v-18da170e="" class="card-body-team">
													<img data-v-18da170e=""
														src="//yuanjududu.com//file/87a62bd9e9c46087bcb5fb76059f25e0.png"
														class="team-logo">
												</div>
												<div data-v-18da170e="" class="card-body-center">
													<img data-v-18da170e=""
														src="data:image/svg+xml;base64,PD94bWwgdmVyc2lvbj0iMS4wIiBlbmNvZGluZz0iVVRGLTgiPz4KPHN2ZyB3aWR0aD0iMjRweCIgaGVpZ2h0PSI3OHB4IiB2aWV3Qm94PSIwIDAgMjQgNzgiIHZlcnNpb249IjEuMSIgeG1sbnM9Imh0dHA6Ly93d3cudzMub3JnLzIwMDAvc3ZnIiB4bWxuczp4bGluaz0iaHR0cDovL3d3dy53My5vcmcvMTk5OS94bGluayI+CiAgICA8IS0tIEdlbmVyYXRvcjogU2tldGNoIDQ5LjMgKDUxMTY3KSAtIGh0dHA6Ly93d3cuYm9oZW1pYW5jb2RpbmcuY29tL3NrZXRjaCAtLT4KICAgIDx0aXRsZT7ljaHniYfljLrliIblibLlt6Y8L3RpdGxlPgogICAgPGRlc2M+Q3JlYXRlZCB3aXRoIFNrZXRjaC48L2Rlc2M+CiAgICA8ZGVmcz4KICAgICAgICA8cmFkaWFsR3JhZGllbnQgY3g9IjEwMCUiIGN5PSI1MCUiIGZ4PSIxMDAlIiBmeT0iNTAlIiByPSI5OC44MDMyODc2JSIgZ3JhZGllbnRUcmFuc2Zvcm09InRyYW5zbGF0ZSgxLjAwMDAwMCwwLjUwMDAwMCksc2NhbGUoMS4wMDAwMDAsMC4zMDAwMDApLHJvdGF0ZSgtMTc5Ljk5OTk5OCksc2NhbGUoMS4wMDAwMDAsMS42MzI1MTgpLHRyYW5zbGF0ZSgtMS4wMDAwMDAsLTAuNTAwMDAwKSIgaWQ9InJhZGlhbEdyYWRpZW50LTEiPgogICAgICAgICAgICA8c3RvcCBzdG9wLWNvbG9yPSIjMEMxMjFGIiBvZmZzZXQ9IjAlIj48L3N0b3A+CiAgICAgICAgICAgIDxzdG9wIHN0b3AtY29sb3I9IiMxQTI1MzgiIHN0b3Atb3BhY2l0eT0iMCIgb2Zmc2V0PSIxMDAlIj48L3N0b3A+CiAgICAgICAgPC9yYWRpYWxHcmFkaWVudD4KICAgIDwvZGVmcz4KICAgIDxnIGlkPSLpm7fnq57mioAyLjAtY29weSIgc3Ryb2tlPSJub25lIiBzdHJva2Utd2lkdGg9IjEiIGZpbGw9Im5vbmUiIGZpbGwtcnVsZT0iZXZlbm9kZCIgZmlsbC1vcGFjaXR5PSIwLjMiPgogICAgICAgIDxnIGlkPSJpY29u5YiH5Zu+IiB0cmFuc2Zvcm09InRyYW5zbGF0ZSgtMTEyLjAwMDAwMCwgLTE5NjUuMDAwMDAwKSIgZmlsbD0idXJsKCNyYWRpYWxHcmFkaWVudC0xKSI+CiAgICAgICAgICAgIDxyZWN0IGlkPSLljaHniYfljLrliIblibLlt6YiIHg9IjExMiIgeT0iMTk2NCIgd2lkdGg9IjI0IiBoZWlnaHQ9IjgwIj48L3JlY3Q+CiAgICAgICAgPC9nPgogICAgPC9nPgo8L3N2Zz4="
														class="center-left">
													<div data-v-18da170e="" class="start-time">23:00</div>
													<img data-v-18da170e=""
														src="data:image/svg+xml;base64,PD94bWwgdmVyc2lvbj0iMS4wIiBlbmNvZGluZz0iVVRGLTgiPz4KPHN2ZyB3aWR0aD0iMjRweCIgaGVpZ2h0PSI3OHB4IiB2aWV3Qm94PSIwIDAgMjQgNzgiIHZlcnNpb249IjEuMSIgeG1sbnM9Imh0dHA6Ly93d3cudzMub3JnLzIwMDAvc3ZnIiB4bWxuczp4bGluaz0iaHR0cDovL3d3dy53My5vcmcvMTk5OS94bGluayI+CiAgICA8IS0tIEdlbmVyYXRvcjogU2tldGNoIDQ5LjMgKDUxMTY3KSAtIGh0dHA6Ly93d3cuYm9oZW1pYW5jb2RpbmcuY29tL3NrZXRjaCAtLT4KICAgIDx0aXRsZT7ljaHniYfljLrliIblibLlj7M8L3RpdGxlPgogICAgPGRlc2M+Q3JlYXRlZCB3aXRoIFNrZXRjaC48L2Rlc2M+CiAgICA8ZGVmcz4KICAgICAgICA8cmFkaWFsR3JhZGllbnQgY3g9IjEwMCUiIGN5PSI1MCUiIGZ4PSIxMDAlIiBmeT0iNTAlIiByPSI5OC44MDMyODc2JSIgZ3JhZGllbnRUcmFuc2Zvcm09InRyYW5zbGF0ZSgxLjAwMDAwMCwwLjUwMDAwMCksc2NhbGUoMS4wMDAwMDAsMC4zMDAwMDApLHJvdGF0ZSgtMTc5Ljk5OTk5OCksc2NhbGUoMS4wMDAwMDAsMS42MzI1MTgpLHRyYW5zbGF0ZSgtMS4wMDAwMDAsLTAuNTAwMDAwKSIgaWQ9InJhZGlhbEdyYWRpZW50LTEiPgogICAgICAgICAgICA8c3RvcCBzdG9wLWNvbG9yPSIjMEMxMjFGIiBvZmZzZXQ9IjAlIj48L3N0b3A+CiAgICAgICAgICAgIDxzdG9wIHN0b3AtY29sb3I9IiMxQTI1MzgiIHN0b3Atb3BhY2l0eT0iMCIgb2Zmc2V0PSIxMDAlIj48L3N0b3A+CiAgICAgICAgPC9yYWRpYWxHcmFkaWVudD4KICAgIDwvZGVmcz4KICAgIDxnIGlkPSLpm7fnq57mioAyLjAtY29weSIgc3Ryb2tlPSJub25lIiBzdHJva2Utd2lkdGg9IjEiIGZpbGw9Im5vbmUiIGZpbGwtcnVsZT0iZXZlbm9kZCIgZmlsbC1vcGFjaXR5PSIwLjMiPgogICAgICAgIDxnIGlkPSJpY29u5YiH5Zu+IiB0cmFuc2Zvcm09InRyYW5zbGF0ZSgtMTc2LjAwMDAwMCwgLTE5NjUuMDAwMDAwKSIgZmlsbD0idXJsKCNyYWRpYWxHcmFkaWVudC0xKSI+CiAgICAgICAgICAgIDxyZWN0IGlkPSLljaHniYfljLrliIblibLlj7MiIHRyYW5zZm9ybT0idHJhbnNsYXRlKDE4OC4wMDAwMDAsIDIwMDQuMDAwMDAwKSBzY2FsZSgtMSwgMSkgdHJhbnNsYXRlKC0xODguMDAwMDAwLCAtMjAwNC4wMDAwMDApICIgeD0iMTc2IiB5PSIxOTY0IiB3aWR0aD0iMjQiIGhlaWdodD0iODAiPjwvcmVjdD4KICAgICAgICA8L2c+CiAgICA8L2c+Cjwvc3ZnPg=="
														class="center-right">
												</div>
												<div data-v-18da170e="" class="card-body-team">
													<img data-v-18da170e=""
														src="//yuanjududu.com//file/40627ac79157a591534baeba9af49362.png"
														class="team-logo">
												</div>
											</section>
											<div data-v-8d7d541a="" data-v-18da170e=""
												class="odds-group-title">
												<div data-v-8d7d541a="" class="empty-badge">&nbsp;</div>
												<div data-v-8d7d541a="" class="title">获胜者</div>
											</div>
											<section data-v-18da170e="" class="card-footer">
												<div data-v-18da170e="" class="card-odds-btn">
													<div data-v-ba6efc5c="" data-v-18da170e=""
														class="home-match-card-button">
														<div data-v-ba6efc5c="" class="button-dark-border">
															<div data-v-ba6efc5c="" class="button-content">
																<div data-v-ba6efc5c="" class="button-name">X-kom</div>
																<div data-v-ba6efc5c="" class="button-odds-content">
																	<div data-v-ba6efc5c="" class="odds-rising-icon"></div>
																	<div data-v-ba6efc5c="" class="btn-odds">
																		<span data-v-ba6efc5c="">1.60</span>
																	</div>
																	<div data-v-ba6efc5c="" class="odds-dropping-icon"></div>
																</div>
															</div>
														</div>
													</div>
												</div>
												<div data-v-18da170e="" class="match-status">
													<div data-v-18da170e="" class="match-is-early">
														<div data-v-18da170e="" class="status-icon early-icon"></div>
														<div data-v-18da170e="" class="match-status-text">未开始</div>
													</div>
												</div>
												<div data-v-18da170e="" class="card-odds-btn">
													<div data-v-ba6efc5c="" data-v-18da170e=""
														class="home-match-card-button">
														<div data-v-ba6efc5c="" class="button-dark-border">
															<div data-v-ba6efc5c="" class="button-content">
																<div data-v-ba6efc5c="" class="button-name">PACT</div>
																<div data-v-ba6efc5c="" class="button-odds-content">
																	<div data-v-ba6efc5c="" class="odds-rising-icon"></div>
																	<div data-v-ba6efc5c="" class="btn-odds">
																		<span data-v-ba6efc5c="">2.22</span>
																	</div>
																	<div data-v-ba6efc5c="" class="odds-dropping-icon"></div>
																</div>
															</div>
														</div>
													</div>
												</div>
											</section>
										</div></span>
									<div data-v-bf66ef20="" style="height: 60px;"></div>
									<div data-v-bf66ef20="" class="empty-list"
										style="display: none;">
										比赛正在筹备中 <br data-v-bf66ef20=""> <br data-v-bf66ef20="">
										请耐心等待
									</div>
									<!---->
								</div>
								<div
									class="xs-plugin-pulldown-container           xs-plugin-pulldown-loading"
									style="position: absolute; width: 100%; height: 60px; line-height: 60px; top: -60px; text-align: center;">
								</div>
							</div>
							<div class=" xs-fixed-container"></div>
						</div>
						
						<div data-v-bf66ef20="" class="vux-popup-dialog base-popup vux-popup-bottom vux-popup-dialog vux-popup-dialog-bwpzr" style="height: auto; max-height: 70vh;">
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
				</div>
			</div>
		</div>
		<div data-v-60a57f0c="">
			<div data-v-60a57f0c=""
				class="vux-popup-dialog bet-slip-pop vux-popup-bottom vux-popup-show vux-popup-dialog-73jz6"
				style="height: auto;">
				<section data-v-60a57f0c="" class="bet-slip-pop-header">
					<div data-v-60a57f0c="" class="slip-number">1</div>
					<div data-v-60a57f0c="" class="remove-all">删除全部</div>
					<div data-v-60a57f0c="" class="pop-header-text">
						<div data-v-60a57f0c="" class="pop-header-balance">余额</div>
						<div data-v-60a57f0c="">0.00</div>
					</div>
					<div data-v-60a57f0c="" class="pop-header-close"></div>
				</section>
				<section data-v-60a57f0c="" class="bet-slip-pop-body">
					<div data-v-60a57f0c="" class="pop-scroll" id="vux-scroller-bomdf"
						style="touch-action: auto; user-select: none; -webkit-user-drag: none; -webkit-tap-highlight-color: rgba(0, 0, 0, 0); position: relative; overflow: hidden;">
						<div class="xs-container"
							style="transform-origin: 0px 0px 0px; transform: translate(0px, 0px) translateZ(0px);">
							<div data-v-60a57f0c=""
								style="transform-origin: 0px 0px 0px; transform: translate(0px, 0px) scale(1) translateZ(0px);">
								<div data-v-60a57f0c="" class="vux-checker-box odds-list">
									<div data-v-60a57f0c="">
										<div data-v-60a57f0c=""
											class="vux-checker-item odds-item vux-tap-active">
											<div data-v-60a57f0c="" class="odds-list-line"></div>
											<section data-v-60a57f0c="" class="remove-odds">
												<div data-v-60a57f0c="" class="remove-odds-icon"></div>
											</section>
											<section data-v-60a57f0c="" class="odds-item-match">
												<div data-v-60a57f0c="" class="odds-name">SaveBuyBackPlz</div>
												<div data-v-60a57f0c="">全场 获胜者</div>
												<div data-v-60a57f0c="">Athletico Esport - VS -
													SaveBuyBackPlz</div>
											</section>
											<section data-v-60a57f0c="" class="odds-item-money">
												<div data-v-60a57f0c="" class="item-money">
													<div data-v-60a57f0c="" class="money-odds">@3.97</div>
													<div data-v-60a57f0c=""
														class="stake-input stake-input-focus">
														<span data-v-60a57f0c="" class="input-placeholder">输入金额
														</span>
													</div>
												</div>
												<div data-v-60a57f0c="" class="item-return">
													预计还返 <span data-v-60a57f0c="" class="return-amount">0</span>
												</div>
											</section>
										</div>
										<div data-v-90afda32="" data-v-60a57f0c=""
											class="base-Keyboard single-keyboard">
											<div data-v-90afda32="" class="content">
												<div data-v-90afda32="" class="content-number">
													<div data-v-90afda32="">1</div>
												</div>
												<div data-v-90afda32="" class="content-number">
													<div data-v-90afda32="">2</div>
												</div>
												<div data-v-90afda32="" class="content-number">
													<div data-v-90afda32="">3</div>
												</div>
												<div data-v-90afda32="" class="content-number">
													<div data-v-90afda32="">4</div>
												</div>
												<div data-v-90afda32="" class="content-number">
													<div data-v-90afda32="">5</div>
												</div>
												<div data-v-90afda32="" class="content-number">
													<div data-v-90afda32="">6</div>
												</div>
												<div data-v-90afda32="" class="content-number">
													<div data-v-90afda32="">7</div>
												</div>
												<div data-v-90afda32="" class="content-number">
													<div data-v-90afda32="">8</div>
												</div>
												<div data-v-90afda32="" class="content-number">
													<div data-v-90afda32="">9</div>
												</div>
												<div data-v-90afda32="" class="content-number">
													<div data-v-90afda32="">0</div>
												</div>
											</div>
											<div data-v-90afda32="" class="content">
												<div data-v-90afda32="" class="max-btn">
													<div data-v-90afda32="">最大投注</div>
													<!---->
												</div>
												<div data-v-90afda32="" class="del-btn">
													<div data-v-90afda32="" class="del-icon"></div>
												</div>
												<div data-v-90afda32="" class="confirm-btn">
													<div data-v-90afda32="">确认</div>
												</div>
											</div>
										</div>
									</div>
								</div>
								<!---->
							</div>
						</div>
						<div class=" xs-fixed-container"></div>
					</div>
				</section>
				<!---->
			</div>
			<section data-v-60a57f0c="" class="bet-slip-tab">
				<div data-v-60a57f0c="" class="tab-content">
					<div data-v-60a57f0c="" class="content-left">
						<div data-v-60a57f0c="" class="bet-amount">
							<div data-v-60a57f0c="">
								投注金额 <span data-v-60a57f0c="">0.00</span>
							</div>
							<div data-v-60a57f0c="" style="height: 2px;"></div>
							<div data-v-60a57f0c="">
								最高还返 <span data-v-60a57f0c="" class="total-return">0.00</span>
							</div>
						</div>
						<div data-v-60a57f0c="" class="toggle-tab">收起</div>
					</div>
					<div data-v-60a57f0c="" class="bet-btn">确认投注</div>
				</div>
			</section>
			<!---->
			<div data-v-60a57f0c="" class="vux-confirm order-confirm">
				<div class="vux-x-dialog">
					<div class="weui-mask" style="display: none;"></div>
					<div class="weui-dialog" style="display: none;">
						<!---->
						<div class="weui-dialog__bd">
							<div class="content">
								<section class="header color-green">
									<div class="success-icon"></div>
									<div>订单提交成功！</div>
								</section>
								<div id="vux-scroller-xl0ez"
									style="max-height: 60vh; height: 0px; touch-action: auto; user-select: none; -webkit-user-drag: none; -webkit-tap-highlight-color: rgba(0, 0, 0, 0); position: relative; overflow: hidden;">
									<div class="xs-container"
										style="transform-origin: 0px 0px 0px; transform: translate(0px, 0px) translateZ(0px);">
										<div
											style="height: 0px; transform-origin: 0px 0px 0px; transform: translate(0px, 0px) scale(1) translateZ(0px);"></div>
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
		</div>
		<!---->
	</div>
	<script type="text/javascript" async=""
		src="https://www.google-analytics.com/analytics.js"></script>
	<script type="text/javascript" async=""
		src="/_Incapsula_Resource?SWJIYLWA=719d34d31c8e3a6e6fffd425f7e032f3&amp;ns=1&amp;cb=180770595"></script>
	<script async=""
		src="https://www.googletagmanager.com/gtag/js?id=UA-115025704-1"></script>
	<script>
		window.dataLayer = window.dataLayer || []

		function gtag() {
			dataLayer.push(arguments)
		}
		gtag('js', new Date())

		gtag('config', 'UA-115025704-1')
		window
				.addEventListener('load', function() {
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
	<a class="vux-popup-mask" data-uuid=",mfqea,bwpzr,73jz6"
		href="javascript:void(0)" style="z-index: -1;"></a>
	<script type="text/javascript">
		//<![CDATA[
				(
						function() {
							var _analytics_scr = document
									.createElement('script');
							_analytics_scr.type = 'text/javascript';
							_analytics_scr.async = true;
							_analytics_scr.src = '/_Incapsula_Resource?SWJIYLWA=719d34d31c8e3a6e6fffd425f7e032f3&ns=1&cb=180770595';
							var _analytics_elem = document
									.getElementsByTagName('script')[0];
							_analytics_elem.parentNode.insertBefore(
									_analytics_scr, _analytics_elem);
						})();
		// ]]>
	</script>
	<div data-v-60a57f0c="" class="base-confirm v-transfer-dom">
		<div class="vux-confirm">
			<div class="vux-x-dialog">
				<div class="weui-mask" style="display: none;"></div>
				<div class="weui-dialog" style="display: none;">
					<!---->
					<div class="weui-dialog__bd">
						<div class="content warning-content">
							<div class="warning"></div>
							<div>抱歉，您的帐户余额不足，请先存款</div>
						</div>
					</div>
					<div class="weui-dialog__ft">
						<a href="javascript:;"
							class="weui-dialog__btn weui-dialog__btn_default">先看看</a> <a
							href="javascript:;"
							class="weui-dialog__btn weui-dialog__btn_primary">去存款</a>
					</div>
				</div>
			</div>
		</div>
	</div>
</body>
</html>