//输入按钮
var numberInput = function(num){
	var e = $("#inputValueSpan");
	var value = e.attr("data-value");
	if("x" == num) {
		if(!empty(value)) {
			value = value.substring(0, value.length - 1);
		}
	} else {
		if(value.length < 6) {
			value = value + num;
		}
	}

	e.attr("data-value", value);
	
	if(!empty(value)) {
		e.attr("class", "input-text");
		e.html(value);
	} else {
		e.attr("class", "input-placeholder");
		e.html("输入金额");
	}
};

//滚动条变换
var tabBarChange = function(index) {
	var e = $("div.vux-tab-ink-bar-transition-backward");
	if(1 == index) {
		e.css("left", "0%");
		e.css("right", "75%");
	} else if(2 == index) {
		e.css("left", "25%");
		e.css("right", "50%");
	} else if(3 == index) {
		e.css("left", "50%");
		e.css("right", "25%");
	} else if(4 == index) {
		e.css("left", "75%");
		e.css("right", "0%");
	}
};

var betList = function(){
	var str = '';
	str += '<div data-v-18da170e="" data-v-bf66ef20="" class="home-match-card">';
	str += '	<section data-v-18da170e="" class="card-header">';
	str += '		<img data-v-18da170e="" src="//yuanjududu.com//file/98c6eb475bf90d035c0d6b7f31fd59d0.svg" width="20px">';
	str += '		<div data-v-18da170e="" class="tournament-name">震中杯 EPICENTER 2018</div>';
	str += '		<div data-v-18da170e="" class="match-round">&nbsp;/&nbsp;bo3</div>';
	str += '		<div data-v-18da170e="" class="play-count">+25</div>';
	str += '	</section>';
	str += '	<section data-v-18da170e="" class="card-body">';
	str += '		<div data-v-18da170e="" class="card-body-team"><img data-v-18da170e="" src="//yuanjududu.com//file/3f6ee3d22a5473a0f4460e04deb31c67.png" class="team-logo"></div>';
	str += '		<div data-v-18da170e="" class="card-body-center">';
	str += '			<img data-v-18da170e="" src="data:image/svg+xml;base64,PD94bWwgdmVyc2lvbj0iMS4wIiBlbmNvZGluZz0iVVRGLTgiPz4KPHN2ZyB3aWR0aD0iMjRweCIgaGVpZ2h0PSI3OHB4IiB2aWV3Qm94PSIwIDAgMjQgNzgiIHZlcnNpb249IjEuMSIgeG1sbnM9Imh0dHA6Ly93d3cudzMub3JnLzIwMDAvc3ZnIiB4bWxuczp4bGluaz0iaHR0cDovL3d3dy53My5vcmcvMTk5OS94bGluayI+CiAgICA8IS0tIEdlbmVyYXRvcjogU2tldGNoIDQ5LjMgKDUxMTY3KSAtIGh0dHA6Ly93d3cuYm9oZW1pYW5jb2RpbmcuY29tL3NrZXRjaCAtLT4KICAgIDx0aXRsZT7ljaHniYfljLrliIblibLlt6Y8L3RpdGxlPgogICAgPGRlc2M+Q3JlYXRlZCB3aXRoIFNrZXRjaC48L2Rlc2M+CiAgICA8ZGVmcz4KICAgICAgICA8cmFkaWFsR3JhZGllbnQgY3g9IjEwMCUiIGN5PSI1MCUiIGZ4PSIxMDAlIiBmeT0iNTAlIiByPSI5OC44MDMyODc2JSIgZ3JhZGllbnRUcmFuc2Zvcm09InRyYW5zbGF0ZSgxLjAwMDAwMCwwLjUwMDAwMCksc2NhbGUoMS4wMDAwMDAsMC4zMDAwMDApLHJvdGF0ZSgtMTc5Ljk5OTk5OCksc2NhbGUoMS4wMDAwMDAsMS42MzI1MTgpLHRyYW5zbGF0ZSgtMS4wMDAwMDAsLTAuNTAwMDAwKSIgaWQ9InJhZGlhbEdyYWRpZW50LTEiPgogICAgICAgICAgICA8c3RvcCBzdG9wLWNvbG9yPSIjMEMxMjFGIiBvZmZzZXQ9IjAlIj48L3N0b3A+CiAgICAgICAgICAgIDxzdG9wIHN0b3AtY29sb3I9IiMxQTI1MzgiIHN0b3Atb3BhY2l0eT0iMCIgb2Zmc2V0PSIxMDAlIj48L3N0b3A+CiAgICAgICAgPC9yYWRpYWxHcmFkaWVudD4KICAgIDwvZGVmcz4KICAgIDxnIGlkPSLpm7fnq57mioAyLjAtY29weSIgc3Ryb2tlPSJub25lIiBzdHJva2Utd2lkdGg9IjEiIGZpbGw9Im5vbmUiIGZpbGwtcnVsZT0iZXZlbm9kZCIgZmlsbC1vcGFjaXR5PSIwLjMiPgogICAgICAgIDxnIGlkPSJpY29u5YiH5Zu+IiB0cmFuc2Zvcm09InRyYW5zbGF0ZSgtMTEyLjAwMDAwMCwgLTE5NjUuMDAwMDAwKSIgZmlsbD0idXJsKCNyYWRpYWxHcmFkaWVudC0xKSI+CiAgICAgICAgICAgIDxyZWN0IGlkPSLljaHniYfljLrliIblibLlt6YiIHg9IjExMiIgeT0iMTk2NCIgd2lkdGg9IjI0IiBoZWlnaHQ9IjgwIj48L3JlY3Q+CiAgICAgICAgPC9nPgogICAgPC9nPgo8L3N2Zz4=" class="center-left">';
	str += '			<div data-v-18da170e="" class="start-time">18:10</div>';
	str += '			<img data-v-18da170e="" src="data:image/svg+xml;base64,PD94bWwgdmVyc2lvbj0iMS4wIiBlbmNvZGluZz0iVVRGLTgiPz4KPHN2ZyB3aWR0aD0iMjRweCIgaGVpZ2h0PSI3OHB4IiB2aWV3Qm94PSIwIDAgMjQgNzgiIHZlcnNpb249IjEuMSIgeG1sbnM9Imh0dHA6Ly93d3cudzMub3JnLzIwMDAvc3ZnIiB4bWxuczp4bGluaz0iaHR0cDovL3d3dy53My5vcmcvMTk5OS94bGluayI+CiAgICA8IS0tIEdlbmVyYXRvcjogU2tldGNoIDQ5LjMgKDUxMTY3KSAtIGh0dHA6Ly93d3cuYm9oZW1pYW5jb2RpbmcuY29tL3NrZXRjaCAtLT4KICAgIDx0aXRsZT7ljaHniYfljLrliIblibLlj7M8L3RpdGxlPgogICAgPGRlc2M+Q3JlYXRlZCB3aXRoIFNrZXRjaC48L2Rlc2M+CiAgICA8ZGVmcz4KICAgICAgICA8cmFkaWFsR3JhZGllbnQgY3g9IjEwMCUiIGN5PSI1MCUiIGZ4PSIxMDAlIiBmeT0iNTAlIiByPSI5OC44MDMyODc2JSIgZ3JhZGllbnRUcmFuc2Zvcm09InRyYW5zbGF0ZSgxLjAwMDAwMCwwLjUwMDAwMCksc2NhbGUoMS4wMDAwMDAsMC4zMDAwMDApLHJvdGF0ZSgtMTc5Ljk5OTk5OCksc2NhbGUoMS4wMDAwMDAsMS42MzI1MTgpLHRyYW5zbGF0ZSgtMS4wMDAwMDAsLTAuNTAwMDAwKSIgaWQ9InJhZGlhbEdyYWRpZW50LTEiPgogICAgICAgICAgICA8c3RvcCBzdG9wLWNvbG9yPSIjMEMxMjFGIiBvZmZzZXQ9IjAlIj48L3N0b3A+CiAgICAgICAgICAgIDxzdG9wIHN0b3AtY29sb3I9IiMxQTI1MzgiIHN0b3Atb3BhY2l0eT0iMCIgb2Zmc2V0PSIxMDAlIj48L3N0b3A+CiAgICAgICAgPC9yYWRpYWxHcmFkaWVudD4KICAgIDwvZGVmcz4KICAgIDxnIGlkPSLpm7fnq57mioAyLjAtY29weSIgc3Ryb2tlPSJub25lIiBzdHJva2Utd2lkdGg9IjEiIGZpbGw9Im5vbmUiIGZpbGwtcnVsZT0iZXZlbm9kZCIgZmlsbC1vcGFjaXR5PSIwLjMiPgogICAgICAgIDxnIGlkPSJpY29u5YiH5Zu+IiB0cmFuc2Zvcm09InRyYW5zbGF0ZSgtMTc2LjAwMDAwMCwgLTE5NjUuMDAwMDAwKSIgZmlsbD0idXJsKCNyYWRpYWxHcmFkaWVudC0xKSI+CiAgICAgICAgICAgIDxyZWN0IGlkPSLljaHniYfljLrliIblibLlj7MiIHRyYW5zZm9ybT0idHJhbnNsYXRlKDE4OC4wMDAwMDAsIDIwMDQuMDAwMDAwKSBzY2FsZSgtMSwgMSkgdHJhbnNsYXRlKC0xODguMDAwMDAwLCAtMjAwNC4wMDAwMDApICIgeD0iMTc2IiB5PSIxOTY0IiB3aWR0aD0iMjQiIGhlaWdodD0iODAiPjwvcmVjdD4KICAgICAgICA8L2c+CiAgICA8L2c+Cjwvc3ZnPg==" class="center-right">';
	str += '		</div>';
	str += '		<div data-v-18da170e="" class="card-body-team"><img data-v-18da170e="" src="//yuanjududu.com//file/1c8b7b613eefd276a83219b668722c23.png" class="team-logo"></div>';
	str += '	</section>';
	str += '	<div data-v-8d7d541a="" data-v-18da170e="" class="odds-group-title">';
	str += '		<div data-v-8d7d541a="" class="empty-badge">&nbsp;</div>';
	str += '		<div data-v-8d7d541a="" class="title">获胜者</div>';
	str += '	</div>';
	str += '	<section data-v-18da170e="" class="card-footer">';
	str += '		<div data-v-18da170e="" class="card-odds-btn">';
	str += '			<div data-v-ba6efc5c="" data-v-18da170e="" class="home-match-card-button btn-locked">';
	str += '				<div data-v-ba6efc5c="" class="button-dark-border">';
	str += '					<div data-v-ba6efc5c="" class="button-content">';
	str += '						<div data-v-ba6efc5c="" class="button-name">3DMAX</div>';
	str += '						<div data-v-ba6efc5c="" class="button-odds-content">';
	str += '							<div data-v-ba6efc5c="" class="odds-rising-icon"></div>';
	str += '							<div data-v-ba6efc5c="" class="btn-odds"></div>';
	str += '							<div data-v-ba6efc5c="" class="odds-dropping-icon"></div>';
	str += '						</div>';
	str += '					</div>';
	str += '				</div>';
	str += '			</div>';
	str += '		</div>';
	str += '		<div data-v-18da170e="" class="match-status">';
	str += '			<div data-v-18da170e="" class="match-is-early">';
	str += '				<div data-v-18da170e="" class="status-icon early-icon"></div>';
	str += '				<div data-v-18da170e="" class="match-status-text">未开始</div>';
	str += '			</div>';
	str += '		</div>';
	str += '		<div data-v-18da170e="" class="card-odds-btn">';
	str += '			<div data-v-ba6efc5c="" data-v-18da170e="" class="home-match-card-button">';
	str += '				<div data-v-ba6efc5c="" class="button-dark-border">';
	str += '					<div data-v-ba6efc5c="" class="button-content">';
	str += '						<div data-v-ba6efc5c="" class="button-name">Red Reserve</div>';
	str += '						<div data-v-ba6efc5c="" class="button-odds-content">';
	str += '							<div data-v-ba6efc5c="" class="odds-rising-icon"></div>';
	str += '							<div data-v-ba6efc5c="" class="btn-odds"><span data-v-ba6efc5c="">1.58</span></div>';
	str += '							<div data-v-ba6efc5c="" class="odds-dropping-icon"></div>';
	str += '						</div>';
	str += '					</div>';
	str += '				</div>';
	str += '			</div>';
	str += '		</div>';
	str += '	</section>';
	str += '</div>';
	return str;
};