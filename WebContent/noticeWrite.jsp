<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Cyber Security Community 게시판</title>
<script src="https://kit.fontawesome.com/9174a5fbf3.js" crossorigin="anonymous"></script>
<link rel="stylesheet" href="css/navbar.css">
<link rel="stylesheet" href="css/write.css">
</head>
<body>
	<%@ include file="navbar.jsp" %>
	<%
		if(userID != null && !userID.equals("admin")){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('권한이 없습니다.')");
			script.println("history.back()");
			script.println("</script>");
		}
	%>
	<div class="container">
		<div class="row">
			<form method="post" action="noticeAction.jsp">
				<table>
					<thead>
						<tr>
							<th>공지사항 글쓰기</th>
						</tr>
					</thead>
					<tbody>
						<tr>
							<td class="title_input"><p>글제목</p><input type="text" class="form-control" placeholder="제목을 입력하세요." name="title" maxlength="50"></td>
						</tr>
						<tr>
							<td class="content_input"><p>글내용</p><textarea class="form-control" placeholder="내용을 입력하세요." name="content" maxlength="2048"></textarea></td>
						</tr>
						<tr>
							<td class="file_input"><p>파일첨부</p><input type="file" class="form-control" name="userFile"></td>
						</tr>
					</tbody>
				</table>
				<div class="btn">
					<button type="submit" class="write_btn">작성 완료<i class="fa-solid fa-pencil"></i></button>
			   </div>
			</form>
		</div>
	</div>
</body>
</html>