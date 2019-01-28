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
<h2 align="center" style="color: #363fef;">회원정보 수정</h2>
<br><br>
<form action="updateOk" method="post" onsubmit="return formCheck()" style="margin: auto; width: 400px;">

	<span style="font-weight: bold;">이름</span><br>
	${vo.name }<br><br><br><br><br>
	<span style="font-weight: bold;">주민등록번호</span><br>
	${vo.idnum1 }
	 - ${vo.idnum2 }<br><br><br><br><br>
	<span style="font-weight: bold;">아이디</span><br>
	${vo.id }<br><br><br><br><br>
	<span>비밀번호</span><br>
	<input type="password" id="password" name="password" required="required" value="${vo.password }"><br><br><br><br><br>
	<span>비밀번호 확인</span><br>
	<input type="password" id="passwordCheck" required="required" value="${vo.password }"><br><br><br><br><br>
	<span>전화번호</span><br>
	<span style="font-size: 10pt; color: grey;">* -를 제외한 번호만을 입력해주세요.</span><br>
	<input type="text" name="phone" required="required" value="${vo.phone }"><br><br><br><br><br>
	
	<div style="margin: auto; width: 300px; text-align: center;">
	<button type="reset">다시수정</button>
	<button type="submit">수정완료</button>
	</div>
</form>
<br><br>
</body>
</html>