<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%><!DOCTYPE html>
<html>
<head>
<base href="${basePath}">
<script src="js/jquery.js"></script>
<script src="admin/js/common.js"></script>
<style type="text/css">
table,table tr th, table tr td { border:1px solid grey;padding:3px;}
table {border-collapse: collapse;}
</style>
<script>
var playTypeId = "6";

var getNewestOdds = function(){
	loadData({
		url : "getNewestOdds",
		data : {
			"playTypeId" : playTypeId,
			"betDirection" : "LEFT"
		},
		success : function(data){
			$("#LEFT .newestOdds").html("左方最新赔率：" + data.result);
		}
	});
	
	loadData({
		url : "getNewestOdds",
		data : {
			"playTypeId" : playTypeId,
			"betDirection" : "RIGHT"
		},
		success : function(data){
			$("#RIGHT .newestOdds").html("右方最新赔率：" + data.result);
		}
	});
};

var getBonusPool = function(){
	loadData({
		url : "getBonusPool",
		data : {
			"playTypeId" : playTypeId,
			"betDirection" : "LEFT"
		},
		success : function(data){
			$("#LEFT .bonusPool").html("左方奖金池：" + data.result);
		}
	});
	
	loadData({
		url : "getBonusPool",
		data : {
			"playTypeId" : playTypeId,
			"betDirection" : "RIGHT"
		},
		success : function(data){
			$("#RIGHT .bonusPool").html("右方奖金池：" + data.result);
		}
	});
};

var getUnSoldBetList = function(){
	loadData({
		url : "getUnSoldBetList",
		data : {
			"playTypeId" : playTypeId,
			"betDirection" : "LEFT"
		},
		success : function(data) {
			var list = data.result;
			if(list != null && list.length > 0) {
				var str = '';
				for(var i=0; i<list.length; i++) {
					var obj = list[i];
					str += '<tr class="content">';
					str += '<td>' + obj.id + '</td>';
					str += '<td>' + obj.versusId + '</td>';
					str += '<td>' + obj.playTypeId + '</td>';
					str += '<td>' + obj.userId + '</td>';
					str += '<td>' + obj.userName + '</td>';
					str += '<td>' + obj.betDirection + '</td>';
					str += '<td>' + obj.odds + '</td>';
					str += '<td>' + obj.betAmount + '</td>';
					str += '<td>' + obj.soldAmount + '</td>';
					str += '<td>' + obj.soldOut + '</td>';
					str += '<td>' + obj.createTime + '</td>';
					str += '</tr>';
				}
				$("tr.content").remove();
				$("table#LEFT").append(str);
			}
		}
	});
	
	
	loadData({
		url : "getUnSoldBetList",
		data : {
			"playTypeId" : playTypeId,
			"betDirection" : "RIGHT"
		},
		success : function(data) {
			var list = data.result;
			if(list != null && list.length > 0) {
				var str = '';
				for(var i=0; i<list.length; i++) {
					var obj = list[i];
					str += '<tr class="content">';
					str += '<td>' + obj.id + '</td>';
					str += '<td>' + obj.versusId + '</td>';
					str += '<td>' + obj.playTypeId + '</td>';
					str += '<td>' + obj.userId + '</td>';
					str += '<td>' + obj.userName + '</td>';
					str += '<td>' + obj.betDirection + '</td>';
					str += '<td>' + obj.odds + '</td>';
					str += '<td>' + obj.betAmount + '</td>';
					str += '<td>' + obj.soldAmount + '</td>';
					str += '<td>' + obj.soldOut + '</td>';
					str += '<td>' + obj.createTime + '</td>';
					str += '</tr>';
				}
				$("tr.content").remove();
				$("table#RIGHT").append(str);
			}
		}
	});
};

$(document).ready(function(){
	getBonusPool();
	getUnSoldBetList();
	getNewestOdds();
});
</script>
<title>竞猜</title>
</head>
<body>
<h2>Hello guess!</h2>

<form action="testBet" method="post">
<table>
	<tr><td>playTypeId：</td><td><input type="text" name="playTypeId" value="6" style="width:400px;"></td></tr>
	<tr><td>userId：</td><td><select name="userId"><option>100001</option><option>100002</option><option>100003</option><option>100004</option><option>100005</option><option>100006</option><option>100007</option></select></td></tr>
	<tr><td>betDirection：</td><td><select name="betDirection"><option>LEFT</option><option>RIGHT</option></select></td></tr>
	<tr><td>odds：</td><td><input type="text" name="odds" style="width:400px;"></td></tr>
	<tr><td>betAmount：</td><td><input type="text" name="betAmount" style="width:400px;"></td></tr>
	<tr><td></td><td><input type="submit" value="提交"></td></tr>
</table>
</form>

<hr>

<table id="LEFT">
	<tr><td colspan="99" class="bonusPool"></td></tr>
	<tr><td colspan="99" class="newestOdds"></td></tr>
	<tr>
		<td>ID</td>
		<td>versusId</td>
		<td>playTypeId</td>
		<td>userId</td>
		<td>userName</td>
		<td>betDirection</td>
		<td>odds</td>
		<td>betAmount</td>
		<td>soldAmount</td>
		<td>soldOut</td>
		<td>createTime</td>
	</tr>
</table>

<hr>

<table id="RIGHT">
	<tr><td colspan="99" class="bonusPool"></td></tr>
	<tr><td colspan="99" class="newestOdds"></td></tr>
	<tr>
		<td>ID</td>
		<td>versusId</td>
		<td>playTypeId</td>
		<td>userId</td>
		<td>userName</td>
		<td>betDirection</td>
		<td>odds</td>
		<td>betAmount</td>
		<td>soldAmount</td>
		<td>soldOut</td>
		<td>createTime</td>
	</tr>
</table>

</body>
</html>