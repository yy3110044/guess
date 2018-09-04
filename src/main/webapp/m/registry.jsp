<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%><!DOCTYPE html>
<html>
<head>
<title>用户注册 - <%=com.yy.guess.util.Util.getConfigCom(application).getWebTitle()%></title>
<%@include file="/m/head-common.jsp"%>
<script>
var checkInput = function(){
	var userName = $.trim($("#userName").val());
	var passWord1 = $("#passWord1").val();
	var passWord2 = $("#passWord2").val();

	if(empty(userName)) {
		$("div.helper-text").remove();
		$("#userName").next().next().after('<div data-v-0fdb235f="" class="helper-text"><div data-v-0fdb235f="" class="alert-icon"></div><div data-v-0fdb235f="">请输入用户名</div></div>');
		$("#registryDiv").addClass("base-button-disabled");
		return false;
	}
	if(userName.length < 6) {
		$("div.helper-text").remove();
		$("#userName").next().next().after('<div data-v-0fdb235f="" class="helper-text"><div data-v-0fdb235f="" class="alert-icon"></div><div data-v-0fdb235f="">用户名不能少于6个字符</div></div>');
		$("#registryDiv").addClass("base-button-disabled");
		return false;
	}
	if(empty(passWord1)) {
		$("div.helper-text").remove();
		$("#passWord1").next().next().after('<div data-v-0fdb235f="" class="helper-text"><div data-v-0fdb235f="" class="alert-icon"></div><div data-v-0fdb235f="">请输入密码</div></div>');
		$("#registryDiv").addClass("base-button-disabled");
		return false;
	}
	if(passWord1.length < 6) {
		$("div.helper-text").remove();
		$("#passWord1").next().next().after('<div data-v-0fdb235f="" class="helper-text"><div data-v-0fdb235f="" class="alert-icon"></div><div data-v-0fdb235f="">密码不能少于6个字符</div></div>');
		$("#registryDiv").addClass("base-button-disabled");
		return false;
	}
	if(empty(passWord2)) {
		$("div.helper-text").remove();
		$("#passWord2").next().next().after('<div data-v-0fdb235f="" class="helper-text"><div data-v-0fdb235f="" class="alert-icon"></div><div data-v-0fdb235f="">请再次输入密码</div></div>');
		$("#registryDiv").addClass("base-button-disabled");
		return false;
	}
	if(passWord1 != passWord2) {
		$("div.helper-text").remove();
		$("#passWord2").next().next().after('<div data-v-0fdb235f="" class="helper-text"><div data-v-0fdb235f="" class="alert-icon"></div><div data-v-0fdb235f="">两次输入密码不一致</div></div>');
		$("#registryDiv").addClass("base-button-disabled");
		return false;
	}
	$("div.helper-text").remove();
	$("#registryDiv").removeClass("base-button-disabled");
	return true;
};

var registry = function(){
	var userName = $.trim($("#userName").val());
	var passWord1 = $("#passWord1").val();
	var passWord2 = $("#passWord2").val();
	var realName = $.trim($("#realName").val());
	if(checkInput()) {
		loadData({
			url : "userRegistry",
			data : {
				"userName" : userName,
				"passWord" : passWord1,
				"realName" : empty(realName) ? null : realName
			},
			success : function(data){
				if(data.code == 100) {
					m_confirm("注册成功，是否前往登陆", function(){
						window.location.href = "${basePath}m/login.jsp";
					});
				} else {
					m_toast(data.msg);
				}
			}
		});
	}
};

$(document).ready(function(){
	$("#userName,#passWord1,#passWord2").keyup(checkInput);
	$("#userName,#passWord1,#passWord2").blur(checkInput);
	$("#userName,#passWord1,#passWord2").focus(checkInput);
});
</script>
</head>
<body>
	<div id="app" class="">
		<nav data-v-1db5fc32="" class="app-header"><ul data-v-1db5fc32=""><li data-v-1db5fc32="" onclick="window.history.back()" class="base-icon history-back"></li><li data-v-1db5fc32="">注册</li><li data-v-1db5fc32="" class="base-icon"></li></ul></nav>
		<div class="weui-tab">
			<div id="vux_view_box_body" class="weui-tab__panel vux-fix-safari-overflow-scrolling">
				<div data-v-2274dd34="" class="register-page router-view">
					<form data-v-2274dd34="">
						<div data-v-0fdb235f="" data-v-2274dd34="" class="base-input">
							<input data-v-0fdb235f="" id="userName" type="text" placeholder="请输入6-12位英文或数字" autocomplete="off" autocorrect="off" autocapitalize="off" maxlength="13">
							<label data-v-0fdb235f="" for="userName" class="input-label">用户名</label>
							<span data-v-0fdb235f="" class="focus-border"></span>
						</div>
						<div data-v-0fdb235f="" data-v-2274dd34="" class="base-input">
							<input data-v-0fdb235f="" id="passWord1" type="password" placeholder="请输入6-11位英文或数字" autocomplete="off" autocorrect="off" autocapitalize="off" maxlength="12">
							<label data-v-0fdb235f="" for="passWord1" class="input-label">密码</label>
							<span data-v-0fdb235f="" class="focus-border"></span>
						</div>
						<div data-v-0fdb235f="" data-v-2274dd34="" class="base-input">
							<input data-v-0fdb235f="" id="passWord2" type="password" placeholder="请再次确认密码" autocomplete="off" autocorrect="off" autocapitalize="off" maxlength="12">
							<label data-v-0fdb235f="" for="passWord2" class="input-label">确认密码</label>
							<span data-v-0fdb235f="" class="focus-border"></span>
						</div>
						<div data-v-0fdb235f="" data-v-2274dd34="" class="base-input">
							<input data-v-0fdb235f="" id="realName" type="text" placeholder="为保证资金安全, 请填写真实姓名" autocomplete="off" autocorrect="off" autocapitalize="off" maxlength="10">
							<label data-v-0fdb235f="" for="realName" class="input-label">真实姓名</label>
							<span data-v-0fdb235f="" class="focus-border"></span>
						</div>
						<!--
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
						-->
						<div data-v-2274dd34="" style="height: 26px;"></div>
						<div data-v-0f69c571="" data-v-2274dd34="" id="registryDiv" class="base-button base-button-disabled">
							<div data-v-0f69c571="" class="button-border">
								<button data-v-0f69c571="" onclick="registry()" type="button" class="button-content">注册</button>
							</div>
						</div>
					</form>
					<div data-v-0f69c571="" data-v-2a361258="" class="base-button">
						<div data-v-0f69c571="" class="button-border">
							<button data-v-0f69c571="" onclick="window.location.href='${basePath}m/login.jsp'" type="button" class="button-content">前往登录</button>
						</div>
					</div>
					<div data-v-2274dd34="" class="rules">
						注册即代表您已经同意并遵守 <a data-v-2274dd34="" href="m/rules.jsp" class="">用户注册协议</a>
					</div>
				</div>
			</div>
		</div>
	</div>
</body>
</html>