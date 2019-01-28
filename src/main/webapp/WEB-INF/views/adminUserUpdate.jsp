<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
<script type="text/javascript">

	function formCheck(){
		var password=$("#password").val();
		var passwordCheck=$("#passwordCheck").val();
		if(password!==passwordCheck){
			alert('비밀번호 확인값이 다릅니다.');
			return false;
		}
		return true;
	}


</script>

</head>


<body>
<br><br>
<h2 align="center" style="color: #363fef;">관리자정보 수정</h2>
<br><br>
<form action="updateOk" method="post" onsubmit="return formCheck()" style="margin: auto; width: 400px;">

	<span style="font-weight: bold;">아이디</span><br>
	${vo.id }<br><br><br><br><br>
	비밀번호<br>
	<input type="password" id="password" name="password" required="required" value="${vo.password }"><br><br><br><br><br>
	비밀번호 확인<br>
	<input type="password" id="passwordCheck" required="required" value="${vo.password }"><br><br><br><br><br>
	
	<div style="margin: auto; width: 300px; text-align: center;">
	<button type="reset">다시수정</button>
	<button type="submit">수정완료</button>
	</div>
</form>
<br><br>
</body>
</html>