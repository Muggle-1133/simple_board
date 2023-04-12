<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link rel="stylesheet" href="css/navbar.css">
<script src="https://kit.fontawesome.com/9174a5fbf3.js" crossorigin="anonymous"></script>
<script src="jquery-3.6.0.min.js"></script>
</head>
<body>
	<%
		String userID = null;
		if(session.getAttribute("userID") != null){
			userID = (String) session.getAttribute("userID");
		}
	%>
	<nav class="navbar">
		<div class="navbar_logo">
			<a href="index.jsp"><i class="fa-solid fa-shield-halved"></i>Cyber Security Community</a>	
		</div>
		<ul class="navbar_menu">
			<li><a href="index.jsp">Home</a></li>
			<li><a href="#none">Q&A</a></li>
			<li><a href="notice.jsp">Notice</a></li>
		</ul>
		<ul class="navbar_user_status">
	<% 
		if(userID == null){
	%>
			<li class="navbar_user_icon"><a href="login.jsp"><i class="fa-solid fa-right-to-bracket"></i>Login</a></li>
			<li class="navbar_user_icon"><a href="SignUp.jsp"><i class="fa-solid fa-user-plus"></i>Sign Up</a></li>
	<% 
		} else {
	%>
			<li class="navbar_user_icon"><i class="fa-solid fa-caret-down"></i>MyPage
				<ul class="dropdown">
					<li class="dropdown_menu"><a href="myProfile.jsp"><i class="fa-solid fa-user"></i>Profile</a></li>
					<li class="dropdown_menu"><a href="myWriting.jsp"><i class="fa-solid fa-file-lines" style="font-size: 15px;"></i>My Writing</a></li>
				</ul>
			</li>
			<li class="navbar_user_icon"><a href="logoutAction.jsp"><i class="fa-solid fa-right-from-bracket"></i>Logout</a></li>
	<%	} %>
		</ul>	
	</nav>
</body>
</html>