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

	function withdrawalCheck(){
		if(confirm('정말 탈퇴하시겠습니까?')!=0){
			if(confirm('탈퇴 후에도 작성한 질문은 남습니다.\n정말 탈퇴하시겠습니까?')!=0){
				
				var id = $("#id").val();
				
				$.ajax({
				    url: "withdrawal", // 요청 할 주소
				    async: true, // false 일 경우 동기 요청으로 변경
				    type: "POST", // GET, PUT
				    data: {
				        "id" : id
				    }, // 전송할 데이터
				    dataType: 'text', // xml, json, script, html
				    beforeSend: function(data) {}, // 서버 요청 전 호출 되는 함수 return false; 일 경우 요청 중단
				    success: function(data) {
				    	alert('탈퇴되었습니다.');
				    	location.href="/yjk/";
				    }, // 요청 완료 시
				    error: function(data) {}, // 요청 실패.
				    complete: function(data) {} // 요청의 실패, 성공과 상관 없이 완료 될 경우 호출
				});
				
				
			}
		}
	}

</script>



</head>


<body>
<br><br>
<h2 align="center" style="color: #363fef;">회원정보</h2>
<br><br>
<div style="margin: auto; width: 400px;">

	<span style="font-weight: bold;">이름</span><br>
	${vo.name }<br><br><br><br><br>
	<span style="font-weight: bold;">주민등록번호</span><br>
	${vo.idnum1 }
	 - ${vo.idnum2 }<br><br><br><br><br>
	<span style="font-weight: bold;">아이디</span><br>
	${vo.id }<br><br><br><br><br>
	<span style="font-weight: bold;">비밀번호</span><br>
	${vo.password }<br><br><br><br><br>
	<span style="font-weight: bold;">전화번호</span><br>
	${vo.phone }<br><br><br><br><br>
	<span style="font-weight: bold;">포인트</span><br>
	<span style="font-size: 10pt; color: grey;">* 500점으로 약국에서 음료교환이 가능합니다.</span><br>
	${vo.point }<br><br><br><br><br>
	
	<div style="margin: auto; width: 300px; text-align: center;">
	<input type="hidden" id="id" value="${sessionScope.id }" readonly="readonly">
	<button type="button" onclick="location.href='account/update'">수정하기</button>
	<button type="button" onclick="withdrawalCheck()">탈퇴하기</button>
	</div>
	<br><br><br><br>
	
</div>

<br><br>
</body>
</html>