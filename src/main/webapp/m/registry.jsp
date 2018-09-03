<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%><!DOCTYPE html>
<html>
<head>
<base href="${basePath}">
<title>用户注册 - <%=com.yy.guess.util.Util.getConfigCom(application).getWebTitle()%></title>
<%@include file="/m/head-common.jsp"%>

</head>
<body>
	<div id="app" class="">
		<nav data-v-944b0690="" class="app-header"><ul data-v-944b0690=""><li data-v-944b0690="" class="base-icon history-back"></li><li data-v-944b0690="">注册</li><li data-v-944b0690="" class="base-icon"></li></ul></nav>
		<div class="weui-tab">
			<div id="vux_view_box_body" class="weui-tab__panel vux-fix-safari-overflow-scrolling">
				<div data-v-73db18bc="" class="register-page router-view">
					<div data-v-518f5f8b="" data-v-73db18bc="" class="base-input">
						<input data-v-518f5f8b="" id="用户名" type="text" placeholder="请输入6-12位英文或数字" autocomplete="off" autocorrect="off" autocapitalize="off" maxlength="13">
						<label data-v-518f5f8b="" for="用户名" class="input-label">用户名 </label>
						<span data-v-518f5f8b="" class="focus-border"></span>
					</div>
					<div data-v-518f5f8b="" data-v-73db18bc="" class="base-input">
						<input data-v-518f5f8b="" id="密码" type="text" placeholder="请输入6-11位英文或数字" autocomplete="off" autocorrect="off" autocapitalize="off" maxlength="12">
						<label data-v-518f5f8b="" for="密码" class="input-label">密码 </label>
						<span data-v-518f5f8b="" class="focus-border"></span>
					</div>
					<div data-v-518f5f8b="" data-v-73db18bc="" class="base-input">
						<input data-v-518f5f8b="" id="确认密码" type="text" placeholder="请再次确认密码" autocomplete="off" autocorrect="off" autocapitalize="off" maxlength="12">
						<label data-v-518f5f8b="" for="确认密码" class="input-label">确认密码 </label>
						<span data-v-518f5f8b="" class="focus-border"></span>
					</div>
					<div data-v-518f5f8b="" data-v-73db18bc="" class="base-input">
						<input data-v-518f5f8b="" id="真实姓名" type="text" placeholder="为保证资金安全, 请填写真实姓名" autocomplete="off" autocorrect="off" autocapitalize="off" maxlength="10">
						<label data-v-518f5f8b="" for="真实姓名" class="input-label">真实姓名</label>
						<span data-v-518f5f8b="" class="focus-border"></span>
					</div>
					<div data-v-518f5f8b="" data-v-73db18bc="" class="base-input">
						<input data-v-518f5f8b="" id="手机号" type="tel" placeholder="请填写手机号码" autocomplete="off" autocorrect="off" autocapitalize="off" maxlength="13">
						<label data-v-518f5f8b="" for="手机号" class="input-label">手机号 </label>
						<span data-v-518f5f8b="" class="focus-border"></span>
						<div data-v-69a74e75="" data-v-73db18bc="" class="base-btn" data-v-518f5f8b="">发送验证码</div>
					</div>
					<div data-v-518f5f8b="" data-v-73db18bc=""
						class="base-input none-label">
						<input data-v-518f5f8b="" id="" type="tel" placeholder="请输入验证码" autocomplete="off" autocorrect="off" autocapitalize="off" maxlength="6">
						<label data-v-518f5f8b="" for="" class="input-label"></label>
						<span data-v-518f5f8b="" class="focus-border"></span>
					</div>
					<div data-v-518f5f8b="" data-v-73db18bc="" class="base-input">
						<input data-v-518f5f8b="" id="推荐码" type="text" placeholder="没有可不填" autocomplete="off" autocorrect="off" autocapitalize="off">
						<label data-v-518f5f8b="" for="推荐码" class="input-label">推荐码 </label>
						<span data-v-518f5f8b="" class="focus-border"></span>
					</div>
					<div data-v-73db18bc="" style="height: 26px;"></div>
					<div data-v-0f69c571="" data-v-73db18bc="" class="base-button base-button-disabled">
						<div data-v-0f69c571="" class="button-border">
							<button data-v-0f69c571="" type="submit" class="button-content">注册</button>
						</div>
					</div>
					<!---->
					<div data-v-73db18bc="" class="rules">
						注册即代表您已经同意并遵守 <a data-v-73db18bc="" href="#/rules" class="">用户注册协议 </a>
					</div>
				</div>
			</div>
		</div>
	</div>

	<div class="vux-alert">
		<div class="vux-x-dialog">
			<div class="weui-mask" style="display: none;"></div>
			<div class="weui-dialog" style="display: none;">
				<div class="weui-dialog__hd">
					<strong class="weui-dialog__title"></strong>
				</div>
				<div class="weui-dialog__bd">
					<div></div>
				</div>
				<div class="weui-dialog__ft">
					<a href="javascript:;"
						class="weui-dialog__btn weui-dialog__btn_primary">确定</a>
				</div>
			</div>
		</div>
	</div>
	<div class="vux-confirm">
		<div class="vux-x-dialog">
			<div class="weui-mask" style="display: none;"></div>
			<div class="weui-dialog" style="display: none;">
				<!---->
				<div class="weui-dialog__bd">
					<div></div>
				</div>
				<div class="weui-dialog__ft">
					<a href="javascript:;"
						class="weui-dialog__btn weui-dialog__btn_default">取消</a> <a
						href="javascript:;"
						class="weui-dialog__btn weui-dialog__btn_primary">确定</a>
				</div>
			</div>
		</div>
	</div>
	<div class="vux-toast">
		<div class="weui-mask_transparent" style="display: none;"></div>
		<div class="weui-toast weui-toast_success vux-toast-middle"
			style="width: 7.6em; display: none;">
			<i class="weui-icon-success-no-circle weui-icon_toast"></i>
			<p class="weui-toast__content">登录成功</p>
		</div>
	</div>
	<div data-v-cd2dfd02="" class="base-alert v-transfer-dom">
		<div data-v-cd2dfd02="" class="vux-x-dialog">
			<div class="weui-mask" style="display: none;"></div>
			<div class="weui-dialog"
				style="background: transparent; display: none;">
				<div data-v-cd2dfd02="" class="alert-content">
					<div data-v-cd2dfd02="" class="warning"></div>
					<div data-v-cd2dfd02="" class="alert-text"></div>
					<div data-v-cd2dfd02="" class="alert-hr"></div>
					<div data-v-cd2dfd02="" class="alert-btn">确认</div>
				</div>
			</div>
		</div>
	</div>
	
	<a class="vux-popup-mask" data-uuid=",99s7o,nidkj"
		href="javascript:void(0)" style="z-index: -1;"></a>
	<div data-v-73db18bc="" class="base-confirm v-transfer-dom">
		<div class="vux-confirm">
			<div class="vux-x-dialog">
				<div class="weui-mask" style="display: none;"></div>
				<div class="weui-dialog" style="display: none;">
					<!---->
					<div class="weui-dialog__bd">
						<div class="content">
							<div class="success"></div>
							<div>注册成功</div>
						</div>
					</div>
					<div class="weui-dialog__ft">
						<a href="javascript:;"
							class="weui-dialog__btn weui-dialog__btn_default">先看看</a> <a
							href="javascript:;"
							class="weui-dialog__btn weui-dialog__btn_primary">去存款</a>
					</div>
				</div>
			</div>
		</div>
	</div>
	
</body>
</html>