<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%><!DOCTYPE html>
<html>
<head>
<title>设置 - <%=com.yy.guess.util.Util.getConfigCom(application).getWebTitle()%></title>
<%@include file="/m/head-common.jsp"%>
<script src="m/js/usercenter.js"></script>
</head>
<body>
	<div id="app">
		<nav data-v-1db5fc32="" class="app-header">
			<ul data-v-1db5fc32="">
				<li data-v-1db5fc32="" onclick="window.location.href='m/usercenter/menu.jsp'" class="base-icon history-back"></li>
				<li data-v-1db5fc32="">设置</li>
				<li data-v-1db5fc32="" class="base-icon"></li>
			</ul>
		</nav>
		<div class="weui-tab dark-view">
			<div id="vux_view_box_body"
				class="weui-tab__panel vux-fix-safari-overflow-scrolling">
				<div data-v-70e7ffa8="" class="setting router-view">
					<div data-v-70e7ffa8="">
						<div class="weui-cells vux-no-group-title">
							<div data-v-70e7ffa8="" class="weui-cell" id="realName">
								<div class="weui-cell__hd"></div>
								<div class="vux-cell-bd vux-cell-primary"><p><label class="vux-label">真实姓名</label></p><span class="vux-label-desc"></span></div>
								<div class="weui-cell__ft"><p data-v-70e7ffa8="" class="cell-text"></p></div>
							</div>
							<div data-v-70e7ffa8="" class="weui-cell vux-tap-active weui-cell_access">
								<div class="weui-cell__hd"></div>
								<div class="vux-cell-bd vux-cell-primary"><p><label class="vux-label">修改手机</label></p><span class="vux-label-desc"></span></div>
								<div class="weui-cell__ft"><p data-v-70e7ffa8="" class="cell-text">15182830910</p></div>
							</div>
							<div data-v-70e7ffa8="" class="weui-cell vux-tap-active weui-cell_access">
								<div class="weui-cell__hd"></div>
								<div class="vux-cell-bd vux-cell-primary"><p><label class="vux-label">修改生日</label></p><span class="vux-label-desc"></span></div>
								<div class="weui-cell__ft"><p data-v-70e7ffa8="" class="cell-text">请选择您的生日</p></div>
							</div>
						</div>
					</div>
					<div data-v-70e7ffa8="">
						<div class="weui-cells vux-no-group-title">
							<div data-v-70e7ffa8="" class="weui-cell vux-tap-active weui-cell_access">
								<div class="weui-cell__hd"></div>
								<div class="vux-cell-bd vux-cell-primary"><p><label class="vux-label">管理银行卡</label></p><span class="vux-label-desc"></span></div>
								<div class="weui-cell__ft"></div>
							</div>
							<div data-v-70e7ffa8="" class="weui-cell vux-tap-active weui-cell_access">
								<div class="weui-cell__hd"></div>
								<div class="vux-cell-bd vux-cell-primary"><p><label class="vux-label">修改密码</label></p><span class="vux-label-desc"></span></div>
								<div class="weui-cell__ft"></div>
							</div>
						</div>
					</div>
					<div data-v-70e7ffa8="">
						<div class="weui-cells vux-no-group-title">
							<div data-v-70e7ffa8="" class="weui-cell" id="logout">
								<div class="weui-cell__hd"></div>
								<div class="vux-cell-bd vux-cell-primary"><p><label class="vux-label">退出登录</label></p><span class="vux-label-desc"></span></div>
								<div class="weui-cell__ft"></div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</body>
</html>