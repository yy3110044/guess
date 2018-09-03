var empty = function(str) {
	return str == null || "" == str;
};

/**
 * obj.url：链接
 * obj.data：参数
 * obj.success：回功回调函数
 * obj.error：失败回调函数
 * obj.redirectCode：跳转代码，默认为200
 * obj.redirectUrl：跳转url
 */
var loadData = function(obj){
	$.ajax({
		"type" : "POST",
		"cache" : false,
		"async" : true,
		"contentType" : "application/x-www-form-urlencoded",
		"dataType" : "json",
		"beforeSend" : function(){
			m_loading();
		},
		"complete" : function(){
			m_loading_close();
		},
		"url" : obj.url,
		"data" : obj.data,
		"success" : function(data, textStatus){
			if(obj.redirectCode == null) {
				obj.redirectCode = 200;
			}
			if(obj.redirectUrl != null && obj.redirectCode == data.code) {
				window.location.href = obj.redirectUrl;
				return;
			}
			if(obj.success != null) {
				obj.success(data, textStatus); //请求成功后调用
			}
		},
		"error" : function(XMLHttpRequest, textStatus, errorThrown){
			showMsg(textStatus);
			if(obj.error != null) {
				obj.error(XMLHttpRequest, textStatus, errorThrown);
			}
		}
	});
};

//提示框1
var m_alert = function(msg){
	var str = '';
	str += '<div id="m_alert_div" class="base-alert v-transfer-dom">';
	str += '	<div data-v-cd2dfd02="" class="vux-x-dialog">';
	str += '		<div class="weui-mask"></div>';
	str += '		<div class="weui-dialog" style="background:transparent;">';
	str += '			<div data-v-cd2dfd02="" class="alert-content">';
	str += '				<div data-v-cd2dfd02="" class="alert-text" style="word-break:break-all;word-wrap:break-word;">' + msg + '</div>';
	str += '				<div data-v-cd2dfd02="" class="alert-hr"></div>';
	str += '				<div data-v-cd2dfd02="" class="alert-btn" onclick="m_alert_close()">确认</div>';
	str += '			</div>';
	str += '		</div>';
	str += '	</div>';
	str += '</div>';
	$("body").append(str);
};
var m_alert_close = function(){
	$("#m_alert_div").remove();
};

//提示框2
var m_alert2 = function(msg){
	var str = '';
	str += '<div class="vux-alert" id="m_alert2_div">';
	str += '	<div class="vux-x-dialog">';
	str += '		<div class="weui-mask"></div>';
	str += '		<div class="weui-dialog">';
	str += '			<div class="weui-dialog__hd">';
	str += '				<strong class="weui-dialog__title"></strong>';
	str += '			</div>';
	str += '			<div class="weui-dialog__bd">';
	str += '				<div>' + msg + '</div>';
	str += '			</div>';
	str += '			<div class="weui-dialog__ft">';
	str += '				<a href="javascript:;" onclick="m_alert2_close()" class="weui-dialog__btn weui-dialog__btn_primary">确定</a>';
	str += '			</div>';
	str += '		</div>';
	str += '	</div>';
	str += '</div>';
	$("body").append(str);
};
var m_alert2_close = function(){
	$("#m_alert2_div").remove();
};

//选择框
var m_confirm_ok_callback = null;
var m_confirm_cancel_callback = null;
var m_confirm = function(msg, ok_callback, cancel_callback){
	m_confirm_ok_callback = ok_callback;
	m_confirm_cancel_callback = cancel_callback;
	var str = '';
	str += '<div id="m_confirm_div" class="base-confirm v-transfer-dom">';
	str += '	<div class="vux-confirm">';
	str += '		<div class="vux-x-dialog">';
	str += '			<div class="weui-mask"></div>';
	str += '			<div class="weui-dialog">';
	str += '				<div class="weui-dialog__bd">';
	str += '					<div class="content">';
	//str += '						<div class="success"></div>';
	str += '						<div>' + msg + '</div>';
	str += '					</div>';
	str += '				</div>';
	str += '				<div class="weui-dialog__ft">';
	str += '					<a href="javascript:;" onclick="m_confirm_ok()" class="weui-dialog__btn weui-dialog__btn_primary">确定</a>';
	str += '					<a href="javascript:;" onclick="m_confirm_cancel()" class="weui-dialog__btn weui-dialog__btn_default">取消</a>';
	str += '				</div>';
	str += '			</div>';
	str += '		</div>';
	str += '	</div>';
	str += '</div>';
	$("body").append(str);
};
var m_confirm_ok = function(){
	if(m_confirm_ok_callback != null) m_confirm_ok_callback();
	$("#m_confirm_div").remove();
};
var m_confirm_cancel = function(){
	if(m_confirm_cancel_callback != null) m_confirm_cancel_callback();
	$("#m_confirm_div").remove();
};

