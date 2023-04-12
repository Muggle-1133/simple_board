<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="java.io.OutputStream"%>
<%@page import="java.io.FileInputStream"%>
<%@page import="java.io.File"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>파일 다운로드</title>
</head>
<body>
	<% 
	
		request.setCharacterEncoding("utf-8");
		
		
		String fileName = request.getParameter("fileName");
		String downLoadFile = request.getSession().getServletContext().getRealPath("/") + "\\fileSave\\" + fileName; 

		File file = new File(downLoadFile);
	    FileInputStream in = new FileInputStream(downLoadFile);
		
	    fileName = new String(fileName.getBytes("utf-8"), "8859_1");   
		
	 	// 8비트로 된 데이터(지정되지 않은 파일 형식)
	    response.setContentType("application/octet-stream");
	 	// 파일 링크를 클릭했을때 다운로드 화면이 출력되게 처리함
	    response.setHeader("Content-Disposition", "attachment; filename=" + fileName ); 
	    
	 	// getOutputStream() 에러 해결 명령어
		out.clear();					
		out = pageContext.pushBody();
	    
		// 다운로드 명령어
	    OutputStream os = response.getOutputStream();
	    
	    int length;
	    byte[] b = new byte[(int)file.length()];

	    while ((length = in.read(b)) > 0) {
	    	os.write(b,0,length);
	    }
	    
	    os.flush();
	    
	    os.close();
	    in.close();
	    
	%>
</body>
</html>