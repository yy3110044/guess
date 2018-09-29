<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%><!DOCTYPE html>
<html>
<head>
<title>充值 - <%=com.yy.guess.util.Util.getConfigCom(application).getWebTitle()%></title>
<%@include file="/m/head-common.jsp"%>
<script src="m/js/usercenter.js"></script>
<script>
var payType = "<%=request.getParameter("payType")%>";
</script>
</head>
<body>
	<div id="app">
		<nav data-v-1db5fc32="" class="app-header">
			<ul data-v-1db5fc32="">
				<li data-v-1db5fc32="" onclick="window.location.href='m/usercenter/wallet/index.jsp'" class="base-icon history-back"></li>
				<li data-v-1db5fc32=""><%=com.yy.fast4j.Fast4jUtils.urlDecode(request.getParameter("payName"))%></li>
				<li data-v-1db5fc32="" class="base-icon"></li>
			</ul>
		</nav>
		<div class="weui-tab">
			<div id="vux_view_box_body" class="weui-tab__panel vux-fix-safari-overflow-scrolling">
				<div data-v-4e00d1d3="" class="dsposit-page router-view">
					<form data-v-4e00d1d3="" onsubmit="return false" class="form-deposit no-card-form">
						<div data-v-4e00d1d3="" class="payItem-list">
							<div data-v-4e00d1d3="">
								<div data-v-4e00d1d3="" class="card-padding card-margin">金额</div>
								<div data-v-4e00d1d3="" class="vux-checker-box amount-checker-content">
									<div data-v-4e00d1d3="" class="vux-checker-item vux-tap-active default-amount-select">
										<div data-v-4e00d1d3="" style="height:2px;"></div>
										<div data-v-4e00d1d3=""><span data-v-4e00d1d3="" class="amount-select">50</span>&nbsp;<span data-v-4e00d1d3="">元</span></div>
										<div data-v-4e00d1d3="" class="selected-checker-light"></div>
									</div>
									<div data-v-4e00d1d3="" class="vux-checker-item vux-tap-active default-amount-select">
										<div data-v-4e00d1d3="" style="height:2px;"></div>
										<div data-v-4e00d1d3=""><span data-v-4e00d1d3="" class="amount-select">100</span>&nbsp;<span data-v-4e00d1d3="">元</span></div>
										<div data-v-4e00d1d3="" class="selected-checker-light"></div>
									</div>
									<div data-v-4e00d1d3="" class="vux-checker-item vux-tap-active default-amount-select">
										<div data-v-4e00d1d3="" style="height:2px;"></div>
										<div data-v-4e00d1d3=""><span data-v-4e00d1d3="" class="amount-select">500</span>&nbsp;<span data-v-4e00d1d3="">元</span></div>
										<div data-v-4e00d1d3="" class="selected-checker-light"></div>
									</div>
									<div data-v-4e00d1d3="" class="vux-checker-item vux-tap-active default-amount-select">
										<div data-v-4e00d1d3="" style="height:2px;"></div>
										<div data-v-4e00d1d3=""><span data-v-4e00d1d3="" class="amount-select">1000</span>&nbsp;<span data-v-4e00d1d3="">元</span></div>
										<div data-v-4e00d1d3="" class="selected-checker-light"></div>
									</div>
									<div data-v-4e00d1d3="" class="vux-checker-item vux-tap-active default-amount-select">
										<div data-v-4e00d1d3="" style="height:2px;"></div>
										<div data-v-4e00d1d3=""><span data-v-4e00d1d3="" class="amount-select">3000</span>&nbsp;<span data-v-4e00d1d3="">元</span></div>
										<div data-v-4e00d1d3="" class="selected-checker-light"></div>
									</div>
									<div data-v-4e00d1d3="" class="vux-checker-item vux-tap-active default-amount-select">
										<div data-v-4e00d1d3="" style="height:2px;"></div>
										<div data-v-4e00d1d3=""><span data-v-4e00d1d3="" class="amount-select">5000</span>&nbsp;<span data-v-4e00d1d3="">元</span></div>
										<div data-v-4e00d1d3="" class="selected-checker-light"></div>
									</div>
								</div>
							</div>
						</div>
						<div data-v-4e00d1d3="" class="card-padding submit-button">
							<div data-v-0f69c571="" data-v-4e00d1d3="" class="base-button base-button-disabled">
								<div data-v-0f69c571="" class="button-border"><button data-v-0f69c571="" type="button" class="button-content">确认</button></div>
							</div>
						</div>
					</form>
				</div>
			</div>
		</div>
	</div>
</body>
</html>