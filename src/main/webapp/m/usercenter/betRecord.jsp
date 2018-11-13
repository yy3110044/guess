<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%><!DOCTYPE html>
<html>
<head>
<title>下注记录 - <%=com.yy.guess.util.Util.getConfigCom(application).getWebTitle()%></title>
<%@include file="/m/head-common.jsp"%>
<script src="m/js/mescroll.min.js"></script>
<script src="m/js/usercenter.js"></script>
<link href="m/js/mescroll.min.css" rel="stylesheet">
<style type="text/css">
#vux-scroller-6vidl::-webkit-scrollbar{display:none;width:0;height:0;}
.tui-flag{background-image:url('m/images/tui.svg')}
</style>
</head>
<body>
	<div id="app">
		<nav data-v-1db5fc32="" class="app-header">
			<ul data-v-1db5fc32="">
				<li data-v-1db5fc32="" onclick="window.location.href='m/usercenter/menu.jsp'" class="base-icon history-back"></li>
				<li data-v-1db5fc32="">下注记录</li>
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
							<div data-v-1545e424="" id="record-card-container" style="transform-origin: 0px 0px 0px; transform: translate(0px, 0px) scale(1) translateZ(0px);padding-bottom:4px;"></div>
						</div>
						<div class=" xs-fixed-container"></div>
					</div>
				</div>
			</div>
		</div>
	</div>
</body>
</html>