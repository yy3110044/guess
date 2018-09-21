<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%><!DOCTYPE html>
<html>
<head>
<title>- <%=com.yy.guess.util.Util.getConfigCom(application).getWebTitle()%></title>
<%@include file="/m/head-common.jsp"%>
<script src="m/js/usercenter.js"></script>
</head>
<body>
	<div id="app">
		<nav data-v-1db5fc32="" class="app-header">
			<ul data-v-1db5fc32="">
				<li data-v-1db5fc32="" onclick="window.location.href='m/usercenter/setting/index.jsp'" class="base-icon history-back"></li>
				<li data-v-1db5fc32="">资料设置</li>
				<li data-v-1db5fc32="" class="base-icon"></li>
			</ul>
		</nav>
		<div class="weui-tab">
			<div id="vux_view_box_body" class="weui-tab__panel vux-fix-safari-overflow-scrolling">
				<div data-v-eb935aa0="" class="change-mobile-page router-view">
					<form data-v-eb935aa0="" onsubmit="return false">

						<div data-v-0fdb235f="" data-v-eb935aa0="" class="base-input">
							<input data-v-0fdb235f="" id="nickName" type="text" placeholder="请输入昵称">
							<label data-v-0fdb235f="" for="nickName" class="input-label">昵称</label>
							<span data-v-0fdb235f="" class="focus-border"></span>
							<!--
							<div data-v-0fdb235f="" class="helper-text"><div data-v-0fdb235f="" class="alert-icon"></div><div data-v-0fdb235f=""></div></div>
							 -->
						</div>
						
						<div data-v-0fdb235f="" data-v-eb935aa0="" class="base-input">
							<input data-v-0fdb235f="" id="qq" type="text" placeholder="请输入QQ">
							<label data-v-0fdb235f="" for="qq" class="input-label">QQ</label>
							<span data-v-0fdb235f="" class="focus-border"></span>
						</div>
						
						<div data-v-0fdb235f="" data-v-eb935aa0="" class="base-input">
							<input data-v-0fdb235f="" id="email" type="text" placeholder="请输入邮箱">
							<label data-v-0fdb235f="" for="email" class="input-label">邮箱</label>
							<span data-v-0fdb235f="" class="focus-border"></span>
						</div>

						<div data-v-eb935aa0="" style="height:26px;"></div>
						<div data-v-0f69c571="" data-v-eb935aa0="" class="base-button">
							<div data-v-0f69c571="" class="button-border"><button data-v-0f69c571="" type="button" class="button-content">确认</button></div>
						</div>
					</form>
				</div>
			</div>
		</div>
	</div>
</body>
</html>