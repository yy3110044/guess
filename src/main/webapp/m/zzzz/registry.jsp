<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%><!DOCTYPE html>
<html>
<head>
<title>用户注册 - <%=com.yy.guess.util.Util.getConfigCom(application).getWebTitle()%></title>
<%@include file="/m/head-common.jsp"%>
</head>
<body>
	<div id="app" class="">
		<nav data-v-1db5fc32="" class="app-header"><ul data-v-1db5fc32=""><li data-v-1db5fc32="" class="base-icon history-back"></li><li data-v-1db5fc32="">注册</li><li data-v-1db5fc32="" class="base-icon"></li></ul></nav>
		<div class="weui-tab">
			<div id="vux_view_box_body" class="weui-tab__panel vux-fix-safari-overflow-scrolling">
				<div data-v-2274dd34="" class="register-page router-view">
					<form data-v-2274dd34="" onsubmit="return false">
						<div data-v-0fdb235f="" data-v-2274dd34="" class="base-input">
							<input data-v-0fdb235f="" id="用户名" type="text" placeholder="请输入6-12位英文或数字" autocomplete="off" autocorrect="off" autocapitalize="off" maxlength="13">
							<label data-v-0fdb235f="" for="用户名" class="input-label">用户名</label>
							<span data-v-0fdb235f="" class="focus-border"></span>
						</div>
						<div data-v-0fdb235f="" data-v-2274dd34="" class="base-input">
							<input data-v-0fdb235f="" id="密码" type="text" placeholder="请输入6-11位英文或数字" autocomplete="off" autocorrect="off" autocapitalize="off" maxlength="12">
							<label data-v-0fdb235f="" for="密码" class="input-label">密码</label>
							<span data-v-0fdb235f="" class="focus-border"></span>
						</div>
						<div data-v-0fdb235f="" data-v-2274dd34="" class="base-input">
							<input data-v-0fdb235f="" id="确认密码" type="text" placeholder="请再次确认密码" autocomplete="off" autocorrect="off" autocapitalize="off" maxlength="12">
							<label data-v-0fdb235f="" for="确认密码" class="input-label">确认密码</label>
							<span data-v-0fdb235f="" class="focus-border"></span>
						</div>
						<div data-v-0fdb235f="" data-v-2274dd34="" class="base-input">
							<input data-v-0fdb235f="" id="真实姓名" type="text" placeholder="为保证资金安全, 请填写真实姓名" autocomplete="off" autocorrect="off" autocapitalize="off" maxlength="10">
							<label data-v-0fdb235f="" for="真实姓名" class="input-label">真实姓名</label>
							<span data-v-0fdb235f="" class="focus-border"></span>
						</div>
						<div data-v-0fdb235f="" data-v-2274dd34="" class="base-input">
							<input data-v-0fdb235f="" id="手机号" type="tel" placeholder="请填写手机号码" autocomplete="off" autocorrect="off" autocapitalize="off" maxlength="13">
							<label data-v-0fdb235f="" for="手机号" class="input-label">手机号</label>
							<span data-v-0fdb235f="" class="focus-border"></span>
							<div data-v-69a74e75="" data-v-2274dd34="" class="base-btn" data-v-0fdb235f="">发送验证码</div>
						</div>
						<div data-v-0fdb235f="" data-v-2274dd34="" class="base-input none-label">
							<input data-v-0fdb235f="" id="" type="tel" placeholder="请输入验证码" autocomplete="off" autocorrect="off" autocapitalize="off" maxlength="6">
							<label data-v-0fdb235f="" for="" class="input-label"></label>
							<span data-v-0fdb235f="" class="focus-border"></span>
						</div>
						<div data-v-0fdb235f="" data-v-2274dd34="" class="base-input">
							<input data-v-0fdb235f="" id="推荐码" type="text" placeholder="没有可不填" autocomplete="off" autocorrect="off" autocapitalize="off">
							<label data-v-0fdb235f="" for="推荐码" class="input-label">推荐码</label>
							<span data-v-0fdb235f="" class="focus-border"></span>
						</div>
						<div data-v-2274dd34="" style="height: 26px;"></div>
						<div data-v-0f69c571="" data-v-2274dd34="" class="base-button base-button-disabled">
							<div data-v-0f69c571="" class="button-border">
								<button data-v-0f69c571="" type="submit" class="button-content">注册</button>
							</div>
						</div>
					</form>
					<div data-v-2274dd34="" class="rules">
						注册即代表您已经同意并遵守 <a data-v-2274dd34="" href="javascript:;" class="">用户注册协议</a>
					</div>
				</div>
			</div>
		</div>
	</div>
</body>
</html>