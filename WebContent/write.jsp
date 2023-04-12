<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
	<div class="container">
		<div class="row">
			<form method="post" action="writeAction.jsp" name="writingForm" enctype="multipart/form-data">
				<table>
					<thead>
						<tr>
							<th>게시판 글쓰기</th>
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
							<td class="file_input"><p>파일첨부</p><input type="file" class="form-control" name="uploadFile"></td>
						</tr>
					</tbody>
				</table>
				<div class="btn">
					<button type="submit" class="write_btn">글쓰기<i class="fa-solid fa-pencil"></i></button>
			   </div>
			</form>
		</div>
	</div>
</body>
</html>