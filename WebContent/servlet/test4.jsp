<%@ page contentType="text/html; charset=UTF-8"%>
<% 
	request.setCharacterEncoding("UTF-8");
	
	String cp = request.getContextPath();
	
	// EL
	// 표현언어
	// null 에 관대하고 데이터 형변환을 자동으로
	// 연산까지 가능 !
	
	request.setAttribute("result", "테스트");
	
	
	
	
	
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>

<form action="" method= "post">

	수1 : <input type ="text" name = "su1"/> <br/>
	
	수2 : <input type= "text" name = "su2"/> <br/>
	
	<input type="submit" value ="결과" /> <br/>

</form>

<br/><br/>

결과 : ${param.su1 + param.su2 }<br/>
${param.su1 } 은 ${param.su1%2 == 0?"짝수": "홀수"}<br/>

${result }<br/>

</body>
</html>