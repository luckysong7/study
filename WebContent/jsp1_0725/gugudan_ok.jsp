<%@page import="org.apache.jasper.tagplugins.jstl.core.Out"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8");
%>

<%
	int n = Integer.parseInt(request.getParameter("dan"));
%>

<%!String print_gugudan(int number) {
		int n2 = number;
		String str = "";
		for (int i = 0; i < 10; i++) {
			str += String.format("%d * %d = %d \n", n2, i, (n2 * i));
		}
		return str;
	}%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>

	<%
		for (int i = 1; i < 10; i++) {
			out.print(n + " * " + i + " = " + (n * i) + "<br/>");
		}
	%>
	
	<br/>
	
	<%
		print_gugudan(n);
	%>
</body>
</html>