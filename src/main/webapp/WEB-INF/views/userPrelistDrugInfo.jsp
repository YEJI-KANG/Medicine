<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>약정보 페이지</title>
<link href="https://fonts.googleapis.com/css?family=Noto+Sans+KR&amp;subset=korean" rel="stylesheet">
<style type="text/css">
body {
	font-family: 'Noto Sans KR', sans-serif;
}
</style>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js" ></script>

<script type="text/javascript">


</script>
</head>
<body>
<div style="width: 400px; overflow:auto; height: 400px; margin: auto; text-align: center;">

		
		<c:if test="${empty apiVO.class_name }">
		<br><br><br><br><br><br><br><br>
		약정보가 존재하지 않습니다.
		</c:if>
		
		<c:if test="${not empty apiVO.class_name }">
		
		<h1>${apiVO.item_name }</h1>
		<h3>(${apiVO.class_name })</h3>
		<img src="${apiVO.item_image }" width="300px"><br><br>
		${apiVO.chart }
		</c:if>
		<br><br>
</div>
</body>
</html>