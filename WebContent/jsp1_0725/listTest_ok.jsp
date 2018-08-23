<%@ page contentType="text/html; charset=UTF-8"%>
<% 
	request.setCharacterEncoding("UTF-8");

	String msg = request.getParameter("msg");
	
	String nameList[] = request.getParameterValues("rightItem");
	msg = msg.replaceAll("\n", "<br/>");
	
	String str = "";
	if(nameList != null){
		for(String temp : nameList){
			str += temp + " ";
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
	대상 : <%=str %><br/>
	메시지 내용 : <%=msg %>
</body>
</html>