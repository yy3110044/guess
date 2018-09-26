<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%><!DOCTYPE html>
<html>
<head>
<title>提款 - <%=com.yy.guess.util.Util.getConfigCom(application).getWebTitle()%></title>
<%@include file="/m/head-common.jsp"%>
<script src="m/js/usercenter.js"></script>
</head>
<body>
	<div id="app">
		<nav data-v-1db5fc32="" class="app-header">
			<ul data-v-1db5fc32="">
				<li onclick="window.location.href='m/usercenter/wallet/index.jsp'" data-v-1db5fc32="" class="base-icon history-back"></li>
				<li data-v-1db5fc32="">提款</li>
				<li data-v-1db5fc32="" class="base-icon"></li>
			</ul>
		</nav>
		<div class="weui-tab">
			<div id="vux_view_box_body" class="weui-tab__panel vux-fix-safari-overflow-scrolling">
				<div data-v-ed4b0372="" class="withdrawal-page router-view">
					<section data-v-ed4b0372="" class="form-withdrawal">
						<input type="hidden" id="userBankAccountId">
						<div data-v-ed4b0372="" class="card-header">
							<div data-v-ed4b0372="">收款帐号</div>
							<div data-v-ed4b0372="" class="name-content">
								<div data-v-ed4b0372="" class="user-name"></div>
								<div data-v-ed4b0372="" class="note">通常30分钟内到帐</div>
							</div>
						</div>
						<div data-v-ed4b0372="" class="card-body">
							<form data-v-ed4b0372="" onsubmit="return false">
								<div data-v-7ec847aa="" data-v-ed4b0372="" class="amount-input">
									<input data-v-7ec847aa="" id="amount" type="number" autocomplete="off" step="0.01">
									<label data-v-7ec847aa="" for="amount" class="input-label">提款金额</label>
									<span data-v-7ec847aa="" class="rmb-icon"></span>
									<span data-v-7ec847aa="" class="focus-border"></span>
								</div>
								<div data-v-ed4b0372="" class="amount-notice">钱包余额&nbsp;¥<span id="balance"></span>，&nbsp;<span data-v-ed4b0372="" class="set-max-amount">全部提现</span></div>
								
								<div data-v-7ec847aa="" data-v-ed4b0372="" class="amount-input">
									<input data-v-7ec847aa="" id="withdrawPassWord" type="password" autocomplete="off" placeholder="输入资金密码" style="padding-left:0px;">
									<label data-v-7ec847aa="" for="withdrawPassWord" class="input-label">资金密码</label>
									<span data-v-7ec847aa="" class="focus-border"></span>
								</div>
								
								<div data-v-0f69c571="" data-v-ed4b0372="" class="base-button base-button-disabled"><div data-v-0f69c571="" class="button-border"><button data-v-0f69c571="" type="button" class="button-content">确认</button></div></div>
							</form>
						</div>
					</section>
				</div>
			</div>
		</div>
	</div>

	<div data-v-ed4b0372="" class="base-confirm v-transfer-dom" style="display:none;">
		<div class="vux-confirm">
			<div class="vux-x-dialog">
				<div class="weui-mask"></div>
				<div class="weui-dialog">
					<div class="weui-dialog__bd"><div class="content"><div class="success"></div><div>申请提款成功</div></div></div>
					<div class="weui-dialog__ft">
						<a href="m/usercenter/wallet/index.jsp" class="weui-dialog__btn weui-dialog__btn_default">返回钱包页</a>
						<a href="m/index.jsp" class="weui-dialog__btn weui-dialog__btn_primary">首页</a>
					</div>
				</div>
			</div>
		</div>
	</div>

	<div data-v-ed4b0372="" id="bankSelector" class="vux-popup-dialog base-popup vux-popup-bottom vux-popup-show" style="height:auto;max-height:55vh;display:none;">
		<div class="popup-header">
			<div>选择收款帐号</div>
			<div class="center-title"></div>
			<div class="click-close-btn"></div>
		</div>
		<div data-v-ed4b0372="" class="popup-content" id="vux-scroller-g9kpq" style="height:192px;touch-action:auto;user-select:none;-webkit-user-drag:none;-webkit-tap-highlight-color:rgba(0, 0, 0, 0);position:relative;">
			<div class="xs-container" style="transform-origin:0px 0px 0px;transform:translateX(0px) translateY(0px) translateZ(0px) scale(1, 1);transition:none 0s ease 0s;">
				<div data-v-ed4b0372="" class="vux-swipeout" style="height:192px;transform-origin:0px 0px 0px;transform:translate(0px, 0px) scale(1) translateZ(0px);overflow:scroll;">
					<div data-v-ed4b0372="" onclick="window.location.href='m/usercenter/wallet/addBankAccount.jsp'" class="content-item">
						<div data-v-ed4b0372="" class="item-icon"></div>
						<div data-v-ed4b0372="" class="item-text item-text-gray">添加银行卡</div>
					</div>
				</div>
			</div>
			<div class="xs-fixed-container"></div>
		</div>
	</div>
	<a id="bankSelectorLevel" class="vux-popup-mask vux-popup-show" data-uuid=",vsmnj,5m6p2,d0qy4" href="javascript:void(0)" style="z-index:500;display:none;"></a>
</body>
</html>