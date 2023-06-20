package web;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;

import org.apache.tomcat.util.http.fileupload.IOUtils;

import dao.UserDao;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;
import vo.User;

@MultipartConfig
@WebServlet("/user/modify")
public class UserUpdateServlet extends HttpServlet {
	@Override
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		String loginId = request.getParameter("id");
		String name = request.getParameter("name");
		String password = request.getParameter("password");
		String email = request.getParameter("email");
		String tel = request.getParameter("tel");
		
		Part part = request.getPart("picture");
		String filename = part.getSubmittedFileName();
		
		String projectHome = System.getenv("PROJECT_HOME");
		String saveDirectory = projectHome + "/src/main/webapp/resources/images";  
		
		FileOutputStream out = new FileOutputStream(new File(saveDirectory, filename));
		InputStream in = part.getInputStream();
		IOUtils.copy(in, out);
		
		UserDao userDao = UserDao.getinstance();
		User user = userDao.getUserById(loginId);
		// 요청파라미터로 전달받은 수정된 회원정보를 User 객체에 저장해서 값을 덮어쓰기
		user.setName(name);
		user.setPassword(password);
		user.setEmail(email);
		user.setTel(tel);
		user.setFileName(filename);
		
		// 수정된 정보가 포함된 Product 객체를 전달해서 데이터베스에 반영시키기
		userDao.updateUser(user);
		
		//재요청 URL 응답
		response.sendRedirect("detail.jsp");
		
	}

}
