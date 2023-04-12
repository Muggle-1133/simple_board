<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter"%>
<%@ page import="board.AdminBoardDAO"%>
<%@ page import="board.AdminBoard"%>
<%@ page import="java.util.ArrayList"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link rel="stylesheet" href="css/navbar.css">
<link rel="stylesheet" href="css/board.css">
<script src="https://kit.fontawesome.com/9174a5fbf3.js" crossorigin="anonymous"></script>
</head>
<body>
	<%@ include file="navbar.jsp" %>
	<% 
		int pageNumber = 1;
		if(request.getParameter("pageNumber")!=null) {
			pageNumber = Integer.parseInt(request.getParameter("pageNumber"));
		}
	%>
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
					AdminBoardDAO boardDAO = new AdminBoardDAO();
					ArrayList<AdminBoard> list = boardDAO.getList(pageNumber);
					for(int i=0; i<list.size(); i++) {
				%>
				<tr>
					<td><%=list.get(i).getBoard_idx()%></td>
					<td><a href="noticeView.jsp?idx=<%=list.get(i).getBoard_idx()%>" class="click-title"><%=list.get(i).getTitle()%></a></td>
					<td><%=list.get(i).getUserID()%></td>
					<td><%=list.get(i).getWriting_date().substring(0,11) + list.get(i).getWriting_date().substring(11,13) + "시" + list.get(i).getWriting_date().substring(14,16) + "분"%></td>
				</tr>
				<% 		
					}
				%>
		   </tbody>
     	</table>
   </section>
   <% 
   		if(userID != null){
			if(userID.equals("admin")){
		
   %>
   		<div class="btn">
	 	   <a href="noticeWrite.jsp"><button class="write_btn">글쓰기<i class="fa-solid fa-pencil"></i></button></a>
	 	</div>
 	<% 
   			}
   		}
 	%>
 	<%
		if(pageNumber != 1) {
	%>
		<a href="index.jsp?pageNumber=<%=pageNumber-1%>" class="btn-arrow-left">이전</a>
	<% 
		} if(boardDAO.nextPage(pageNumber + 1)) {
	%>
		<a href="index.jsp?pageNumber=<%=pageNumber+1%>" class="btn-arrow-right">다음</a>
	<% 
		}
	%>
</body>
</html>