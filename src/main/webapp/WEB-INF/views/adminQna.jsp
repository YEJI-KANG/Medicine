<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<!DOCTYPE html>
<html>

<head>
<meta charset="UTF-8">
<title>제목</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js" ></script>
<script type="text/javascript" src="resources/js/comm.js"></script>
<style type="text/css">


</style>

<script type="text/javascript">

$( function() {
	//textarea 내용에맞춰 크기조정하기...
	var tarea=$("#content");
	var tval=$("#content").val();
	var scrollHeight=$("#content").prop('scrollHeight');
	var clientHeight=$("#content").prop('clientHeight');
	//alert(tval);
	//alert(scrollHeight+"");
	//alert(clientHeight+"");
    if (scrollHeight > clientHeight){
    	//alert(scrollHeight);
    	$("#content").css("height",scrollHeight);
    }
});


function resize(obj) {
	  obj.style.height = "1px";
	  obj.style.height = (12+obj.scrollHeight)+"px";
	}



function insertCheck() {
	var idx = $("#idx").val();
	var p = $("#p").val();
	var id = $("#id").val();
	var amemo = $("#amemo").val();
		$.ajax({
		    url: "qnaInsert", // 요청 할 주소
		    async: true, // false 일 경우 동기 요청으로 변경
		    type: "POST", // GET, PUT
		    data: {
		        "p": p,
		        "idx": idx,
		        "id" : id,
		        "amemo" : amemo
		    }, // 전송할 데이터
		    dataType: 'text', // xml, json, script, html
		    beforeSend: function(data) {}, // 서버 요청 전 호출 되는 함수 return false; 일 경우 요청 중단
		    success: function(data) {
		    	location.reload(); // 화면 새로 고침
		    }, // 요청 완료 시
		    error: function(data) {}, // 요청 실패.
		    complete: function(data) {} // 요청의 실패, 성공과 상관 없이 완료 될 경우 호출
		});
		return true;
	
}



function updateCheck(){
	var idxObj = $("#idx")
	var contentObj = $("#content")
	var content = $("#content").val()
	var updateBtnObj = $("#updateBtn")
	if(updateBtnObj.val().trim()==="수정"){
		// alert(updateBtnObj.val() + "!!!!");
		contentObj.prop("readonly","")
		contentObj.css("background-color","white")
		contentObj.css("resize","vertical")
		contentObj.focus().val('').val(content)
		contentObj.attr("onkeydown","resize(this)")
		contentObj.attr("onkeyup","resize(this)")
		updateBtnObj.val("수정완료")
	}else if(updateBtnObj.val().trim()==="수정완료"){
		var idx = idxObj.val();
		var p = $("#p").val();
		var id = $("#id").val();
		var amemo = contentObj.val();
		
		$.ajax({
		    url: "qnaUpdate", // 요청 할 주소
		    async: true, // false 일 경우 동기 요청으로 변경
		    type: "POST", // GET, PUT
		    data: {
		        "p": p,
		        "idx": idx,
		        "amemo": amemo,
		        "id" : id
		    }, // 전송할 데이터
		    dataType: 'text', // xml, json, script, html
		    beforeSend: function(jqXHR) {}, // 서버 요청 전 호출 되는 함수 return false; 일 경우 요청 중단
		    success: function(data) {
		    	// alert(data);
		    	contentObj.prop("readonly","readonly")
		    	contentObj.css("background-color","transparent")
		    	contentObj.css("resize","none")
		    	contentObj.removeAttr("onkeydown");
				contentObj.removeAttr("onkeyup");
				updateBtnObj.val("수정")
		    }, // 요청 완료 시
		    error: function(jqXHR) {}, // 요청 실패.
		    complete: function(jqXHR) {} // 요청의 실패, 성공과 상관 없이 완료 될 경우 호출
		});
	}
}



function deleteCheck() {
	var idx = $("#idx").val();
	var p = $("#p").val();
	var id = $("#id").val();
	if(confirm('답변을 정말 삭제하시겠습니까?')!=0){
		$.ajax({
		    url: "qnaDelete", // 요청 할 주소
		    async: true, // false 일 경우 동기 요청으로 변경
		    type: "POST", // GET, PUT
		    data: {
		        "p": p,
		        "idx": idx,
		        "id" : id
		    }, // 전송할 데이터
		    dataType: 'text', // xml, json, script, html
		    beforeSend: function(jqXHR) {}, // 서버 요청 전 호출 되는 함수 return false; 일 경우 요청 중단
		    success: function(data) {
		    	location.reload(); // 화면 새로 고침
		    }, // 요청 완료 시
		    error: function(jqXHR) {}, // 요청 실패.
		    complete: function(jqXHR) {} // 요청의 실패, 성공과 상관 없이 완료 될 경우 호출
		});
		return true;
	}
}



