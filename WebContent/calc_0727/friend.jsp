<%@ page contentType="text/html; charset=UTF-8"%>
<% 
	request.setCharacterEncoding("UTF-8");
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>

	<form action="friend_ok.jsp">
		이름 : <input type="text" name ="userName" /> <br/>
		
		나이 : <input type="text" name ="age" /> <br/>
		
		성별 : <input type="radio" name ="sex" value ="남자"/>남자
			   <input type="radio" name ="sex" value ="여자"/>여자 <br/>
		
		
		이상형 : <input type ="checkbox" name ="ideal"  value ="청순"/>청순 
				 <input type ="checkbox" name ="ideal"  value ="가련"/>가련
				 <input type ="checkbox" name ="ideal"  value ="섹시"/>섹시<br/>
				
		<input type="submit" value="등록" >
		
	</form>

</body>
</html>