package com.svt;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.GenericServlet;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;

public class Test1 extends GenericServlet{
	
	private static final long serialVersionUID = 1L;

	@Override
	public void service(ServletRequest request, ServletResponse response)
			throws ServletException, IOException {
		
		response.setContentType("text/html;charSet=UTF-8");
		
		try {
			
			PrintWriter out = response.getWriter();
			out.print("html");
			out.println("<head>");
			out.print("<title>");
			out.print("���� ���α׷�</title></head>");
			out.print("<body style= 'font-size : 12pt;'>");
			out.print("ȭ�� �������� �������� JSP �� ���ϴ�.");
			out.print("</body>");
			out.print("</html>");
			
		} catch (Exception e) {
			System.out.println(e.toString());
		}
		
	}
}
