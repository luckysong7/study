<%@page import="com.naver.NaverDTO"%>
<%@page import="com.naver.NaverDAO"%>
<%@page import="util.DBConn"%>
<%@page import="java.sql.Connection"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<% 
	request.setCharacterEncoding("UTF-8");
	
	String cp = request.getContextPath();
	
	String id = request.getParameter("id");
	
	Connection conn =DBConn.getConnection();
	
	NaverDAO dao = new NaverDAO(conn);
	
	NaverDTO dto = dao.getReadData(id);

	DBConn.close();

	if(dto == null){
		response.sendRedirect("membership.jsp");
	}
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>정보 수정 화면</title>
<style type="text/css">
td.td1 {
	background-color: #EAEAEA;
	width: 140pt;
	height: 40pt;
	text-align: left;
}

td.td2 {
	width: 340pt;
	height: 40pt;
}
</style>
<script type="text/javascript">

	function fOpen1() {
		window.open("securityInfo.jsp", "newindow",
				"width = 900, height = 700", "status = yes");
	}
	function fOpen2() {
		window.open("pwInfo.jsp", "newindow", "width = 500, height = 300",
				"status = yes");
	}

	function sendIt() {

		var f = document.myForm;

		
		if (!f.pw1.value) {
			alert("비밀번호를 입력하세요 !");
			f.pw1.focus();
			return;
		}
		if (!f.pw2.value) {
			alert("비밀번호를 입력하세요 !");
			f.pw2.focus();
			return;
		}
		if (f.pw1.value != f.pw2.value) {
			alert("비밀번호가 일치하지 않습니다 !");
			f.pw2.focus();
			return;
		}

		if (!f.tel1.value) {
			alert("번호를 입력하세요 !");
			f.tel1.focus();
			return;
		}
		if (!f.tel2.value) {
			alert("번호를 입력하세요 !");
			f.tel2.focus();
			return;
		}
		if (!f.ans.value) {
			alert("답변을 입력하세요 !");
			f.ans.focus();
			return;
		}
		if (!f.email.value) {
			alert("이메일을 입력하세요 !");
			f.email.focus();
			return;
		}

		if (!f.email2.value) {
			alert("이메일을 입력하세요 !");
			f.email2.focus();
			return;
		}

		f.action = "<%=cp%>/register/update_ok.jsp";
		f.submit();

	}



	function emailCheck() { // 이메일 체크 
		var f = document.myForm;

		var clength = f.sel1.options.length;

		var cvalue = f.sel1.selectedIndex;

		f.email2.value = "";

		if (cvalue == (clength - 1)) {
			f.email2.readOnly = false;
		} else {
			f.email2.value = f.sel1.options[cvalue].value;
			f.email2.readOnly = true;
		}
	}

	function makeQuestion() { // 질문 직접 선택 
		var f = document.myForm;

		var clength2 = f.question.options.length;

		var cvalue2 = f.question.selectedIndex;
		
		if (cvalue2 == (clength2 - 1)) {
			f.question2.readOnly = false;
			 
			f.question2.value = "";
			
			f.question2.focus();
		
		}else {
			f.question2.readOnly = true;
		}
	}
