<%@ page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="decorator"
	uri="http://www.opensymphony.com/sitemesh/decorator"%>
<%@ taglib prefix="page" uri="http://www.opensymphony.com/sitemesh/page"%>

<!DOCTYPE html>
<html lang="ko">

<head>
<meta charset="UTF-8">
<title>신촌이젠약국</title>
<decorator:head />
<link href="https://fonts.googleapis.com/css?family=Noto+Sans+KR&amp;subset=korean" rel="stylesheet">
<style type="text/css">

/* 	font: normal 12pt verdana, arial, helvetica; */

body {
	font-family: 'Noto Sans KR', sans-serif;
}

input,pre,button,select,option{
font-family: 'Noto Sans KR', sans-serif;
}

pre{
word-wrap: break-word;
white-space: pre-wrap;
white-space: -moz-pre-wrap;
white-space: -pre-wrap;
white-space: -o-pre-wrap;
word-break:break-all;
font-size: medium;
}


button,
input[type='submit'],
input[type='button']{
    color: #000000;
    border: #000000 solid 1px;
    background-color: #ffffff;
}

button:hover,
input[type='submit']:hover,
input[type='button']:hover {
    color: #ffffff;
    border: #363fef solid 1px;
    background-color: #363fef;
    cursor: pointer;
}


textarea {
font-family: 'Noto Sans KR', sans-serif;
background-color:transparent;
font-size: medium;
resize: vertical;
width: 560px;
border: 0;
overflow: hidden;
}

header {
font-family:'Noto Sans KR', sans-serif;
font-size: 13pt;
}

footer {
font-family:'Noto Sans KR', sans-serif;
color: #464646;
}

/* a:link : 클릭하지 않은 링크
a:visited : 한번 클릭했던 혹은 다녀갔던 링크
a:hover : 링크를 클릭하려고 마우스를 가져갔을 때
decoration : 밑줄
none : 없는 상태
underline : 있는 상태

a:active : 링크부분에서 마우스를 누르고 있는 동안의 상태

출처: http://it77.tistory.com/126 */

#smallheader,
#smallheader a:link,
#smallheader a:visited,
#smallheader a:hover,
#smallheader a:active
{
	font-size: 12px;
	text-decoration: none;
	color: black;
	text-align: right;
}

#icon,
#icon a:link,
#icon a:visited,
#icon a:hover,
#icon a:active {
	border: none;
	text-decoration: none;
	color: black;
	text-align: center;
	padding: 20px; 
	margin-top: 20px
}


    
#menu {
	width: 100%;
	background: white;
	text-align:center;
}

#menu>ul {	
	padding: 10px ;
	margin: 20px;
	width: 100%;
	height: 30px;
	text-align: center;
}

#menu>ul li {

	display: inline-block;
	position: relative;
	width: 200px;

}

/*마우스 갖다대기이전 메뉴 속성(링크걸려도 색상유지)*/
#menu>ul li a:link, 
#menu>ul li a:visited {
	padding: 15px 0;
	display: block;
	text-align: center;
	text-decoration: none;
	background: white;
	color: #464646;
	width: 200px;
}

/*마우스 갖다대면 변하는 속성*/
#menu>ul li:hover a, 
#menu>ul li a:hover, 
#menu>ul li a:active {
	padding: 15px 0;
	display: block;
	text-align: center;
	text-decoration: none;
	background: #363fef;
	color: white;
	width: 200px;
}


}
</style>

</head>

<body>

	<%-- header --%>
	<%-- https://www.codingfactory.net/10225 --%>
	<%-- 메뉴바 출처: http://cssmenumaker.com/menu/simple-red --%>
	<header style="text-align: center">
		
		<div id='smallheader'>
		  <span style="font-weight: bold; color: #363fef;">${id }</span> 님 환영합니다 │
		  <a href='logout'><span style="margin-right: 20px;" >로그아웃</span></a>
		</div>
		  <hr color="#E3E3E3" >
		
				<%-- 로고 --%>
				<a href="/yjk">
				<img src="/yjk/resources/image/phar_title.png" id="icon"></a>
				
		<div id='menu'>
			<ul>
				
				<li>
				<a href='/yjk/notice'><span id="notice" >공지사항</span></a>
				</li>
				
				<li>
				<a href="/yjk/prelist"><span id="prelist">조제내역</span></a>
					<%-- <ul>
						<li><a href='#'><span>1</span></a></li>
						<li><a href='#'><span>2</span></a></li>
						<li><a href='#'><span>3</span></a></li>
					</ul> --%>
				</li>
				
				<li><a href='/yjk/account'><span id="account">회원정보</span></a>
					<%-- <ul>
						<li><a href='#'><span>1</span></a></li>
						<li><a href='#'><span>2</span></a></li>
					</ul> --%>
				</li>
				
				<li class='last'>
				<a href='/yjk/qna'><span id="qna">QnA</span></a>
				</li>
			</ul>
		</div>
	
	</header>



	<%-- body --%>
	<decorator:body></decorator:body>



	<%-- footer --%>
	<%-- https://ofcourse.kr/css-course/text-align-%EC%86%8D%EC%84%B1 --%>
	<%-- https://ojji.wayful.com/2013/12/HTML-set-Two-Parallel-DIVs-columns.html --%>
	<footer style="width:100%; text-align:center; background-color:#eaeaea ">
		<br><br><br>
		<table style="margin: auto; width: 800px; padding:5px; text-align: center; font-size: 11px; border: none;">
			<tr>
				<%-- 이미지 --%>
				<td style="border-right: 1px solid white; border-bottom: none;">
				<img src="/yjk/resources/image/phar_under.png" id="under">
				</td>
				<%--  --%>
				<td style="text-align: left; border-right: 1px solid white; padding-left: 20px; border-bottom: none;">
				(주)신촌이젠컴퓨터학원 ㅣ 제작자 : 강예지<br>
				주소 : 03780 서울특별시 서대문구 신촌로 141 은하빌딩 4층 <br>
				<br>
				<br>
				본 사이트의 회원가입은 약국이용자만 가능합니다.<br>
				Copyright (c) Sinchon Ezen Drugstore. All Right Reserved.
				</td>
				<%--  --%>
				<td style="padding-left: 10px; border-bottom: none;">
				<span style="font-weight: bold;">영업시간</span><br>
				평 &nbsp;&nbsp;일&nbsp; 08:30 ~ 18:30<br>
				토요일&nbsp; 09:00 ~ 14:00<br><br><br>
				<span style="font-weight: bold;">문의연락</span><br>
				TEL&nbsp; 02-123-4567<br>
				FAX&nbsp; 02-123-4567				
				</td>
			</tr>
		</table>
		<br><br><br>
	</footer>

</body>

</html>


