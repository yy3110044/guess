<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%><!DOCTYPE html>
<html>
<head>
<title>用户中心 - <%=com.yy.guess.util.Util.getConfigCom(application).getWebTitle()%></title>
<%@include file="/m/head-common.jsp"%>
</head>
<body><noscript><strong>請啟用JavaScript已继续。</strong><br><h5>iOS > 设置 > Safari浏览器 > 高级 > JavaScript</h5><h5>Chrome > 设置 > 网站设置 > JavaScript</h5></noscript><div id="app" class=""><!----> <!----> <!----> <div class="loading-bkg" style="display: none;"><div data-v-c96941ea="" class="loading"><svg data-v-c96941ea="" version="1.1" id="loader-1" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" x="0px" y="0px" width="40px" height="40px" viewBox="0 0 40 40" enable-background="new 0 0 40 40" xml:space="preserve"><path data-v-c96941ea="" opacity="0.2" fill="#000" d="M20.201,5.169c-8.254,0-14.946,6.692-14.946,14.946c0,8.255,6.692,14.946,14.946,14.946
  s14.946-6.691,14.946-14.946C35.146,11.861,28.455,5.169,20.201,5.169z M20.201,31.749c-6.425,0-11.634-5.208-11.634-11.634
  c0-6.425,5.209-11.634,11.634-11.634c6.425,0,11.633,5.209,11.633,11.634C31.834,26.541,26.626,31.749,20.201,31.749z"></path> <path data-v-c96941ea="" fill="#000" d="M26.013,10.047l1.654-2.866c-2.198-1.272-4.743-2.012-7.466-2.012h0v3.312h0
  C22.32,8.481,24.301,9.057,26.013,10.047z" transform="rotate(246.816 20 20)"><animateTransform data-v-c96941ea="" attributeType="xml" attributeName="transform" type="rotate" from="0 20 20" to="360 20 20" dur="0.5s" repeatCount="indefinite"></animateTransform></path></svg></div></div> <nav data-v-1db5fc32="" class="app-header"><ul data-v-1db5fc32=""><li data-v-1db5fc32="" class="base-icon history-back"></li> <li data-v-1db5fc32="">通知</li> <li data-v-1db5fc32="" class="base-icon"></li></ul></nav> <div class="weui-tab"> <div id="vux_view_box_body" class="weui-tab__panel vux-fix-safari-overflow-scrolling"><div data-v-6a2bb1cf="" class="notice-page router-view"><section data-v-6a2bb1cf="" class="notice-content"><div data-v-6a2bb1cf="" class="content-title"><div data-v-6a2bb1cf="" class="notice-icon" style="background-image: url(&quot;data:image/svg+xml;base64,PD94bWwgdmVyc2lvbj0iMS4wIiBlbmNvZGluZz0iVVRGLTgiPz4KPHN2ZyB3aWR0aD0iMjRweCIgaGVpZ2h0PSIyNHB4IiB2aWV3Qm94PSIwIDAgMjQgMjQiIHZlcnNpb249IjEuMSIgeG1sbnM9Imh0dHA6Ly93d3cudzMub3JnLzIwMDAvc3ZnIiB4bWxuczp4bGluaz0iaHR0cDovL3d3dy53My5vcmcvMTk5OS94bGluayI+CiAgICA8IS0tIEdlbmVyYXRvcjogU2tldGNoIDQ5LjMgKDUxMTY3KSAtIGh0dHA6Ly93d3cuYm9oZW1pYW5jb2RpbmcuY29tL3NrZXRjaCAtLT4KICAgIDx0aXRsZT7kuK3lpZbkv6Hmga88L3RpdGxlPgogICAgPGRlc2M+Q3JlYXRlZCB3aXRoIFNrZXRjaC48L2Rlc2M+CiAgICA8ZGVmcz48L2RlZnM+CiAgICA8ZyBpZD0i6Zu356ue5oqAMi4w77yI6LCD5pW0djAx77yJIiBzdHJva2U9Im5vbmUiIHN0cm9rZS13aWR0aD0iMSIgZmlsbD0ibm9uZSIgZmlsbC1ydWxlPSJldmVub2RkIj4KICAgICAgICA8ZyBpZD0iaWNvbuWIh+WbviIgdHJhbnNmb3JtPSJ0cmFuc2xhdGUoLTIwNi4wMDAwMDAsIC0xMzE3LjAwMDAwMCkiPgogICAgICAgICAgICA8ZyBpZD0i5Lit5aWW5L+h5oGvIiB0cmFuc2Zvcm09InRyYW5zbGF0ZSgyMDYuMDAwMDAwLCAxMzE3LjAwMDAwMCkiPgogICAgICAgICAgICAgICAgPHBhdGggZD0iTTE4LDEyIEwxOCw5IEMxOCw4LjQ0NzcxNTI1IDE3LjU1MjI4NDcsOCAxNyw4IEw3LDggQzYuNDQ3NzE1MjUsOCA2LDguNDQ3NzE1MjUgNiw5IEw2LDEyIEw1LDEyIEM0LjQ0NzcxNTI1LDEyIDQsMTEuNTUyMjg0NyA0LDExIEw0LDggQzQsNi44OTU0MzA1IDQuODk1NDMwNSw2IDYsNiBMMTgsNiBDMTkuMTA0NTY5NSw2IDIwLDYuODk1NDMwNSAyMCw4IEwyMCwxMSBDMjAsMTEuNTUyMjg0NyAxOS41NTIyODQ3LDEyIDE5LDEyIEwxOCwxMiBaIiBpZD0iQ29tYmluZWQtU2hhcGUiIGZpbGw9IiNFNTJCRjMiIGZpbGwtcnVsZT0iZXZlbm9kZCI+PC9wYXRoPgogICAgICAgICAgICAgICAgPHBhdGggZD0iTTcsMTAgTDcsMTggQzcsMTguNTUyMjg0NyA3LjQ0NzcxNTI1LDE5IDgsMTkgTDE2LDE5IEMxNi41NTIyODQ3LDE5IDE3LDE4LjU1MjI4NDcgMTcsMTggTDE3LDEwIEwxOSwxMCBMMTksMTkgQzE5LDIwLjEwNDU2OTUgMTguMTA0NTY5NSwyMSAxNywyMSBMNywyMSBDNS44OTU0MzA1LDIxIDUsMjAuMTA0NTY5NSA1LDE5IEw1LDEwIEw3LDEwIFoiIGlkPSJDb21iaW5lZC1TaGFwZSIgZmlsbD0iI0U1MkJGMyIgZmlsbC1ydWxlPSJldmVub2RkIj48L3BhdGg+CiAgICAgICAgICAgICAgICA8cGF0aCBkPSJNNi41LDEwLjUgTDEzLjUsMTAuNSBMNi41LDEwLjUgWiBNMTUuNSwxMC41IEwxNy41LDEwLjUgTDE1LjUsMTAuNSBaIiBpZD0iQ29tYmluZWQtU2hhcGUiIHN0cm9rZT0iI0JBM0ZGRiIgc3Ryb2tlLXdpZHRoPSIxIj48L3BhdGg+CiAgICAgICAgICAgICAgICA8cGF0aCBkPSJNMTEuNSw1LjE0NTE0MDE0IEwxMS41Nzc3ODk4LDUuMjY3ODQwNTYgTDExLjUsNSBMMTEuNSw1LjE0NTE0MDE0IFogTTExLjUsNS41IEwxMS41LDYgTDEyLDUuNSBMMTEuNSw1LjUgWiBNOC45ODMxMjU4NCw1LjUgTDguOTU1MDc4MTIsNS41IEw4Ljk1NTA3ODEyLDYgTDkuMzk2MjYwNjksNi4yMzUyODI3IEw5Ljc3OTA4NjY0LDUuNTE3NDM5MjcgTDguOTgzMTI1ODQsNS41IFoiIGlkPSJDb21iaW5lZC1TaGFwZSIgc3Ryb2tlPSIjQkEzRkZGIiBzdHJva2Utd2lkdGg9IjEiPjwvcGF0aD4KICAgICAgICAgICAgICAgIDxwYXRoIGQ9Ik0xNi41LDUuMTQ1MTQwMTQgTDE2LjU3Nzc4OTgsNS4yNjc4NDA1NiBMMTYuNSw1IEwxNi41LDUuMTQ1MTQwMTQgWiBNMTYuNSw1LjUgTDE2LjUsNiBMMTcsNS41IEwxNi41LDUuNSBaIE0xMy45ODMxMjU4LDUuNSBMMTMuOTU1MDc4MSw1LjUgTDEzLjk1NTA3ODEsNiBMMTQuMzk2MjYwNyw2LjIzNTI4MjcgTDE0Ljc3OTA4NjYsNS41MTc0MzkyNyBMMTMuOTgzMTI1OCw1LjUgWiIgaWQ9IkNvbWJpbmVkLVNoYXBlIiBzdHJva2U9IiNCQTNGRkYiIHN0cm9rZS13aWR0aD0iMSIgdHJhbnNmb3JtPSJ0cmFuc2xhdGUoMTQuNTAwMDAwLCA0LjAwMDAwMCkgc2NhbGUoLTEsIDEpIHRyYW5zbGF0ZSgtMTQuNTAwMDAwLCAtNC4wMDAwMDApICI+PC9wYXRoPgogICAgICAgICAgICA8L2c+CiAgICAgICAgPC9nPgogICAgPC9nPgo8L3N2Zz4=&quot;);"></div> <div data-v-6a2bb1cf="">恭喜中奖</div> <div data-v-6a2bb1cf="" class="notice-time">2018年9月3日 20:16:11</div></div> <div data-v-6a2bb1cf="" class="content-body"><div data-v-6a2bb1cf="">盈利  12.7</div></div></section><!----><!----></div></div> </div> <!----> <!----></div><script type="text/javascript" async="" src="/_Incapsula_Resource?SWJIYLWA=719d34d31c8e3a6e6fffd425f7e032f3&amp;ns=1&amp;cb=675340672"></script><script type="text/javascript" async="" src="https://www.google-analytics.com/analytics.js"></script><script async="" src="https://www.googletagmanager.com/gtag/js?id=UA-115025704-1"></script><script>window.dataLayer = window.dataLayer || []

    function gtag() {
      dataLayer.push(arguments)
    }
    gtag('js', new Date())

    gtag('config', 'UA-115025704-1')
    window.addEventListener('load', function () {
      setTimeout(function () {
        window.scrollTo(0, 1)
      }, 10)
    })</script><script type="text/javascript" src="static/js/manifest.569709e9b6416c4decb5.js"></script><script type="text/javascript" src="static/js/vendor.a457f24991fca5f2ac72.js"></script><script type="text/javascript" src="static/js/app.025d194ca9a0fd517ef4.js"></script><div class="vux-alert"><div class="vux-x-dialog"><div class="weui-mask" style="display: none;"></div> <div class="weui-dialog" style="display: none;"><div class="weui-dialog__hd"><strong class="weui-dialog__title"></strong></div> <div class="weui-dialog__bd"><div></div></div> <div class="weui-dialog__ft"><a href="javascript:;" class="weui-dialog__btn weui-dialog__btn_primary">确定</a></div></div></div></div><div class="vux-confirm"><div class="vux-x-dialog"><div class="weui-mask" style="display: none;"></div> <div class="weui-dialog" style="display: none;"><!----> <div class="weui-dialog__bd"><div></div></div> <div class="weui-dialog__ft"><a href="javascript:;" class="weui-dialog__btn weui-dialog__btn_default">取消</a> <a href="javascript:;" class="weui-dialog__btn weui-dialog__btn_primary">确定</a></div></div></div></div><div class="vux-toast"><div class="weui-mask_transparent" style="display: none;"></div> <div class="weui-toast weui-toast_success vux-toast-middle" style="width: 7.6em; display: none;"><i class="weui-icon-success-no-circle weui-icon_toast" style=""></i> <p class="weui-toast__content">登录成功</p></div></div><div data-v-cd2dfd02="" class="base-alert v-transfer-dom"><div data-v-cd2dfd02="" class="vux-x-dialog"><div class="weui-mask" style="display: none;"></div> <div class="weui-dialog" style="background: transparent; display: none;"><div data-v-cd2dfd02="" class="alert-content"><div data-v-cd2dfd02="" class="warning"></div> <div data-v-cd2dfd02="" class="alert-text"></div> <div data-v-cd2dfd02="" class="alert-hr"></div> <div data-v-cd2dfd02="" class="alert-btn">确认
      </div></div></div></div></div><script type="text/javascript">
//<![CDATA[
(function() {
var _analytics_scr = document.createElement('script');
_analytics_scr.type = 'text/javascript'; _analytics_scr.async = true; _analytics_scr.src = '/_Incapsula_Resource?SWJIYLWA=719d34d31c8e3a6e6fffd425f7e032f3&ns=1&cb=675340672';
var _analytics_elem = document.getElementsByTagName('script')[0]; _analytics_elem.parentNode.insertBefore(_analytics_scr, _analytics_elem);
})();
// ]]>
</script><a class="vux-popup-mask" data-uuid=",mkqed,fl2rs" href="javascript:void(0)"></a></body>
</html>