<%@page import="com.guest.GuestDAO"%>
<%@page import="com.naver.NaverDAO"%>
<%@page import="util.DBConn"%>
<%@page import="java.sql.Connection"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<% 
	request.setCharacterEncoding("UTF-8");
	
	String cp = request.getContextPath();
	
	String pageNum = request.getParameter("pageNum");
	
%>

<jsp:useBean id="dto" class="com.guest.GuestDTO" scope="page"></jsp:useBean>
<jsp:setProperty property="*" name="dto"/>

<% 

	Connection conn = DBConn.getConnection();

	GuestDAO dao = new GuestDAO(conn);
	
	int maxNum = dao.getMaxNum();
	
	dto.setNum(maxNum +1);
	dto.setIpAddr(request.getRemoteAddr());
	
	dao.insertData(dto);
	
	DBConn.close();
	
	response.sendRedirect("guest.jsp");


%>