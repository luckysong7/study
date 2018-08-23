<%@page import="com.svt.MyData"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8");

	String cp = request.getContextPath();

	List<MyData> lists = new ArrayList<MyData>();
	MyData ob ;
	ob = new MyData("송재훈",27);
	lists.add(ob);
	
	ob = new MyData("송재민",25);
	lists.add(ob);
	
	request.setAttribute("lists", lists);
	
%>

<jsp:forward page="result.jsp"/>
