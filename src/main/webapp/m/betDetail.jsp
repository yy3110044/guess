<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%><!DOCTYPE html>
<html>
<head>
<title>下注详情 - <%=com.yy.guess.util.Util.getConfigCom(application).getWebTitle()%></title>
<%@include file="/m/head-common.jsp"%>
<script src="m/js/betDetail.js"></script>
<style type="text/css">
#vux_view_box_body::-webkit-scrollbar{display:none;width:0;height:0;}
.betting-odds .stage-title{height:18px !important;}
</style>
<script>
$(document).ready(function(){initData("${param.versusId}");});
</script>
</head>
<body>
	<div id="app" class="">
		<nav data-v-1db5fc32="" class="app-header">
			<ul data-v-1db5fc32="">
				<li data-v-1db5fc32="" onclick="window.location.href='${basePath}m/index.jsp'" class="base-icon history-back"></li>
				<li data-v-1db5fc32="">游戏竞猜</li>
				<li data-v-1db5fc32="" class="base-icon"></li>
			</ul>
		</nav>
		<div class="weui-tab">
			<div id="vux_view_box_body" class="weui-tab__panel vux-fix-safari-overflow-scrolling" style="padding-bottom:25px !important;">
				<div data-v-31296f00="" class="betting-page router-view">
					<section data-v-31296f00="" class="betting-info">
						<section data-v-31296f00="" class="info-title">
							<img data-v-31296f00="" src="" width="20px">
							<div data-v-31296f00="" class="tournament-name"></div>
							<div data-v-31296f00="" class="match-round"></div>
						</section>
						<section data-v-31296f00="" class="info-team">
							<div data-v-31296f00="" class="team-info left-team"><img data-v-31296f00="" src="" class="team-logo"><div data-v-31296f00="" class="team-name"></div></div>
							<div data-v-31296f00="" class="betting-status"></div>
							<div data-v-31296f00="" class="team-info right-team"><img data-v-31296f00="" src="" class="team-logo"><div data-v-31296f00="" class="team-name"></div></div>
						</section>
					</section>
					<section data-v-31296f00="" class="betting-stage"><div data-v-31296f00="" class="vux-tab-wrap"><div class="vux-tab-container" id="bo_title_div"></div></div></section>
				</div>
			</div>
		</div>
	</div>
</body>
</html>