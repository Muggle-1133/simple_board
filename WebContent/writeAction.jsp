<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="board.BoardDAO" %>
<%@ page import="com.oreilly.servlet.MultipartRequest" %>
<%@ page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy" %>
<%@ page import="java.util.*" %>
<%@ page import="java.io.*" %>
<% request.setCharacterEncoding("UTF-8"); %>
<jsp:useBean id="board" class="board.Board" scope="page" />

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
</head>
<body>
	<% 
		String userID = null;
	
		String realFolder = "";
		String saveFolder = "fileSave";
		String encType = "utf-8";
		int maxSize = 5*1024*1024; // 최대 업로드 5MB
		String element = "";
		String filesystemName = null;
		String originalFileName = "";
		
		
		ServletContext context = request.getServletContext();
		realFolder = context.getRealPath(saveFolder);
		
	    MultipartRequest multi = new MultipartRequest(request, realFolder, maxSize, encType, new DefaultFileRenamePolicy());
	    Enumeration<?> files = multi.getFileNames();
	    
	    board.setTitle(multi.getParameter("title"));
		board.setContent(multi.getParameter("content"));
		
		if (files.hasMoreElements()) { 
			
			element = (String)files.nextElement(); 
			
			filesystemName = multi.getFilesystemName(element); 
			originalFileName = multi.getOriginalFileName(element); 
		}
		
		if(session.getAttribute("userID") != null){
			userID = (String) session.getAttribute("userID");
		}
		if(userID == null){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('로그인 후 사용하실 수 있습니다.')");
			script.println("location.href = 'login.jsp");
			script.println("</script>");
		}
		else {
			if(board.getTitle() == null || board.getContent() == null) {
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("alert('입력이 안된 사항이 있습니다.')");
				script.println("history.back()");
				script.println("</script>");
			}
			else {
				BoardDAO boardDAO = new BoardDAO();
				int result = boardDAO.write(board.getTitle(), userID, board.getContent(), filesystemName);
				if(result == -1) {
					PrintWriter script = response.getWriter();
					script.println("<script>");
					script.println("alert('데이터베이스 오류가 발생하였습니다.')");
					script.println("history.back()");
					script.println("</script>");
				}
				else if(result == 1){
					PrintWriter script = response.getWriter();
					script.println("<script>");
					script.println("location.href = 'index.jsp'");
					script.println("</script>");
				}	
			}
			
		}
	%>
</body>
</html>