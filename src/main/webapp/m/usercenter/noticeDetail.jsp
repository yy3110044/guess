<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%><!DOCTYPE html>
<html>
<head>
<title>通知详情 - <%=com.yy.guess.util.Util.getConfigCom(application).getWebTitle()%></title>
<%@include file="/m/head-common.jsp"%>
<script src="m/js/usercenter.js"></script>
<script>var noticeId = "${param.noticeId}";</script>
<style type="text/css">
#vux_view_box_body::-webkit-scrollbar{display:none;width:0;height:0;}
</style>
</head>
<body>
	<div id="app">
		<nav data-v-1db5fc32="" class="app-header">
			<ul data-v-1db5fc32="">
				<li data-v-1db5fc32="" onclick="window.location.href='m/usercenter/notice.jsp'" class="base-icon history-back"></li>
				<li data-v-1db5fc32="">通知详情</li>
				<li data-v-1db5fc32="" class="base-icon"></li>
			</ul>
		</nav>
		<div class="weui-tab">
			<div id="vux_view_box_body" class="weui-tab__panel vux-fix-safari-overflow-scrolling mescroll">
				<div data-v-7c5a7d97="" class="notice-detail router-view">
					<div data-v-7c5a7d97="">
						<section data-v-7c5a7d97="" class="notice-time"></section>
						<section data-v-7c5a7d97="" class="notice-card">
							<div data-v-7c5a7d97="" class="card-header" style="font-size: 1.6rem;"></div>
							<div data-v-7c5a7d97="" class="card-body" style="text-indent:2em;font-size:1.4rem;">
								<div data-v-7c5a7d97="" class="card-body" style="font-size:1.4rem;">金额：2.00</div>
								<div data-v-7c5a7d97="" class="card-body" style="font-size:1.4rem;">订单号：4445484512</div>
								<div data-v-7c5a7d97="" class="card-body" style="font-size:1.4rem;">时间：20151515151</div>
							</div>
						</section>
					</div>
				</div>
			</div>
		</div>
	</div>
</body>
</html>