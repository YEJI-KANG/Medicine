<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>조제정보 입력</title>

<link rel="stylesheet" href="https://code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css" />
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>

<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>

<script type="text/javascript">

$(function () {

	
})

	function deleteCheck(idx) {
		if(confirm('정말 삭제하시겠습니까?')!=0){
			location.href="notice/delete?idx="+idx;
		}
		else{ }
	}

</script>

</head>


<body>
<br><br>
<h2 align="center" style="color: #363fef;">공지사항</h2>
<br><br>
<div style="margin: auto; width: 700px; text-align: center;">

	<span style="font-weight: bold; font-size: 15pt;">${vo.title }</span><br>
	<br>
	
	<div style="background-color: #eaeaea; padding-left:50px; text-align: left;">
	<br>
	<pre>${vo.context }</pre>
	<br>
	</div>
	
	
	
	
	<br><br><br><br>

	
	
	
	<c:if test="${flag==0 }">
	<button type="button" onclick="location.href='/yjk/notice'">뒤로가기</button>
	</c:if>
	<c:if test="${flag!=0 }">
	<button type="button" onclick="location.href='/yjk/notice'">뒤로가기</button>
	<button onclick="location.href='notice/update?idx=${vo.idx }'">수정하기</button>
	<button onclick="deleteCheck(${vo.idx })">삭제하기</button>
	</c:if>
	
	<br><br><br><br>
	
</div>

<br><br>
</body>
</html>