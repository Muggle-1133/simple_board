<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter"%>
<%@ page import="board.BoardDAO"%>
<%@ page import="board.Board"%>
<%@ page import="java.util.ArrayList"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link rel="stylesheet" href="css/navbar.css">
<link rel="stylesheet" href="css/myWritingStyle.css">
<script src="https://kit.fontawesome.com/9174a5fbf3.js" crossorigin="anonymous"></script>
<title>Cyber Security Community</title>
</head>
<body>
	<% 
		int pageNumber = 1;
		if(request.getParameter("pageNumber")!=null) {
			pageNumber = Integer.parseInt(request.getParameter("pageNumber"));
		}
	%>
	<%@ include file="navbar.jsp" %>
	<section class="lists_box">
       <div class="table-container">
       		<table border="1">
	           <thead>
	           	   <tr class="title"><td colspan="3">내 게시글 관리</td></tr>
	               <tr>
	                   <th>번호</th>
	                   <th>제목</th>
	                   <th>작성날짜</th>
	               </tr>
	           </thead>
	           <tbody>
	           		<% 
		           		BoardDAO boardDAO = new BoardDAO();
		        		ArrayList<Board> list = boardDAO.getMyWriting(userID);
		        		if (list.size() == 0) {
		        	%>
		        		<tr>
							<td colspan="3" class="no_writing">작성한 글이 없습니다.</td>
						</tr>
					<%	
		        		}
		        		for (int i = 0; i < list.size(); i++) {
	           		%>
	           		<tr>
						<td><%=list.get(i).getBoard_idx()%></td>
						<td><a href="view.jsp?idx=<%=list.get(i).getBoard_idx()%>" class="click-title"><%=list.get(i).getTitle()%></a></td>
						<td><%=list.get(i).getBoard_date().substring(0,11) + list.get(i).getBoard_date().substring(11,13) + "시" + list.get(i).getBoard_date().substring(14,16) + "분"%></td>
					</tr>
					<% 		
						}
					%>
	           </tbody>
	       </table>
       </div>
	</section>
</body>
</html>