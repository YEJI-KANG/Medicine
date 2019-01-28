<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title></title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js" ></script>
<script type="text/javascript">

</script>
</head>
<body>
<br><br><br><br><br><br><br>

<div style="margin: auto; width: 700px;">

	<div style="margin: auto; text-align: center;">
	<br><br>

	회원님의 아이디는<br>
	<span style="color: #363fef; font-weight: bold;">${result }</span> 입니다.
	<br><br>
	
	<button style="width: 100px;" onclick="location.href='/yjk/'">로그인</button>
	&nbsp;&nbsp;
	<button style="width: 100px;" onclick="location.href='find'">비밀번호찾기</button>
	
	<br><br><br>
	</div>
</div>

	
<br><br><br><br><br><br><br>
</body>
</html>