<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%><!DOCTYPE html>
<html>
<head>
<title>绑定银行卡 - <%=com.yy.guess.util.Util.getConfigCom(application).getWebTitle()%></title>
<%@include file="/m/head-common.jsp"%>
<script src="m/js/usercenter.js"></script>
<script>
var msg = "<%=com.yy.fast4j.Fast4jUtils.urlDecode(request.getParameter("msg"))%>";
$(document).ready(function(){if(!empty(msg)) m_alert(msg);});
</script>
</head>
<body>
	<div id="app">
		<nav data-v-1db5fc32="" class="app-header">
			<ul data-v-1db5fc32="">
				<li onclick="window.location.href='m/usercenter/wallet/index.jsp'" data-v-1db5fc32="" class="base-icon history-back"></li>
				<li data-v-1db5fc32="">添加银行卡</li>
				<li data-v-1db5fc32="" class="base-icon"></li>
			</ul>
		</nav>
		<div class="weui-tab">
			<div id="vux_view_box_body" class="weui-tab__panel vux-fix-safari-overflow-scrolling">
				<div data-v-da80ad50="" class="add-bank-card-page router-view">
					<section data-v-da80ad50="" class="form-card">
						<input type="hidden" id="bankCode">
						<div data-v-da80ad50="" class="card-header">
							<div data-v-da80ad50="">持卡人</div>
							<div data-v-da80ad50="" class="name-content">
								<div data-v-da80ad50="" class="user-name"></div>
								<div data-v-da80ad50="" class="note">持卡人姓名需与注册帐号一致</div>
							</div>
						</div>
						<div data-v-da80ad50="" class="card-body">
							<div data-v-7ec847aa="" data-v-da80ad50="" class="amount-input card-input">
								<input data-v-7ec847aa="" id="bankAccount" type="text" placeholder="请输入卡号" autocomplete="off">
								<label data-v-7ec847aa="" for="bankAccount" class="input-label">卡号</label>
								<span data-v-7ec847aa="" class="rmb-icon"></span>
								<span data-v-7ec847aa="" class="focus-border"></span>
							</div>
							<div data-v-0fdb235f="" data-v-da80ad50="" class="base-input light-border">
								<input data-v-0fdb235f="" id="bankName" type="text" placeholder="请选择开户银行" readonly="readonly" autocomplete="off">
								<label data-v-0fdb235f="" for="bankName" class="input-label">开户银行</label>
								<span data-v-0fdb235f="" class="focus-border"></span>
								<div data-v-0fdb235f="" class="right-icon" style="background-image:url('data:image/svg+xml;base64,PD94bWwgdmVyc2lvbj0iMS4wIiBlbmNvZGluZz0iVVRGLTgiPz4KPHN2ZyB3aWR0aD0iMjJweCIgaGVpZ2h0PSIyMnB4IiB2aWV3Qm94PSIwIDAgMjIgMjIiIHZlcnNpb249IjEuMSIgeG1sbnM9Imh0dHA6Ly93d3cudzMub3JnLzIwMDAvc3ZnIiB4bWxuczp4bGluaz0iaHR0cDovL3d3dy53My5vcmcvMTk5OS94bGluayI+CiAgICA8IS0tIEdlbmVyYXRvcjogU2tldGNoIDQ5LjEgKDUxMTQ3KSAtIGh0dHA6Ly93d3cuYm9oZW1pYW5jb2RpbmcuY29tL3NrZXRjaCAtLT4KICAgIDx0aXRsZT7ml6XljobkuIvkuIDpobU8L3RpdGxlPgogICAgPGRlc2M+Q3JlYXRlZCB3aXRoIFNrZXRjaC48L2Rlc2M+CiAgICA8ZGVmcz48L2RlZnM+CiAgICA8ZyBpZD0iUGFnZS0xIiBzdHJva2U9Im5vbmUiIHN0cm9rZS13aWR0aD0iMSIgZmlsbD0ibm9uZSIgZmlsbC1ydWxlPSJldmVub2RkIj4KICAgICAgICA8ZyBpZD0i5o6n5Lu2IiB0cmFuc2Zvcm09InRyYW5zbGF0ZSgtODIuMDAwMDAwLCAtNzI2LjAwMDAwMCkiIGZpbGw9IiM1NjZFODQiPgogICAgICAgICAgICA8ZyBpZD0i5pel5Y6G5LiL5LiA6aG1IiB0cmFuc2Zvcm09InRyYW5zbGF0ZSg4Mi4wMDAwMDAsIDcyNi4wMDAwMDApIj4KICAgICAgICAgICAgICAgIDxwYXRoIGQ9Ik0xMC41LDExIEwxNiwxNi41IEwxNC41LDE4IEw5LDEyLjUgTDcuNSwxMSBMMTQuNSw0IEwxNiw1LjUgTDEwLjUsMTEgWiIgaWQ9IkNvbWJpbmVkLVNoYXBlIiB0cmFuc2Zvcm09InRyYW5zbGF0ZSgxMS43NTAwMDAsIDExLjAwMDAwMCkgc2NhbGUoLTEsIDEpIHRyYW5zbGF0ZSgtMTEuNzUwMDAwLCAtMTEuMDAwMDAwKSAiPjwvcGF0aD4KICAgICAgICAgICAgPC9nPgogICAgICAgIDwvZz4KICAgIDwvZz4KPC9zdmc+');"></div>
							</div>
							<div data-v-0f69c571="" data-v-da80ad50="" class="base-button base-button-disabled">
								<div data-v-0f69c571="" class="button-border"><button data-v-0f69c571="" type="button" class="button-content">确认</button></div>
							</div>
						</div>
					</section>
				</div>
			</div>
		</div>
	</div>

	<div data-v-da80ad50="" id="bankSelector" class="vux-popup-dialog base-popup vux-popup-bottom vux-popup-show" style="height:auto;max-height:55vh;display:none;">
		<div class="popup-header">
			<div>选择开户银行</div>
			<div class="center-title"></div>
			<div class="click-close-btn hide-btn"></div>
		</div>
		<div data-v-da80ad50="" class="popup-content" id="vux-scroller-px8ds" style="touch-action:auto;user-select:none;-webkit-user-drag:none;-webkit-tap-highlight-color:rgba(0, 0, 0, 0);position:relative;overflow:scroll;">
			<div class="xs-container" style="transform-origin: 0px 0px 0px; transform: translate(0px, 0px) translateZ(0px);">
				<div data-v-da80ad50="" style="transform-origin:0px 0px 0px;transform:translate(0px, 0px) scale(1) translateZ(0px);">
					<div data-v-da80ad50="" class="bank-item" data-bank-code="ICBC" data-bank-name="中国工商银行">
						<img data-v-da80ad50="" src="" width="40px">
						<div data-v-da80ad50="" class="bank-name">中国工商银行</div>
					</div>
					<div data-v-da80ad50="" class="bank-item" data-bank-code="BOC" data-bank-name="中国银行">
						<img data-v-da80ad50="" src="" width="40px">
						<div data-v-da80ad50="" class="bank-name">中国银行</div>
					</div>
					<div data-v-da80ad50="" class="bank-item" data-bank-code="CCB" data-bank-name="中国建设银行">
						<img data-v-da80ad50="" src="" width="40px">
						<div data-v-da80ad50="" class="bank-name">中国建设银行</div>
					</div>
					<div data-v-da80ad50="" class="bank-item" data-bank-code="ABC" data-bank-name="中国农业银行">
						<img data-v-da80ad50="" src="" width="40px">
						<div data-v-da80ad50="" class="bank-name">中国农业银行</div>
					</div>
					<div data-v-da80ad50="" class="bank-item" data-bank-code="CMB" data-bank-name="招商银行">
						<img data-v-da80ad50="" src="" width="40px">
						<div data-v-da80ad50="" class="bank-name">招商银行</div>
					</div>
					<div data-v-da80ad50="" class="bank-item" data-bank-code="CMBC" data-bank-name="中国民生银行">
						<img data-v-da80ad50="" src="" width="40px">
						<div data-v-da80ad50="" class="bank-name">中国民生银行</div>
					</div>
					<div data-v-da80ad50="" class="bank-item" data-bank-code="BCM" data-bank-name="交通银行">
						<img data-v-da80ad50="" src="" width="40px">
						<div data-v-da80ad50="" class="bank-name">交通银行</div>
					</div>
					<div data-v-da80ad50="" class="bank-item" data-bank-code="CIB" data-bank-name="兴业银行">
						<img data-v-da80ad50="" src="" width="40px">
						<div data-v-da80ad50="" class="bank-name">兴业银行</div>
					</div>
					<div data-v-da80ad50="" class="bank-item" data-bank-code="CEB" data-bank-name="中国光大银行">
						<img data-v-da80ad50="" src="" width="40px">
						<div data-v-da80ad50="" class="bank-name">中国光大银行</div>
					</div>
					<div data-v-da80ad50="" class="bank-item" data-bank-code="PABC" data-bank-name="平安银行">
						<img data-v-da80ad50="" src="" width="40px">
						<div data-v-da80ad50="" class="bank-name">平安银行</div>
					</div>
					<div data-v-da80ad50="" class="bank-item" data-bank-code="CITICIB" data-bank-name="中信银行">
						<img data-v-da80ad50="" src="" width="40px">
						<div data-v-da80ad50="" class="bank-name">中信银行</div>
					</div>
				</div>
			</div>
			<div class="xs-fixed-container"></div>
		</div>
	</div>
	<a id="bankSelectorLevel" class="vux-popup-mask vux-popup-show" data-uuid=",vsmnj,5m6p2,ba29i" href="javascript:;" style="z-index:500;display:none;"></a>
</body>
</html>