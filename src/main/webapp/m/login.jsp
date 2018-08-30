<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%><!DOCTYPE html>
<html>
<head>
<base href="${basePath}">
<title>RAYBET雷竞技-最佳电子竞技即时竞猜平台。</title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">

<meta name="viewport" content="width=device-width,initial-scale=1,minimum-scale=1,maximum-scale=1,user-scalable=no,viewport-fit=cover">
<meta name="theme-color" content="#090C15">
<meta name="format-detection" content="telephone=no">
<meta name="format-detection" content="email=no">
<meta name="apple-mobile-web-app-title" content="雷竞技">
<meta name="referrer" content="never">

<meta http-equiv="x-dns-prefetch-control" content="on">
<link rel="dns-prefetch" href="${basePath}"><!-- dns缓存 -->

<link rel="apple-touch-icon" sizes="192x192" href="m/images/logo/icon_192.png">
<link rel="icon" type="image/png" sizes="192x192" href="m/images/logo/icon_192.png">
<link rel="icon" type="image/png" sizes="32x32" href="m/images/logo/icon_32.png">
<link rel="icon" type="image/png" href="m/images/logo/icon_192.png" >
<link rel="icon" type="image/png" sizes="32x32" href="m/images/logo/favicon-32x32.png">
<link rel="shortcut icon" type="image/png" href="m/images/logo/favicon-32x32.png">
<link rel="apple-touch-icon" href="m/images/logo/apple-touch-icon.png">
<link rel="apple-touch-icon" sizes="192x192" href="m/images/logo/apple-touch-icon.png">
<link href="m/css/app.css" rel="stylesheet">
</head>
<body>
	<noscript>
		<strong>請啟用JavaScript已继续。</strong><br>
		<h5>iOS > 设置 > Safari浏览器 > 高级 > JavaScript</h5>
		<h5>Chrome > 设置 > 网站设置 > JavaScript</h5>
	</noscript>
	<div id="app" class="">
		<div class="loading-bkg" style="display:none;"><div data-v-c96941ea="" class="loading"><svg data-v-c96941ea="" version="1.1" id="loader-1" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" x="0px" y="0px" width="40px" height="40px" viewBox="0 0 40 40" enable-background="new 0 0 40 40" xml:space="preserve"><path data-v-c96941ea="" opacity="0.2" fill="#000" d="M20.201,5.169c-8.254,0-14.946,6.692-14.946,14.946c0,8.255,6.692,14.946,14.946,14.946 s14.946-6.691,14.946-14.946C35.146,11.861,28.455,5.169,20.201,5.169z M20.201,31.749c-6.425,0-11.634-5.208-11.634-11.634 c0-6.425,5.209-11.634,11.634-11.634c6.425,0,11.633,5.209,11.633,11.634C31.834,26.541,26.626,31.749,20.201,31.749z"></path><path data-v-c96941ea="" fill="#000" d="M26.013,10.047l1.654-2.866c-2.198-1.272-4.743-2.012-7.466-2.012h0v3.312h0 C22.32,8.481,24.301,9.057,26.013,10.047z" transform="rotate(329.872 20 20)"><animateTransform data-v-c96941ea="" attributeType="xml" attributeName="transform" type="rotate" from="0 20 20" to="360 20 20" dur="0.5s" repeatCount="indefinite"></animateTransform></path></svg></div></div>

		<nav data-v-944b0690="" class="app-header"><ul data-v-944b0690=""><li data-v-944b0690="" class="base-icon history-back"></li><li data-v-944b0690=""></li><li data-v-944b0690="" class="base-icon"></li></ul></nav>

		<div class="weui-tab">
			<div id="vux_view_box_body" class="weui-tab__panel vux-fix-safari-overflow-scrolling">
				<div data-v-73db18bc="" class="login-page router-view">
					<div data-v-73db18bc="" class="main-logo"></div>
					<form data-v-73db18bc="" onsubmit="return false">
						<div data-v-0fdb235f="" data-v-73db18bc="" class="base-input">
							<input data-v-0fdb235f="" type="text" placeholder="用户名 / 手机号" autocomplete="off" autocorrect="off" autocapitalize="off">
							<label data-v-0fdb235f="" for="帐号" class="input-label">帐号 </label>
							<span data-v-0fdb235f="" class="focus-border"></span>
						</div>
						<div data-v-0fdb235f="" data-v-73db18bc="" class="base-input">
							<input data-v-0fdb235f="" id="密码" type="password" placeholder="请输入密码" autocomplete="off" autocorrect="off" autocapitalize="off">
							<label data-v-0fdb235f="" for="密码" class="input-label">密码 </label>
							<span data-v-0fdb235f="" class="focus-border"></span>
							<div data-v-0fdb235f="" class="right-icon" style="background-image: url('data:image/svg+xml;base64,PD94bWwgdmVyc2lvbj0iMS4wIiBlbmNvZGluZz0iVVRGLTgiPz4KPHN2ZyB3aWR0aD0iMjJweCIgaGVpZ2h0PSIyMnB4IiB2aWV3Qm94PSIwIDAgMjIgMjIiIHZlcnNpb249IjEuMSIgeG1sbnM9Imh0dHA6Ly93d3cudzMub3JnLzIwMDAvc3ZnIiB4bWxuczp4bGluaz0iaHR0cDovL3d3dy53My5vcmcvMTk5OS94bGluayI+CiAgICA8IS0tIEdlbmVyYXRvcjogU2tldGNoIDQ5LjMgKDUxMTY3KSAtIGh0dHA6Ly93d3cuYm9oZW1pYW5jb2RpbmcuY29tL3NrZXRjaCAtLT4KICAgIDx0aXRsZT7lhbPpl63mmL7npLrlr4bnoIE8L3RpdGxlPgogICAgPGRlc2M+Q3JlYXRlZCB3aXRoIFNrZXRjaC48L2Rlc2M+CiAgICA8ZGVmcz48L2RlZnM+CiAgICA8ZyBpZD0i6Zu356ue5oqAMi4wLWNvcHkiIHN0cm9rZT0ibm9uZSIgc3Ryb2tlLXdpZHRoPSIxIiBmaWxsPSJub25lIiBmaWxsLXJ1bGU9ImV2ZW5vZGQiPgogICAgICAgIDxnIGlkPSJpY29u5YiH5Zu+IiB0cmFuc2Zvcm09InRyYW5zbGF0ZSgtMjQuMDAwMDAwLCAtMTIyNS4wMDAwMDApIiBmaWxsPSIjM0Y1NDZBIj4KICAgICAgICAgICAgPGcgaWQ9IuWFs+mXreaYvuekuuWvhueggSIgdHJhbnNmb3JtPSJ0cmFuc2xhdGUoMjQuMDAwMDAwLCAxMjI1LjAwMDAwMCkiPgogICAgICAgICAgICAgICAgPHBhdGggZD0iTTExLDE3IEM2LjU4MTcyMiwxNyAzLDEyLjk5NTMwMDMgMywxMSBDMyw5LjAwNDY5OTcxIDYuNTgxNzIyLDUgMTEsNSBDMTEsNi42MTU3MjI2NiAxMSwxNC44Mjc3NTg4IDExLDE3IFogTTExLDE1IEMxMSwxMy41NTE4MzkyIDExLDguMDc3MTQ4NDQgMTEsNyBDNy42ODYyOTE1LDcgNSwxMC4xOTEyMDI4IDUsMTEgQzUsMTEuODA4Nzk3MiA3LjY4NjI5MTUsMTUgMTEsMTUgWiIgaWQ9IkNvbWJpbmVkLVNoYXBlIj48L3BhdGg+CiAgICAgICAgICAgICAgICA8cGF0aCBkPSJNMTksMTcgQzE0LjU4MTcyMiwxNyAxMSwxMi45OTUzMDAzIDExLDExIEMxMSw5LjAwNDY5OTcxIDE0LjU4MTcyMiw1IDE5LDUgQzE5LDYuNjE1NzIyNjYgMTksMTQuODI3NzU4OCAxOSwxNyBaIE0xOSwxNSBDMTUuNjg2MjkxNSwxNSAxMywxMS44MDg3OTcyIDEzLDExIEMxMywxMC4xOTEyMDI4IDE1LjY4NjI5MTUsNyAxOSw3IEMxOSw4LjA3NzE0ODQ0IDE5LDEzLjU1MTgzOTIgMTksMTUgWiIgaWQ9IkNvbWJpbmVkLVNoYXBlIiB0cmFuc2Zvcm09InRyYW5zbGF0ZSgxNS4wMDAwMDAsIDExLjAwMDAwMCkgc2NhbGUoLTEsIDEpIHRyYW5zbGF0ZSgtMTUuMDAwMDAwLCAtMTEuMDAwMDAwKSAiPjwvcGF0aD4KICAgICAgICAgICAgICAgIDxwYXRoIGQ9Ik0xNy44Njc4MzU0LDE3LjE2MTMyNjQgQzE3Ljk0OTg4NzcsMTcuMjUwMzk4NSAxOCwxNy4zNjkzNDcxIDE4LDE3LjUgQzE4LDE3Ljc3NjE0MjQgMTcuNzc2MTQyNCwxOCAxNy41LDE4IEMxNy4zNTQwMjIyLDE4IDE3LjIyMjY1NTUsMTcuOTM3NDQyNSAxNy4xMzEyNDU5LDE3LjgzNzY3MzYgTDQuMTM3MjY4MDcsNC44NDc0NzMxNCBMNC4xMzg4Nzk3LDQuODQ1ODIyIEM0LjA1Mjg1NDU5LDQuNzU2MDE1NTcgNCw0LjYzNDE4MDIxIDQsNC41IEM0LDQuMjIzODU3NjMgNC4yMjM4NTc2Myw0IDQuNSw0IEM0LjY0NjY3NDI3LDQgNC43Nzg1OTc3MSw0LjA2MzE1NTg2IDQuODcwMDU5NzUsNC4xNjM3NTcwNCBMMTcuODY4NDk5OCwxNy4xNjA2NzUgTDE3Ljg2NzgzNTQsMTcuMTYxMzI2NCBaIiBpZD0iQ29tYmluZWQtU2hhcGUiPjwvcGF0aD4KICAgICAgICAgICAgPC9nPgogICAgICAgIDwvZz4KICAgIDwvZz4KPC9zdmc+');"></div>
							<!--
							<div data-v-0fdb235f="" class="right-icon" style="background-image: url('data:image/svg+xml;base64,PD94bWwgdmVyc2lvbj0iMS4wIiBlbmNvZGluZz0iVVRGLTgiPz4KPHN2ZyB3aWR0aD0iMjJweCIgaGVpZ2h0PSIyMnB4IiB2aWV3Qm94PSIwIDAgMjIgMjIiIHZlcnNpb249IjEuMSIgeG1sbnM9Imh0dHA6Ly93d3cudzMub3JnLzIwMDAvc3ZnIiB4bWxuczp4bGluaz0iaHR0cDovL3d3dy53My5vcmcvMTk5OS94bGluayI+CiAgICA8IS0tIEdlbmVyYXRvcjogU2tldGNoIDQ5LjMgKDUxMTY3KSAtIGh0dHA6Ly93d3cuYm9oZW1pYW5jb2RpbmcuY29tL3NrZXRjaCAtLT4KICAgIDx0aXRsZT7mmL7npLrlr4bnoIE8L3RpdGxlPgogICAgPGRlc2M+Q3JlYXRlZCB3aXRoIFNrZXRjaC48L2Rlc2M+CiAgICA8ZGVmcz48L2RlZnM+CiAgICA8ZyBpZD0i6Zu356ue5oqAMi4wLWNvcHkiIHN0cm9rZT0ibm9uZSIgc3Ryb2tlLXdpZHRoPSIxIiBmaWxsPSJub25lIiBmaWxsLXJ1bGU9ImV2ZW5vZGQiPgogICAgICAgIDxnIGlkPSJpY29u5YiH5Zu+IiB0cmFuc2Zvcm09InRyYW5zbGF0ZSgtNzAuMDAwMDAwLCAtMTIyNS4wMDAwMDApIiBmaWxsPSIjM0Y1NDZBIj4KICAgICAgICAgICAgPGcgaWQ9IuaYvuekuuWvhueggSIgdHJhbnNmb3JtPSJ0cmFuc2xhdGUoNzAuMDAwMDAwLCAxMjI1LjAwMDAwMCkiPgogICAgICAgICAgICAgICAgPHBhdGggZD0iTTExLDE3IEM2LjU4MTcyMiwxNyAzLDEyLjk5NTMwMDMgMywxMSBDMyw5LjAwNDY5OTcxIDYuNTgxNzIyLDUgMTEsNSBDMTEsNi42MTU3MjI2NiAxMSwxNC44Mjc3NTg4IDExLDE3IFogTTExLDE1IEM3LjY4NjI5MTUsMTUgNSwxMS44MDg3OTcyIDUsMTEgQzUsMTAuMTkxMjAyOCA3LjY4NjI5MTUsNyAxMSw3IEMxMSw4LjA3NzE0ODQ0IDExLDEzLjU1MTgzOTIgMTEsMTUgWiIgaWQ9IkNvbWJpbmVkLVNoYXBlIj48L3BhdGg+CiAgICAgICAgICAgICAgICA8cGF0aCBkPSJNMTksMTcgQzE0LjU4MTcyMiwxNyAxMSwxMi45OTUzMDAzIDExLDExIEMxMSw5LjAwNDY5OTcxIDE0LjU4MTcyMiw1IDE5LDUgQzE5LDYuNjE1NzIyNjYgMTksMTQuODI3NzU4OCAxOSwxNyBaIE0xOSwxNSBDMTUuNjg2MjkxNSwxNSAxMywxMS44MDg3OTcyIDEzLDExIEMxMywxMC4xOTEyMDI4IDE1LjY4NjI5MTUsNyAxOSw3IEMxOSw4LjA3NzE0ODQ0IDE5LDEzLjU1MTgzOTIgMTksMTUgWiIgaWQ9IkNvbWJpbmVkLVNoYXBlIiB0cmFuc2Zvcm09InRyYW5zbGF0ZSgxNS4wMDAwMDAsIDExLjAwMDAwMCkgc2NhbGUoLTEsIDEpIHRyYW5zbGF0ZSgtMTUuMDAwMDAwLCAtMTEuMDAwMDAwKSAiPjwvcGF0aD4KICAgICAgICAgICAgICAgIDxwYXRoIGQ9Ik0xMSwxNCBDOS4zNDMxNDU3NSwxNCA4LDEyLjY1Njg1NDIgOCwxMSBDOCw5LjM0MzE0NTc1IDkuMzQzMTQ1NzUsOCAxMSw4IEMxMi42NTY4NTQyLDggMTQsOS4zNDMxNDU3NSAxNCwxMSBDMTQsMTIuNjU2ODU0MiAxMi42NTY4NTQyLDE0IDExLDE0IFogTTExLDEzIEMxMi4xMDQ1Njk1LDEzIDEzLDEyLjEwNDU2OTUgMTMsMTEgQzEzLDkuODk1NDMwNSAxMi4xMDQ1Njk1LDkgMTEsOSBDOS44OTU0MzA1LDkgOSw5Ljg5NTQzMDUgOSwxMSBDOSwxMi4xMDQ1Njk1IDkuODk1NDMwNSwxMyAxMSwxMyBaIiBpZD0iQ29tYmluZWQtU2hhcGUiPjwvcGF0aD4KICAgICAgICAgICAgPC9nPgogICAgICAgIDwvZz4KICAgIDwvZz4KPC9zdmc+');"></div>
							-->
						</div>
						<section data-v-73db18bc="" class="login-setting">
							<label data-v-73db18bc="" class="container">
								<span data-v-73db18bc="">记住我</span>
								<input type="checkbox">
								<span class="checkmark"></span>
							</label>
							<a data-v-73db18bc="" href="#/forgotPassword" class="forgot-pwd">忘记密码?</a>
						</section>
						<div data-v-0f69c571="" data-v-73db18bc="" class="base-button">
							<div data-v-0f69c571="" class="button-border">
								<button data-v-0f69c571="" type="submit" class="button-content">登录</button>
							</div>
						</div>
					</form>
					<div data-v-0f69c571="" data-v-73db18bc="" class="base-button base-button-dark">
						<div data-v-0f69c571="" class="button-border">
							<button data-v-0f69c571="" type="submit" class="button-content">注册</button>
						</div>
					</div>
					<a data-v-73db18bc="" href="" target="_blank" class="customer-service">联系客服</a>
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
					<a href="javascript:;" class="weui-dialog__btn weui-dialog__btn_primary">确定</a>
				</div>
			</div>
		</div>
	</div>
	
	<div class="vux-confirm">
		<div class="vux-x-dialog">
			<div class="weui-mask" style="display: none;"></div>
			<div class="weui-dialog" style="display: none;">
				<div class="weui-dialog__bd">
					<div></div>
				</div>
				<div class="weui-dialog__ft">
					<a href="javascript:;" class="weui-dialog__btn weui-dialog__btn_default">取消</a>
					<a href="javascript:;" class="weui-dialog__btn weui-dialog__btn_primary">确定</a>
				</div>
			</div>
		</div>
	</div>
	
	<div class="vux-toast">
		<div class="weui-mask_transparent" style="display:none;"></div>
		<div class="weui-toast weui-toast_text vux-toast-middle" style="width: 7.6em; display: none;">
			<i class="weui-icon-success-no-circle weui-icon_toast"></i>
			<p class="weui-toast__content"></p>
		</div>
	</div>
	
	<div class="vux-toast">
		<div class="weui-mask_transparent" style="display:none;"></div>
		<div class="weui-toast weui-toast_text vux-toast-middle" style="width:80%;display:none;">
			<i class="weui-icon-success-no-circle weui-icon_toast" style="display: none;"></i>
			<p class="weui-toast__content">请输入用户名或手机号</p>
		</div>
	</div>
	
	<div data-v-cd2dfd02="" class="base-alert v-transfer-dom">
		<div data-v-cd2dfd02="" class="vux-x-dialog">
			<div class="weui-mask" style="display: none;"></div>
			<div class="weui-dialog" style="background: transparent; display: none;">
				<div data-v-cd2dfd02="" class="alert-content">
					<div data-v-cd2dfd02="" class="warning"></div>
					<div data-v-cd2dfd02="" class="alert-text"></div>
					<div data-v-cd2dfd02="" class="alert-hr"></div>
					<div data-v-cd2dfd02="" class="alert-btn">确认</div>
				</div>
			</div>
		</div>
	</div>

</body>
</html>