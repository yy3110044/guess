<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%><!DOCTYPE html>
<html><%com.yy.guess.component.ConfigComponent cfgCom = com.yy.guess.util.Util.getConfigCom(application);%>
<head>
<title>充值 - <%=cfgCom.getWebTitle()%></title>
<%@include file="/m/head-common.jsp"%>
<script src="m/js/usercenter.js"></script>
<script>
var payMin = <%=cfgCom.getPayMin()%>;
var payMax = <%=cfgCom.getPayMax()%>;
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
					<form data-v-4e00d1d3="" onsubmit="return false" class="form-deposit">
						<div data-v-4e00d1d3="" class="payItem-list">
							<div data-v-4e00d1d3="" class="card-padding amount-input-margin">
								<div data-v-7ec847aa="" data-v-4e00d1d3="" class="amount-input">
									<input data-v-7ec847aa="" id="amount" type="number" autocomplete="off" pattern="[0-9]*">
									<label data-v-7ec847aa="" for="amount" class="input-label">金额</label>
									<span data-v-7ec847aa="" class="rmb-icon"></span>
									<span data-v-7ec847aa="" class="focus-border"></span>
								</div>
								<div data-v-4e00d1d3="" class="amount-notice">单笔限额 ¥<%=cfgCom.getPayMin()%> ~ <%=cfgCom.getPayMax()%></div>
							</div>
						</div>
						<div data-v-4e00d1d3="" class="card-padding submit-button">
							<div data-v-0f69c571="" data-v-4e00d1d3="" class="base-button base-button-disabled">
								<div data-v-0f69c571="" class="button-border"><button data-v-0f69c571="" type="submit" class="button-content">确认</button></div>
							</div>
						</div>
					</form>
				</div>
			</div>
		</div>
	</div>
</body>
</html>