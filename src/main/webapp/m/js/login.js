var login = function(){
	var userName = $.trim($("#userName").val());
	var passWord = $("#passWord").val();
	var autoLogin = $("#autoLogin").is(":checked");
	if(empty(userName)) {
		m_toast("输入用户名");
		return;
	}
	if(empty(passWord)) {
		m_toast("输入密码");
		return;
	}
	loadData({
		url : "userLogin",
		data : {
			"userName" : userName,
			"passWord" : passWord,
			"autoLogin" : autoLogin,
			"loginType" : "WEB"
		},
		success : function(data){
			if(data.code == 100) {
				m_toast(data.msg, true);
				window.location.href = "m/index.jsp";
			} else {
				m_toast(data.msg);
			}
		}
	});
};
$(document).ready(function(){
	if(!empty(msg)) {
		m_toast(msg);
	}
	loadData({
		"url" : "isLoginBySession",
		"success" : function(data) {
			if(data.code == 100) {
				if(data.result) { //已登陆直接跳转
					window.location.href = "m/index.jsp";
				} else { //未登陆
					var t1 = $.trim($("#autoLogin").attr("data-token1"));
					var t2 = $.trim($("#autoLogin").attr("data-token2"));
					if(!empty(t1) && !empty(t2) && "您已成功退出" != msg) {
						loadData({
							url : "userLogin",
							data : {
								"userName" : t1,
								"passWord" : t2,
								"autoLogin" : true,
								"loginType" : "WEB"
							},
							success : function(data){
								if(data.code == 100) {
									m_toast(data.msg, true);
									window.location.href = "m/index.jsp";
								} else if(data.code == 101) {
									m_toast("您已修改了密码，请手动登录一次");
								} else  {
									m_toast(data.msg);
								}
							}
						});
					}
				}
			}
		}
	});
});