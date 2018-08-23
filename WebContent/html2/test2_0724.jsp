<%@ page contentType="text/html; charset=UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<script type="text/javascript">
	function test1(color) {
		document.bgColor = color;
	}

	function idpwCheck() {
		var f = document.myform;
		if (!f.id.value) {
			alert("아이디를 입력하세요 !");
			f.id.focus();
			return;
		}
		if (!f.pw.value) {
			alert("비밀번호를 입력하세요 !");
			f.pw.focus();
			return;
		}
		alert("로그인 성공 !");
	}
</script>

</head>
<body>
	<h2>배경색 선택하기</h2>
	<input type="radio" name="r1" value="red" onclick="test1('red')" />
	<input type="radio" name="r1" value="white" onclick="test1('white')" />
	<input type="radio" name="r1" value="green" onclick="test1('green')" />
	<input type="radio" name="r1" value="orange" onclick="test1('orange')" />


	<br />
	<br />
	<br />

	<form action="" name="myform">
		<table style="font-size: 10pt; font-family: 돋움;" cellpadding="3">
			<tr>
				<td><b>아이디</b></td>
				<td><input type="text" name="id"
					style="width: 100pt; height: 13pt;" /></td>
				<td></td>
			</tr>
			<tr>
				<td><b>패스워드</b></td>
				<td><input type="password" name="pw"
					style="width: 100pt; height: 13pt;" /></td>
				<td>
					<!-- 				<a href="javascript:idpwCheck();">  --> <!-- 				<img alt="그림없음" -->
					<!-- 						src="../html1/image/btn_login.gif"> --> <!-- 				</a> -->
					<input type="button" value="로그인" onclick="idpwCheck();">

				</td>
			</tr>
			<tr>
				<td colspan="3" align="center"><input type="checkbox">아이디저장
					<input type="checkbox">보안접속</td>
			</tr>
			<tr height="1">
				<td colspan="3" bgcolor="#dad6d7"></td>
			</tr>

		</table>
	</form>

</body>
</html>