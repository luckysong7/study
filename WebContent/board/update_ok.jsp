<%@page import="java.net.URLEncoder"%>
<%@page import="com.board.BoardDAO"%>
<%@page import="util.DBConn"%>
<%@page import="java.sql.Connection"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8");

	String cp = request.getContextPath();

	String pageNum = request.getParameter("pageNum");
	String num = request.getParameter("num");
	//************************************************************
	String searchKey = request.getParameter("searchKey");
	String searchValue = request.getParameter("searchValue");
	String param = "";
	if (searchValue != null || !searchValue.equals("")) {
		param = "&searchKey=" + searchKey;
		param += "&searchValue=" + URLEncoder.encode(searchValue, "UTF-8");

	}
	//************************************************************
%>


<jsp:useBean id="dto" class="com.board.BoardDTO"></jsp:useBean>
<jsp:setProperty property="*" name="dto" />

<%
	Connection conn = DBConn.getConnection();

	BoardDAO dao = new BoardDAO(conn);

	int result = dao.updateData(dto);

	DBConn.close();

	response.sendRedirect("list.jsp?pageNum=" + pageNum + param);
%>