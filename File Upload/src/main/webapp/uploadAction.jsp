<%@ page import = "file.FileDAO" %>
<%@ page import = "java.io.File" %>
<!--cos안의 하나의 클래스를 외부라이브러리로써 가져온다. -> 사용자가 업로드한 같은 이름의 파일이 있으면 이름을 바꿔준다. -->
<%@ page import = "com.oreilly.servlet.multipart.DefaultFileRenamePolicy" %>
<%@ page import = "com.oreilly.servlet.MultipartRequest" %>

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>JSP 파일 업로드</title>
</head>
<body>
	<%
	//전체 프로젝트에 대한 자원을 관리하는 객체 -> 우리가 만든 폴더에 저장하는 등
		String directory = "C:/jsp/upload";
		int maxSize = 1024 * 1024 * 100;
		String encoding = "UTF-8";
		
		MultipartRequest multipartRequest
		= new MultipartRequest(request, directory, maxSize, encoding,
				new DefaultFileRenamePolicy());
		
		//name = file로 전송되기 때문에 전송 받은 업로드 파일의 이름은 file로써 처리
		String fileName = multipartRequest.getOriginalFileName("file");
		String fileRealName = multipartRequest.getFilesystemName("file");
		
		if(!fileName.endsWith(".doc")&& !fileName.endsWith(".hwp")&&
				!fileName.endsWith(".pdf")&&!fileName.endsWith(".xls")){
			File file = new File(directory + fileRealName);
			file.delete();
			out.write("업로드할 수 없는 확장자입니다.");
		}else{
			new FileDAO().upload(fileName, fileRealName);
			out.write("파일명 : "+ fileName +"<br>");
			out.write("실제 파일명 : "+ fileRealName +"<br>");	
		}
	%>
</body>
</html>