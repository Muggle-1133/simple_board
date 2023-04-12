<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="user.UserDAO" %>
<%@ page import="java.io.PrintWriter" %>
<% request.setCharacterEncoding("UTF-8"); %>
<jsp:useBean id="user" class="user.User" scope="page" />
<jsp:setProperty name="user" property="userPassword" />
<jsp:setProperty name="user" property="userEmail" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link rel="stylesheet" href="css/navbar.css">
<link rel="stylesheet" href="css/userInfoUpdate.css">
<script src="https://kit.fontawesome.com/9174a5fbf3.js" crossorigin="anonymous"></script>
<title>마이 페이지</title>
</head>
<body>
	<%@ include file="navbar.jsp" %>
	<section>
		<% 
			UserDAO userDAO = new UserDAO();
			int result = userDAO.update(userID, user);
		
		%>
		<div class="info">
			<form id="myForm" method="post" name="myForm" action="userInfoUpdateAction.jsp">
				<div class="image_item">
					<img src="img/user_profile.png">
				</div>
				<p><b><%=userID%></b>님의 회원정보</p>
				<div class="info_items">
					<label><span>아이디</span><input class="userID" type="text" id="userId" name="userID" readonly value="<%= userID %>"></label>
					<label><span>패스워드</span><input id="userPassword" name="userPassword" type="password" value="<%= user.getUserPassword() %>"></label>
					<label><span>이메일</span><input id="userEmail" name="userEmail" type="text" value="<%= user.getUserEmail() %>"></label>
				</div>
				<div class="btn">
					<button class="update_btn" onclick="return confirm('수정 하시겠습니까?')">수정 완료</button>
				</div>
			</form>
		</div>
	</section>
</body>
</html>