</script>
</head>
<body>

	<h2>회원정보입력</h2>

	<hr color="#6799FF" size="3" width="10%" align="left" />
	<hr color="gray" size="2" align="right" />
	회원정보는 개인정보취급방침에 따라 안전하게 보호되며 회원님의 명백한 동의 없이 공개 또는 제3자에게 제공되지 않습니다.
	<a href="javascript:fOpen1();"><span style="color: blue"><u>개인정보취급방침</u></span></a>
	<br />
	<br />
	<table width="100" cellpadding="0" cellspacing="3" align="center">
		<tr>
			<td align="right"><input type="button" class="btn" value="돌아가기"
				onclick="javascript:location.href ='<%=cp%>/register/membership.jsp';" /></td>
		</tr>
	</table>
	<br/>
	<form name="myForm" method="post">
		<table width="1000" border="2" bordercolor="#EAEAEA"
			style="border-width: 1px;" cellpadding="1" cellspacing="0">
			<tr>
				<td class="td1"><img alt="" src="../html1/image/checkImg.PNG">&nbsp;&nbsp;<b>이름</b></td>
				<td class="td2"><%=dto.getName() %></td>
			</tr>

			<tr>
				<td class="td1"><img alt="" src="../html1/image/checkImg.PNG">&nbsp;&nbsp;<b>아이디</b></td>
				<td class="td2"><%=dto.getId() %> @naver.com <input
					type="button" value="중복확인" /><br /> <span
					style="font-size: 8pt; color: #D5D5D5">입력하신 아이디로 네이버 이메일 주소가
						생성됩니다.</span></td>
			</tr>

			<tr>
				<td class="td1"><img alt="" src="../html1/image/checkImg.PNG">&nbsp;&nbsp;<b>별명</b></td>
				<td class="td2"><input type="text" name="nickname" /></td>
			</tr>

			<tr>
				<td class="td1"><img alt="" src="../html1/image/checkImg.PNG">&nbsp;&nbsp;<b>비밀번호</b></td>
				<td class="td2"><input type="password" name="pw1" /> <a
					href="javascript:fOpen2();"><span style="color: blue"><u>비밀번호
								도움말</u></span></a></td>
			</tr>

			<tr>
				<td class="td1"><img alt="" src="../html1/image/checkImg.PNG">&nbsp;&nbsp;<b>비밀번호
						확인</b></td>
				<td class="td2"><input type="password" name="pw2" /></td>
			</tr>

			<tr>
				<td class="td1"><img alt="" src="../html1/image/checkImg.PNG">&nbsp;&nbsp;<b>비밀번호
						발급수단</b></td>
				<td height="230" class="td2"><span style="color: orange">아래
						항목은 아이디 확인, 임시비밀번호 발급시 반드시 필요한 정보입니다.<br />정확한 정보를 입력한 후 꼭 기억해
						주세요.
				</span>
					<div style="background-color: #EAEAEA; height: 190">
						&nbsp;&nbsp;<b>1.비밀번호 질문ㆍ답</b><br /> &nbsp;&nbsp;질문 
						<select style = "width: 500pt;" name="question" onchange="makeQuestion();">
							<option value ="선택하세요">선택하세요</option>
							<option value ="가장 기억에 남는 장소는 ?">가장 기억에 남는 장소는?</option>
							<option value ="가장 소중한 물건은 ?">가장 소중한 물건은?</option>
							<option value ="강아지/고양이의 이름은 ?">키우는 강아지또는 고양이의 이름은?</option>
							<option value ="직접입력">직접입력</option>
						</select>
						<br />
						 &nbsp;&nbsp;<input type="text" style="width: 530pt"
							value="질문에서 직접입력을 선택하면 가입 가능합니다." readonly="readonly"
							name="question2"><br /> &nbsp;&nbsp;답변 <input
							type="text" name= "ans"> <br /> &nbsp;&nbsp;<b>2.이메일 주소</b><br />
						&nbsp;&nbsp;<input type="text" name="email" /> @ <input
							type="text" name="email2" readonly="readonly" /> 
							<select
							name="sel1" onchange="emailCheck();">
							<option>선택하세요</option>
							<option value="naver.com">naver.com</option>
							<option value="google.com">google.com</option>
							<option value="daum.net">daum.net</option>
							<option value="">직접입력</option>
						</select>
						 <input type="checkbox"> 등록안함 <br /> &nbsp;&nbsp;<b>3.휴대폰
							번호</b><br /> &nbsp;&nbsp;<select style="height: 16pt;" name="tel">
							<option>선택</option>
							<option>010</option>
							<option>011</option>
							<option>017</option>
						</select> - <input type="text" name="tel1"> - <input type="text"
							name="tel2"> <input type="checkbox" name = "agreecheckbox" value ="등록"> 등록안함 <br />
						<br />

					</div></td>
			</tr>

			<tr>
				<td class="td1"><img alt="" src="../html1/image/checkImg.PNG">&nbsp;&nbsp;<b>소식지
						수신</b></td>
				<td class="td2"><input type="checkbox" name="agreecheck"
					value="동의"> 네이버 메일로 네이버 소식지를 수신합니다. <br /></td>
			</tr>

		</table>

		<br /> <br />
		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		<input type = "hidden" name = "id" value = "<%=dto.getId() %>" />
		<input type="button" value = "수정완료" onclick = "sendIt();"/> 
		<input type="button" value = "수정취소" onclick = "javascript:location.href='<%=cp%>/register/membership.jsp';"/> 
		
	</form>
</body>
</html>