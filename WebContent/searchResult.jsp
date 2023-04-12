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
<link rel="stylesheet" href="css/board.css">
<link rel="stylesheet" href="css/search.css">
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
	<section class="table-container">
       <table border="1">
           <thead>
               <tr>
                   <th>번호</th>
                   <th>제목</th>
                   <th>작성자</th>
                   <th>작성날짜</th>
               </tr>
           </thead>
           <tbody>
           		<% 
	           		BoardDAO boardDAO = new BoardDAO();
	        		ArrayList<Board> list = boardDAO.getSearch(request.getParameter("searchField"), request.getParameter("searchText"));
	        		if (list.size() == 0) {
	        			PrintWriter script = response.getWriter();
	        			script.println("<script>");
	        			script.println("alert('검색결과가 없습니다.')");
	        			script.println("history.back()");
	        			script.println("</script>");
	        		}
	        		for (int i = 0; i < list.size(); i++) {
           		%>
           		<tr>
					<td><%=list.get(i).getBoard_idx()%></td>
					<td><a href="view.jsp?idx=<%=list.get(i).getBoard_idx()%>" class="click-title"><%=list.get(i).getTitle()%></a></td>
					<td><%=list.get(i).getUserID()%></td>
					<td><%=list.get(i).getBoard_date().substring(0,11) + list.get(i).getBoard_date().substring(11,13) + "시" + list.get(i).getBoard_date().substring(14,16) + "분"%></td>
				</tr>
				<% 		
					}
				%>
           </tbody>
       </table>
	</section>
	<div class="search_form">
		<form class="search_field" action="searchResult.jsp">
		<select name="searchField">
			<option value="title">제목</option>
			<option value="userID">글쓴이</option>			
		</select>
		<input type="text" id="selectInput" name="searchText">
		<button type="submit" class="search_btn">검색</button>
		</form>
	</div>
</body>
</html>