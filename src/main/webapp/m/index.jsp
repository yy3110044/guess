<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%><!DOCTYPE html>
<html>
<head>
<title>下注列表 - <%=com.yy.guess.util.Util.getConfigCom(application).getWebTitle()%></title>
<%@include file="/m/head-common.jsp"%>
<script src="m/js/mescroll.min.js"></script>
<script src="m/js/index.js"></script>
<link href="m/js/mescroll.min.css" rel="stylesheet">
<style type="text/css">
#vux-scroller-60yre::-webkit-scrollbar{display:none;width:0;height:0;}
</style>
<script>
$(document).ready(function(){initData("${param.type}", <%=com.yy.guess.util.Util.getConfigCom(application).getClientLoadDataInterval()%>);/*初始化*/});
</script>
</head>
<body>
	<div id="app">
		<nav data-v-1db5fc32="" class="app-header">
			<ul data-v-1db5fc32="">
				<li data-v-1db5fc32="" class="notice-count"><a data-v-1db5fc32="" href="m/usercenter/menu.jsp" class="base-icon personal-info"></a></li>
				<li data-v-1db5fc32="" class="home-logo"></li>
				<li data-v-1db5fc32=""><a data-v-e7bb725a="" data-v-1db5fc32="" href="<%=com.yy.guess.util.Util.getConfigCom(application).getCustomerServiceUrl()%>" rel="noopener noreferrer" class="customer-service base-icon service-link"></a></li>
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
										<div data-v-de9ae73a="" onclick="tabBarChange(2, this)" class="vux-tab-item vux-tab-selected" style="border: none; color: rgb(255, 255, 255);">进行中&nbsp;<span data-v-de9ae73a="" class="match-number"></span></div>
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
									<div data-v-cd1e9d3c="" class="games-info"><div data-v-cd1e9d3c="" class="games-icon all-games-icon"></div><div data-v-cd1e9d3c="">全部</div></div>
									<div data-v-cd1e9d3c="" class="selected-checker-light"></div>
								</div>
							</div>
						</div>
					</div>

					<div data-v-bf66ef20="" class="match-card-list">
						<section data-v-bf66ef20="" class="content-hearer"></section>
						<div data-v-bf66ef20="" id="vux-scroller-60yre" class="mescroll" style="touch-action:auto;user-select:none;-webkit-user-drag:none;-webkit-tap-highlight-color:rgba(0, 0, 0, 0);position:relative;overflow:scroll;">
							<div class="xs-container"><div data-v-bf66ef20=""><div data-v-bf66ef20="" id="betListContainer"></div></div></div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</body>
</html>