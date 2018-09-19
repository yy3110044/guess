<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%><!DOCTYPE html>
<html>
<head>
<title>用户中心 - <%=com.yy.guess.util.Util.getConfigCom(application).getWebTitle()%></title>
<%@include file="/m/head-common.jsp"%>
<script src="m/js/usercenter.js"></script>
</head>
<body>
	<div id="app">
		<nav data-v-1db5fc32="" class="app-header">
			<ul data-v-1db5fc32="">
				<li data-v-1db5fc32="" onclick="window.location.href='m/index.jsp'" class="base-icon history-back"></li>
				<li data-v-1db5fc32="">个人资料</li>
				<li data-v-1db5fc32=""><a data-v-1db5fc32="" href="javascript:;" class="base-icon account-setting"></a></li>
			</ul>
		</nav>
		<div class="weui-tab dark-view">
			<div id="vux_view_box_body" class="weui-tab__panel vux-fix-safari-overflow-scrolling">
				<div data-v-0df6a7f4="" class="personal-info router-view">
					<section data-v-0df6a7f4="" class="link-list">
						<div data-v-0df6a7f4="">
							<div class="weui-cells vux-no-group-title">
								<div data-v-0df6a7f4="" class="weui-cell user-name" style="height:113px;">
									<div class="weui-cell__hd"></div>
									<div class="vux-cell-bd vux-cell-primary"><p><label class="vux-label">您好!</label></p><span class="vux-label-desc"></span></div>
									<div class="weui-cell__ft"></div>
								</div>
								<div data-v-0df6a7f4="" class="weui-cell vux-tap-active weui-cell_access">
									<div class="weui-cell__hd"><div data-v-0df6a7f4="" class="base-icon wallet-icon"></div></div>
									<div class="vux-cell-bd vux-cell-primary"><p><label class="vux-label">钱包</label></p><span class="vux-label-desc"></span></div>
									<div class="weui-cell__ft"><p data-v-0df6a7f4="" class="wallet-lebal"><span data-v-0df6a7f4="">余额</span><span data-v-0df6a7f4="" class="wallet-lebal-balance"></span></p></div>
								</div>
							</div>
						</div>
						<div data-v-0df6a7f4="">
							<div class="weui-cells vux-no-group-title">
								<div onclick="window.location.href='m/usercenter/betRecord.jsp'" data-v-0df6a7f4="" class="weui-cell vux-tap-active weui-cell_access">
									<div class="weui-cell__hd"><div data-v-0df6a7f4="" class="base-icon bettingrecord-icon"></div></div>
									<div class="vux-cell-bd vux-cell-primary"><p><label class="vux-label">投注记录</label></p><span class="vux-label-desc"></span></div>
									<div class="weui-cell__ft"></div>
								</div>
								<div data-v-0df6a7f4="" class="weui-cell vux-tap-active weui-cell_access">
									<div class="weui-cell__hd"><div data-v-0df6a7f4="" class="base-icon notice-icon"></div></div>
									<div class="vux-cell-bd vux-cell-primary"><p><label class="vux-label">通知</label></p><span class="vux-label-desc"></span></div>
									<div class="weui-cell__ft"></div>
								</div>
								<div data-v-0df6a7f4="" class="weui-cell vux-tap-active weui-cell_access">
									<div class="weui-cell__hd"><div data-v-0df6a7f4="" class="base-icon activity-icon"></div></div>
									<div class="vux-cell-bd vux-cell-primary"><p><label class="vux-label">活动</label></p><span class="vux-label-desc"></span></div>
									<div class="weui-cell__ft"></div>
								</div>
							</div>
						</div>
						<div data-v-0df6a7f4="">
							<div class="weui-cells vux-no-group-title">
								<div data-v-0df6a7f4="" class="weui-cell vux-tap-active weui-cell_access">
									<div class="weui-cell__hd"><div data-v-0df6a7f4="" class="base-icon rule-icon"></div></div>
									<div class="vux-cell-bd vux-cell-primary"><p><label class="vux-label">玩法规则</label></p><span class="vux-label-desc"></span></div>
									<div class="weui-cell__ft"></div>
								</div>
								<div data-v-0df6a7f4="" class="weui-cell vux-tap-active weui-cell_access">
									<div class="weui-cell__hd"><div data-v-0df6a7f4="" class="base-icon about-icon"></div></div>
									<div class="vux-cell-bd vux-cell-primary"><p><label class="vux-label">关于我们</label></p><span class="vux-label-desc"></span></div>
									<div class="weui-cell__ft"></div>
								</div>
							</div>
						</div>
					</section>
					<section data-v-0df6a7f4="" class="button-group">
						<a data-v-0df6a7f4="" href="javascript:;" class="button">推荐</a>
						<div data-v-0df6a7f4="" class="button">代理</div>
						<a data-v-e7bb725a="" data-v-0df6a7f4="" href="<%=com.yy.guess.util.Util.getConfigCom(application).getCustomerServiceUrl()%>" target="_blank" rel="noopener noreferrer" class="customer-service button">联系</a>
					</section>
				</div>
			</div>
		</div>
	</div>
</body>
</html>