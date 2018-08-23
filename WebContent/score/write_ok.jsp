<%@page import="com.score.ScoreDAO"%>
<%@page import="util.DBConn"%>
<%@page import="java.sql.Connection"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<% 
	request.setCharacterEncoding("UTF-8");
%>

<jsp:useBean id="dto" class="com.score.ScoreDTO" scope="page"></jsp:useBean>
<jsp:setProperty property="*" name="dto"/>

<%

	Connection conn = DBConn.getConnection();

	ScoreDAO dao = new ScoreDAO(conn);
	
	int result = dao.insertData(dto);
	
	DBConn.close();
	if(result != 0){
		response.sendRedirect("list.jsp");
		
	}

%>

입력오류 !!!

