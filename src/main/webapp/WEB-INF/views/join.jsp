<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원가입</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
<script type="text/javascript">
	
	var i=2; //0:사용가능 아이디 //1:존재하는 아이디 //2:idCheck안함

	
$(function () {

	$( "#id" ).keydown(function() {
		  i=2;
		  //alert('키다운');
		});
	
	
})

	

	function idCheck() {
		
		var value=$("#id").val();
		
		if(value===""||value.trim().length==0){
			alert('아이디를 입력해주세요.');
		}
		else{
		$.ajax({
			url: "idCheck",
			data: "id="+value,
			success:
				function(data) {
				//alert(typeof(data)); : String
					var data1=data;
					if(data1==='1'||data1==1){
						alert('이미 존재하는 아이디입니다.');
						i=1;
					}
					else{
						alert('사용가능한 아이디입니다.');
						i=0;
					}
		
			}	
		});
		}
	}
	
//	
	function formCheck(){
		
	if(i==1 || i==2){
			alert('아이디 중복체크가 필요합니다.');
			return false;
		}
		if($("#id").val().length<4){
			alert('아이디는 4자이상이여야 합니다.');
			i=2;
			return false;
		}

		var engNum = /[ㄱ-ㅎ|ㅏ-ㅣ|가-힣]/;
		if(engNum.test($("#id").val())){
			alert('아이디는 영문과 숫자로만 구성되어야 합니다.'); 
			i=2;
			return false;
		}

		var password=$("#password").val();
		var passwordCheck=$("#passwordCheck").val();
		if(password!==passwordCheck){
			alert('비밀번호 확인값이 다릅니다.');
			return false;
		}
		if($("#idnum1").val().length!=6){
			alert('주민등록번호 앞자리는 6자리여야 합니다.');
			return false;
		}
		if($("#idnum2").val().length!=7){
			alert('주민등록번호 뒷자리는 7자리여야 합니다.');
			return false;
		}
		return true;
	
	
	}

</script>
</head>


<body>

<br><br>
<h2 align="center" style="color: #363fef;">회원가입</h2>
<br><br>
<form action="join" method="post" onsubmit="return formCheck()" style="margin: auto; width: 400px;">

	이름<br>
	<span style="font-size: 10pt; color: grey;">* 약국 이용경험이 있는 분만 가입이 가능합니다.</span><br>
	<input type="text" name="name" required="required"><br><br><br><br><br>
	주민등록번호<br>
	<span style="font-size: 10pt; color: grey;">* 약국 이용경험이 있는 분만 가입이 가능합니다.</span><br>
	<input type="text" name="idnum1" required="required" id="idnum1" maxlength="6">
	 - <input type="text" name="idnum2" required="required" id="idnum2" maxlength="7"><br><br><br><br><br>
	아이디<br>
	<span style="font-size: 10pt; color: grey;">* 4자이상의 영문,숫자로만 입력해주세요.</span><br>
	<input type="text" name="id" required="required" id="id">
	<button type="button" onclick="idCheck()">중복확인</button>
	<br><br><br><br><br>
	비밀번호<br>
	<input type="password" id="password" name="password" required="required"><br><br><br><br><br>
	비밀번호 확인<br>
	<input type="password" id="passwordCheck" required="required"><br><br><br><br><br>
	전화번호<br>
	<span style="font-size: 10pt; color: grey;">* -를 제외한 번호만을 입력해주세요.</span><br>
	<input type="text" name="phone" required="required"><br><br><br><br><br>
	

	<button type="reset" style="margin-left: 130px;">다시작성</button>
	<button type="submit">작성완료</button>

	<br><br><br><br>
	
</form>

<br><br>
		
	<c:if test="${not empty result and result==1 }">
		<script type="text/javascript">
		alert('약국 이용기록이 없습니다.');
		</script>
	</c:if>
	
	<c:if test="${not empty result and result==2 }">
		<script type="text/javascript">
		alert('이미 가입한 사용자입니다.');
		</script>
	</c:if>
	

</body>


</html>