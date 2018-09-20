<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%><!DOCTYPE html>
<html>
<head>
<title>用户通知 - <%=com.yy.guess.util.Util.getConfigCom(application).getWebTitle()%></title>
<%@include file="/m/head-common.jsp"%>
<script src="m/js/mescroll.min.js"></script>
<script src="m/js/usercenter.js"></script>
<link href="m/js/mescroll.min.css" rel="stylesheet">
<style type="text/css">
.notice-icon{background-image:url('data:image/svg+xml;base64,PD94bWwgdmVyc2lvbj0iMS4wIiBlbmNvZGluZz0iVVRGLTgiPz4KPHN2ZyB3aWR0aD0iMjRweCIgaGVpZ2h0PSIyNHB4IiB2aWV3Qm94PSIwIDAgMjQgMjQiIHZlcnNpb249IjEuMSIgeG1sbnM9Imh0dHA6Ly93d3cudzMub3JnLzIwMDAvc3ZnIiB4bWxuczp4bGluaz0iaHR0cDovL3d3dy53My5vcmcvMTk5OS94bGluayI+CiAgICA8IS0tIEdlbmVyYXRvcjogU2tldGNoIDQ5LjMgKDUxMTY3KSAtIGh0dHA6Ly93d3cuYm9oZW1pYW5jb2RpbmcuY29tL3NrZXRjaCAtLT4KICAgIDx0aXRsZT7kuK3lpZbkv6Hmga88L3RpdGxlPgogICAgPGRlc2M+Q3JlYXRlZCB3aXRoIFNrZXRjaC48L2Rlc2M+CiAgICA8ZGVmcz48L2RlZnM+CiAgICA8ZyBpZD0i6Zu356ue5oqAMi4w77yI6LCD5pW0djAx77yJIiBzdHJva2U9Im5vbmUiIHN0cm9rZS13aWR0aD0iMSIgZmlsbD0ibm9uZSIgZmlsbC1ydWxlPSJldmVub2RkIj4KICAgICAgICA8ZyBpZD0iaWNvbuWIh+WbviIgdHJhbnNmb3JtPSJ0cmFuc2xhdGUoLTIwNi4wMDAwMDAsIC0xMzE3LjAwMDAwMCkiPgogICAgICAgICAgICA8ZyBpZD0i5Lit5aWW5L+h5oGvIiB0cmFuc2Zvcm09InRyYW5zbGF0ZSgyMDYuMDAwMDAwLCAxMzE3LjAwMDAwMCkiPgogICAgICAgICAgICAgICAgPHBhdGggZD0iTTE4LDEyIEwxOCw5IEMxOCw4LjQ0NzcxNTI1IDE3LjU1MjI4NDcsOCAxNyw4IEw3LDggQzYuNDQ3NzE1MjUsOCA2LDguNDQ3NzE1MjUgNiw5IEw2LDEyIEw1LDEyIEM0LjQ0NzcxNTI1LDEyIDQsMTEuNTUyMjg0NyA0LDExIEw0LDggQzQsNi44OTU0MzA1IDQuODk1NDMwNSw2IDYsNiBMMTgsNiBDMTkuMTA0NTY5NSw2IDIwLDYuODk1NDMwNSAyMCw4IEwyMCwxMSBDMjAsMTEuNTUyMjg0NyAxOS41NTIyODQ3LDEyIDE5LDEyIEwxOCwxMiBaIiBpZD0iQ29tYmluZWQtU2hhcGUiIGZpbGw9IiNFNTJCRjMiIGZpbGwtcnVsZT0iZXZlbm9kZCI+PC9wYXRoPgogICAgICAgICAgICAgICAgPHBhdGggZD0iTTcsMTAgTDcsMTggQzcsMTguNTUyMjg0NyA3LjQ0NzcxNTI1LDE5IDgsMTkgTDE2LDE5IEMxNi41NTIyODQ3LDE5IDE3LDE4LjU1MjI4NDcgMTcsMTggTDE3LDEwIEwxOSwxMCBMMTksMTkgQzE5LDIwLjEwNDU2OTUgMTguMTA0NTY5NSwyMSAxNywyMSBMNywyMSBDNS44OTU0MzA1LDIxIDUsMjAuMTA0NTY5NSA1LDE5IEw1LDEwIEw3LDEwIFoiIGlkPSJDb21iaW5lZC1TaGFwZSIgZmlsbD0iI0U1MkJGMyIgZmlsbC1ydWxlPSJldmVub2RkIj48L3BhdGg+CiAgICAgICAgICAgICAgICA8cGF0aCBkPSJNNi41LDEwLjUgTDEzLjUsMTAuNSBMNi41LDEwLjUgWiBNMTUuNSwxMC41IEwxNy41LDEwLjUgTDE1LjUsMTAuNSBaIiBpZD0iQ29tYmluZWQtU2hhcGUiIHN0cm9rZT0iI0JBM0ZGRiIgc3Ryb2tlLXdpZHRoPSIxIj48L3BhdGg+CiAgICAgICAgICAgICAgICA8cGF0aCBkPSJNMTEuNSw1LjE0NTE0MDE0IEwxMS41Nzc3ODk4LDUuMjY3ODQwNTYgTDExLjUsNSBMMTEuNSw1LjE0NTE0MDE0IFogTTExLjUsNS41IEwxMS41LDYgTDEyLDUuNSBMMTEuNSw1LjUgWiBNOC45ODMxMjU4NCw1LjUgTDguOTU1MDc4MTIsNS41IEw4Ljk1NTA3ODEyLDYgTDkuMzk2MjYwNjksNi4yMzUyODI3IEw5Ljc3OTA4NjY0LDUuNTE3NDM5MjcgTDguOTgzMTI1ODQsNS41IFoiIGlkPSJDb21iaW5lZC1TaGFwZSIgc3Ryb2tlPSIjQkEzRkZGIiBzdHJva2Utd2lkdGg9IjEiPjwvcGF0aD4KICAgICAgICAgICAgICAgIDxwYXRoIGQ9Ik0xNi41LDUuMTQ1MTQwMTQgTDE2LjU3Nzc4OTgsNS4yNjc4NDA1NiBMMTYuNSw1IEwxNi41LDUuMTQ1MTQwMTQgWiBNMTYuNSw1LjUgTDE2LjUsNiBMMTcsNS41IEwxNi41LDUuNSBaIE0xMy45ODMxMjU4LDUuNSBMMTMuOTU1MDc4MSw1LjUgTDEzLjk1NTA3ODEsNiBMMTQuMzk2MjYwNyw2LjIzNTI4MjcgTDE0Ljc3OTA4NjYsNS41MTc0MzkyNyBMMTMuOTgzMTI1OCw1LjUgWiIgaWQ9IkNvbWJpbmVkLVNoYXBlIiBzdHJva2U9IiNCQTNGRkYiIHN0cm9rZS13aWR0aD0iMSIgdHJhbnNmb3JtPSJ0cmFuc2xhdGUoMTQuNTAwMDAwLCA0LjAwMDAwMCkgc2NhbGUoLTEsIDEpIHRyYW5zbGF0ZSgtMTQuNTAwMDAwLCAtNC4wMDAwMDApICI+PC9wYXRoPgogICAgICAgICAgICA8L2c+CiAgICAgICAgPC9nPgogICAgPC9nPgo8L3N2Zz4=');}
#vux_view_box_body::-webkit-scrollbar{display:none;width:0;height:0;}
</style>
</head>
<body>
	<div id="app">
		<nav data-v-1db5fc32="" class="app-header">
			<ul data-v-1db5fc32="">
				<li data-v-1db5fc32="" onclick="window.location.href='m/usercenter/menu.jsp'" class="base-icon history-back"></li>
				<li data-v-1db5fc32="">用户通知</li>
				<li data-v-1db5fc32="" class="base-icon"></li>
			</ul>
		</nav>
		<div class="weui-tab">
			<div id="vux_view_box_body" class="weui-tab__panel vux-fix-safari-overflow-scrolling mescroll">
				<div data-v-6a2bb1cf="" class="notice-page router-view">
					<!--
					<section data-v-6a2bb1cf="" class="notice-content">
						<div data-v-6a2bb1cf="" class="content-title">
							<div data-v-6a2bb1cf="" class="notice-icon"></div>
							<div data-v-6a2bb1cf="">恭喜中奖</div>
							<div data-v-6a2bb1cf="" class="notice-time">2018年9月3日 20:16:11</div>
						</div>
						<div data-v-6a2bb1cf="" class="content-body"><div data-v-6a2bb1cf="">盈利0.00</div></div>
					</section>
					-->
				</div>
			</div>
		</div>
	</div>
</body>
</html>