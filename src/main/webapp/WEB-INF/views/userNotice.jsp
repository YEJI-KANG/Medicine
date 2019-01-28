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
	
	
});




</script>


</head>

<body>
<br><br>
<h2 align="center" style="color: #363fef;">공지사항</h2>
<br><br>
	<table style="margin:auto; width:700px; padding: 5px; text-align: center;"> 
		<%-- 마진오토:중앙정렬 --%>
	

		
		<tr>
		<th>번호</th>
		<th width="50%">제목</th>
		<th>등록일</th>
		<th>조회수</th>
		</tr>
		
		<c:if test="${paging.totalCount==0 }">
		<tr><td colspan="4" align="center">등록된 공지사항이 없습니다</td></tr>
		</c:if>
		
		<c:if test="${paging.totalCount>0 }">
		<c:forEach items="${paging.lists }" var="vo" varStatus="vs">
		<tr onmouseover="this.style.background='#f4f4f4'" onmouseout="this.style.background='white'">	
			<td>${paging.totalCount-(paging.pageSize*(paging.currentPage-1))-vs.index}</td>
			<td style="text-align: left; cursor: pointer;" onclick="location.href='notice?idx=${vo.idx }'">${vo.title }</td>
			<td><fmt:formatDate value="${vo.regdate }" pattern="yyyy-MM-dd"/></td>
			<td>${vo.cnt }</td>
		</tr>	
		</c:forEach>
		</c:if>
	</table>
	
	
<br>
	
	<table style="margin:auto; width:700px; text-align: center; border: none;">
	<tr>
		<td colspan="4" style="text-align: center; border: none;">
		
		<%-- 이전 --%>
		<c:if test="${paging.startPage>1 }">
		<span style="cursor:pointer;color:#464646;"
		onclick="post_to_url('notice', {'p':'${paging.startPage-1 }','s':'${paging.pageSize }','b':'${paging.blockSize }'});">
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
		onclick="post_to_url('notice', {'p':'${i }','s':'${paging.pageSize }','b':'${paging.blockSize }'});">
		${i }</span> 
		</c:if>
		&nbsp;	
		</c:forEach>
		</c:if>
		
		<%-- 다음 --%>
		<c:if test="${paging.endPage<paging.totalPage }">
		<span style="cursor:pointer;color:#464646;" 
		onclick="post_to_url('notice', {'p':'${paging.endPage+1 }','s':'${paging.pageSize }','b':'${paging.blockSize }'});">
		▶</span>
		</c:if>
		
			</td>
		</tr>
	</table>
	
	

<br><br><br><br>
</body>
</html>