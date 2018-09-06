<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%><!DOCTYPE html>
<html>
<head>
<title>下注列表 - <%=com.yy.guess.util.Util.getConfigCom(application).getWebTitle()%></title>
<%@include file="/m/head-common.jsp"%>
<script src="m/js/bet.js"></script>
<script>
var balance = 0;
$(document).ready(function(){
	$("#vux-scroller-60yre").height($(window).height() - 132);//设置高度

	$("div.vux-tab-item").on("tap", function(){
		//alert(index);
	});
	
	var str = '';
	for(var i=0; i<100; i++) {
		str += betList();
	}
	$("#betListContainer").append(str);
	
	
	
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
										<div data-v-de9ae73a="" class="vux-tab-item vux-tab-selected" style="border:none;color:rgb(255, 255, 255);">今日<span data-v-de9ae73a="" class="match-number">17</span></div>
										<span data-v-de9ae73a="" class="column-line"></span>
										<div data-v-de9ae73a="" class="vux-tab-item" style="border: none; color: rgb(186, 206, 241);">进行中<span data-v-de9ae73a="" class="match-number">0</span></div>
										<span data-v-de9ae73a="" class="column-line"></span>
										<div data-v-de9ae73a="" class="vux-tab-item" style="border: none; color: rgb(186, 206, 241);">赛前<span data-v-de9ae73a="" class="match-number">57</span></div>
										<span data-v-de9ae73a="" class="column-line"></span>
										<div data-v-de9ae73a="" class="vux-tab-item" style="border: none; color: rgb(186, 206, 241);">已结束</div>
										<span data-v-de9ae73a="" class="column-line"></span>
										<div class="vux-tab-ink-bar vux-tab-ink-bar-transition-backward" style="display:block;height:22px;background-color:transparent;left:0%;right:75%;"></div>
									</div>
								</div>
							</div>
							<div data-v-de9ae73a="" class="show-filter-games-btn"></div>
						</section>
						<section data-v-de9ae73a="" class="filter-games" style="display: none;">
							<div data-v-de9ae73a="" class="hide-filter-games-btn" style="visibility: hidden;">完成</div>
							<div data-v-de9ae73a="">筛选游戏</div>
							<div data-v-de9ae73a="" class="hide-filter-games-btn">
								<div data-v-de9ae73a="" class="btn-content">✓</div>
							</div>
						</section>
					</div>
					
					<div data-v-cd1e9d3c="" data-v-bf66ef20="">
						<div data-v-cd1e9d3c="" class="vux-popup-dialog games-picker vux-popup-top vux-popup-dialog vux-popup-dialog-mfqea" style="height: calc(100% - 92px); display: none;">
							<div data-v-cd1e9d3c="" class="vux-checker-box checker-content">
								<div data-v-cd1e9d3c="" class="default-checker-item selected-checker-item">
									<div data-v-cd1e9d3c="" style="height: 2px;">&nbsp;</div>
									<div data-v-cd1e9d3c="" class="games-info">
										<div data-v-cd1e9d3c="" class="games-icon all-games-icon"></div>
										<div data-v-cd1e9d3c="">全部</div>
									</div>
									<div data-v-cd1e9d3c="" class="selected-checker-light"></div>
								</div>
								<div data-v-cd1e9d3c="" class="vux-checker-item vux-tap-active default-checker-item selected-all-games">
									<div data-v-cd1e9d3c="" style="height: 2px;">&nbsp;</div>
									<div data-v-cd1e9d3c="" class="games-info">
										<div data-v-cd1e9d3c="" class="games-icon" style="background-image: url(&quot;//yuanjududu.com//file/d511f1c87538e99ca914ef559dfa68ba.svg&quot;);"></div>
										<div data-v-cd1e9d3c="">DOTA2</div>
									</div>
									<div data-v-cd1e9d3c="" class="selected-checker-light"></div>
								</div>
								<div data-v-cd1e9d3c="" class="vux-checker-item vux-tap-active default-checker-item selected-all-games">
									<div data-v-cd1e9d3c="" style="height: 2px;">&nbsp;</div>
									<div data-v-cd1e9d3c="" class="games-info">
										<div data-v-cd1e9d3c="" class="games-icon" style="background-image: url(&quot;//yuanjududu.com//file/98c6eb475bf90d035c0d6b7f31fd59d0.svg&quot;);"></div>
										<div data-v-cd1e9d3c="">CSGO</div>
									</div>
									<div data-v-cd1e9d3c="" class="selected-checker-light"></div>
								</div>
								<div data-v-cd1e9d3c="" class="vux-checker-item vux-tap-active default-checker-item selected-all-games">
									<div data-v-cd1e9d3c="" style="height: 2px;">&nbsp;</div>
									<div data-v-cd1e9d3c="" class="games-info">
										<div data-v-cd1e9d3c="" class="games-icon" style="background-image: url(&quot;//yuanjududu.com//file/cb9287b9cbdc7414adeb287df1feeebb.svg&quot;);"></div>
										<div data-v-cd1e9d3c="">英雄联盟</div>
									</div>
									<div data-v-cd1e9d3c="" class="selected-checker-light"></div>
								</div>
								<div data-v-cd1e9d3c="" class="vux-checker-item vux-tap-active default-checker-item selected-all-games">
									<div data-v-cd1e9d3c="" style="height: 2px;">&nbsp;</div>
									<div data-v-cd1e9d3c="" class="games-info">
										<div data-v-cd1e9d3c="" class="games-icon" style="background-image: url(&quot;//yuanjududu.com//file/aebc1f0c88b9eab27a72511d0e1a9d8e.svg&quot;);"></div>
										<div data-v-cd1e9d3c="">王者荣耀</div>
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

						<div data-v-bf66ef20="" id="vux-scroller-60yre" style="touch-action:auto;user-select:none;-webkit-user-drag:none;-webkit-tap-highlight-color:rgba(0, 0, 0, 0);position:relative;overflow:scroll;">
							<div class="xs-container">
								<div data-v-bf66ef20="">
									<div data-v-bf66ef20="" id="betListContainer">

										<div data-v-18da170e="" data-v-bf66ef20="" class="home-match-card">
											<section data-v-18da170e="" class="card-header">
												<img data-v-18da170e="" src="//yuanjududu.com//file/98c6eb475bf90d035c0d6b7f31fd59d0.svg" width="20px">
												<div data-v-18da170e="" class="tournament-name">震中杯 EPICENTER 2018</div>
												<div data-v-18da170e="" class="match-round">&nbsp;/&nbsp;bo3</div>
												<div data-v-18da170e="" class="play-count">+25</div>
											</section>
											<section data-v-18da170e="" class="card-body">
												<div data-v-18da170e="" class="card-body-team"><img data-v-18da170e="" src="//yuanjududu.com//file/3f6ee3d22a5473a0f4460e04deb31c67.png" class="team-logo"></div>
												<div data-v-18da170e="" class="card-body-center">
													<img data-v-18da170e="" src="data:image/svg+xml;base64,PD94bWwgdmVyc2lvbj0iMS4wIiBlbmNvZGluZz0iVVRGLTgiPz4KPHN2ZyB3aWR0aD0iMjRweCIgaGVpZ2h0PSI3OHB4IiB2aWV3Qm94PSIwIDAgMjQgNzgiIHZlcnNpb249IjEuMSIgeG1sbnM9Imh0dHA6Ly93d3cudzMub3JnLzIwMDAvc3ZnIiB4bWxuczp4bGluaz0iaHR0cDovL3d3dy53My5vcmcvMTk5OS94bGluayI+CiAgICA8IS0tIEdlbmVyYXRvcjogU2tldGNoIDQ5LjMgKDUxMTY3KSAtIGh0dHA6Ly93d3cuYm9oZW1pYW5jb2RpbmcuY29tL3NrZXRjaCAtLT4KICAgIDx0aXRsZT7ljaHniYfljLrliIblibLlt6Y8L3RpdGxlPgogICAgPGRlc2M+Q3JlYXRlZCB3aXRoIFNrZXRjaC48L2Rlc2M+CiAgICA8ZGVmcz4KICAgICAgICA8cmFkaWFsR3JhZGllbnQgY3g9IjEwMCUiIGN5PSI1MCUiIGZ4PSIxMDAlIiBmeT0iNTAlIiByPSI5OC44MDMyODc2JSIgZ3JhZGllbnRUcmFuc2Zvcm09InRyYW5zbGF0ZSgxLjAwMDAwMCwwLjUwMDAwMCksc2NhbGUoMS4wMDAwMDAsMC4zMDAwMDApLHJvdGF0ZSgtMTc5Ljk5OTk5OCksc2NhbGUoMS4wMDAwMDAsMS42MzI1MTgpLHRyYW5zbGF0ZSgtMS4wMDAwMDAsLTAuNTAwMDAwKSIgaWQ9InJhZGlhbEdyYWRpZW50LTEiPgogICAgICAgICAgICA8c3RvcCBzdG9wLWNvbG9yPSIjMEMxMjFGIiBvZmZzZXQ9IjAlIj48L3N0b3A+CiAgICAgICAgICAgIDxzdG9wIHN0b3AtY29sb3I9IiMxQTI1MzgiIHN0b3Atb3BhY2l0eT0iMCIgb2Zmc2V0PSIxMDAlIj48L3N0b3A+CiAgICAgICAgPC9yYWRpYWxHcmFkaWVudD4KICAgIDwvZGVmcz4KICAgIDxnIGlkPSLpm7fnq57mioAyLjAtY29weSIgc3Ryb2tlPSJub25lIiBzdHJva2Utd2lkdGg9IjEiIGZpbGw9Im5vbmUiIGZpbGwtcnVsZT0iZXZlbm9kZCIgZmlsbC1vcGFjaXR5PSIwLjMiPgogICAgICAgIDxnIGlkPSJpY29u5YiH5Zu+IiB0cmFuc2Zvcm09InRyYW5zbGF0ZSgtMTEyLjAwMDAwMCwgLTE5NjUuMDAwMDAwKSIgZmlsbD0idXJsKCNyYWRpYWxHcmFkaWVudC0xKSI+CiAgICAgICAgICAgIDxyZWN0IGlkPSLljaHniYfljLrliIblibLlt6YiIHg9IjExMiIgeT0iMTk2NCIgd2lkdGg9IjI0IiBoZWlnaHQ9IjgwIj48L3JlY3Q+CiAgICAgICAgPC9nPgogICAgPC9nPgo8L3N2Zz4=" class="center-left">
													<div data-v-18da170e="" class="start-time">18:10</div>
													<img data-v-18da170e="" src="data:image/svg+xml;base64,PD94bWwgdmVyc2lvbj0iMS4wIiBlbmNvZGluZz0iVVRGLTgiPz4KPHN2ZyB3aWR0aD0iMjRweCIgaGVpZ2h0PSI3OHB4IiB2aWV3Qm94PSIwIDAgMjQgNzgiIHZlcnNpb249IjEuMSIgeG1sbnM9Imh0dHA6Ly93d3cudzMub3JnLzIwMDAvc3ZnIiB4bWxuczp4bGluaz0iaHR0cDovL3d3dy53My5vcmcvMTk5OS94bGluayI+CiAgICA8IS0tIEdlbmVyYXRvcjogU2tldGNoIDQ5LjMgKDUxMTY3KSAtIGh0dHA6Ly93d3cuYm9oZW1pYW5jb2RpbmcuY29tL3NrZXRjaCAtLT4KICAgIDx0aXRsZT7ljaHniYfljLrliIblibLlj7M8L3RpdGxlPgogICAgPGRlc2M+Q3JlYXRlZCB3aXRoIFNrZXRjaC48L2Rlc2M+CiAgICA8ZGVmcz4KICAgICAgICA8cmFkaWFsR3JhZGllbnQgY3g9IjEwMCUiIGN5PSI1MCUiIGZ4PSIxMDAlIiBmeT0iNTAlIiByPSI5OC44MDMyODc2JSIgZ3JhZGllbnRUcmFuc2Zvcm09InRyYW5zbGF0ZSgxLjAwMDAwMCwwLjUwMDAwMCksc2NhbGUoMS4wMDAwMDAsMC4zMDAwMDApLHJvdGF0ZSgtMTc5Ljk5OTk5OCksc2NhbGUoMS4wMDAwMDAsMS42MzI1MTgpLHRyYW5zbGF0ZSgtMS4wMDAwMDAsLTAuNTAwMDAwKSIgaWQ9InJhZGlhbEdyYWRpZW50LTEiPgogICAgICAgICAgICA8c3RvcCBzdG9wLWNvbG9yPSIjMEMxMjFGIiBvZmZzZXQ9IjAlIj48L3N0b3A+CiAgICAgICAgICAgIDxzdG9wIHN0b3AtY29sb3I9IiMxQTI1MzgiIHN0b3Atb3BhY2l0eT0iMCIgb2Zmc2V0PSIxMDAlIj48L3N0b3A+CiAgICAgICAgPC9yYWRpYWxHcmFkaWVudD4KICAgIDwvZGVmcz4KICAgIDxnIGlkPSLpm7fnq57mioAyLjAtY29weSIgc3Ryb2tlPSJub25lIiBzdHJva2Utd2lkdGg9IjEiIGZpbGw9Im5vbmUiIGZpbGwtcnVsZT0iZXZlbm9kZCIgZmlsbC1vcGFjaXR5PSIwLjMiPgogICAgICAgIDxnIGlkPSJpY29u5YiH5Zu+IiB0cmFuc2Zvcm09InRyYW5zbGF0ZSgtMTc2LjAwMDAwMCwgLTE5NjUuMDAwMDAwKSIgZmlsbD0idXJsKCNyYWRpYWxHcmFkaWVudC0xKSI+CiAgICAgICAgICAgIDxyZWN0IGlkPSLljaHniYfljLrliIblibLlj7MiIHRyYW5zZm9ybT0idHJhbnNsYXRlKDE4OC4wMDAwMDAsIDIwMDQuMDAwMDAwKSBzY2FsZSgtMSwgMSkgdHJhbnNsYXRlKC0xODguMDAwMDAwLCAtMjAwNC4wMDAwMDApICIgeD0iMTc2IiB5PSIxOTY0IiB3aWR0aD0iMjQiIGhlaWdodD0iODAiPjwvcmVjdD4KICAgICAgICA8L2c+CiAgICA8L2c+Cjwvc3ZnPg==" class="center-right">
												</div>
												<div data-v-18da170e="" class="card-body-team"><img data-v-18da170e="" src="//yuanjududu.com//file/1c8b7b613eefd276a83219b668722c23.png" class="team-logo"></div>
											</section>
											<div data-v-8d7d541a="" data-v-18da170e="" class="odds-group-title">
												<div data-v-8d7d541a="" class="empty-badge">&nbsp;</div>
												<div data-v-8d7d541a="" class="title">获胜者</div>
											</div>
											<section data-v-18da170e="" class="card-footer">
												<div data-v-18da170e="" class="card-odds-btn">
													<div data-v-ba6efc5c="" data-v-18da170e="" class="home-match-card-button btn-locked">
														<div data-v-ba6efc5c="" class="button-dark-border">
															<div data-v-ba6efc5c="" class="button-content">
																<div data-v-ba6efc5c="" class="button-name">3DMAX</div>
																<div data-v-ba6efc5c="" class="button-odds-content">
																	<div data-v-ba6efc5c="" class="odds-rising-icon"></div>
																	<div data-v-ba6efc5c="" class="btn-odds"></div>
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
													<div data-v-ba6efc5c="" data-v-18da170e="" class="home-match-card-button">
														<div data-v-ba6efc5c="" class="button-dark-border">
															<div data-v-ba6efc5c="" class="button-content">
																<div data-v-ba6efc5c="" class="button-name">Red Reserve</div>
																<div data-v-ba6efc5c="" class="button-odds-content">
																	<div data-v-ba6efc5c="" class="odds-rising-icon"></div>
																	<div data-v-ba6efc5c="" class="btn-odds"><span data-v-ba6efc5c="">1.58</span></div>
																	<div data-v-ba6efc5c="" class="odds-dropping-icon"></div>
																</div>
															</div>
														</div>
													</div>
												</div>
											</section>
										</div>

										<div data-v-18da170e="" data-v-bf66ef20="" class="home-match-card">
											<section data-v-18da170e="" class="card-header">
												<img data-v-18da170e="" src="//yuanjududu.com//file/d511f1c87538e99ca914ef559dfa68ba.svg" width="20px">
												<div data-v-18da170e="" class="tournament-name">ESL ANZ Championship</div>
												<div data-v-18da170e="" class="match-round">&nbsp;/&nbsp;bo1</div>
												<div data-v-18da170e="" class="play-count">+2</div>
											</section>
											<section data-v-18da170e="" class="card-body">
												<div data-v-18da170e="" class="card-body-team">
													<img data-v-18da170e="" src="//yuanjududu.com//file/1672db3ae01e54f06cce4dc44ec6ec7a.png" class="team-logo">
												</div>
												<div data-v-18da170e="" class="card-body-center">
													<img data-v-18da170e="" src="data:image/svg+xml;base64,PD94bWwgdmVyc2lvbj0iMS4wIiBlbmNvZGluZz0iVVRGLTgiPz4KPHN2ZyB3aWR0aD0iMjRweCIgaGVpZ2h0PSI3OHB4IiB2aWV3Qm94PSIwIDAgMjQgNzgiIHZlcnNpb249IjEuMSIgeG1sbnM9Imh0dHA6Ly93d3cudzMub3JnLzIwMDAvc3ZnIiB4bWxuczp4bGluaz0iaHR0cDovL3d3dy53My5vcmcvMTk5OS94bGluayI+CiAgICA8IS0tIEdlbmVyYXRvcjogU2tldGNoIDQ5LjMgKDUxMTY3KSAtIGh0dHA6Ly93d3cuYm9oZW1pYW5jb2RpbmcuY29tL3NrZXRjaCAtLT4KICAgIDx0aXRsZT7ljaHniYfljLrliIblibLlt6Y8L3RpdGxlPgogICAgPGRlc2M+Q3JlYXRlZCB3aXRoIFNrZXRjaC48L2Rlc2M+CiAgICA8ZGVmcz4KICAgICAgICA8cmFkaWFsR3JhZGllbnQgY3g9IjEwMCUiIGN5PSI1MCUiIGZ4PSIxMDAlIiBmeT0iNTAlIiByPSI5OC44MDMyODc2JSIgZ3JhZGllbnRUcmFuc2Zvcm09InRyYW5zbGF0ZSgxLjAwMDAwMCwwLjUwMDAwMCksc2NhbGUoMS4wMDAwMDAsMC4zMDAwMDApLHJvdGF0ZSgtMTc5Ljk5OTk5OCksc2NhbGUoMS4wMDAwMDAsMS42MzI1MTgpLHRyYW5zbGF0ZSgtMS4wMDAwMDAsLTAuNTAwMDAwKSIgaWQ9InJhZGlhbEdyYWRpZW50LTEiPgogICAgICAgICAgICA8c3RvcCBzdG9wLWNvbG9yPSIjMEMxMjFGIiBvZmZzZXQ9IjAlIj48L3N0b3A+CiAgICAgICAgICAgIDxzdG9wIHN0b3AtY29sb3I9IiMxQTI1MzgiIHN0b3Atb3BhY2l0eT0iMCIgb2Zmc2V0PSIxMDAlIj48L3N0b3A+CiAgICAgICAgPC9yYWRpYWxHcmFkaWVudD4KICAgIDwvZGVmcz4KICAgIDxnIGlkPSLpm7fnq57mioAyLjAtY29weSIgc3Ryb2tlPSJub25lIiBzdHJva2Utd2lkdGg9IjEiIGZpbGw9Im5vbmUiIGZpbGwtcnVsZT0iZXZlbm9kZCIgZmlsbC1vcGFjaXR5PSIwLjMiPgogICAgICAgIDxnIGlkPSJpY29u5YiH5Zu+IiB0cmFuc2Zvcm09InRyYW5zbGF0ZSgtMTEyLjAwMDAwMCwgLTE5NjUuMDAwMDAwKSIgZmlsbD0idXJsKCNyYWRpYWxHcmFkaWVudC0xKSI+CiAgICAgICAgICAgIDxyZWN0IGlkPSLljaHniYfljLrliIblibLlt6YiIHg9IjExMiIgeT0iMTk2NCIgd2lkdGg9IjI0IiBoZWlnaHQ9IjgwIj48L3JlY3Q+CiAgICAgICAgPC9nPgogICAgPC9nPgo8L3N2Zz4=" class="center-left">
													<div data-v-18da170e="" class="start-time">18:30</div>
													<img data-v-18da170e="" src="data:image/svg+xml;base64,PD94bWwgdmVyc2lvbj0iMS4wIiBlbmNvZGluZz0iVVRGLTgiPz4KPHN2ZyB3aWR0aD0iMjRweCIgaGVpZ2h0PSI3OHB4IiB2aWV3Qm94PSIwIDAgMjQgNzgiIHZlcnNpb249IjEuMSIgeG1sbnM9Imh0dHA6Ly93d3cudzMub3JnLzIwMDAvc3ZnIiB4bWxuczp4bGluaz0iaHR0cDovL3d3dy53My5vcmcvMTk5OS94bGluayI+CiAgICA8IS0tIEdlbmVyYXRvcjogU2tldGNoIDQ5LjMgKDUxMTY3KSAtIGh0dHA6Ly93d3cuYm9oZW1pYW5jb2RpbmcuY29tL3NrZXRjaCAtLT4KICAgIDx0aXRsZT7ljaHniYfljLrliIblibLlj7M8L3RpdGxlPgogICAgPGRlc2M+Q3JlYXRlZCB3aXRoIFNrZXRjaC48L2Rlc2M+CiAgICA8ZGVmcz4KICAgICAgICA8cmFkaWFsR3JhZGllbnQgY3g9IjEwMCUiIGN5PSI1MCUiIGZ4PSIxMDAlIiBmeT0iNTAlIiByPSI5OC44MDMyODc2JSIgZ3JhZGllbnRUcmFuc2Zvcm09InRyYW5zbGF0ZSgxLjAwMDAwMCwwLjUwMDAwMCksc2NhbGUoMS4wMDAwMDAsMC4zMDAwMDApLHJvdGF0ZSgtMTc5Ljk5OTk5OCksc2NhbGUoMS4wMDAwMDAsMS42MzI1MTgpLHRyYW5zbGF0ZSgtMS4wMDAwMDAsLTAuNTAwMDAwKSIgaWQ9InJhZGlhbEdyYWRpZW50LTEiPgogICAgICAgICAgICA8c3RvcCBzdG9wLWNvbG9yPSIjMEMxMjFGIiBvZmZzZXQ9IjAlIj48L3N0b3A+CiAgICAgICAgICAgIDxzdG9wIHN0b3AtY29sb3I9IiMxQTI1MzgiIHN0b3Atb3BhY2l0eT0iMCIgb2Zmc2V0PSIxMDAlIj48L3N0b3A+CiAgICAgICAgPC9yYWRpYWxHcmFkaWVudD4KICAgIDwvZGVmcz4KICAgIDxnIGlkPSLpm7fnq57mioAyLjAtY29weSIgc3Ryb2tlPSJub25lIiBzdHJva2Utd2lkdGg9IjEiIGZpbGw9Im5vbmUiIGZpbGwtcnVsZT0iZXZlbm9kZCIgZmlsbC1vcGFjaXR5PSIwLjMiPgogICAgICAgIDxnIGlkPSJpY29u5YiH5Zu+IiB0cmFuc2Zvcm09InRyYW5zbGF0ZSgtMTc2LjAwMDAwMCwgLTE5NjUuMDAwMDAwKSIgZmlsbD0idXJsKCNyYWRpYWxHcmFkaWVudC0xKSI+CiAgICAgICAgICAgIDxyZWN0IGlkPSLljaHniYfljLrliIblibLlj7MiIHRyYW5zZm9ybT0idHJhbnNsYXRlKDE4OC4wMDAwMDAsIDIwMDQuMDAwMDAwKSBzY2FsZSgtMSwgMSkgdHJhbnNsYXRlKC0xODguMDAwMDAwLCAtMjAwNC4wMDAwMDApICIgeD0iMTc2IiB5PSIxOTY0IiB3aWR0aD0iMjQiIGhlaWdodD0iODAiPjwvcmVjdD4KICAgICAgICA8L2c+CiAgICA8L2c+Cjwvc3ZnPg==" class="center-right">
												</div>
												<div data-v-18da170e="" class="card-body-team">
													<img data-v-18da170e="" src="//yuanjududu.com//file/2c1bc68e92c4b9f12feb1fe0095bfef1.png" class="team-logo">
												</div>
											</section>
											<div data-v-8d7d541a="" data-v-18da170e="" class="odds-group-title">
												<div data-v-8d7d541a="" class="empty-badge">&nbsp;</div>
												<div data-v-8d7d541a="" class="title">获胜者</div>
											</div>
											<section data-v-18da170e="" class="card-footer">
												<div data-v-18da170e="" class="card-odds-btn">
													<div data-v-ba6efc5c="" data-v-18da170e="" class="home-match-card-button">
														<div data-v-ba6efc5c="" class="button-dark-border">
															<div data-v-ba6efc5c="" class="button-content">
																<div data-v-ba6efc5c="" class="button-name">Athletico Esport</div>
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
										
									</div>
								</div>
							</div>
						</div>

					</div>
				</div>
			</div>
		</div>

		<!--
		<div data-v-60a57f0c="" class="vux-popup-dialog bet-slip-pop vux-popup-bottom vux-popup-show vux-popup-dialog-73jz6" style="height:auto;">
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
				<div data-v-60a57f0c="" class="pop-scroll" id="vux-scroller-bomdf" style="touch-action: auto; user-select: none; -webkit-user-drag: none; -webkit-tap-highlight-color: rgba(0, 0, 0, 0); position: relative; overflow:auto;">
					<div class="xs-container" style="transform-origin: 0px 0px 0px; transform: translate(0px, 0px) translateZ(0px);">
						<div data-v-60a57f0c=""
							style="transform-origin: 0px 0px 0px; transform: translate(0px, 0px) scale(1) translateZ(0px);">
							<div data-v-60a57f0c="" class="vux-checker-box odds-list">
								<div data-v-60a57f0c="">
									<div data-v-60a57f0c="" class="vux-checker-item odds-item vux-tap-active">
										<div data-v-60a57f0c="" class="odds-list-line"></div>
										<section data-v-60a57f0c="" class="remove-odds" style="visibility:hidden;">
											<div data-v-60a57f0c="" class="remove-odds-icon"></div>
										</section>
										<section data-v-60a57f0c="" class="odds-item-match">
											<div data-v-60a57f0c="" class="odds-name">SaveBuyBackPlz</div>
											<div data-v-60a57f0c="">全场 获胜者</div>
											<div data-v-60a57f0c="">Athletico Esport - VS - SaveBuyBackPlz</div>
										</section>
										<section data-v-60a57f0c="" class="odds-item-money">
											<div data-v-60a57f0c="" class="item-money">
												<div data-v-60a57f0c="" class="money-odds">@3.97</div>
												<div data-v-60a57f0c="" class="stake-input stake-input-focus">
													<span data-v-60a57f0c="" class="input-placeholder" id="inputValueSpan" data-value="">输入金额</span>
												</div>
											</div>
											<div data-v-60a57f0c="" class="item-return">预计还返 <span data-v-60a57f0c="" class="return-amount">0</span></div>
										</section>
									</div>
									<div data-v-90afda32="" data-v-60a57f0c="" class="base-Keyboard single-keyboard">
										<div data-v-90afda32="" class="content">
											<div data-v-90afda32="" class="content-number" onclick="numberInput('1')"><div data-v-90afda32="">1</div></div>
											<div data-v-90afda32="" class="content-number" onclick="numberInput('2')"><div data-v-90afda32="">2</div></div>
											<div data-v-90afda32="" class="content-number" onclick="numberInput('3')"><div data-v-90afda32="">3</div></div>
											<div data-v-90afda32="" class="content-number" onclick="numberInput('4')"><div data-v-90afda32="">4</div></div>
											<div data-v-90afda32="" class="content-number" onclick="numberInput('5')"><div data-v-90afda32="">5</div></div>
											<div data-v-90afda32="" class="content-number" onclick="numberInput('6')"><div data-v-90afda32="">6</div></div>
											<div data-v-90afda32="" class="content-number" onclick="numberInput('7')"><div data-v-90afda32="">7</div></div>
											<div data-v-90afda32="" class="content-number" onclick="numberInput('8')"><div data-v-90afda32="">8</div></div>
											<div data-v-90afda32="" class="content-number" onclick="numberInput('9')"><div data-v-90afda32="">9</div></div>
											<div data-v-90afda32="" class="content-number" onclick="numberInput('0')"><div data-v-90afda32="">0</div></div>
										</div>
										<div data-v-90afda32="" class="content">
											<div data-v-90afda32="" class="max-btn">
												<div data-v-90afda32="">最大投注</div>
											</div>
											<div data-v-90afda32="" class="del-btn" onclick="numberInput('x')">
												<div data-v-90afda32="" class="del-icon"></div>
											</div>
											<div data-v-90afda32="" class="confirm-btn">
												<div data-v-90afda32="">确认</div>
											</div>
										</div>
									</div>
								</div>
							</div>
						</div>
					</div>
					<div class=" xs-fixed-container"></div>
				</div>
			</section>
		</div>
		-->

		<!--
		<section data-v-60a57f0c="" class="bet-slip-tab">
			<div data-v-60a57f0c="" class="tab-content">
				<div data-v-60a57f0c="" class="content-left">
					<div data-v-60a57f0c="" class="bet-amount">
						<div data-v-60a57f0c="">投注金额 <span data-v-60a57f0c="">0.00</span></div>
						<div data-v-60a57f0c="" style="height:2px;"></div>
						<div data-v-60a57f0c="">最高还返 <span data-v-60a57f0c="" class="total-return">0.00</span></div>
					</div>
					<div data-v-60a57f0c="" class="toggle-tab">收起</div>
				</div>
				<div data-v-60a57f0c="" class="bet-btn">确认投注</div>
			</div>
		</section>
		-->

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
</body>
</html>