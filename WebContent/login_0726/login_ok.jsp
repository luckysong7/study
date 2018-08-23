<%@ page contentType="text/html; charset=UTF-8"%>
<% 
	request.setCharacterEncoding("UTF-8");

	String userId = request.getParameter("userId");
	String userPwd = request.getParameter("userPwd");
	
	if(userId.equals("para") && userPwd.equals("para")){
		session.setAttribute("userId", userId);
		
		response.sendRedirect("login.jsp");
	}
		
%>


	※ 아이디나 패스워드가 틀립니다. <br/>
	<a href = "login.jsp">돌아가기</a>
