<%@page import="util.DBConn"%>
<%@page import="java.sql.Connection"%>
<%@page import="com.naver.NaverDAO"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<% 
	request.setCharacterEncoding("UTF-8");
	
	String cp = request.getContextPath();
	
	String id = request.getParameter("id");
	
	Connection conn = DBConn.getConnection();
	
	NaverDAO dao =	new NaverDAO(conn);
	
	boolean result = dao.confirmId(id);
	
	DBConn.close();
	
	if(result){ %>
		<center>
			<br/><br/>
			<h4>이미 사용중인 ID 입니다.</h4>
		</center> 
	<%} else { %>
		<center>
			<br/><br/>
			<h4>입력하신 <%=id %> 는 사용하실 수 있는 ID 입니다.</h4>
		</center> 
	<% 
	}
	%>


