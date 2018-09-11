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

</script>
<title>竞猜</title>
</head>
<body>
<h2>Hello guess!</h2>

<form action="user/bet" method="post">
<table>
	<tr><td>playTypeId：</td><td><input type="text" name="playTypeId" value="6" style="width:400px;"></td></tr>
	<tr><td>betDirection：</td><td><select name="betDirection"><option>LEFT</option><option>RIGHT</option></select></td></tr>
	<tr><td>betAmount：</td><td><input type="text" name="betAmount" style="width:400px;"></td></tr>
	<tr><td></td><td><input type="submit" value="提交"></td></tr>
</table>
</form>

</body>
</html>