<%@ page contentType="text/html; charset=UTF-8"%>
<% 
	request.setCharacterEncoding("UTF-8");

	String name = request.getParameter("name");
	String memo = request.getParameter("memo");
	String type[] = request.getParameterValues("type");
	
	memo = memo.replaceAll("\n", "<br/>");
	
	System.out.print(type[0]);
	String str = "";
	if(type != null){
		for(String temp : type){
			str += temp + " ";
		}
	}
	
	String major = request.getParameter("major");
	
	String hb[] = request.getParameterValues("hb");
	
	String str2 = "";
	if(hb != null){
		for(String temp2 : hb){
			str2 += temp2 + " ";
		}
	}
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>

	이름 : <%=name %>
	메모 : <%=memo %>
	이상형 : <%=str %>
	전공 : <%=major %>
	취미 : <%=str2 %>
</body>
</html>