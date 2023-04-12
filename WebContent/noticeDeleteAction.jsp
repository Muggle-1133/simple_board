<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="board.AdminBoardDAO"%>
<%@ page import="board.AdminBoard"%>
<%@ page import="java.io.PrintWriter"%>
<% request.setCharacterEncoding("UTF-8");%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
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
			script.println("alert('권한이 없습니다.)");
			script.println("history.back()");
			script.println("</script>");
		}
		else if(userID != null && !userID.equals("admin")){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('권한이 없습니다.)");
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
			script.println("history.back()");
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
		else {
			
			AdminBoardDAO boardDAO = new AdminBoardDAO();
			int result = boardDAO.delete(board_idx);
			if(result == -1){
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("alert('글 삭제에 실패하였습니다.')");
				script.println("history.back()");
				script.println("</script>");
			}
			else {
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("location.href = 'notice.jsp'");
				script.println("</script>");
			}
		}
		
	%>
</body>
</html>