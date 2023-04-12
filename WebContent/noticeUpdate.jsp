<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="board.AdminBoardDAO"%>
<%@ page import="board.AdminBoard"%>
<%@ page import="java.io.PrintWriter"%>
<% request.setCharacterEncoding("UTF-8");%>
<jsp:useBean id="board" class="board.AdminBoard" scope="page" />
<jsp:setProperty name="board" property="title" />
<jsp:setProperty name="board" property="content" />
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Cyber Security Community 공지사항</title>
<script src="https://kit.fontawesome.com/9174a5fbf3.js" crossorigin="anonymous"></script>
<link rel="stylesheet" href="css/navbar.css">
<link rel="stylesheet" href="css/write.css">
</head>
<body>
	<%
		String userID = null;
		if(session.getAttribute("userID") != null){
			userID = (String) session.getAttribute("userID");
		}
		if(userID == null){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('로그인 후 이용하실 수 있습니다.')");
			script.println("location.href = 'login.jsp'");
			script.println("</script>");
		}
		else if(!userID.equals("admin")){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('권한이 없습니다.')");
			script.println("history.back()");
			script.println("</script>");
		}
		
		int board_idx = 0;
		if(request.getParameter("idx")!=null) {
			board_idx = Integer.parseInt(request.getParameter("idx"));
		}
		if(board_idx==0) {
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('유효하지 않은 글입니다.')");
			script.println("location.href = 'index.jsp'");
			script.println("</script>");
		}
		AdminBoard AdminBoard = new AdminBoardDAO().getBoard(board_idx);
		if(AdminBoard == null){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('유효하지 않은 글입니다.')");
			script.println("history.back()");
			script.println("</script>");
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
			<li class="navbar_user_icon"><a href="myPage.jsp"><i class="fa-solid fa-circle-user"></i>MyPage</a></li>
			<li class="navbar_user_icon"><a href="logoutAction.jsp"><i class="fa-solid fa-right-from-bracket"></i>Logout</a></li>
		</ul>	
	</nav>
	<div class="container">
		<div class="row">
			<form method="post" action="noticeUpdateAction.jsp?idx=<%=board_idx%>">
				<table>
					<thead>
						<tr>
							<th>게시판 글 수정</th>
						</tr>
					</thead>
					<tbody>
						<tr>
							<td class="title_input"><p>글제목</p><input type="text" class="form-control" placeholder="제목을 입력하세요." name="title" maxlength="50" value="<%=AdminBoard.getTitle()%>"></td>
						</tr>
						<tr>
							<td class="content_input"><p>글내용</p><textarea class="form-control" placeholder="내용을 입력하세요." name="content" maxlength="2048"><%=AdminBoard.getContent()%></textarea></td>
						</tr>
						<tr>
							<td class="file_input"><p>파일첨부</p><input type="file" class="form-control" name="userFile"></td>
						</tr>
					</tbody>
				</table>
				<div class="btn">
					<button type="submit" class="write_btn">수정완료<i class="fa-solid fa-pencil"></i></button>
					<button type="button" class="cancel_btn" onclick="if(confirm('취소 하시겠습니까?')){ history.back(); }">취소<i class="fa-solid fa-ban"></i></button>
			   </div>
			</form>
		</div>
	</div>
</body>
</html>