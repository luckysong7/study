<%@ page contentType="text/html; charset=UTF-8"%>
<% 
	request.setCharacterEncoding("UTF-8");
%>

<jsp:useBean id="vo" class="com.calc.GuestVO" scope="page"></jsp:useBean>
<jsp:setProperty property="*" name="vo"/>


<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>

이름 : <%=vo.getUserName() %><br/><br/>
제목 : <%=vo.getSubject() %><br/><br/>
내용 : <%=vo.getContent().replaceAll("\n", "<br/>") %><br/><br/>
날짜 : <%=vo.getCreated() %><br/><br/>



</body>
</html>