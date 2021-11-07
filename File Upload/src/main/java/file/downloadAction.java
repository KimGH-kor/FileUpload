package file;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.ServletOutputStream;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/downloadAction")
public class downloadAction extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String fileName = request.getParameter("file");
		
		String directory = "C:/jsp/upload";
		File file = new File(directory + "/" + fileName);
		
		//MimeType = 어떠한 데이터를 주고받을지에 대한 정보를 담는 것
		String mimeType = getServletContext().getMimeType(file.toString());
		if(mimeType == null) {
			response.setContentType("application/octet-stream");//파일 관련 데이터는 octet-stream을 이용
		}
		
		String downloadName = null;
		if(request.getHeader("user-agent").indexOf("MSIE")==-1) {
			downloadName = new String(fileName.getBytes("UTF-8"),"8859_1");
		}else {
			downloadName = new String(fileName.getBytes("EUC-KR"),"8859_1");
		}
		
		response.setHeader("Content-Disposition", "attachment;filename=\""+downloadName);
		
		FileInputStream fileInputStream = new FileInputStream(file);
		ServletOutputStream servletOutputStream = response.getOutputStream();
		
		byte b[] = new byte[1024];
		int data = 0;
		
		while ((data = (fileInputStream.read(b,0,b.length))) != -1){
		servletOutputStream.write(b,0,data);	
		}
		
		new FileDAO().hit(fileName);
		
		servletOutputStream.flush();
		servletOutputStream.close();
		fileInputStream.close();
		
	}
}
