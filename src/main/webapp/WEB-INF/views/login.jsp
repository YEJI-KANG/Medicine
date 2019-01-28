<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title></title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
<script type="text/javascript">

	function formCheck() {
		
		
		return true;
	}

</script>

</head>

<body>
<br><br><br>

<form action="login" method="post" onsubmit="formCheck()" style="margin: auto; width: 700px;">

	<div style="margin: auto; text-align: center; background-color: #eaeaea">
	<br><br>
	
	아이디<br>
	<input type="text" name="id" id="id" style="width: 200px;" required="required">
	<br><br>
	
	비밀번호<br>
	<input type="password" name="password" id="password" style="width: 200px;" required="required">
	<br><br>
	
	<button type="submit" style="width: 200px;">로그인</button><br><br>
	<span style="width: 100px; font-size: 12px; cursor: pointer;" onclick="location.href='join'"
	onmouseover="this.style.color='#363fef'" onmouseout="this.style.color='black'">
	회원가입</span>
	
	&nbsp;&nbsp;
	<span style="width: 100px; font-size: 12px; cursor: pointer;" onclick="location.href='find'"
	onmouseover="this.style.color='#363fef'" onmouseout="this.style.color='black'">
	아이디/비밀번호찾기</span>
	
	<br><br><br>
	</div>
</form>

	<c:if test="${not empty result and result==1 }">
		<script type="text/javascript">
		alert('가입되지않은 아이디입니다.\n회원가입 후, 로그인 바랍니다.');
		</script>
	</c:if>
	<c:if test="${not empty result and result==2 }">
		<script type="text/javascript">
		alert('비밀번호가 틀립니다.');
		</script>
	</c:if>
	<c:if test="${not empty result and result==4 }">
		<script type="text/javascript">
		alert('탈퇴한 아이디입니다.\n다시 회원가입 후, 로그인 바랍니다.');
		</script>
	</c:if>


<br><br><br><br><br><br>
</body>
</html>