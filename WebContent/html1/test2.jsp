<%@ page contentType="text/html; charset=UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
	<table border="1" height="200" width=60% align="center" cellpadding="0"
		cellspacing="0">

		<tr align="center">
			<td colspan="2">가</td>
			<td>다</td>
			<td rowspan="3">라</td>
		</tr>

		<tr>
			<td>A</td>
			<td>B</td>
			<td rowspan="2">C</td>
		</tr>

		<tr>
			<td>1</td>
			<td>2</td>

		</tr>

	</table>


	<br />
	<br />
	<br />
<hr color="blue" size="3"/>
	<table border="1" width="600">
		<tr>
			<td></td>
			<td>
				<table border="1" width="100%">
					<tr>
						<td>a</td>
						<td>b</td>
					</tr>
					<tr>
						<td>1</td>
						<td>2</td>
					</tr>
				</table>

			</td>
		</tr>
	</table>
	<br />
	<br />
	<br />
<hr color="blue" size="3"/>
	<table border="1">
		<tr>
			<td>
				<table border="1">
					<tr>
						<td>A</td>
					</tr>
					<tr>
						<td>B</td>
					</tr>
					<tr>
						<td>C</td>
					</tr>
				</table>
			</td>
			<td>
				<table border="1" width="100%" height="100%">
					<tr>
						<td>1</td>
						<td>2</td>
					</tr>
					<tr>
						<td>3</td>
						<td>4</td>
					</tr>

				</table>
			</td>
		</tr>
	</table>

<hr color="blue" size="3"/>
	<table border="3">
		<tr>
			<td align="center">화면상단</td>
		</tr>
		<tr>
			<td>
				<table border="1">
					<tr align="center">
						<td>왼쪽</td>
						<td>가운데</td>
						<td>오른쪽</td>
					</tr>
				</table>
			</td>
		</tr>
		<tr>
			<td align="center">화면하단</td>
		</tr>

	</table>
<hr color="blue" size="3"/>
	<br />
	<br />
<hr color="blue" size="3"/>
	<h3>폼 양식</h3>
	<table>
		<tr>
			<td>아이디</td>
			<td><input type="text" /></td>
		</tr>
		<tr>
			<td>비밀번호</td>
			<td><input type="password" /></td>
		</tr>
	</table>

	<table style="font-size: 10pt; font-family: 돋움" cellpadding="3">
		<tr>
			<td><b>아이디</b></td>
			<td><input type="text" style="width: 100;" /></td>
			<td></td>
		</tr>

		<tr>
			<td><b>비밀번호</b></td>
			<td><input type="password" style="width: 100; height: 22;">
			</td>
			<td><img alt="" src="./image/btn_login.gif" border="0"></td>
		</tr>

		<tr>
			<td colspan="3" align="center"><input type="checkbox"
				checked="checked">아이디 저장 <input type="checkbox">
				보안접속</td>
		</tr>

		<tr>
			<td colspan="3" bgcolor="#dad6d7"></td>
		</tr>


	</table>
<hr color="blue" size="3"/>
	<table background="./image/bg_575x84.gif" width="575" height="84">
		<tr>
			<td align="center">
				<table style="font-size: 10pt; font-family: 돋움" cellpadding="3">
					<tr>
						<td><input type="text" style="width: 300; height: 22;">
							<img alt="" src="./image/btn_search.gif" align="top" /></td>
					</tr>
					<tr>
						<td align="center">
							<input type="radio" name="r1" checked="checked"><b>카페명</b>
							<input type="radio" name="r1"><b>게시물</b>
							<input	type="radio" name="r1"><b>매니저</b>
							
					
						</td>
					</tr>
				</table>
			</td>
		</tr>
	</table>

<hr color="blue" size="3"/>
<hr color="blue" size="3"/>

<h3>좋아하는 연예인</h3>
<input type = "checkbox">최유정
<input type = "checkbox">제니
<input type = "checkbox">홍진영
<input type = "checkbox">김세정

<hr color="blue" size="3"/>

<br>

<input type ="file" />
전화번호
<select>
	<option>선택</option>
	<option>010</option>
	<option>011</option>
	<option>016</option>
	<option>017</option>
</select>
-
<input type="text"  size="4"/>
- 
<input type="text"  size="4"/> 

<br>
<hr color="blue" size="3"/>
메모 : <br/>
<textarea rows="7" cols="20"></textarea>

<hr color="blue" size="3"/>
<br>
<input type="button" value = "확인" style="background-color: green; color: white; " width="300" />

</body>
</html>