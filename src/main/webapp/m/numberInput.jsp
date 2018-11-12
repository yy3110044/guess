<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<div data-v-60a57f0c="" id="numberInputDiv" data-versus-id="" data-versus-item-id="" class="vux-popup-dialog bet-slip-pop vux-popup-bottom vux-popup-show vux-popup-dialog-73jz6" style="height:auto;bottom:0;display:none;">
	<section data-v-60a57f0c="" class="bet-slip-pop-header">
		<div data-v-60a57f0c="" class="slip-number" style="display:none;"></div>
		<div data-v-60a57f0c="" class="remove-all"></div>
		<div data-v-60a57f0c="" class="pop-header-text"><div data-v-60a57f0c="" class="pop-header-balance">余额</div><div data-v-60a57f0c="" data-balance="" data-bet-amount-min="" data-bet-amount-max="" id="userBalanceDiv"></div></div>
		<div data-v-60a57f0c="" class="pop-header-close" onclick="numberInputClose()"></div>
	</section>
	<section data-v-60a57f0c="" class="bet-slip-pop-body">
		<div data-v-60a57f0c="" class="pop-scroll" id="vux-scroller-bomdf" style="touch-action:auto;user-select:none;-webkit-user-drag:none;-webkit-tap-highlight-color:rgba(0, 0, 0, 0);position:relative;overflow:auto;">
			<div class="xs-container" style="transform-origin:0px 0px 0px;transform:translate(0px, 0px) translateZ(0px);">
				<div data-v-60a57f0c="" style="transform-origin:0px 0px 0px;transform:translate(0px, 0px) scale(1) translateZ(0px);">
					<div data-v-60a57f0c="" class="vux-checker-box odds-list">
						<div data-v-60a57f0c="">
							<div data-v-60a57f0c="" class="vux-checker-item odds-item vux-tap-active">
								<div data-v-60a57f0c="" class="odds-list-line"></div>
								<section data-v-60a57f0c="" class="remove-odds" style="visibility:hidden;"><div data-v-60a57f0c="" class="remove-odds-icon"></div></section>
								<section data-v-60a57f0c="" class="odds-item-match">
									<div data-v-60a57f0c=""></div>
									<div data-v-60a57f0c="" class="odds-name"></div>
									<div data-v-60a57f0c=""></div>
								</section>
								<section data-v-60a57f0c="" class="odds-item-money">
									<div data-v-60a57f0c="" class="item-money">
										<div data-v-60a57f0c="" class="money-odds" data-odds="" data-current-versus-id=""></div>
										<div data-v-60a57f0c="" class="stake-input stake-input-focus"><span data-v-60a57f0c="" class="input-placeholder" id="inputValueSpan" data-value="">输入金额</span></div>
									</div>
									<div data-v-60a57f0c="" class="item-return">预计返还&nbsp;<span data-v-60a57f0c="" class="return-amount"></span></div>
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
									<div data-v-90afda32="" class="max-btn" onclick="numberInput('max')"><div data-v-90afda32="">最大投注</div></div>
									<div data-v-90afda32="" class="del-btn" onclick="numberInput('x')"><div data-v-90afda32="" class="del-icon"></div></div>
									<div data-v-90afda32="" class="confirm-btn" onclick="numberInput('ok')"><div data-v-90afda32="">确认下注</div></div>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
			<div class="xs-fixed-container"></div>
		</div>
	</section>
	<section data-v-60a57f0c="" class="bet-slip-pop-note" style="display:none;">
		<div data-v-60a57f0c="" class="note-alert"><div data-v-60a57f0c="" class="alert-icon"></div>您所选投注项的盘口、赔率或有效性已经产生变化</div>
	</section>
</div>

<div data-v-60a57f0c="" class="vux-confirm order-confirm" id="betSuccessDiv" style="display:none;">
	<div class="vux-x-dialog">
		<div class="weui-mask" style=""></div>
		<div class="weui-dialog" style="">
			<div class="weui-dialog__bd">
				<div class="content">
					<section class="header color-green"><div class="success-icon"></div><div>订单提交成功！</div></section>
					<div id="vux-scroller-oezyh" style="max-height:60vh;height:auto;touch-action:auto;user-select:none;-webkit-user-drag:none;-webkit-tap-highlight-color:rgba(0, 0, 0, 0);position:relative;overflow:hidden;">
						<div class="xs-container" style="transform-origin:0px 0px 0px;transform:translateX(0px) translateY(0px) translateZ(0px) scale(1, 1);transition:none 0s ease 0s;">
							<div style="height:auto;transform-origin:0px 0px 0px;transform:translate(0px, 0px) scale(1) translateZ(0px);">
								<div class="order-item">
									<div class="odds-item">
										<div class="match-info">
											<div class="odds-title">
												<div class="games-icon versus-logo-url"></div>
												<div class="versus-name"></div>
												<div class="match-stage"></div>
											</div>
											<div class="odds-match">下注项目：<span class="versus-item-name"></span></div>
											<div class="odds-match">下注金额：<span class="bet-amount"></span></div>
											<div class="odds-match">下注赔率：<span class="bet-odds"></span></div>
											<div class="odds-match">预计返还：<span class="bet-bonus"></span></div>
											<div class="odds-match">下注时间：<span class="bet-time"></span></div>
										</div>
									</div>
									<div class="order-info order-title"><div class="item-name"></div><div class="order-success">提交成功</div></div>
									<!--
									<div class="order-info">
										<div class="stake">投注金额：<span class="color-white"></span></div>
										<div>预计盈利：<span class="color-white"></span></div>
									</div>
									-->
									<div class="order-note">您可以在“个人中心&nbsp;-&nbsp;投注记录”中留意订单状态</div>
								</div>
							</div>
						</div>
						<div class=" xs-fixed-container"></div>
					</div>
				</div>
			</div>
			<div class="weui-dialog__ft">
				<a href="m/usercenter/betRecord.jsp" class="weui-dialog__btn weui-dialog__btn_default">投注记录</a>
				<a href="javascript:;" onclick="betSuccessClose()" class="weui-dialog__btn weui-dialog__btn_primary">继续投注</a>
			</div>
		</div>
	</div>
</div>