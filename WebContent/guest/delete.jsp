
<%@page import="com.guest.GuestDAO"%>
<%@page import="util.DBConn"%>
<%@page import="java.sql.Connection"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<% 
	request.setCharacterEncoding("UTF-8");
	
	String cp = request.getContextPath();
	
	int num =Integer.parseInt(request.getParameter("num"));
	
	String pageNum = request.getParameter("pageNum");
	
	Connection conn = DBConn.getConnection();
	GuestDAO dao = new GuestDAO(conn);
	
	int result = dao.deleteData(num);
	
	DBConn.close();
	
	response.sendRedirect("guest.jsp?pageNum="+pageNum);
	
%>

Delete 오류!