<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>JSP 파일 업로드</title>
</head>
<body>
	<!-- enctype="multipart/form-data"는 업로드 할때 사용되는 클래스와 연동되는 타입이다. -->
	<form action="uploadAction.jsp" method="post" enctype="multipart/form-data">
		파일 : <input type="file"name="file"><br>
		<input type="submit" value="업로드"><br>
	</form>
	<a href="fileDownlaod.jsp">파일 다운로드</a>
</body>
</html>