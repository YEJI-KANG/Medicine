<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>찾기</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
<script type="text/javascript">


function IDformCheck(){
	if($("#IDidnum1").val().length!=6){
		alert('주민등록번호 앞자리는 6자리여야 합니다.');
		return false;
	}
	if($("#IDidnum2").val().length!=7){
		alert('주민등록번호 뒷자리는 7자리여야 합니다.');
		return false;
	}
	return true;
}


function PSformCheck(){
	if($("#PSid").val().length<4){
		alert('아이디는 4자이상이여야 합니다.');
		return false;
	}
	if($("#PSidnum1").val().length!=6){
		alert('주민등록번호 앞자리는 6자리여야 합니다.');
		return false;
	}
	if($("#PSidnum2").val().length!=7){
		alert('주민등록번호 뒷자리는 7자리여야 합니다.');
		return false;
	}
	return true;
}


</script>


</head>
<body>
<br><br><br><br><br><br><br>

<form action="find" method="post" onsubmit="IDformCheck()" style="margin: auto; width: 700px;">

	<div style="margin: auto; text-align: center; background-color: #eaeaea">
	<br><br>
	<h2 align="center" style="color: #363fef;">아이디 찾기</h2>
	<br><br>
	이름<br>
	<input type="text" name="IDname" id="IDname" style="width: 200px;" required="required">
	<br><br>
	
	주민등록번호<br>
	<input type="text" name="IDidnum1" id="IDidnum1" style="width: 88px;" required="required" maxlength="6"> - 
	<input type="password" name="IDidnum2" id="IDidnum2" style="width: 88px;" required="required" maxlength="7">
	<br><br>
	
	<button type="submit" style="width: 200px;">아이디 찾기</button><br><br>
	

	<br><br>
	</div>
</form>

<br><br>

<form action="find" method="post" onsubmit="PSformCheck()" style="margin: auto; width: 700px;">

	<div style="margin: auto; text-align: center; background-color: #eaeaea">
	<br><br>
	<h2 align="center" style="color: #363fef;">비밀번호 찾기</h2>
	<br><br>
	
	아이디<br>
		<input type="text" name="PSid" id="PSid" style="width: 200px;" required="required">
	<br><br>
	
	이름<br>
	<input type="text" name="PSname" id="PSname" style="width: 200px;" required="required">
	<br><br>
	
	주민등록번호<br>
	<input type="text" name="PSidnum1" id="PSidnum1" style="width: 88px;" required="required" maxlength="6"> - 
	<input type="password" name="PSidnum2" id="PSidnum2" style="width: 88px;" required="required" maxlength="7">
	<br><br>
	
	<button type="submit" style="width: 200px;">비밀번호 찾기</button><br><br>
	

	<br><br>
	</div>
</form>

	<c:if test="${not empty result and result.equals('1') }">
		<script type="text/javascript">
		alert('약국 이용기록이 없는 정보입니다.');
		</script>
	</c:if>
	
	<c:if test="${not empty result and result.equals('2') }">
		<script type="text/javascript">
		alert('회원 가입기록이 없거나 탈퇴한 정보입니다.');
		</script>
	</c:if>
	
	<c:if test="${not empty result and result.equals('3') }">
		<script type="text/javascript">
		alert('입력한 아이디가 틀립니다.');
		</script>
	</c:if>
	
<br><br><br><br><br><br><br>
</body>
</html>