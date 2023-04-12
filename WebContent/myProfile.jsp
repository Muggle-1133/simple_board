<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.SQLException"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.PreparedStatement"%>
<%@ page import="java.io.PrintWriter"%>
<%	
	Connection conn = null;
	PreparedStatement pstmt = null;
	ResultSet rs = null;
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link rel="stylesheet" href="css/navbar.css">
<link rel="stylesheet" href="css/myPage.css">
<script src="https://kit.fontawesome.com/9174a5fbf3.js" crossorigin="anonymous"></script>
<title>마이 페이지</title>
</head>
<body>
	<%@ include file="navbar.jsp" %>
	<section>
<%
	try {
		Class.forName("org.mariadb.jdbc.Driver");
		
		String jdbcDriver = "jdbc:mariadb://localhost:3306/SecureCoding?" + "useUnicode=true&characterEncoding=utf8";
		String dbID = "root";
		String dbPass = "ycdc2021!";
		
		conn = DriverManager.getConnection(jdbcDriver, dbID, dbPass);
		
		String SQL = "SELECT * FROM user WHERE userID = ?";

		pstmt = conn.prepareStatement(SQL);
		pstmt.setString(1,userID);
		rs = pstmt.executeQuery();
		
		if(rs.next()){

%>
		<div class="info">
			<form id="myForm" method="post" name="myForm" action="userInfoUpdate.jsp">
				<div class="image_item">
					<img src="img/user_profile.png">
				</div>
				<p><b><%=userID%></b>님의 회원정보</p>
				<div class="info_items">
					<label><span>아이디</span><input class="userID" type="text" id="userId" name="userID" readonly value="<%= userID %>"></label>
					<label><span>패스워드</span><input id="userPassword" name="userPassword" type="password" readonly value="<%=rs.getString("userPassword")%>"></label>
					<label><span>이메일</span><input id="userEmail" name="userEmail" type="text" readonly value="<%=rs.getString("userEmail")%>"></label>
				</div>
				<div class="btn">
					<input type="submit" class="update_btn" value="개인정보 수정">
				</div>
			</form>
		</div>
<%    	} else{

			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('로그인 후 이용해주세요.');");
			script.println("location.href = 'login.jsp';");
			script.println("</script>");
			script.close();

  		 }
		
	}catch(SQLException e){
    e.printStackTrace();
	}finally{
    	if(pstmt!=null) try{pstmt.close();}catch(SQLException e){}
    	if(conn!=null) try{conn.close();}catch(SQLException e){}
	}
%>
	</section>
</body>
</html>