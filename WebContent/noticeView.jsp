<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter"%>
<%@ page import="board.AdminBoard"%>
<%@ page import="board.AdminBoardDAO"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Cyber Security Community 게시글 목록</title>
<script src="https://kit.fontawesome.com/9174a5fbf3.js" crossorigin="anonymous"></script>
<link rel="stylesheet" href="css/navbar.css">
<link rel="stylesheet" href="css/view.css">
</head>
<body>
	<%
			int board_idx = 0;
			if(request.getParameter("idx") != null){
				board_idx = Integer.parseInt(request.getParameter("idx"));
			}
			if(board_idx == 0){
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("alert('유효하지 않은 글입니다.')");
				script.println("location.href = 'notice.jsp'");
				script.println("</script>");
			}
			AdminBoard board = new AdminBoardDAO().getBoard(board_idx);
			if(board == null){
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("alert('유효하지 않은 글입니다.')");
				script.println("history.back()");
				script.println("</script>");
			}
	%>
	<%@ include file="navbar.jsp" %>
	<div class="container">
		<div class="row">
			<table>
				<thead>
					<tr>
						<th colspan="3">게시판 글 보기</th>
					</tr>
				</thead>
				<tbody>
					<tr class="writing_title">
						<td class="td1"><p>글제목</p></td>
						<td><%= board.getTitle().replaceAll(" ", "&nbsp;").replaceAll("<", "&lt;").replaceAll(">", "&gt;").replaceAll("\n", "<br>") %></td>
					</tr>
					<tr class="writing_writer">
						<td class="td1"><p>작성자</p></td>
						<td><%= board.getUserID() %></td>
					</tr>
					<tr class="writing_date">
						<td class="td1"><p>작성일자</p></td>
						<td><%= board.getWriting_date().substring(0,11) + board.getWriting_date().substring(11,13) + "시" + board.getWriting_date().substring(14,16) + "분" %></td>
					</tr>
					<tr class="writing_content">
						<td class="td1"><p>글내용</p></td>
						<td><%= board.getContent().replaceAll(" ", "&nbsp;").replaceAll("<", "&lt;").replaceAll(">", "&gt;").replaceAll("\n", "<br>") %></td>
					</tr>
				</tbody>
			</table>
			<div class="btn">
				<a href="notice.jsp"><button class="list_btn">목록</button></a>
			<% 
				if(userID != null && userID.equals(board.getUserID())){
			%>
				<a href="noticeUpdate.jsp?idx=<%= board_idx %>" onclick="return confirm('수정 하시겠습니까?')"><button class="update_btn">수정</button></a>
				<a href="noticeDeleteAction.jsp?idx=<%= board_idx %>" onclick="return confirm('정말 삭제하시겠습니까?')"><button class="delete_btn">삭제</button></a>
			<%		
				}
			%>
		   </div>
		</div>
	</div>
</body>
</html>