<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>조제정보 입력</title>

<link rel="stylesheet" href="//cdnjs.cloudflare.com/ajax/libs/timepicker/1.3.5/jquery.timepicker.min.css">
<link rel="stylesheet" href="https://code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css" />
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>

<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
<script src="//cdnjs.cloudflare.com/ajax/libs/timepicker/1.3.5/jquery.timepicker.min.js"></script>
<script type="text/javascript">

$(function () {


	var today=new Date();
	var dd=today.getDate();
		if(dd<10) dd='0'+dd;
	var mm=today.getMonth()+1;
		if(mm<10) mm='0'+mm;
	var yyyy=today.getFullYear().toString();
	//var yy=yyyy.substring(2,4);
	var yymmdd=yyyy+"/"+mm+"/"+dd;
	document.getElementById("calendar").value=yymmdd;

	
/* 	var hh=today.getHours();
    var MMM= today.getMinutes();
    var ss= today.getSeconds();
    var time=hh+""+MMM+""+ss;
    document.getElementById("time").value=time; */
	

	$(function(){
		$( "#calendar" ).datepicker({
		    dateFormat: 'yy/mm/dd',
		    defaultDate: +0,
		    prevText: '이전 달',
		    nextText: '다음 달',
		    monthNames: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'],
		    monthNamesShort: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'],
		    dayNames: ['일','월','화','수','목','금','토'],
		    dayNamesShort: ['일','월','화','수','목','금','토'],
		    dayNamesMin: ['일','월','화','수','목','금','토'],
		    showMonthAfterYear: true,
		    changeMonth: true,
		    changeYear: true,
		    yearSuffix: '년',
		    
		  });
		
		$('#time').timepicker({
		    timeFormat: 'hh:mm:ss',
		    interval: 60,
		    minTime: '10',
		    maxTime: '6:00pm',
		    defaultTime: 'now',
		    startTime: '10:00',
		    dynamic: false,
		    dropdown: false,
		    scrollbar: false
		});
		
	});
	//alert("들어옴");
	/* $(this).children().children(".medicine").attr('name','dlist['+index2+'].drugname');
	$(this).children().children(".how").attr('name','dlist['+index2+'].how'); */
	
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
	
//	
	var count=1; //전체갯수
//	
	$("#drugTable").on("click", ".btnPlus", function() {
		count+=1;
		
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
		
		if(count==1){
			alert("처방약은 하나이상 존재합니다.");
		}
		else{
			count-=1;	
			
			var obj=$(this).parent().parent().nextAll();
			var objsize=obj.size()*1;
			//alert(objsize);
			var i=0*1;
			$(obj).each(function () {
				var content=$(this).children(".no").html()*1;
				$(this).children(".no").html(content-1);
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

	function timeCheck(){
	
	
	var predate1=$("#calendar").val();
	var predate2=$("#time").val();
	var predate=predate1+" "+predate2;
	$("#predate").val(predate);
	
	return true;
	}


</script>

</head>


<body>
<br><br>
<h2 align="center" style="color: #363fef;">조제내역 작성</h2>
<br><br>
<form action="insertOk" onsubmit="return timeCheck()" method="post" style="margin: auto; width: 500px;">

	처방날짜<br>
	<input type="text" name="predate1" required="required" id="calendar">
	<input type="text" name="predate2" required="required" id="time">
	<input type="hidden" name="predate" readonly="readonly" value="" id="predate">
	<br><br><br><br><br>
	이름<br>
	<input type="text" name="name" required="required"><br><br><br><br><br>
	주민등록번호<br>
	<input type="text" name="idnum1" required="required" maxlength="6">
	 - <input type="text" name="idnum2" required="required" maxlength="7"><br><br><br><br><br>
	의료기관명<br>
	<input type="text" name="hospital" required="required"><br><br><br><br><br>
	
	처방약 목록<br><br>
	<table id="drugTable">
		<tr>
			<th>No</th>
			<th>약이름</th>
			<th>용법</th>
			<th></th>
			<th></th>
		</tr>
		<tr>
			<td class="no" style="text-align: right;">1</td>
			<td><input type="text" name="dlist[0].drugname" required="required" class="drugname"></td>
			<td><input type="text" name="dlist[0].how" required="required" class="how"></td>
			<td> <input type='button' class='btnPlus' id='btnPlus' value=' + '></td>
			<td><input type='button' class='btnMinus' id='btnMinus' value=' - '></td>
		</tr>
	</table>

	
	
	<br><br><br><br><br>
	
	가격<br>
	<input type="text" name="price" required="required"> 원<br><br><br><br><br>
	
	<div style="margin: auto; width: 300px; text-align: center;">
	<button type="reset" >다시작성</button>
	<button type="submit">작성완료</button>
	</div>
	<br><br><br><br>
	
</form>

<br><br>
</body>
</html>