</script>


</head>

<body>
<br><br>
<h2 align="center" style="color: #363fef;">QnA</h2>
<br><br>

	
	
	
	

	<div style="margin:auto; width:700px; text-align: center;"> 
	
	
	
	
		<%-- 질문 ======================================================================= --%>
	
		<%-- 질문없음 --%>
		<c:if test="${empty paging.lists }">등록된 질문이 없습니다</c:if>
		
		<%-- 질문있음 --%>
		<c:if test="${not empty paging.lists }">
		<c:forEach items="${paging.lists }" var="vo" varStatus="vs">
			
			<table style="margin:auto; padding: 10px; width:600px; text-align: left; background-color: #f4f4f4">
			<tr>
				<td style="font-weight: bold; text-align: left;">
					<br>No. ${paging.totalPage - paging.currentPage +1}<br>
					<span style="font-weight: normal; color: #363fef;">작성자: ${vo.id }</span>
				</td>
				<td style="text-align: right;color: #464646;"><br>
					<fmt:formatDate value="${vo.qdate }" pattern="yyyy-MM-dd / hh:mm"/>
				</td>
			</tr>
			<tr>
				<td colspan="2"><br><pre>${vo.qmemo }</pre><br></td>
			</tr>
			</table>
			<br>
			
			
			
			
		<%-- 답변 ======================================================================= --%>	
					
			<%-- 답변없음/textarea 입력폼 --%>
			<c:if test="${empty vo.amemo }">
				<div style="margin:auto; width:600px; text-align: center;">
						<br>
						<span style="text-align: left; font-weight: bold;">등록된 답변이 없습니다.</span><br>
						<br>
						<input type="hidden" id="idx" name="idx" value="${vo.idx }">
						<input type="hidden" id="p" name="p" value="${paging.currentPage }">
						<input type="hidden" id="id" value="${sessionScope.id }" readonly="readonly">
						<textarea style="width: 600px; height: 50px; background-color:#cdcfef; resize: vertical;" 
						onkeydown="resize(this)" onkeyup="resize(this)"
						placeholder="답변을 작성하세요." id="amemo" required="required"></textarea>
						<br>
						<input type="button" style="width: 600px;" id="insertBtn" value="작성완료" onclick="insertCheck()">
				<br><br>
				</div>	
			</c:if>
			
		
			
			<%-- 답변있음 --%>
			<c:if test="${not empty vo.amemo }">
				<table style="margin:auto; padding:10px; width:600px; text-align: left; background-color: #cdcfef">
				<tr>
					<td style="font-weight: bold; text-align: left;"><br>답변입니다.</td>
					<td style="text-align: right; color: #464646;"><br><fmt:formatDate value="${vo.adate }" pattern="yyyy-MM-dd / hh:mm"/></td>
				</tr>
				<tr>
					<td colspan="2">
					<br>
					<input type="hidden" id="idx" value="${vo.aidx }" readonly="readonly">
					<input type="hidden" id="p" value="${paging.currentPage }" readonly="readonly">
					<input type="hidden" id="id" value="${sessionScope.id }" readonly="readonly">
					<textarea id="content" readonly="readonly" style="resize: none;">${vo.amemo }</textarea>
					</td>
				</tr>
				<tr>
					<td colspan="2" style="text-align: right;">
					<input type="button" value="수정" onclick="updateCheck();" id="updateBtn">
					<input type="button" value="삭제" onclick="deleteCheck();" id="deleteBtn">
					</td>
				</tr>
				</table>

			</c:if>
		</c:forEach>
		</c:if>
		
		
	</div>
	
	
	
	<br>
	
	
	
	
	
	
	<%-- 페이지 표시 코드--%>		
	<table style="margin:auto; width:700px; text-align: center;">
		<tr>
		<td colspan="5" style="text-align: center;">
		
		<%-- 이전 --%>
		<c:if test="${paging.startPage>1 }">
		<span style="cursor:pointer;color:#464646;"
		onclick="post_to_url('qna', {'p':'${paging.startPage-1 }','s':'${paging.pageSize }','b':'${paging.blockSize }'});">
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
		onclick="post_to_url('qna', {'p':'${i }','s':'${paging.pageSize }','b':'${paging.blockSize }'});">${i }</span>
		</c:if>
		&nbsp;
		</c:forEach>
		</c:if>
		
		<%-- 다음 --%>
		<c:if test="${paging.endPage<paging.totalPage }">
		<span style="cursor:pointer;color:#464646;" 
		onclick="post_to_url('qna', {'p':'${paging.endPage+1 }','s':'${paging.pageSize }','b':'${paging.blockSize }'});">
		▶</span>
		</c:if>
		
			</td>
		</tr>
		</table>


<br><br><br><br>
</body>
</html>