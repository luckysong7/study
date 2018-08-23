<%@page import="java.net.URLEncoder"%>
<%@page import="com.board.BoardDAO"%>
<%@page import="util.DBConn"%>
<%@page import="java.sql.Connection"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<% 
	request.setCharacterEncoding("UTF-8");
	
	String cp = request.getContextPath();
	
	String searchKey = request.getParameter("searchKey");
	String searchValue = request.getParameter("searchValue");
	String pageNum = request.getParameter("pageNum");
	String param = "";
	
	if(searchValue != null || !searchValue.equals("")){
		param ="&searchKey="+searchKey;
		param +="&searchValue=" + URLEncoder.encode(searchValue,"UTF-8");
		
	}
	
	
%>
<jsp:useBean id="dto" class="com.board.BoardDTO" scope="page"></jsp:useBean>
<jsp:setProperty property="*" name="dto"/>


<%
	Connection conn = DBConn.getConnection();

	BoardDAO dao = new BoardDAO(conn);
	
	int maxNum = dao.getMaxNum();
	
	dto.setNum(maxNum +1);
	dto.setIpAddr(request.getRemoteAddr());
	
	dao.insertData(dto);
	
	DBConn.close();
	
	response.sendRedirect("list.jsp?"+param+"&pageNum="+pageNum);
	

%>
