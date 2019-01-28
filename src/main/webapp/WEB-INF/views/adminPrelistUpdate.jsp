<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>조제정보 입력</title>

<link rel="stylesheet" href="https://code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css" />
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>

<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>

<script type="text/javascript">

$(function () {

	
//달력에 날짜 지정
	var today="${vo.predate }";
	//들어오는 포맷: Fri Jan 04 14:32:57 KST 2019
	var array=today.split(" ");
	
	var dd=array[2];
	var yyyy=array[5];
	var mm=array[1];
	var hhMMss=array[3]; //14:32:57
	
	var array2=hhMMss.split(":");
	var hh=array2[0];
	var MMM=array2[1];
	var ss=array2[2];
	
	
	
	if(mm==="Jan"){mm=1;}
	else if(mm==="Jan"){mm=1;}
	else if(mm==="Feb"){mm=2;}
	else if(mm==="Mar"){mm=3;}
	else if(mm==="Apr"){mm=4;}
	else if(mm==="May"){mm=5;}
	else if(mm==="Jun"){mm=6;}
	else if(mm==="Jul"){mm=7;}
	else if(mm==="Aug"){mm=8;}
	else if(mm==="Sep"){mm=9;}
	else if(mm==="Oct"){mm=10;}
	else if(mm==="Nov"){mm=11;}
	else if(mm==="Dec"){mm=12;}
	
	if(mm<10) mm='0'+mm;
	var yymmdd=yyyy+"/"+mm+"/"+dd+" "+hhMMss;
	document.getElementById("calendar").value=yymmdd;

//


	$(function(){
	});

	//
	var autocomp_opt={
			source : function(request, response) {
				$.ajax({
					type : 'post',
					url : "/yjk/resources/openAPI.jsp",
					dataType : "json",
					//request.term = $("#autocomplete").val()
					data : {
						value : request.term
					},
					success : function(data) {
					//	$("#result").html(data);
						response(data);
					}
				});
			},
			//조회를 위한 최소글자수
			minLength : 1,
			select : function(event, ui) {
				// 만약 검색리스트에서 선택하였을때 선택한 데이터에 의한 이벤트발생
			}
	}
	

//	
	var count=${fn:length(vo.druglist)};
//	
	$("#drugTable").on("click", ".btnPlus", function() {
		count+=1;
		//alert(count);
		var rowIndex=$(this).parent().parent().prevAll().length+1;
		
		var obj=$(this).parent().parent().nextAll();
		var i=0*1;
		$(obj).each(function () {
			var content=$(this).children(".no").html()*1;
			$(this).children(".no").html(content+1);

			$(this).children().eq(1).children('input[type=text]').attr('name','dlist['+(rowIndex*1+i*1)+'].drugname');
			$(this).children().eq(2).children('input[type=text]').attr('name','dlist['+(rowIndex*1+i*1)+'].how');
			i+=1;
		})

		var makeTable=$("<tr><td class='no' style='text-align: right;'>"+rowIndex+"</td><td><input type='text' name='dlist["+(rowIndex*1-1)+"].drugname' required='required' class='drugname'></td><td><input type='text' name='dlist["+(rowIndex*1-1)+"].how' required='required' class='how'></td><td> <input type='button' class='btnPlus' value=' + '> </td><td> <input type='button' class='btnMinus' value=' - '> </td></tr>");
		$('.drugname', makeTable).autocomplete(autocomp_opt);
		var thistr=$(this).parent().parent();
		thistr.after(makeTable);
		

	});  
//	
	$("#drugTable").on("click", ".btnMinus", function() {
		//alert(count);
		if(count==1){
			alert("처방약은 하나이상 존재합니다.");
		}
		else{
			count-=1;	
			
			var obj=$(this).parent().parent().nextAll();
			var objsize=obj.size()*1;
			//alert(objsize);
			var i=0+0;
			$(obj).each(function () {
				var content=$(this).children(".no").html()*1;
				$(this).children(".no").html(content-1);
				//alert(count*1); //NaN
				//alert(objsize*1);
				//alert(i*1);
				$(this).children().eq(1).children('input[type=text]').attr('name','dlist['+(count*1-objsize*1+i*1)+'].drugname');
				$(this).children().eq(2).children('input[type=text]').attr('name','dlist['+(count*1-objsize*1+i*1)+'].how');
				i+=1;
			})
			
			$(this).parent().parent().remove();
		}
	});  
//

	$(".drugname").autocomplete({
		source : function(request, response) {
			$.ajax({
				type : 'post',
				url : "/yjk/resources/openAPI.jsp",
				dataType : "json",
				//request.term = $("#autocomplete").val()
				data : {
					value : request.term
				},
				success : function(data) {
				//	$("#result").html(data);
					response(data);
				}
			});
		},
		//조회를 위한 최소글자수
		minLength : 1,
		select : function(event, ui) {
			// 만약 검색리스트에서 선택하였을때 선택한 데이터에 의한 이벤트발생
		}
	});
	
})

</script>

</head>


<body>
<br><br>
<h2 align="center" style="color: #363fef;">조제내역 수정</h2>
<br><br>
<form action="updateOk?idx=${vo.idx }" method="post" style="margin: auto; width: 500px;">

	처방날짜<br>
	<span style="font-size: 10pt; color: grey;">* 날짜는 수정이 불가합니다.</span><br>
	<input type="text" name="predate" required="required" readonly="readonly" id="calendar">
	<br><br><br><br><br>
	이름<br>
	<input type="text" name="name" required="required" value="${vo.name }"><br><br><br><br><br>
	주민등록번호<br>
	<input type="text" name="idnum1" required="required" value="${vo.idnum1 }" maxlength="6">
	 - <input type="text" name="idnum2" required="required" value="${vo.idnum2 }" maxlength="7"><br><br><br><br><br>
	의료기관명<br>
	<input type="text" name="hospital" required="required" value="${vo.hospital }"><br><br><br><br><br>
	
	처방약 목록<br><br>
	<table id="drugTable">
		<tr>
			<th>No</th>
			<th>약이름</th>
			<th>용법</th>
			<th></th>
			<th></th>
		</tr>
		
		<c:if test="${not empty vo.druglist }">
		<c:forEach items="${vo.druglist }" var="vo" varStatus="vs">
			<tr>
				<td class="no" style="text-align: right;">${vs.count }</td>
				<td><input type="text" name="dlist[${vs.index }].drugname" required="required" class="drugname" value="${vo.drugname }"></td>
				<td><input type="text" name="dlist[${vs.index }].how" required="required" class="how" value="${vo.how }"></td>
				<td><input type='button' class='btnPlus' id='btnPlus' value=' + '></td>
				<td><input type='button' class='btnMinus' id='btnMinus' value=' - '></td>	
			</tr>
		</c:forEach>
		</c:if>

	</table>

	
	
	<br><br><br><br><br>
	
	가격<br>
	<input type="text" name="price" required="required" value="${vo.price }"> 원<br><br><br><br><br>
	
	<div style="margin: auto; width: 400px; text-align: center;">
	<button type="reset" >다시수정</button>
	<button type="submit">수정완료</button>
	</div>
	<br><br><br><br>
	
</form>

<br><br>
</body>
</html>