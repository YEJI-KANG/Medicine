<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title></title>

<link rel="stylesheet" href="https://code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css" />
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>

<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>

<script type="text/javascript">

$(function () {
	
	var tarea=$("#context");
	var tval=$("#context").val();
	var scrollHeight=$("#context").prop('scrollHeight');
	var clientHeight=$("#context").prop('clientHeight');
	//alert(tval);
	//alert(scrollHeight+"");
	//alert(clientHeight+"");
    if (scrollHeight > clientHeight){
    	//alert(scrollHeight);
    	$("#context").css("height",scrollHeight);
    }
	
})


function resize(obj) {
	  obj.style.height = "1px";
	  obj.style.height = (12+obj.scrollHeight)+"px";
	}



	function textCheck(){
		var text=document.getElementById("context").value;
		//text=text.replace(/(?:\r\n|\r|\n)/g, '<br/>');
		//document.getElementById("context").value = str;
		//alert(text);
		return true;
	}


</script>

</head>


<body>
<br><br>
<h2 align="center" style="color: #363fef;">공지사항 수정</h2>
<br><br>
<form action="updateOk?idx=${vo.idx }" onsubmit="return textCheck()" method="post" style="margin: auto; width: 700px;">

	제목<br>
	<input type="text" name="title" required="required" id="title" value="${vo.title }"><br><br><br><br><br>
	내용<br>
	<textarea style="resize: vertical;background-color: #f4f4f4;" 
	id="context" name="context"  onkeydown="resize(this)" onkeyup="resize(this)"
	cols="100%" required="required">${vo.context }</textarea>
	<br><br><br><br><br>
	
	
	<div style="margin: auto; width: 500px; text-align: center;">
	<button type="reset" >다시수정</button>
	<button type="submit">수정완료</button>
	</div>
	<br><br><br><br>
	
</form>

<br><br>
</body>
</html>