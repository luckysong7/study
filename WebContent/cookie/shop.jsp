<%@page import="java.net.URLDecoder"%>
<%@page import="java.net.URLEncoder"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix ="c" uri="http://java.sun.com/jsp/jstl/core" %>
<% 
	request.setCharacterEncoding("UTF-8");
	
	String cp = request.getContextPath();
	
	Cookie[] ck = request.getCookies();
	
	
	
	
	
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>

<table width ="400" border="1" cellpadding="0" cellspacing="0"> 
	<tr>
		<th>상품명</th>
		<th>가격</th>
	</tr>

	<tr>
		<td><a href ="a1.jsp">냉장고</a></td>
		<td>1000</td>
	</tr>
	
	<tr>
		<td><a href ="a2.jsp">세탁기</a></td>
		<td>2000</td>
	</tr>
	
	<tr>
		<td><a href ="a3.jsp">LCDTV</a></td>
		<td>3000</td>
	</tr>
</table>

<br/>

<hr align="left" width="400" color="red"/>

오늘본 상품 목록 <br/>

<%

	if(ck != null){
		for(int i = ck.length-1 ; i >= 0 ; i--){
			if(ck[i].getName().indexOf("productName") != -1){
%>
				<%=URLDecoder.decode(ck[i].getValue(), "UTF-8") %>
				<img width="100" height="100" src="./image/<%=URLDecoder.decode(ck[i].getValue(), "UTF-8")%>.jpg"> <br/>
				
<%
			}
		}
	}
%>

</body>
</html>