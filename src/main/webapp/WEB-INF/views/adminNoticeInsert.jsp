<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
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

	
})


function resize(obj) {
	  obj.style.height = "1px";
	  obj.style.height = (12+obj.scrollHeight)+"px";
	}

</script>

</head>


<body>
<br><br>
<h2 align="center" style="color: #363fef;">공지사항 작성</h2>
<br><br>
<form action="insertOk" method="post" style="margin: auto; width: 700px;">

	제목<br>
	<input type="text" name="title" required="required" id="title" size="50%"><br><br><br><br><br>
	내용<br>
	<textarea id="context" name="context" rows="5" cols="100%" required="required" 
	onkeydown="resize(this)" onkeyup="resize(this)"
	style="background-color: #f4f4f4"></textarea><br><br><br><br><br>
	
	
	<div style="margin: auto; width: 400px; text-align: center;">
	<button type="reset" >다시작성</button>
	<button type="submit">작성완료</button>
	</div>
	<br><br><br><br>
	
</form>

<br><br>
</body>
</html>