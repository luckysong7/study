<%@page import="com.naver.NaverDTO"%>
<%@page import="java.util.List"%>
<%@page import="util.DBConn"%>
<%@page import="com.naver.NaverDAO"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<% 
	request.setCharacterEncoding("UTF-8");
	
	String cp = request.getContextPath();
	
	NaverDAO dao = new NaverDAO(DBConn.getConnection());
	
	List<NaverDTO> lists = dao.getList();
	
	DBConn.close();
	
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>

	<table width="1450" cellpadding="0" cellspacing="3" align="center" bgcolor="#e4e4e4">
		<tr height="50">
			<td bgcolor="#ffffff" style="padding-left: 10px;"><b>네이버 회원정보 리스트</b></td>
		</tr>
	</table>

<br/>
	<table width="1450" cellpadding="0" cellspacing="3" align="center">
		<tr>
			<td align="right"><input type="button" class="btn" value="등록하기"
				onclick="javascript:location.href ='<%=cp%>/register/register.jsp';" /></td>
		</tr>
	</table>
	<br/>
	<table width="1450" cellpadding="0" cellspacing="1" align="center"
		bgcolor="#cccccc">
		<tr height="30">
			<td align="center" bgcolor="#e6e6e6" width="80">이&nbsp;&nbsp;름</td>

			<td align="center" bgcolor="#e6e6e6" width="150">아이디</td>

			<td align="center" bgcolor="#e6e6e6" width="60">별&nbsp;&nbsp;명</td>

			<td align="center" bgcolor="#e6e6e6" width="80">비밀번호</td>

			<td align="center" bgcolor="#e6e6e6" width="250">질&nbsp;&nbsp;문</td>

			<td align="center" bgcolor="#e6e6e6" width="100">답&nbsp;&nbsp;변</td>

			<td align="center" bgcolor="#e6e6e6" width="180">이메일&nbsp;주소</td>

			<td align="center" bgcolor="#e6e6e6" width="180">핸드폰&nbsp;번호</td>

			<td align="center" bgcolor="#e6e6e6" width="70">동의여부</td>
			
			<td align="center" bgcolor="#e6e6e6" width="100">수&nbsp;&nbsp;&nbsp;정</td>
		</tr>
		
		<%
			for(NaverDTO dto : lists){
		%>
		
		<tr height="30">
			<td height="30" align="center" bgcolor="#ffffff"> <%=dto.getName() %> </td>
			<td height="30" align="center" bgcolor="#ffffff"> <%=dto.getId() %>@naver.com </td>
			<td height="30" align="center" bgcolor="#ffffff"> <%=dto.getNickname() %> </td>
			<td height="30" align="center" bgcolor="#ffffff"> <%=dto.getPw1() %> </td>
			<td height="30" align="center" bgcolor="#ffffff"> 
			<%if(dto.getQuestion().equals("직접입력")){ %>
			<%=dto.getQuestion2() %>
			<%} else{%>
			<%=dto.getQuestion() %>
			<%} %>
			</td>
			<td height="30" align="center" bgcolor="#ffffff"> <%=dto.getAns() %> </td>
			<td height="30" align="center" bgcolor="#ffffff"> <%=dto.getEmail() %>@<%=dto.getEmail2() %> </td>
			<td height="30" align="center" bgcolor="#ffffff"> <%=dto.getTel() %> - <%=dto.getTel1() %> - <%=dto.getTel2() %> </td>
			<td height="30" align="center" bgcolor="#ffffff"> <%=dto.getAgreecheck() %> </td>
			<td height="30" align="center" bgcolor="#ffffff">
				<a href="<%=cp%>/register/update.jsp?id=<%=dto.getId() %>"> 수정</a> 
				<a href="<%=cp%>/register/delete_ok.jsp?id=<%=dto.getId() %>"> 삭제</a>
			</td>
		
		</tr>
		<%
			}
		%>

	</table>
</body>
</html>