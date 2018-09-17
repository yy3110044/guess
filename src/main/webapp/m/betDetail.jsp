<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%><!DOCTYPE html>
<html>
<head>
<title>下注详情 - <%=com.yy.guess.util.Util.getConfigCom(application).getWebTitle()%></title>
<%@include file="/m/head-common.jsp"%>
<script src="m/js/mescroll.min.js"></script>
<script src="m/js/betDetail.js"></script>
<link href="m/js/mescroll.min.css" rel="stylesheet">
<style type="text/css">
#vux_view_box_body::-webkit-scrollbar{display:none;width:0;height:0;}
</style>
<script>
$(document).ready(function(){
	//initData("${param.versusId}");
	
	var s1 = $("#scroll1");
	var s2 = $("#scroll2");
	var s3 = $("#scroll3");
	var s4 = $("#scroll4");
	var s5 = $("#scroll5");
	var s6 = $("#scroll6");
	
	var ss = $("#vux_view_box_body");
	
	
	//一个模84
	//多个playType：+48
	
	ss.scroll(function(){
		$(".tournament-name").html("scrollTop：" + (ss.scrollTop()) + "，offsetTop：" + ss.offset().top + "，positionTop：" + ss.position().top);
		s1.find(".odds-group-title").html("scrollTop：" + s1.scrollTop() + "，offsetTop：" + s1.offset().top + "，positionTop：" + s1.position().top);
		s2.find(".odds-group-title").html("scrollTop：" + s2.scrollTop() + "，offsetTop：" + s2.offset().top + "，positionTop：" + s2.position().top);
		s3.find(".odds-group-title").html("scrollTop：" + s3.scrollTop() + "，offsetTop：" + s3.offset().top + "，positionTop：" + s3.position().top);
		s4.find(".odds-group-title").html("scrollTop：" + s4.scrollTop() + "，offsetTop：" + s4.offset().top + "，positionTop：" + s4.position().top);
		s5.find(".odds-group-title").html("scrollTop：" + s5.scrollTop() + "，offsetTop：" + s5.offset().top + "，positionTop：" + s5.position().top);
		s6.find(".odds-group-title").html("scrollTop：" + s6.scrollTop() + "，offsetTop：" + s6.offset().top + "，positionTop：" + s6.position().top);
	});
	
	$("section.betting-odds").click(function(){
		alert($(this).height());
	});
});

