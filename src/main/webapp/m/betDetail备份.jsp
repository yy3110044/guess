<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%><!DOCTYPE html>
<html>
<head>
<title>下注详情 - <%=com.yy.guess.util.Util.getConfigCom(application).getWebTitle()%></title>
<%@include file="/m/head-common.jsp"%>
<script src="m/js/betDetail.js"></script>
<style type="text/css">
#vux_view_box_body::-webkit-scrollbar{display:none;width:0;height:0;}
.betting-odds .stage-title{height:18px !important;}
.ping{background-position: 50%;background-repeat: no-repeat;width: 28px;height: 34px;background-image:url('data:image/svg+xml;base64,PD94bWwgdmVyc2lvbj0iMS4wIiBlbmNvZGluZz0iVVRGLTgiPz4KPHN2ZyB3aWR0aD0iMjhweCIgaGVpZ2h0PSIzNHB4IiB2aWV3Qm94PSIwIDAgMjggMzQiIHZlcnNpb249IjEuMSIgeG1sbnM9Imh0dHA6Ly93d3cudzMub3JnLzIwMDAvc3ZnIiB4bWxuczp4bGluaz0iaHR0cDovL3d3dy53My5vcmcvMTk5OS94bGluayI+CiAgICA8IS0tIEdlbmVyYXRvcjogU2tldGNoIDQ5LjMgKDUxMTY3KSAtIGh0dHA6Ly93d3cuYm9oZW1pYW5jb2RpbmcuY29tL3NrZXRjaCAtLT4KICAgIDx0aXRsZT7lubPlsYDlm77moIc8L3RpdGxlPgogICAgPGRlc2M+Q3JlYXRlZCB3aXRoIFNrZXRjaC48L2Rlc2M+CiAgICA8ZGVmcz4KICAgICAgICA8bGluZWFyR3JhZGllbnQgeDE9IjUwJSIgeTE9IjAlIiB4Mj0iNTAlIiB5Mj0iMTAwJSIgaWQ9ImxpbmVhckdyYWRpZW50LTEiPgogICAgICAgICAgICA8c3RvcCBzdG9wLWNvbG9yPSIjOEUwRjE2IiBvZmZzZXQ9IjAlIj48L3N0b3A+CiAgICAgICAgICAgIDxzdG9wIHN0b3AtY29sb3I9IiM3QzEwMTAiIHN0b3Atb3BhY2l0eT0iMCIgb2Zmc2V0PSIxMDAlIj48L3N0b3A+CiAgICAgICAgPC9saW5lYXJHcmFkaWVudD4KICAgICAgICA8cmFkaWFsR3JhZGllbnQgY3g9IjMwLjU0MTA1MzQlIiBjeT0iMi43NTY4MDk1NCUiIGZ4PSIzMC41NDEwNTM0JSIgZnk9IjIuNzU2ODA5NTQlIiByPSIxMTIuNDI4OTQxJSIgZ3JhZGllbnRUcmFuc2Zvcm09InRyYW5zbGF0ZSgwLjMwNTQxMSwwLjAyNzU2OCksc2NhbGUoMS4wMDAwMDAsMC42MDYwNjEpLHJvdGF0ZSg5OC40MTQ1NzkpLHNjYWxlKDEuMDAwMDAwLDAuMjI0MDQwKSx0cmFuc2xhdGUoLTAuMzA1NDExLC0wLjAyNzU2OCkiIGlkPSJyYWRpYWxHcmFkaWVudC0yIj4KICAgICAgICAgICAgPHN0b3Agc3RvcC1jb2xvcj0iI0ZGMjIyMiIgb2Zmc2V0PSIwJSI+PC9zdG9wPgogICAgICAgICAgICA8c3RvcCBzdG9wLWNvbG9yPSIjRkYyMjIyIiBzdG9wLW9wYWNpdHk9IjAiIG9mZnNldD0iMTAwJSI+PC9zdG9wPgogICAgICAgIDwvcmFkaWFsR3JhZGllbnQ+CiAgICAgICAgPHJhZGlhbEdyYWRpZW50IGN4PSI3Ny4xNjQ0MDU2JSIgY3k9IjIuODAwNjg4ODclIiBmeD0iNzcuMTY0NDA1NiUiIGZ5PSIyLjgwMDY4ODg3JSIgcj0iNDQuNTA4MDQwMSUiIGdyYWRpZW50VHJhbnNmb3JtPSJ0cmFuc2xhdGUoMC43NzE2NDQsMC4wMjgwMDcpLHNjYWxlKDEuMDAwMDAwLDAuNjA2MDYxKSxyb3RhdGUoOTAuMDAwMDAwKSxzY2FsZSgxLjAwMDAwMCwwLjQwMzczOSksdHJhbnNsYXRlKC0wLjc3MTY0NCwtMC4wMjgwMDcpIiBpZD0icmFkaWFsR3JhZGllbnQtMyI+CiAgICAgICAgICAgIDxzdG9wIHN0b3AtY29sb3I9IiNGRjIyMjIiIG9mZnNldD0iMCUiPjwvc3RvcD4KICAgICAgICAgICAgPHN0b3Agc3RvcC1jb2xvcj0iI0ZGMjIyMiIgc3RvcC1vcGFjaXR5PSIwIiBvZmZzZXQ9IjEwMCUiPjwvc3RvcD4KICAgICAgICA8L3JhZGlhbEdyYWRpZW50PgogICAgICAgIDxwb2x5Z29uIGlkPSJwYXRoLTQiIHBvaW50cz0iNCAwIDI0IDAgMjQgMjkgMTQgMzMgNCAyOSI+PC9wb2x5Z29uPgogICAgICAgIDxmaWx0ZXIgeD0iLTUuMCUiIHk9Ii0zLjAlIiB3aWR0aD0iMTEwLjAlIiBoZWlnaHQ9IjEwNi4xJSIgZmlsdGVyVW5pdHM9Im9iamVjdEJvdW5kaW5nQm94IiBpZD0iZmlsdGVyLTUiPgogICAgICAgICAgICA8ZmVHYXVzc2lhbkJsdXIgc3RkRGV2aWF0aW9uPSIxIiBpbj0iU291cmNlQWxwaGEiIHJlc3VsdD0ic2hhZG93Qmx1cklubmVyMSI+PC9mZUdhdXNzaWFuQmx1cj4KICAgICAgICAgICAgPGZlT2Zmc2V0IGR4PSIwIiBkeT0iMCIgaW49InNoYWRvd0JsdXJJbm5lcjEiIHJlc3VsdD0ic2hhZG93T2Zmc2V0SW5uZXIxIj48L2ZlT2Zmc2V0PgogICAgICAgICAgICA8ZmVDb21wb3NpdGUgaW49InNoYWRvd09mZnNldElubmVyMSIgaW4yPSJTb3VyY2VBbHBoYSIgb3BlcmF0b3I9ImFyaXRobWV0aWMiIGsyPSItMSIgazM9IjEiIHJlc3VsdD0ic2hhZG93SW5uZXJJbm5lcjEiPjwvZmVDb21wb3NpdGU+CiAgICAgICAgICAgIDxmZUNvbG9yTWF0cml4IHZhbHVlcz0iMCAwIDAgMCAwLjQ3MDU4ODIzNSAgIDAgMCAwIDAgMCAgIDAgMCAwIDAgMCAgMCAwIDAgMC40OTg2MTI5OTggMCIgdHlwZT0ibWF0cml4IiBpbj0ic2hhZG93SW5uZXJJbm5lcjEiPjwvZmVDb2xvck1hdHJpeD4KICAgICAgICA8L2ZpbHRlcj4KICAgICAgICA8bGluZWFyR3JhZGllbnQgeDE9IjAlIiB5MT0iOTguOTY3NjM1NiUiIHgyPSIxMDAlIiB5Mj0iOTguOTY3NjM1NiUiIGlkPSJsaW5lYXJHcmFkaWVudC02Ij4KICAgICAgICAgICAgPHN0b3Agc3RvcC1jb2xvcj0iI0ZGMjIyMiIgc3RvcC1vcGFjaXR5PSIwIiBvZmZzZXQ9IjAlIj48L3N0b3A+CiAgICAgICAgICAgIDxzdG9wIHN0b3AtY29sb3I9IiNCRTAwMDAiIG9mZnNldD0iMTMuMjc3MTgxJSI+PC9zdG9wPgogICAgICAgICAgICA8c3RvcCBzdG9wLWNvbG9yPSIjQkUwMDAwIiBvZmZzZXQ9Ijg2LjU5ODMwNzMlIj48L3N0b3A+CiAgICAgICAgICAgIDxzdG9wIHN0b3AtY29sb3I9IiNGRjIyMjIiIHN0b3Atb3BhY2l0eT0iMCIgb2Zmc2V0PSIxMDAlIj48L3N0b3A+CiAgICAgICAgPC9saW5lYXJHcmFkaWVudD4KICAgICAgICA8cG9seWdvbiBpZD0icGF0aC03IiBwb2ludHM9IjAgMCAyOCAwIDI4IDEgMCAxIj48L3BvbHlnb24+CiAgICAgICAgPHRleHQgaWQ9InRleHQtOCIgZm9udC1mYW1pbHk9IlBpbmdGYW5nU0MtTWVkaXVtLCBQaW5nRmFuZyBTQyIgZm9udC1zaXplPSIxNCIgZm9udC13ZWlnaHQ9IjQwMCIgZmlsbD0iI0ZGRUFCOCI+CiAgICAgICAgICAgIDx0c3BhbiB4PSI3IiB5PSIyNCI+5bmzPC90c3Bhbj4KICAgICAgICA8L3RleHQ+CiAgICAgICAgPGZpbHRlciB4PSItMjEuNCUiIHk9Ii0xNS4wJSIgd2lkdGg9IjE0Mi45JSIgaGVpZ2h0PSIxMzAuMCUiIGZpbHRlclVuaXRzPSJvYmplY3RCb3VuZGluZ0JveCIgaWQ9ImZpbHRlci05Ij4KICAgICAgICAgICAgPGZlT2Zmc2V0IGR4PSIwIiBkeT0iMCIgaW49IlNvdXJjZUFscGhhIiByZXN1bHQ9InNoYWRvd09mZnNldE91dGVyMSI+PC9mZU9mZnNldD4KICAgICAgICAgICAgPGZlR2F1c3NpYW5CbHVyIHN0ZERldmlhdGlvbj0iMSIgaW49InNoYWRvd09mZnNldE91dGVyMSIgcmVzdWx0PSJzaGFkb3dCbHVyT3V0ZXIxIj48L2ZlR2F1c3NpYW5CbHVyPgogICAgICAgICAgICA8ZmVDb2xvck1hdHJpeCB2YWx1ZXM9IjAgMCAwIDAgMC41NTY4NjI3NDUgICAwIDAgMCAwIDAuMDU0OTAxOTYwOCAgIDAgMCAwIDAgMC4wODYyNzQ1MDk4ICAwIDAgMCAxIDAiIHR5cGU9Im1hdHJpeCIgaW49InNoYWRvd0JsdXJPdXRlcjEiPjwvZmVDb2xvck1hdHJpeD4KICAgICAgICA8L2ZpbHRlcj4KICAgIDwvZGVmcz4KICAgIDxnIGlkPSLpm7fnq57mioAyLjAtY29weSIgc3Ryb2tlPSJub25lIiBzdHJva2Utd2lkdGg9IjEiIGZpbGw9Im5vbmUiIGZpbGwtcnVsZT0iZXZlbm9kZCI+CiAgICAgICAgPGcgaWQ9Imljb27liIflm74iIHRyYW5zZm9ybT0idHJhbnNsYXRlKC04NC4wMDAwMDAsIC0xMTc0LjAwMDAwMCkiPgogICAgICAgICAgICA8ZyBpZD0iR3JvdXAtNCIgdHJhbnNmb3JtPSJ0cmFuc2xhdGUoODQuMDAwMDAwLCAxMTc0LjAwMDAwMCkiPgogICAgICAgICAgICAgICAgPHBvbHlnb24gaWQ9IlJlY3RhbmdsZS00IiBmaWxsPSIjRkYyMjIyIiBwb2ludHM9IjMgMCAyNSAwIDI1IDI5LjUgMTQgMzQgMyAyOS41Ij48L3BvbHlnb24+CiAgICAgICAgICAgICAgICA8ZyBpZD0iUmVjdGFuZ2xlLTQiPgogICAgICAgICAgICAgICAgICAgIDx1c2UgZmlsbD0iI0ZGMjIyMiIgZmlsbC1ydWxlPSJldmVub2RkIiB4bGluazpocmVmPSIjcGF0aC00Ij48L3VzZT4KICAgICAgICAgICAgICAgICAgICA8dXNlIGZpbGwtb3BhY2l0eT0iMC43IiBmaWxsPSJ1cmwoI2xpbmVhckdyYWRpZW50LTEpIiBmaWxsLXJ1bGU9ImV2ZW5vZGQiIHhsaW5rOmhyZWY9IiNwYXRoLTQiPjwvdXNlPgogICAgICAgICAgICAgICAgICAgIDx1c2UgZmlsbD0idXJsKCNyYWRpYWxHcmFkaWVudC0yKSIgZmlsbC1ydWxlPSJldmVub2RkIiB4bGluazpocmVmPSIjcGF0aC00Ij48L3VzZT4KICAgICAgICAgICAgICAgICAgICA8dXNlIGZpbGwtb3BhY2l0eT0iMC40IiBmaWxsPSJ1cmwoI3JhZGlhbEdyYWRpZW50LTMpIiBmaWxsLXJ1bGU9ImV2ZW5vZGQiIHhsaW5rOmhyZWY9IiNwYXRoLTQiPjwvdXNlPgogICAgICAgICAgICAgICAgICAgIDx1c2UgZmlsbD0iYmxhY2siIGZpbGwtb3BhY2l0eT0iMSIgZmlsdGVyPSJ1cmwoI2ZpbHRlci01KSIgeGxpbms6aHJlZj0iI3BhdGgtNCI+PC91c2U+CiAgICAgICAgICAgICAgICA8L2c+CiAgICAgICAgICAgICAgICA8ZyBpZD0iUmVjdGFuZ2xlIiB0cmFuc2Zvcm09InRyYW5zbGF0ZSgxNC4wMDAwMDAsIDAuNTAwMDAwKSBzY2FsZSgxLCAtMSkgdHJhbnNsYXRlKC0xNC4wMDAwMDAsIC0wLjUwMDAwMCkgIj4KICAgICAgICAgICAgICAgICAgICA8dXNlIGZpbGw9InVybCgjbGluZWFyR3JhZGllbnQtNikiIHhsaW5rOmhyZWY9IiNwYXRoLTciPjwvdXNlPgogICAgICAgICAgICAgICAgICAgIDx1c2UgZmlsbC1vcGFjaXR5PSIwLjMiIGZpbGw9IiMxRjJGNDkiIHhsaW5rOmhyZWY9IiNwYXRoLTciPjwvdXNlPgogICAgICAgICAgICAgICAgPC9nPgogICAgICAgICAgICAgICAgPGcgaWQ9IuiDnCIgZmlsbD0iI0ZGRUFCOCIgZmlsbC1vcGFjaXR5PSIxIj4KICAgICAgICAgICAgICAgICAgICA8dXNlIGZpbHRlcj0idXJsKCNmaWx0ZXItOSkiIHhsaW5rOmhyZWY9IiN0ZXh0LTgiPjwvdXNlPgogICAgICAgICAgICAgICAgICAgIDx1c2UgeGxpbms6aHJlZj0iI3RleHQtOCI+PC91c2U+CiAgICAgICAgICAgICAgICA8L2c+CiAgICAgICAgICAgIDwvZz4KICAgICAgICA8L2c+CiAgICA8L2c+Cjwvc3ZnPgo=');margin-top: -5px;}
</style>
<script>
$(document).ready(function(){initData("${param.versusId}", <%=com.yy.guess.util.Util.getConfigCom(application).getClientLoadDataInterval()%>);});
</script>
</head>
<body>
	<div id="app" class="">
		<nav data-v-1db5fc32="" class="app-header">
			<ul data-v-1db5fc32="">
				<li data-v-1db5fc32="" onclick="window.location.href='${basePath}m/index.jsp?type=${param.type}'" class="base-icon history-back"></li>
				<li data-v-1db5fc32="">游戏竞猜</li>
				<li data-v-1db5fc32="" class="base-icon"></li>
			</ul>
		</nav>
		<div class="weui-tab">
			<div id="vux_view_box_body" class="weui-tab__panel vux-fix-safari-overflow-scrolling" style="padding-bottom:25px !important;">
				<div data-v-31296f00="" class="betting-page router-view">
					<section data-v-31296f00="" class="betting-info">
						<section data-v-31296f00="" class="info-title">
							<img data-v-31296f00="" src="" width="20px">
							<div data-v-31296f00="" class="tournament-name"></div>
							<div data-v-31296f00="" class="match-round"></div>
						</section>
						<section data-v-31296f00="" class="info-team">
							<div data-v-31296f00="" class="team-info left-team"><img data-v-31296f00="" src="" class="team-logo"><div data-v-31296f00="" class="team-name"></div></div>
							<div data-v-31296f00="" class="betting-status"></div>
							<div data-v-31296f00="" class="team-info right-team"><img data-v-31296f00="" src="" class="team-logo"><div data-v-31296f00="" class="team-name"></div></div>
						</section>
					</section>
					<section data-v-31296f00="" class="betting-stage"><div data-v-31296f00="" class="vux-tab-wrap"><div class="vux-tab-container" id="bo_title_div"></div></div></section>
				</div>
			</div>
		</div>
	</div>
</body>
</html>