//选择框2
var m_confirm_ok_callback2 = null;
var m_confirm_cancel_callback2 = null;
var m_confirm2 = function(msg, ok_callback, cancel_callback){
	m_confirm_ok_callback2 = ok_callback;
	m_confirm_cancel_callback2 = cancel_callback;
	var str = '';
	str += '<div class="vux-confirm" id="m_confirm_div2">';
	str += '	<div class="vux-x-dialog">';
	str += '		<div class="weui-mask"></div>';
	str += '		<div class="weui-dialog">';
	str += '			<div class="weui-dialog__bd">';
	str += '				<div>' + msg + '</div>';
	str += '			</div>';
	str += '			<div class="weui-dialog__ft">';
	str += '				<a href="javascript:;" onclick="m_confirm_ok2()" class="weui-dialog__btn weui-dialog__btn_primary">确定</a>';
	str += '				<a href="javascript:;" onclick="m_confirm_cancel2()" class="weui-dialog__btn weui-dialog__btn_default">取消</a>';
	str += '			</div>';
	str += '		</div>';
	str += '	</div>';
	str += '</div>';
	$("body").append(str);
};
var m_confirm_ok2 = function(){
	if(m_confirm_ok_callback2 != null) m_confirm_ok_callback2();
	$("#m_confirm_div2").remove();
};
var m_confirm_cancel2 = function(){
	if(m_confirm_cancel_callback2 != null) m_confirm_cancel_callback2();
	$("#m_confirm_div2").remove();
};

//toast框
var m_toast = function(msg, showSuccessImg, showTransparent, timeout){
	if(showSuccessImg == null) showSuccessImg = false;
	if(showTransparent == null) showTransparent = false;
	if(timeout == null) timeout = 4000;
	var str = '';
	str += '<div class="vux-toast" id="m_toast_div">';
	if(showTransparent) {
		str += '<div class="weui-mask_transparent"></div>';
	}
	str += '	<div class="weui-toast weui-toast_text vux-toast-middle" style="width:80%;">';
	if(showSuccessImg) {
		str += '	<i class="weui-icon-success-no-circle weui-icon_toast"></i>';
	}
	str += '		<p class="weui-toast__content" style="word-break:break-all;word-wrap:break-word;">' + msg + '</p>';
	str += '	</div>';
	str += '	<script>';
	str += '	setTimeout("m_toast_close()", ' + timeout + ');';
	str += '	</script>';
	str += '</div>';
	$("body").append(str);
};
var m_toast_close = function(){
	$("#m_toast_div").remove();
};

//加载中图片
var m_loading = function(){
	var str = '<div class="loading-bkg"><div data-v-c96941ea="" class="loading"><svg data-v-c96941ea="" version="1.1" id="loader-1" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" x="0px" y="0px" width="40px" height="40px" viewBox="0 0 40 40" enable-background="new 0 0 40 40" xml:space="preserve"><path data-v-c96941ea="" opacity="0.2" fill="#000" d="M20.201,5.169c-8.254,0-14.946,6.692-14.946,14.946c0,8.255,6.692,14.946,14.946,14.946 s14.946-6.691,14.946-14.946C35.146,11.861,28.455,5.169,20.201,5.169z M20.201,31.749c-6.425,0-11.634-5.208-11.634-11.634 c0-6.425,5.209-11.634,11.634-11.634c6.425,0,11.633,5.209,11.633,11.634C31.834,26.541,26.626,31.749,20.201,31.749z"></path><path data-v-c96941ea="" fill="#000" d="M26.013,10.047l1.654-2.866c-2.198-1.272-4.743-2.012-7.466-2.012h0v3.312h0 C22.32,8.481,24.301,9.057,26.013,10.047z" transform="rotate(329.872 20 20)"><animateTransform data-v-c96941ea="" attributeType="xml" attributeName="transform" type="rotate" from="0 20 20" to="360 20 20" dur="0.5s" repeatCount="indefinite"></animateTransform></path></svg></div></div>';
	$("body").append(str);
};
var m_loading_close = function(){
	$("div.loading-bkg").remove();
}