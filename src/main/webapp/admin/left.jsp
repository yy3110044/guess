<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<div class="left">
	<div class="sdmenu" id="my_menu">
		<div>
			<span>网站管理</span>
			<a href="">网站信息</a>
			<a href="">权限列表</a>
			<a href="">添加权限</a>
		</div>
		<div>
			<span>影片管理</span>
			<a href="">影片列表</a>
			<a href="">添加影片</a>
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