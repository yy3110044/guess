<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<div class="left">
	<div class="sdmenu" id="my_menu">
		<div>
			<span>网站管理</span>
			<a href="admin/webSite/webSiteInfo.jsp">网站信息</a>
			<a href="admin/webSite/modifyConfig.jsp">修改参数</a>
		</div>
		<div>
			<span>用户管理</span>
		</div>
		<div>
			<span>竞猜管理</span>
			<a href="">项目列表</a>
			<a href="admin/guess/sportAdd.jsp">添加项目</a>
			<a href="">战队列表</a>
			<a href="admin/guess/teamAdd.jsp">添加战队</a>
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