var goScroll = function() {
	var val = prompt("输入");
	$("#vux_view_box_body").scrollTop(val);
}
</script>
</head>
<body>
	<div id="app" class="">
		<nav data-v-1db5fc32="" class="app-header">
			<ul data-v-1db5fc32="">
				<li data-v-1db5fc32="" onclick="window.location.href='${basePath}m/index.jsp'" class="base-icon history-back"></li>
				<li data-v-1db5fc32="" onclick="goScroll()">游戏竞猜</li>
				<li data-v-1db5fc32="" class="base-icon"></li>
			</ul>
		</nav>
		<div class="weui-tab">
			<div id="vux_view_box_body" class="weui-tab__panel vux-fix-safari-overflow-scrolling">
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


					
					<section data-v-31296f00="" class="betting-odds" id="scroll1">
						<div data-v-31296f00="" class="stage-title"><div data-v-31296f00="" class="stage-border"></div>全场<div data-v-31296f00="" class="stage-border"></div></div>
						<div data-v-31296f00="" class="group-list">
							<div data-v-8d7d541a="" data-v-31296f00="" class="odds-group-title">
								<div data-v-8d7d541a="" class="empty-badge">&nbsp;</div>
								<div data-v-8d7d541a="" class="title">获胜者</div>
							</div>
							
							
							
						</div>
					</section>
					
					
					<section data-v-31296f00="" class="betting-odds" id="scroll2">
						<div data-v-31296f00="" class="stage-title"><div data-v-31296f00="" class="stage-border"></div>地图1<div data-v-31296f00="" class="stage-border"></div></div>
						<div data-v-31296f00="" class="group-list">
							<div data-v-8d7d541a="" data-v-31296f00="" class="odds-group-title">
								<div data-v-8d7d541a="" class="empty-badge">&nbsp;</div>
								<div data-v-8d7d541a="" class="title">获胜者 （含加时）</div>
							</div>
							<div data-v-31296f00="" class="group-odds">
								<div data-v-31296f00="" class="odds-btn">
									<div data-v-549598f5="" data-v-31296f00="" class="home-match-card-button btn-odds-rising">
										<div data-v-549598f5="" class="button-dark-border">
											<div data-v-549598f5="" class="button-content btn-left">
												<div data-v-549598f5="" class="button-name">3DMAX</div>
												<div data-v-549598f5="" class="button-odds-content">
													<div data-v-549598f5="" class="odds-rising-icon"></div>
													<div data-v-549598f5="" class="odds-dropping-icon"></div>
													<div data-v-549598f5="" class="btn-odds"><span data-v-549598f5="">2.19</span></div>
												</div>
											</div>
										</div>
									</div>
								</div>
								<div data-v-31296f00="" class="odds-btn">
									<div data-v-549598f5="" data-v-31296f00="" class="home-match-card-button btn-odds-dropping">
										<div data-v-549598f5="" class="button-dark-border">
											<div data-v-549598f5="" class="button-content btn-right">
												<div data-v-549598f5="" class="button-odds-content">
													<div data-v-549598f5="" class="btn-odds"><span data-v-549598f5="">1.62</span></div>
													<div data-v-549598f5="" class="odds-rising-icon"></div>
													<div data-v-549598f5="" class="odds-dropping-icon"></div>
												</div>
												<div data-v-549598f5="" class="button-name">Red Reserve</div>
											</div>
										</div>
									</div>
								</div>
							</div>
							
							<div data-v-31296f00="" class="group-odds" onclick="alert($(this).height())">
								<div data-v-31296f00="" class="odds-btn">
									<div data-v-549598f5="" data-v-31296f00="" class="home-match-card-button btn-odds-rising">
										<div data-v-549598f5="" class="button-dark-border">
											<div data-v-549598f5="" class="button-content btn-left">
												<div data-v-549598f5="" class="button-name">3DMAX</div>
												<div data-v-549598f5="" class="button-odds-content">
													<div data-v-549598f5="" class="odds-rising-icon"></div>
													<div data-v-549598f5="" class="odds-dropping-icon"></div>
													<div data-v-549598f5="" class="btn-odds"><span data-v-549598f5="">2.19</span></div>
												</div>
											</div>
										</div>
									</div>
								</div>
								<div data-v-31296f00="" class="odds-btn">
									<div data-v-549598f5="" data-v-31296f00="" class="home-match-card-button btn-odds-dropping">
										<div data-v-549598f5="" class="button-dark-border">
											<div data-v-549598f5="" class="button-content btn-right">
												<div data-v-549598f5="" class="button-odds-content">
													<div data-v-549598f5="" class="btn-odds"><span data-v-549598f5="">1.62</span></div>
													<div data-v-549598f5="" class="odds-rising-icon"></div>
													<div data-v-549598f5="" class="odds-dropping-icon"></div>
												</div>
												<div data-v-549598f5="" class="button-name">Red Reserve</div>
											</div>
										</div>
									</div>
								</div>
							</div>
							
							
							<div data-v-31296f00="" class="group-odds">
								<div data-v-31296f00="" class="odds-btn">
									<div data-v-549598f5="" data-v-31296f00="" class="home-match-card-button btn-odds-rising">
										<div data-v-549598f5="" class="button-dark-border">
											<div data-v-549598f5="" class="button-content btn-left">
												<div data-v-549598f5="" class="button-name">3DMAX</div>
												<div data-v-549598f5="" class="button-odds-content">
													<div data-v-549598f5="" class="odds-rising-icon"></div>
													<div data-v-549598f5="" class="odds-dropping-icon"></div>
													<div data-v-549598f5="" class="btn-odds"><span data-v-549598f5="">2.19</span></div>
												</div>
											</div>
										</div>
									</div>
								</div>
								<div data-v-31296f00="" class="odds-btn">
									<div data-v-549598f5="" data-v-31296f00="" class="home-match-card-button btn-odds-dropping">
										<div data-v-549598f5="" class="button-dark-border">
											<div data-v-549598f5="" class="button-content btn-right">
												<div data-v-549598f5="" class="button-odds-content">
													<div data-v-549598f5="" class="btn-odds"><span data-v-549598f5="">1.62</span></div>
													<div data-v-549598f5="" class="odds-rising-icon"></div>
													<div data-v-549598f5="" class="odds-dropping-icon"></div>
												</div>
												<div data-v-549598f5="" class="button-name">Red Reserve</div>
											</div>
										</div>
									</div>
								</div>
							</div>
						</div>
					</section>
					
					<section data-v-31296f00="" class="betting-odds" id="scroll3">
						<div data-v-31296f00="" class="stage-title"><div data-v-31296f00="" class="stage-border"></div>地图2<div data-v-31296f00="" class="stage-border"></div></div>
						<div data-v-31296f00="" class="group-list">
							<div data-v-8d7d541a="" data-v-31296f00="" class="odds-group-title">
								<div data-v-8d7d541a="" class="empty-badge">&nbsp;</div>
								<div data-v-8d7d541a="" class="title">获胜者 （含加时）</div>
							</div>
							<div data-v-31296f00="" class="group-odds">
								<div data-v-31296f00="" class="odds-btn">
									<div data-v-549598f5="" data-v-31296f00="" class="home-match-card-button btn-odds-rising">
										<div data-v-549598f5="" class="button-dark-border">
											<div data-v-549598f5="" class="button-content btn-left">
												<div data-v-549598f5="" class="button-name">3DMAX</div>
												<div data-v-549598f5="" class="button-odds-content">
													<div data-v-549598f5="" class="odds-rising-icon"></div>
													<div data-v-549598f5="" class="odds-dropping-icon"></div>
													<div data-v-549598f5="" class="btn-odds"><span data-v-549598f5="">2.19</span></div>
												</div>
											</div>
										</div>
									</div>
								</div>
								<div data-v-31296f00="" class="odds-btn">
									<div data-v-549598f5="" data-v-31296f00="" class="home-match-card-button btn-odds-dropping">
										<div data-v-549598f5="" class="button-dark-border">
											<div data-v-549598f5="" class="button-content btn-right">
												<div data-v-549598f5="" class="button-odds-content">
													<div data-v-549598f5="" class="btn-odds"><span data-v-549598f5="">1.62</span></div>
													<div data-v-549598f5="" class="odds-rising-icon"></div>
													<div data-v-549598f5="" class="odds-dropping-icon"></div>
												</div>
												<div data-v-549598f5="" class="button-name">Red Reserve2</div>
											</div>
										</div>
									</div>
								</div>
							</div>
						</div>
					</section>
					
					<section data-v-31296f00="" class="betting-odds" id="scroll4">
						<div data-v-31296f00="" class="stage-title"><div data-v-31296f00="" class="stage-border"></div>地图3<div data-v-31296f00="" class="stage-border"></div></div>
						<div data-v-31296f00="" class="group-list">
							<div data-v-8d7d541a="" data-v-31296f00="" class="odds-group-title">
								<div data-v-8d7d541a="" class="empty-badge">&nbsp;</div>
								<div data-v-8d7d541a="" class="title">获胜者 （含加时）</div>
							</div>
							<div data-v-31296f00="" class="group-odds">
								<div data-v-31296f00="" class="odds-btn">
									<div data-v-549598f5="" data-v-31296f00="" class="home-match-card-button btn-odds-rising">
										<div data-v-549598f5="" class="button-dark-border">
											<div data-v-549598f5="" class="button-content btn-left">
												<div data-v-549598f5="" class="button-name">3DMAX</div>
												<div data-v-549598f5="" class="button-odds-content">
													<div data-v-549598f5="" class="odds-rising-icon"></div>
													<div data-v-549598f5="" class="odds-dropping-icon"></div>
													<div data-v-549598f5="" class="btn-odds"><span data-v-549598f5="">2.19</span></div>
												</div>
											</div>
										</div>
									</div>
								</div>
								<div data-v-31296f00="" class="odds-btn">
									<div data-v-549598f5="" data-v-31296f00="" class="home-match-card-button btn-odds-dropping">
										<div data-v-549598f5="" class="button-dark-border">
											<div data-v-549598f5="" class="button-content btn-right">
												<div data-v-549598f5="" class="button-odds-content">
													<div data-v-549598f5="" class="btn-odds"><span data-v-549598f5="">1.62</span></div>
													<div data-v-549598f5="" class="odds-rising-icon"></div>
													<div data-v-549598f5="" class="odds-dropping-icon"></div>
												</div>
												<div data-v-549598f5="" class="button-name">Red Reserve3</div>
											</div>
										</div>
									</div>
								</div>
							</div>
						</div>
					</section>
					
					<section data-v-31296f00="" class="betting-odds" id="scroll5">
						<div data-v-31296f00="" class="stage-title"><div data-v-31296f00="" class="stage-border"></div>地图4<div data-v-31296f00="" class="stage-border"></div></div>
						<div data-v-31296f00="" class="group-list">
							<div data-v-8d7d541a="" data-v-31296f00="" class="odds-group-title">
								<div data-v-8d7d541a="" class="empty-badge">&nbsp;</div>
								<div data-v-8d7d541a="" class="title">获胜者 （含加时）</div>
							</div>
							<div data-v-31296f00="" class="group-odds">
								<div data-v-31296f00="" class="odds-btn">
									<div data-v-549598f5="" data-v-31296f00="" class="home-match-card-button btn-odds-rising">
										<div data-v-549598f5="" class="button-dark-border">
											<div data-v-549598f5="" class="button-content btn-left">
												<div data-v-549598f5="" class="button-name">3DMAX</div>
												<div data-v-549598f5="" class="button-odds-content">
													<div data-v-549598f5="" class="odds-rising-icon"></div>
													<div data-v-549598f5="" class="odds-dropping-icon"></div>
													<div data-v-549598f5="" class="btn-odds"><span data-v-549598f5="">2.19</span></div>
												</div>
											</div>
										</div>
									</div>
								</div>
								<div data-v-31296f00="" class="odds-btn">
									<div data-v-549598f5="" data-v-31296f00="" class="home-match-card-button btn-odds-dropping">
										<div data-v-549598f5="" class="button-dark-border">
											<div data-v-549598f5="" class="button-content btn-right">
												<div data-v-549598f5="" class="button-odds-content">
													<div data-v-549598f5="" class="btn-odds"><span data-v-549598f5="">1.62</span></div>
													<div data-v-549598f5="" class="odds-rising-icon"></div>
													<div data-v-549598f5="" class="odds-dropping-icon"></div>
												</div>
												<div data-v-549598f5="" class="button-name">Red Reserve4</div>
											</div>
										</div>
									</div>
								</div>
							</div>
						</div>
					</section>
					
					<section data-v-31296f00="" class="betting-odds" id="scroll6">
						<div data-v-31296f00="" class="stage-title"><div data-v-31296f00="" class="stage-border"></div>地图5<div data-v-31296f00="" class="stage-border"></div></div>
						<div data-v-31296f00="" class="group-list">
							<div data-v-8d7d541a="" data-v-31296f00="" class="odds-group-title">
								<div data-v-8d7d541a="" class="empty-badge">&nbsp;</div>
								<div data-v-8d7d541a="" class="title">获胜者 （含加时）</div>
							</div>
							<div data-v-31296f00="" class="group-odds">
								<div data-v-31296f00="" class="odds-btn">
									<div data-v-549598f5="" data-v-31296f00="" class="home-match-card-button btn-odds-rising">
										<div data-v-549598f5="" class="button-dark-border">
											<div data-v-549598f5="" class="button-content btn-left">
												<div data-v-549598f5="" class="button-name">3DMAX</div>
												<div data-v-549598f5="" class="button-odds-content">
													<div data-v-549598f5="" class="odds-rising-icon"></div>
													<div data-v-549598f5="" class="odds-dropping-icon"></div>
													<div data-v-549598f5="" class="btn-odds"><span data-v-549598f5="">2.19</span></div>
												</div>
											</div>
										</div>
									</div>
								</div>
								<div data-v-31296f00="" class="odds-btn">
									<div data-v-549598f5="" data-v-31296f00="" class="home-match-card-button btn-odds-dropping">
										<div data-v-549598f5="" class="button-dark-border">
											<div data-v-549598f5="" class="button-content btn-right">
												<div data-v-549598f5="" class="button-odds-content">
													<div data-v-549598f5="" class="btn-odds"><span data-v-549598f5="">1.62</span></div>
													<div data-v-549598f5="" class="odds-rising-icon"></div>
													<div data-v-549598f5="" class="odds-dropping-icon"></div>
												</div>
												<div data-v-549598f5="" class="button-name">Red Reserve5</div>
											</div>
										</div>
									</div>
								</div>
							</div>
						</div>
					</section>
					
				</div>
			</div>
		</div>
	</div>
</body>
</html>