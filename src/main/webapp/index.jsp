<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%><!DOCTYPE html>
<html>
<head>
<base href="${basePath}">
<!--
<script src="js/jquery.js"></script>
-->
<script src="admin/js/common.js"></script>
<script src="https://cdn.bootcss.com/iScroll/5.2.0/iscroll.min.js"></script>
<style type="text/css">
#wrapper {
	position: absolute;
	z-index: 1;
	top: 45px;
	bottom: 48px;
	left: 0;
	width: 100%;
	background: #ccc;
	overflow: hidden;
}
#scroller {
	position: absolute;
	z-index: 1;
	-webkit-tap-highlight-color: rgba(0,0,0,0);
	width: 100%;
	-webkit-transform: translateZ(0);
	-moz-transform: translateZ(0);
	-ms-transform: translateZ(0);
	-o-transform: translateZ(0);
	transform: translateZ(0);
	-webkit-touch-callout: none;
	-webkit-user-select: none;
	-moz-user-select: none;
	-ms-user-select: none;
	user-select: none;
	-webkit-text-size-adjust: none;
	-moz-text-size-adjust: none;
	-ms-text-size-adjust: none;
	-o-text-size-adjust: none;
	text-size-adjust: none;
}
</style>
<script>
var load = function(){
	var myScroll = new IScroll("#wrapper", {
		scrollbars: true,
		mouseWheel: true,
		interactiveScrollbars: true,
		shrinkScrollbars: 'scale',
		fadeScrollbars: true
	});
}
</script>
<title>竞猜</title>
</head>
<body onload="load()">
<h2>Hello guess!</h2>
<div id="wrapper">
	<div id="scroller">
		<ul>
			<li>Pretty row 1</li>
			<li>Pretty row 2</li>
			<li>Pretty row 3</li>
			<li>Pretty row 4</li>
			<li>Pretty row 5</li>
			<li>Pretty row 6</li>
			<li>Pretty row 7</li>
			<li>Pretty row 8</li>
			<li>Pretty row 9</li>
			<li>Pretty row 10</li>
			<li>Pretty row 11</li>
			<li>Pretty row 12</li>
			<li>Pretty row 13</li>
			<li>Pretty row 14</li>
			<li>Pretty row 15</li>
			<li>Pretty row 16</li>
			<li>Pretty row 17</li>
			<li>Pretty row 18</li>
			<li>Pretty row 19</li>
			<li>Pretty row 20</li>
			<li>Pretty row 21</li>
			<li>Pretty row 22</li>
			<li>Pretty row 23</li>
			<li>Pretty row 24</li>
			<li>Pretty row 25</li>
			<li>Pretty row 26</li>
			<li>Pretty row 27</li>
			<li>Pretty row 28</li>
			<li>Pretty row 29</li>
			<li>Pretty row 30</li>
			<li>Pretty row 31</li>
			<li>Pretty row 32</li>
			<li>Pretty row 33</li>
			<li>Pretty row 34</li>
			<li>Pretty row 35</li>
			<li>Pretty row 36</li>
			<li>Pretty row 37</li>
			<li>Pretty row 38</li>
			<li>Pretty row 39</li>
			<li>Pretty row 40</li>
			<li>Pretty row 41</li>
			<li>Pretty row 42</li>
			<li>Pretty row 43</li>
			<li>Pretty row 44</li>
			<li>Pretty row 45</li>
			<li>Pretty row 46</li>
			<li>Pretty row 47</li>
			<li>Pretty row 48</li>
			<li>Pretty row 49</li>
			<li>Pretty row 50</li>
		</ul>
	</div>
</div>
</body>
</html>