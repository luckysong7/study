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

	<form action="test5_ok.jsp" method="get">
		이름 : <input type="text" name="name" /> <br /> 메모 :
		<textarea rows="5" cols="30" name="memo"></textarea>
		<br /> 이상형 : <br /> <input type="checkbox" name="type" value="웃는 여자">웃는
		여자 <br /> <input type="checkbox" name="type" value="청순한 여자">청순한
		여자 <br /> <input type="checkbox" name="type" value="긴머리">긴머리
		<br /> <input type="checkbox" name="type" value="귀여운 여자">귀여운여자
		<br /> 전공 : <br /> <select name="major">
			<option value="컴공">컴공</option>
			<option value="경영">경영</option>
			<option value="국문">국문</option>
			<option value="전자">전자</option>
		</select> <br />
		<br /> 취미 : <br /> <select name="hb" size="4" multiple="multiple">
			<option value="운동">운동</option>
			<option value="게임">게임</option>
			<option value="음악">음악</option>
		</select> 
		<input type="submit" value="전송"> <br />
	</form>


</body>
</html>