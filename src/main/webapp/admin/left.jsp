<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<div class="left">
	<div class="sdmenu" id="my_menu">
		<div>
			<span>网站管理</span>
			<a href="admin/webSite/webSiteInfo.jsp">网站信息</a>
			<a href="admin/webSite/modifyConfig.jsp">修改参数</a>
			<a href="admin/webSite/loginLogList.jsp">登陆日志</a>
			<a href="admin/webSite/systemNoticeList.jsp">系统通知</a>
		</div>
		<div>
			<span>用户管理</span>
			<a href="admin/user/userList.jsp">用户列表</a>
			<!--
			<a href="admin/user/userTreeList.jsp">用户代理</a>
			-->
			<a href="admin/user/userNoticeList.jsp">用户通知</a>
			<a href="admin/tradeFlow/tradeFlowList.jsp">交易流水</a>
			<a href="admin/user/withdrawalList.jsp">提款列表</a>
		</div>
		<div>
			<span>竞猜管理</span>
			<a href="admin/v2/newGuessItem/list.jsp">项目列表</a>
			<!--
			<a href="admin/guess/teamList.jsp">队伍管理</a>
			-->
			<a href="admin/v2/newGuessVersus/list.jsp">竞猜列表</a>
			<a href="admin/v2/newGuessBet/list.jsp">下注列表</a>
		</div>
	</div>
</div>
<div class="Switch"></div>
<script type="text/javascript">
$(document).ready(function(){
    $(".Switch").click(function(){
		$(".left").toggle();
	});
    
    $("#my_menu div span").click(function(){
    	$(this).parent().toggleClass("collapsed");
    });
    
    var p = "${param.p}";
    $("#my_menu div a").each(function(){
    	if(p == $(this).html()) {
    		$(this).addClass("current");
    	}
    });
});
</script>