<%@ page contentType="text/html; charset=UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<script type="text/javascript">
	function sendIt() {
		var f = document.myForm;
		
		if(!f.su1.value){
			alert("su1 을 입력하세요 ~!~~!");
			f.su1.focus();
			return ;
		}
		
		if(!f.su2.value){
			alert("su2을 입력 ~!~~!")
			f.su2.focus();
			return ;
		}
		if(!f.name.value){
			alert("name을 입력 ~!~~!")
			f.name.focus();
			return ;
		}
		f.action = "test1_ok.jsp";
		f.submit();
		
		
	}
</script>



</head>
<body>
	<form action="" name="myForm" method="post">

		수1 : <input type="text" name="su1" /><br /> 수2 : <input type="text"
			name="su2" /><br /> 이름 : <input type="text" name="name" /><br /> <input
			type="button" value="결과" onclick="sendIt();" /><br />


	</form>
</body>
</html>