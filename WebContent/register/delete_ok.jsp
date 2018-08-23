<%@page import="util.DBConn"%>
<%@page import="com.naver.NaverDAO"%>
<%@page import="java.sql.Connection"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<% 
	request.setCharacterEncoding("UTF-8");
	
	String cp = request.getContextPath();
	
	String id = request.getParameter("id");
	
	NaverDAO dao = new NaverDAO(DBConn.getConnection());
	
	int result = dao.deleteDate(id);
	
	DBConn.close();
	
	response.sendRedirect("membership.jsp");
	
%>

