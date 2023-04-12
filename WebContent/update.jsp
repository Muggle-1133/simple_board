<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter"%>
<%@ page import="board.BoardDAO"%>
<%@ page import="board.Board"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Cyber Security Community 공지사항</title>
<script src="https://kit.fontawesome.com/9174a5fbf3.js" crossorigin="anonymous"></script>
<link rel="stylesheet" href="css/navbar.css">
<link rel="stylesheet" href="css/write.css">
</head>
<body>
	<%@ include file="navbar.jsp" %>
	<%
		if(userID == null){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('로그인을 하세요.')");
			script.println("location.href = 'login.jsp'");
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
		Board board = new BoardDAO().getBoard(board_idx);
		if(!userID.equals(board.getUserID())){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('권한이 없습니다.')");
			script.println("location.href = 'index.jsp'");
			script.println("</script>");
		}
	%>
	<div class="container">
		<div class="row">
			<form method="post" action="updateAction.jsp?idx=<%=board_idx%>" enctype="multipart/form-data" name="writingForm">
				<table>
					<thead>
						<tr>
							<th>게시판 글 수정</th>
						</tr>
					</thead>
					<tbody>
						<tr>
							<td class="title_input"><p>글제목</p><input type="text" class="form-control" placeholder="제목을 입력하세요." name="title" maxlength="50" value="<%=board.getTitle()%>"></td>
						</tr>
						<tr>
							<td class="content_input"><p>글내용</p><textarea class="form-control" placeholder="내용을 입력하세요." name="content" maxlength="2048"><%=board.getContent()%></textarea></td>
						</tr>
						<tr>
							<% 
								if(board.getUploadFile() == null) {
							%>
							<td class="file_input"><p>파일첨부</p><input type="file" class="form-control" name="uploadFile"></td>
							<% 
								}
								else {
							%>
							<td class="file_input"><p>파일첨부</p><input type="file" class="form-control" name="uploadFile"><%=board.getUploadFile()%></td>
							<% 
								}
							%>
						</tr>
					</tbody>
				</table>
				<div class="btn">
					<button type="submit" class="write_btn">글수정<i class="fa-solid fa-pencil"></i></button>
					<button type="button" class="cancel_btn" onclick="if(confirm('취소 하시겠습니까?')){ history.back(); }">취소<i class="fa-solid fa-ban"></i></button>
			   </div>
			</form>
		</div>
	</div>
</body>
</html>