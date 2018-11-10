<%
if(com.yy.guess.util.Util.isMobile(request)) {
	response.sendRedirect(request.getAttribute("basePath") + "m/index.jsp");
	return;
}
%><%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%><!DOCTYPE html>
<html>
<head>
<title>首页 - <%=com.yy.guess.util.Util.getConfigCom(application).getWebTitle()%></title>
<base href="${basePath}">
<meta charset="UTF-8">
<meta content="always" name="referrer">
<meta name="viewport" content="width=device-width, user-scalable=no, minimum-scale=1.0, maximum-scale=1.0, shrink-to-fit=no">
<meta name="mobile-web-app-capable" content="yes">
<meta name="apple-mobile-web-app-capable" content="yes">
<meta name="apple-mobile-web-app-status-bar-style" content="black-translucent">
<meta http-equiv="x-ua-compatible" content="ie=edge,chrome=1">
<meta name="theme-color" content="#040A18">
<link rel="stylesheet" type="text/css" href="assets/css/main.css">
<style type="text/css">
html,body {height:100%;width:100%;overflow-x:hidden;}
body {
  margin: 0;
  padding: 0;
  font-family: -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, "Helvetica Neue", Helvetica, "PingFang SC", "Hiragino Sans GB", "Microsoft YaHei", SimSun, sans-serif;
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
  -webkit-touch-callout: none;
  -webkit-user-select: none;
  -khtml-user-select: none;
  -moz-user-select: none;
  -ms-user-select: none;
  user-select: none;
  font-size: 1.5rem;
  line-height: 2.2rem;
  text-align: center;
  color: #fff;
  background-color: #040A18;
}
a {
  color: #fff;
  text-decoration: none;
}
.banner {
  width: 100%;
  background-image: url('https://staticimg.top/20181110/e28e618a-d8d6-4ee0-aecc-70db83d6954a.jpg');
  background-repeat: no-repeat;
  background-size: contain;
  background-position-x: center;
}
.image-pc {
  max-width: 1500px;
  display: block;
  visibility: hidden;
}

.image-mobile {
  display: none;
}

.btn-group {
  display: flex;
  justify-content: center;
  align-items: center;
  margin-top: -40px;
}

.button {
  width: 224px;
  height: 62px;
  margin: 6px 12px;
  background-image: linear-gradient(135deg, #21ABB1 0%, #2D8FB4 100%);
  box-shadow: 0 0 4px 0 rgba(14, 20, 34, 0.50);
  border-radius: 6px;
  border: 1px solid #22d7d9;
  font-size: 28px;
  outline: none;
  color: #fff;
}

.button:focus {
  background-image: linear-gradient(135deg, #16737D 0%, #1D607E 100%);
  box-shadow: 0 0 4px 0 rgba(14, 20, 34, 0.50);
  border: 2px solid #1fc0c2;
}

.app-button {
  background: #252F44;
  box-shadow: 0 2px 6px 0 #040A18, 0 5px 10px 0 rgba(31, 255, 250, 0.27);
  color: #1efffa;
  border-color: #1efffa;
}

.button-pc {
  display: block;
}

.button-mobile {
  display: none;
}

.app-button:focus {
  background: #151B29;
  color: #fff;
  border-color: #1d617e;
}

.qrcode {
  margin-top: 48px;
  display: flex;
  justify-content: center;
}

.qrcode-border {
  width: 306px;
  height: 306px;
  display: flex;
  flex-direction: column;
  justify-content: space-between;
  align-items: center;
  background-image: url('https://staticimg.top/20181110/e07b8260-79cf-47c0-a9f9-52545c2374e1.svg');
  background-size: contain;
  margin: 0 40px;
}

.qrcode-title {
  color: #1ffdfa;
}

@media (max-width: 768px) {
  .banner {
    background-image: url('https://staticimg.top/20181110/286e2104-7635-467b-a71c-e9c0afaba7a7.jpg');
  }
  .image-pc {
    display: none;
  }
  .image-mobile {
    display: block;
    visibility: hidden;
  }
  .btn-group {
    flex-direction: column;
    margin-top: -80px;
  }
  .button {
    width: calc(100% - 121px);
    height: 50px;
  }
  .button-pc {
    display: none;
  }
  .button-mobile {
    display: flex;
    justify-content: center;
    align-items: center;
  }
  .qrcode {
    display: none;
  }
}
</style>
</head>

<body>
	<section class="banner">
		<img src="https://staticimg.top/20181110/6e3c4d9e-e334-4640-8c3d-bdcce7ca2b44.jpg" width="100%" class="image-pc">
		<img src="https://staticimg.top:443/20181110/7ee30015-8ef6-434e-8d95-1bc6e91dd1dc.jpg" width="100%" class="image-mobile">
	</section>

	<section class="qrcode" id="h5_qrcode">
		<div class="qrcode-border">
			<div class="qrcode-title">手机扫描打开</div>
			<img id="qrcode_img" src="qr.png?url=${basePath}m/index.jsp" style="width:214px;margin-bottom:40px;">
		</div>
		<div class="qrcode-border" id="app_qrcode">
			<div class="qrcode-title">扫描下载Android APP</div>
			<img id="qrcode_img" src="qr.png?url=${basePath}bet999.apk" style="width:214px;margin-bottom:40px;">
		</div>
	</section>
	<footer style="height: 100px"></footer>
</body>
</html>