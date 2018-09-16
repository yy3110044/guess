<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%><!DOCTYPE html>
<html>
<head>
<title>用户登陆 - <%=com.yy.guess.util.Util.getConfigCom(application).getWebTitle()%></title>
<%@include file="/m/head-common.jsp"%>
<script>
var login = function(){
	var userName = $.trim($("#userName").val());
	var passWord = $("#passWord").val();
	if(empty(userName)) {
		m_toast("输入用户名");
		return;
	}
	if(empty(passWord)) {
		m_toast("输入密码");
		return;
	}
	loadData({
		url : "userLogin",
		data : {
			"userName" : userName,
			"passWord" : passWord,
			"loginType" : "WEB"
		},
		success : function(data){
			if(data.code == 100) {
				m_toast(data.msg, true);
				window.location.href = "${basePath}m/index.jsp";
			} else {
				m_toast(data.msg);
			}
		}
	});
};
$(document).ready(function(){
	loadData({
		"url" : "isLoginBySession",
		"success" : function(data) {
			if(data.code == 100) {
				if(data.result) {
					window.location.href = "${basePath}m/index.jsp";
				}
			}
		}
	});
});
</script>
</head>
<body>
	<div id="app" class="">
		<nav data-v-1db5fc32="" class="app-header"><ul data-v-1db5fc32=""><li data-v-1db5fc32="" onclick="window.history.back()" class="base-icon history-back"></li><li data-v-1db5fc32=""></li><li data-v-1db5fc32="" class="base-icon"></li></ul></nav>
		<div class="weui-tab">
			<div id="vux_view_box_body" class="weui-tab__panel vux-fix-safari-overflow-scrolling">
				<div data-v-2a361258="" class="login-page router-view">
					<div data-v-2a361258="" class="main-logo"></div>
					<form data-v-2a361258="">
						<div data-v-0fdb235f="" data-v-2a361258="" class="base-input">
							<input data-v-0fdb235f="" id="userName" type="text" placeholder="用户名 / 手机号" autocomplete="off" autocorrect="off" autocapitalize="off">
							<label data-v-0fdb235f="" for="userName" class="input-label">帐号</label>
							<span data-v-0fdb235f="" class="focus-border"></span>
						</div>
						<div data-v-0fdb235f="" data-v-2a361258="" class="base-input">
							<input data-v-0fdb235f="" id="passWord" type="password" placeholder="请输入密码" autocomplete="off" autocorrect="off" autocapitalize="off">
							<label data-v-0fdb235f="" for="passWord" class="input-label">密码</label>
							<span data-v-0fdb235f="" class="focus-border"></span>
							<!--
							<div data-v-0fdb235f="" class="right-icon" style="background-image: url('data:image/svg+xml;base64,PD94bWwgdmVyc2lvbj0iMS4wIiBlbmNvZGluZz0iVVRGLTgiPz4KPHN2ZyB3aWR0aD0iMjJweCIgaGVpZ2h0PSIyMnB4IiB2aWV3Qm94PSIwIDAgMjIgMjIiIHZlcnNpb249IjEuMSIgeG1sbnM9Imh0dHA6Ly93d3cudzMub3JnLzIwMDAvc3ZnIiB4bWxuczp4bGluaz0iaHR0cDovL3d3dy53My5vcmcvMTk5OS94bGluayI+CiAgICA8IS0tIEdlbmVyYXRvcjogU2tldGNoIDQ5LjMgKDUxMTY3KSAtIGh0dHA6Ly93d3cuYm9oZW1pYW5jb2RpbmcuY29tL3NrZXRjaCAtLT4KICAgIDx0aXRsZT7lhbPpl63mmL7npLrlr4bnoIE8L3RpdGxlPgogICAgPGRlc2M+Q3JlYXRlZCB3aXRoIFNrZXRjaC48L2Rlc2M+CiAgICA8ZGVmcz48L2RlZnM+CiAgICA8ZyBpZD0i6Zu356ue5oqAMi4wLWNvcHkiIHN0cm9rZT0ibm9uZSIgc3Ryb2tlLXdpZHRoPSIxIiBmaWxsPSJub25lIiBmaWxsLXJ1bGU9ImV2ZW5vZGQiPgogICAgICAgIDxnIGlkPSJpY29u5YiH5Zu+IiB0cmFuc2Zvcm09InRyYW5zbGF0ZSgtMjQuMDAwMDAwLCAtMTIyNS4wMDAwMDApIiBmaWxsPSIjM0Y1NDZBIj4KICAgICAgICAgICAgPGcgaWQ9IuWFs+mXreaYvuekuuWvhueggSIgdHJhbnNmb3JtPSJ0cmFuc2xhdGUoMjQuMDAwMDAwLCAxMjI1LjAwMDAwMCkiPgogICAgICAgICAgICAgICAgPHBhdGggZD0iTTExLDE3IEM2LjU4MTcyMiwxNyAzLDEyLjk5NTMwMDMgMywxMSBDMyw5LjAwNDY5OTcxIDYuNTgxNzIyLDUgMTEsNSBDMTEsNi42MTU3MjI2NiAxMSwxNC44Mjc3NTg4IDExLDE3IFogTTExLDE1IEMxMSwxMy41NTE4MzkyIDExLDguMDc3MTQ4NDQgMTEsNyBDNy42ODYyOTE1LDcgNSwxMC4xOTEyMDI4IDUsMTEgQzUsMTEuODA4Nzk3MiA3LjY4NjI5MTUsMTUgMTEsMTUgWiIgaWQ9IkNvbWJpbmVkLVNoYXBlIj48L3BhdGg+CiAgICAgICAgICAgICAgICA8cGF0aCBkPSJNMTksMTcgQzE0LjU4MTcyMiwxNyAxMSwxMi45OTUzMDAzIDExLDExIEMxMSw5LjAwNDY5OTcxIDE0LjU4MTcyMiw1IDE5LDUgQzE5LDYuNjE1NzIyNjYgMTksMTQuODI3NzU4OCAxOSwxNyBaIE0xOSwxNSBDMTUuNjg2MjkxNSwxNSAxMywxMS44MDg3OTcyIDEzLDExIEMxMywxMC4xOTEyMDI4IDE1LjY4NjI5MTUsNyAxOSw3IEMxOSw4LjA3NzE0ODQ0IDE5LDEzLjU1MTgzOTIgMTksMTUgWiIgaWQ9IkNvbWJpbmVkLVNoYXBlIiB0cmFuc2Zvcm09InRyYW5zbGF0ZSgxNS4wMDAwMDAsIDExLjAwMDAwMCkgc2NhbGUoLTEsIDEpIHRyYW5zbGF0ZSgtMTUuMDAwMDAwLCAtMTEuMDAwMDAwKSAiPjwvcGF0aD4KICAgICAgICAgICAgICAgIDxwYXRoIGQ9Ik0xNy44Njc4MzU0LDE3LjE2MTMyNjQgQzE3Ljk0OTg4NzcsMTcuMjUwMzk4NSAxOCwxNy4zNjkzNDcxIDE4LDE3LjUgQzE4LDE3Ljc3NjE0MjQgMTcuNzc2MTQyNCwxOCAxNy41LDE4IEMxNy4zNTQwMjIyLDE4IDE3LjIyMjY1NTUsMTcuOTM3NDQyNSAxNy4xMzEyNDU5LDE3LjgzNzY3MzYgTDQuMTM3MjY4MDcsNC44NDc0NzMxNCBMNC4xMzg4Nzk3LDQuODQ1ODIyIEM0LjA1Mjg1NDU5LDQuNzU2MDE1NTcgNCw0LjYzNDE4MDIxIDQsNC41IEM0LDQuMjIzODU3NjMgNC4yMjM4NTc2Myw0IDQuNSw0IEM0LjY0NjY3NDI3LDQgNC43Nzg1OTc3MSw0LjA2MzE1NTg2IDQuODcwMDU5NzUsNC4xNjM3NTcwNCBMMTcuODY4NDk5OCwxNy4xNjA2NzUgTDE3Ljg2NzgzNTQsMTcuMTYxMzI2NCBaIiBpZD0iQ29tYmluZWQtU2hhcGUiPjwvcGF0aD4KICAgICAgICAgICAgPC9nPgogICAgICAgIDwvZz4KICAgIDwvZz4KPC9zdmc+');"></div>
							<div data-v-0fdb235f="" class="right-icon" style="background-image: url('data:image/svg+xml;base64,PD94bWwgdmVyc2lvbj0iMS4wIiBlbmNvZGluZz0iVVRGLTgiPz4KPHN2ZyB3aWR0aD0iMjJweCIgaGVpZ2h0PSIyMnB4IiB2aWV3Qm94PSIwIDAgMjIgMjIiIHZlcnNpb249IjEuMSIgeG1sbnM9Imh0dHA6Ly93d3cudzMub3JnLzIwMDAvc3ZnIiB4bWxuczp4bGluaz0iaHR0cDovL3d3dy53My5vcmcvMTk5OS94bGluayI+CiAgICA8IS0tIEdlbmVyYXRvcjogU2tldGNoIDQ5LjMgKDUxMTY3KSAtIGh0dHA6Ly93d3cuYm9oZW1pYW5jb2RpbmcuY29tL3NrZXRjaCAtLT4KICAgIDx0aXRsZT7mmL7npLrlr4bnoIE8L3RpdGxlPgogICAgPGRlc2M+Q3JlYXRlZCB3aXRoIFNrZXRjaC48L2Rlc2M+CiAgICA8ZGVmcz48L2RlZnM+CiAgICA8ZyBpZD0i6Zu356ue5oqAMi4wLWNvcHkiIHN0cm9rZT0ibm9uZSIgc3Ryb2tlLXdpZHRoPSIxIiBmaWxsPSJub25lIiBmaWxsLXJ1bGU9ImV2ZW5vZGQiPgogICAgICAgIDxnIGlkPSJpY29u5YiH5Zu+IiB0cmFuc2Zvcm09InRyYW5zbGF0ZSgtNzAuMDAwMDAwLCAtMTIyNS4wMDAwMDApIiBmaWxsPSIjM0Y1NDZBIj4KICAgICAgICAgICAgPGcgaWQ9IuaYvuekuuWvhueggSIgdHJhbnNmb3JtPSJ0cmFuc2xhdGUoNzAuMDAwMDAwLCAxMjI1LjAwMDAwMCkiPgogICAgICAgICAgICAgICAgPHBhdGggZD0iTTExLDE3IEM2LjU4MTcyMiwxNyAzLDEyLjk5NTMwMDMgMywxMSBDMyw5LjAwNDY5OTcxIDYuNTgxNzIyLDUgMTEsNSBDMTEsNi42MTU3MjI2NiAxMSwxNC44Mjc3NTg4IDExLDE3IFogTTExLDE1IEM3LjY4NjI5MTUsMTUgNSwxMS44MDg3OTcyIDUsMTEgQzUsMTAuMTkxMjAyOCA3LjY4NjI5MTUsNyAxMSw3IEMxMSw4LjA3NzE0ODQ0IDExLDEzLjU1MTgzOTIgMTEsMTUgWiIgaWQ9IkNvbWJpbmVkLVNoYXBlIj48L3BhdGg+CiAgICAgICAgICAgICAgICA8cGF0aCBkPSJNMTksMTcgQzE0LjU4MTcyMiwxNyAxMSwxMi45OTUzMDAzIDExLDExIEMxMSw5LjAwNDY5OTcxIDE0LjU4MTcyMiw1IDE5LDUgQzE5LDYuNjE1NzIyNjYgMTksMTQuODI3NzU4OCAxOSwxNyBaIE0xOSwxNSBDMTUuNjg2MjkxNSwxNSAxMywxMS44MDg3OTcyIDEzLDExIEMxMywxMC4xOTEyMDI4IDE1LjY4NjI5MTUsNyAxOSw3IEMxOSw4LjA3NzE0ODQ0IDE5LDEzLjU1MTgzOTIgMTksMTUgWiIgaWQ9IkNvbWJpbmVkLVNoYXBlIiB0cmFuc2Zvcm09InRyYW5zbGF0ZSgxNS4wMDAwMDAsIDExLjAwMDAwMCkgc2NhbGUoLTEsIDEpIHRyYW5zbGF0ZSgtMTUuMDAwMDAwLCAtMTEuMDAwMDAwKSAiPjwvcGF0aD4KICAgICAgICAgICAgICAgIDxwYXRoIGQ9Ik0xMSwxNCBDOS4zNDMxNDU3NSwxNCA4LDEyLjY1Njg1NDIgOCwxMSBDOCw5LjM0MzE0NTc1IDkuMzQzMTQ1NzUsOCAxMSw4IEMxMi42NTY4NTQyLDggMTQsOS4zNDMxNDU3NSAxNCwxMSBDMTQsMTIuNjU2ODU0MiAxMi42NTY4NTQyLDE0IDExLDE0IFogTTExLDEzIEMxMi4xMDQ1Njk1LDEzIDEzLDEyLjEwNDU2OTUgMTMsMTEgQzEzLDkuODk1NDMwNSAxMi4xMDQ1Njk1LDkgMTEsOSBDOS44OTU0MzA1LDkgOSw5Ljg5NTQzMDUgOSwxMSBDOSwxMi4xMDQ1Njk1IDkuODk1NDMwNSwxMyAxMSwxMyBaIiBpZD0iQ29tYmluZWQtU2hhcGUiPjwvcGF0aD4KICAgICAgICAgICAgPC9nPgogICAgICAgIDwvZz4KICAgIDwvZz4KPC9zdmc+');"></div>
							-->
						</div>
						<section data-v-2a361258="" class="login-setting" style="visibility:hidden;">
							<label data-v-2a361258="" class="container">
								<span data-v-2a361258="">记住我</span>
								<input type="checkbox">
								<span class="checkmark"></span>
							</label>
							<a data-v-2a361258="" href="javascript:;" class="forgot-pwd">忘记密码?</a>
						</section>
						<div data-v-0f69c571="" data-v-2a361258="" class="base-button">
							<div data-v-0f69c571="" class="button-border">
								<button data-v-0f69c571="" onclick="login()" type="button" class="button-content">登录</button>
							</div>
						</div>
					</form>
					<div data-v-0f69c571="" data-v-2a361258="" class="base-button base-button-dark">
						<div data-v-0f69c571="" class="button-border">
							<button data-v-0f69c571="" onclick="window.location.href='${basePath}m/registry.jsp'" type="button" class="button-content">注册</button>
						</div>
					</div>
					<a data-v-e7bb725a="" data-v-2a361258="" href="<%=com.yy.guess.util.Util.getConfigCom(application).getCustomerServiceUrl()%>" target="_blank" rel="noopener noreferrer" class="customer-service">联系客服</a>
				</div>
			</div>
		</div>
	</div>
</body>
</html>