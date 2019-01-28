<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<style>
  table {
    width: 100%;
    border-top: 1px solid #464646;
    border-collapse: collapse;
  }
  th, td {
    border-bottom: 1px solid #464646;
    padding: 10px;
  }
</style>

<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
<script type="text/javascript" src="resources/js/comm.js"></script>
<script type="text/javascript">

	function pointCheck(cnt){
		//alert(cnt);
		var idx=$("#idx"+cnt).val();
		var point=$("#point"+cnt).val();
		
		//alert(idx + " : "+point);
		
		if(point<500){
			alert('500점 미만의 포인트는 사용할 수 없습니다.');
		}
		else{
			if(confirm('포인트 500점을 사용하시겠습니까?')){
				
				$.ajax({
				    url: "pointCheck", // 요청 할 주소
				    async: true, // false 일 경우 동기 요청으로 변경
				    type: "POST", // GET, PUT
				    data: {
				        "idx" : idx,
				        "point" : point
				    }, // 전송할 데이터
				    dataType: 'text', // xml, json, script, html
				    beforeSend: function(data) {}, // 서버 요청 전 호출 되는 함수 return false; 일 경우 요청 중단
				    success: function(data) {
				    	alert('500 포인트를 사용하였습니다.');
				    	location.reload(); // 화면 새로 고침
				    }, // 요청 완료 시
				    error: function(data) {}, // 요청 실패.
				    complete: function(data) {} // 요청의 실패, 성공과 상관 없이 완료 될 경우 호출
				});
			
				
			}
			else{}
		}
			
	}
	
	

</script>

</head>
<body>


<br><br>
<h2 align="center" style="color: #363fef;">관리자정보</h2>
<br><br>
<table style="margin: auto; width: 800px; padding:5px;text-align: center;">

<tr>
<th>번호</th>
<th>이름</th>
<th>아이디</th>
<th>비밀번호</th>
<th></th>
</tr>

	<c:forEach var="vo" items="${paging.lists }" varStatus="vs" end="0">
		<tr onmouseover="this.style.background='#f4f4f4'" onmouseout="this.style.background='white'">
		<td>${paging.pageSize*(paging.currentPage-1)+vs.count}</td>
		<td>${vo.name }</td>
		<td>${vo.id }</td>
		<td>${vo.password }</td>
		<%--관리자만 수정버튼 --%>
		<td><button class="update" onclick="location.href='account/update'">수정</button></td>
		</tr>

	</c:forEach>

</table>




<br><br><br><br>
<h2 align="center" style="color: #363fef;">회원정보</h2>
<br><br>
<table style="margin: auto; width: 800px; padding:5px;text-align: center;">

<tr>
<th>번호</th>
<th>이름</th>
<th>주민번호</th>
<th>아이디</th>
<th>비밀번호</th>
<th>전화번호</th>
<th>이용횟수</th>
<th>포인트</th>
<th></th>
</tr>

	<c:if test="${(paging.totalCount-1)==0 }">
	<tr><td colspan="9" align="center">등록된 회원 없음</tr>
	</c:if>
	
	<c:if test="${(paging.totalCount-1)>0 }">
	<c:forEach var="vo" items="${paging.lists }" varStatus="vs" begin="1">
		<tr onmouseover="this.style.background='#f4f4f4'" onmouseout="this.style.background='white'">
		<td>${paging.pageSize*(paging.currentPage-1)+vs.count}</td>
		<td>${vo.name }</td>
		<td>${vo.idnum1 }-${vo.idnum2 }</td>
		<td>${vo.id }</td>
		<td>${vo.password }</td>
		<td>${vo.phone }</td>
		<td>${vo.temp1 }</td>
		<td>${vo.point }</td>
		<td>
		<input type="hidden" id="idx${paging.pageSize*(paging.currentPage-1)+vs.count }" value="${vo.personidx }">
		<input type="hidden" id="point${paging.pageSize*(paging.currentPage-1)+vs.count }" value="${vo.point }">
		<button class="usePoint" onclick="pointCheck(${paging.pageSize*(paging.currentPage-1)+vs.count })">사용</button>
		</td>

	</c:forEach>
	</c:if>

</table>

	<br>

	<table style="margin: auto; width: 800px; text-align: center; border: none;">
	<tr>
		<td colspan="7" style="text-align: center;border: none;">
		
		<%-- 이전 --%>
		<c:if test="${paging.startPage>1 }">
		<span style="cursor:pointer;color:#464646;"
		onclick="post_to_url('user', {'p':'${paging.startPage-1 }','s':'${paging.pageSize }','b':'${paging.blockSize }'});">
		◀</span>
		</c:if>
				&nbsp;		 
		<%-- 페이지 번호 목록 --%>
		<c:if test="${paging.totalCount>0 }">
		<c:forEach var="i" begin="${paging.startPage}" end="${paging.endPage }">
		
		<c:if test="${i==paging.currentPage }">
		<span style="cursor:pointer;color:black; font-size: 15pt;">${i }</span>
		</c:if>
		
		<c:if test="${i!=paging.currentPage }">
		<span style="cursor:pointer;color:#464646;" 
		onclick="post_to_url('user', {'p':'${i }','s':'${paging.pageSize }','b':'${paging.blockSize }'});">
		${i }</span>
		</c:if>
		&nbsp;	
		</c:forEach>
		</c:if>
		
		<%-- 다음 --%>
		<c:if test="${paging.endPage<paging.totalPage }">
		<span style="cursor:pointer;color:#464646;" 
		onclick="post_to_url('user', {'p':'${paging.endPage+1 }','s':'${paging.pageSize }','b':'${paging.blockSize }'});">
		▶</span>
		</c:if>
		
			</td>
		</tr>
	</table>
		
<br><br><br><br>
</body>
</html>