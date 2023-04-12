<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Cyber Security Community 로그인</title>
<link rel="stylesheet" href="css/navbar.css">
<link rel="stylesheet" href="css/login.css">
<script src="js/jquery-3.6.0.min.js"></script>
<script type="text/javascript">
$(document).ready(function(){
	  let key = getCookie("key");
	  $("#id").val(key);
	
	  function setCookie(cookieName, value, exdays) {
	    let exdate = new Date();
	    exdate.setDate(exdate.getDate() + exdays);
	    let cookieValue =
	      escape(value) +
	      (exdays == null ? "" : "; expires=" + exdate.toGMTString());
	    document.cookie = cookieName + "=" + cookieValue;
	  }
	
	  function deleteCookie(cookieName) {
	    let expireDate = new Date();
	    expireDate.setDate(expireDate.getDate() - 1);
	    document.cookie =
	      cookieName + "= " + "; expires=" + expireDate.toGMTString();
	  }
	
	  function getCookie(cookieName) {
	    cookieName = cookieName + "=";
	    let cookieData = document.cookie;
	    let start = cookieData.indexOf(cookieName);
	    let cookieValue = "";
	    if (start != -1) {
	      start += cookieName.length;
	      let end = cookieData.indexOf(";", start);
	      if (end == -1) end = cookieData.length;
	      cookieValue = cookieData.substring(start, end);
	    }
	    return unescape(cookieValue);
	  }
	
	  if ($("#id").val() != "") {
	    // 그 전에 ID를 저장해서 처음 페이지 로딩 시, 입력 칸에 저장된 ID가 표시된 상태라면,
	    $("#idSaveCheck").attr("checked", true); // ID 저장하기를 체크 상태로 두기.
	  }
	
	  $("#idSaveCheck").change(function () {
	    // 체크박스에 변화가 있다면,
	    if ($("#idSaveCheck").is(":checked")) {
	      // ID 저장하기 체크했을 때,
	      setCookie("key", $("#id").val(), 7); // 7일 동안 쿠키 보관
	    } else {
	      // ID 저장하기 체크 해제 시,
	      deleteCookie("key");
	    }
	  });
	
	  // ID 저장하기를 체크한 상태에서 ID를 입력하는 경우, 이럴 때도 쿠키 저장.
	  $("#id").keyup(function () {
	    // ID 입력 칸에 ID를 입력할 때,
	    if ($("#idSaveCheck").is(":checked")) {
	      // ID 저장하기를 체크한 상태라면,
	      setCookie("key", $("#id").val(), 7); // 7일 동안 쿠키 보관
	    }
	  });
})
</script>
</head>
<body>
	<%@ include file="navbar.jsp" %>
	<section>
		<form class="login" action="loginAction.jsp">
			<h2 class="title">로그인</h2>
			<span>아이디</span>
			<input type="text" placeholder="ID" id="id" name="userID">
			<span>비밀번호</span>
			<input type="password" placeholder="Password" id="pwd" name="userPassword">
			<p>
				<label>
					<input type="checkbox" id="idSaveCheck">아이디 저장
				</label>
			</p>
			<input type="submit" value="로그인">
		</form>
	</section>
</body>
</html>