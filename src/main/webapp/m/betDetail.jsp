<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%><!DOCTYPE html>
<html>
<head>
<title>下注详情 - <%=com.yy.guess.util.Util.getConfigCom(application).getWebTitle()%></title>
<%@include file="/m/head-common.jsp"%>
<script src="m/js/mescroll.min.js"></script>
<script src="m/js/betDetail.js"></script>
<link href="m/js/mescroll.min.css" rel="stylesheet">
<script>
var versusId = ${param.versusId};
$(document).ready(function(){});
</script>
</head>
<body>
	<div id="app" class="">
		<nav data-v-1db5fc32="" class="app-header">
			<ul data-v-1db5fc32="">
				<li data-v-1db5fc32="" onclick="window.location.href='${basePath}m/index.jsp'" class="base-icon history-back"></li>
				<li data-v-1db5fc32="">游戏竞猜</li>
				<li data-v-1db5fc32="" class="base-icon"></li>
			</ul>
		</nav>
		<div class="weui-tab">
			<div id="vux_view_box_body" class="weui-tab__panel vux-fix-safari-overflow-scrolling">
				<div data-v-31296f00="" class="betting-page router-view">
					<section data-v-31296f00="" class="betting-info">
						<section data-v-31296f00="" class="info-title">
							<img data-v-31296f00="" src="//yuanjududu.com//file/98c6eb475bf90d035c0d6b7f31fd59d0.svg" width="20px">
							<div data-v-31296f00="" class="tournament-name">震中杯 EPICENTER 2018</div>
							<div data-v-31296f00="" class="match-round">&nbsp;/ bo3</div>
						</section>
						<section data-v-31296f00="" class="info-team">
							<div data-v-31296f00="" class="team-info">
								<img data-v-31296f00="" src="//yuanjududu.com//file/3f6ee3d22a5473a0f4460e04deb31c67.png" class="team-logo">
								<div data-v-31296f00="" class="team-name">3DMAX</div>
							</div>
							<div data-v-31296f00="" class="betting-status">
								<div data-v-31296f00="" class="status-early">
									<div data-v-31296f00="" class="is-early">
										<div data-v-31296f00="" class="match-date">9月3日 周一</div>
										<div data-v-31296f00="" class="match-time">18:10</div>
									</div>
								</div>
								<div data-v-31296f00="" class="is-raedy">未开始</div>
							</div>
							<div data-v-31296f00="" class="team-info">
								<img data-v-31296f00="" src="//yuanjududu.com//file/1c8b7b613eefd276a83219b668722c23.png" class="team-logo">
								<div data-v-31296f00="" class="team-name">Red Reserve</div>
							</div>
						</section>
					</section>
					
					<!--
					<section data-v-31296f00="" class="betting-stage">
						<div data-v-31296f00="" class="vux-tab-wrap">
							<div class="vux-tab-container">
								<div class="vux-tab">
									<div data-v-31296f00="" class="vux-tab-item vux-tab-selected" style="border: none; color: rgb(255, 255, 255);">全场</div>
									<div data-v-31296f00="" class="vux-tab-item" style="border: none; color: rgb(186, 206, 241);">地图1</div>
									<div data-v-31296f00="" class="vux-tab-item" style="border: none; color: rgb(186, 206, 241);">地图2</div>
									<div data-v-31296f00="" class="vux-tab-item vux-tab-disabled" style="border:none;">&nbsp;</div>
									<div data-v-31296f00="" class="vux-tab-item vux-tab-disabled" style="border:none;">&nbsp;</div>
									<div class="vux-tab-ink-bar vux-tab-ink-bar-transition-backward" style="display: block; height: 22px; background-color: transparent; left: 0%; right: 80%;"></div>
								</div>
							</div>
						</div>
					</section>
					-->
					
					<section data-v-31296f00="" class="betting-stage">
						<div data-v-31296f00="" class="vux-tab-wrap">
							<div class="vux-tab-container">
								<div class="vux-tab scrollable">
									<div data-v-31296f00="" class="vux-tab-item vux-tab-selected" style="border: none; color: rgb(255, 255, 255);">全场</div>
									<div data-v-31296f00="" class="vux-tab-item" style="border: none; color: rgb(186, 206, 241);">地图1</div>
									<div data-v-31296f00="" class="vux-tab-item" style="border: none; color: rgb(186, 206, 241);">地图2</div>
									<div data-v-31296f00="" class="vux-tab-item" style="border: none; color: rgb(186, 206, 241);">地图1</div>
									<div data-v-31296f00="" class="vux-tab-item" style="border: none; color: rgb(186, 206, 241);">地图2</div>
									<div data-v-31296f00="" class="vux-tab-item" style="border: none; color: rgb(186, 206, 241);">地图1</div>
									<div data-v-31296f00="" class="vux-tab-item" style="border: none; color: rgb(186, 206, 241);">地图2</div>
									<div data-v-31296f00="" class="vux-tab-item" style="border: none; color: rgb(186, 206, 241);">地图1</div>
									<div data-v-31296f00="" class="vux-tab-item" style="border: none; color: rgb(186, 206, 241);">地图2</div>
									<div data-v-31296f00="" class="vux-tab-item" style="border: none; color: rgb(186, 206, 241);">地图1</div>
									<div data-v-31296f00="" class="vux-tab-item" style="border: none; color: rgb(186, 206, 241);">地图2</div>
									<div data-v-31296f00="" class="vux-tab-item" style="border: none; color: rgb(186, 206, 241);">地图1</div>
									<div data-v-31296f00="" class="vux-tab-item" style="border: none; color: rgb(186, 206, 241);">地图2</div>
									<div data-v-31296f00="" class="vux-tab-item vux-tab-disabled" style="border:none;">&nbsp;</div>
									<div data-v-31296f00="" class="vux-tab-item vux-tab-disabled" style="border:none;">&nbsp;</div>
									<div class="vux-tab-ink-bar vux-tab-ink-bar-transition-backward" style="display: block; height: 22px; background-color: transparent; left: 0%; right: 80%;"></div>
								</div>
							</div>
						</div>
					</section>
					
					<section data-v-31296f00="" class="betting-odds">
						<div data-v-31296f00="" class="stage-title"><div data-v-31296f00="" class="stage-border"></div>全场<div data-v-31296f00="" class="stage-border"></div></div>
						
						<div data-v-31296f00="" class="group-list">
							<div data-v-8d7d541a="" data-v-31296f00="" class="odds-group-title odds-group-title">
								<div data-v-8d7d541a="" class="empty-badge">&nbsp;</div>
								<div data-v-8d7d541a="" class="title">获胜者</div>
							</div>
							<div data-v-31296f00="" class="group-odds">
								<div data-v-31296f00="" class="odds-btn">
									<div data-v-549598f5="" data-v-31296f00="" class="home-match-card-button">
										<div data-v-549598f5="" class="button-dark-border">
											<div data-v-549598f5="" class="button-content btn-left">
												<div data-v-549598f5="" class="button-name">3DMAX</div>
												<div data-v-549598f5="" class="button-odds-content">
													<div data-v-549598f5="" class="odds-rising-icon"></div>
													<div data-v-549598f5="" class="odds-dropping-icon"></div>
													<div data-v-549598f5="" class="btn-odds">
														<span data-v-549598f5="">2.26</span>
													</div>
												</div>
											</div>
										</div>
									</div>
								</div>
								<div data-v-31296f00="" class="odds-btn">
									<div data-v-549598f5="" data-v-31296f00="" class="home-match-card-button">
										<div data-v-549598f5="" class="button-dark-border">
											<div data-v-549598f5="" class="button-content btn-right">
												<div data-v-549598f5="" class="button-odds-content">
													<div data-v-549598f5="" class="btn-odds"><span data-v-549598f5="">1.58</span></div>
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
					
					
					<section data-v-31296f00="" class="betting-odds">
						<div data-v-31296f00="" class="stage-title"><div data-v-31296f00="" class="stage-border"></div>地图1<div data-v-31296f00="" class="stage-border"></div></div>
						<div data-v-31296f00="" class="group-list">
							<div data-v-8d7d541a="" data-v-31296f00="" class="odds-group-title odds-group-title">
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
						</div>
					</section>
					<div data-v-31296f00="" style="height:503px;"></div>
				</div>
			</div>
		</div>
	</div>
</body>
</html>