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
<script type="text/javascript" src="/yjk/resources/js/comm.js"></script>
<style type="text/css">

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

<script type="text/javascript">

$( function() {
	$(".btn").click(function(){
		
		var nexttr = $(this).parent().parent().next(); //상대위치처리
		
		if($(nexttr).css('display')=='table-row') {
			// alert($(nexttr).css('display')); // table-row
			$(this).text("▼");
			$(nexttr).hide();
		}else{
			// alert($(nexttr).css('display')); // none
			$(this).text("▲");
			$(nexttr).show();
		}
	});
	
	
});

	function deleteCheck(idx) {
		if(confirm('정말 삭제하시겠습니까?')!=0){
			location.href="prelist/delete?idx="+idx;
		}
		else{ }
	}


</script>


</head>

<body>
<br><br>
<h2 align="center" style="color: #363fef;">조제내역</h2>
<br><br>
	<table style="margin:auto; width:800px; padding:5px; text-align: center;"> 
		<%-- 마진오토:중앙정렬 --%>
	

		
		<tr>
		<th>번호</th>
		<th>날짜</th>
		<th>이름</th>
		<th>주민번호</th>
		<th>병원</th>
		<th>가격</th>
		<th>처방약</th>
		<th> </th>
		<th> </th>
		</tr>
		
		<c:if test="${paging.totalCount==0 }">
		<tr><td colspan="9" align="center">등록된 조제기록 없음</td></tr>
		</c:if>
		
		<c:if test="${paging.totalCount>0 }">
		<c:forEach items="${paging.lists }" var="vo" varStatus="vs">
		<tr onmouseover="this.style.background='#f4f4f4'" onmouseout="this.style.background='white'">
			<c:if test="${not empty option}">
			<td>${paging.pageSize*(paging.currentPage-1)+vs.count}</td>
			</c:if>
			<c:if test="${empty option && empty search }">
			<td>${paging.totalCount-(paging.pageSize*(paging.currentPage-1))-vs.index}</td>
			</c:if>
			<td><fmt:formatDate value="${vo.predate }" pattern="yyyy-MM-dd"/> </td>
			<td>${vo.name }</td>
			<td>${vo.idnum1 }-${vo.idnum2 }</td>
			<td>${vo.hospital }</td>
			<td>${vo.price }</td>
			<td><button class="btn">▼</button></td>
			<td><button class="update" onclick="location.href='prelist/update?idx=${vo.idx }'">수정</button></td>
			<td><button class="delete" onclick="deleteCheck(${vo.idx })">삭제</button></td>
		</tr>
		
		
		<tr style="display: none;">
		<td colspan="9" style="background-color:#eaeaea; text-align: left;"><br>
			<table style="border: none;">
			<tr>
				<th style="border:none; background-color: white;">No</th>
				<th style="border:none;background-color: white;">이름</th>
				<th style="border:none;background-color: white;">용법</th>
			</tr>
			<c:forEach items="${vo.druglist }" var="drug" varStatus="vs2">
				<tr onmouseover="this.style.background='#f4f4f4'" onmouseout="this.style.background='#eaeaea'">
				<td style="border:none; width: 5%; text-align: center;">${vs2.count }</td>
				<td style="border:none;width: 30%;">${drug.drugname }</td>
				<td style="border:none;">${drug.how }</td>
				</tr>
			</c:forEach>
			</table><br>
		</td>
		</tr>
			
		</c:forEach>
		</c:if>
	</table>
	
	
	<table style="margin:auto; width:800px; text-align: center; border: none;">
		<tr>
			<td colspan="9" style="text-align: right; border: none;">
			<button onclick="location.href='/yjk/prelist/insert'">조제정보작성</button>
			</td>
		</tr>	
	</table>
	
	
	
	
	<table style="margin:auto; width:800px; text-align: center; border: none;">
	<tr>
		<td colspan="9" style="text-align: center; border: none;">
		
		<%-- 이전 --%>
		<c:if test="${paging.startPage>1 }">
		<span style="cursor:pointer;color:#464646;"
		onclick="post_to_url('prelist', {'p':'${paging.startPage-1 }','s':'${paging.pageSize }','b':'${paging.blockSize }'});">
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
		onclick="post_to_url('prelist', {'p':'${i }','s':'${paging.pageSize }','b':'${paging.blockSize }'});">
		${i }</span>
		</c:if>
		&nbsp;	
		</c:forEach>
		</c:if>
		
		<%-- 다음 --%>
		<c:if test="${paging.endPage<paging.totalPage }">
		<span style="cursor:pointer;color:#464646;" 
		onclick="post_to_url('prelist', {'p':'${paging.endPage+1 }','s':'${paging.pageSize }','b':'${paging.blockSize }'});">
		▶</span>
		</c:if>
		
			</td>
		</tr>
	</table>
	
	
	
	
	<%-- 검색 --%>
	<%-- http://all-record.tistory.com/129 --%>
	<br>
    <div style="text-align: center; margin: auto; width: 800px;">
        <form>
            <select name="option">
                <option value="1">이름</option>
                <option value="2">병원</option>
                <option value="3">처방약</option>
            </select>
            <input type="text" size="20" name="search"/>&nbsp;
            <input type="submit" value="검색"/>
        </form>    
    </div>
	<br>



<br><br><br><br>
</body>
</html>