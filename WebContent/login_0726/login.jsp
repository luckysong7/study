<%@ page contentType="text/html; charset=UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8");

	String userId = (String) session.getAttribute("userId");
	
// 	session.setMaxInactiveInterval(5);
	session.setMaxInactiveInterval(20*60); // 20분
	
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>

<script type="text/javascript">
	function sendIt() {
		var f = document.myForm;
		if (!f.userId.value) {
			alert("아이디를 입력하세요 !");
			f.userId.focus();
			return;
		}
		if (!f.userPwd.value) {
			alert("패스워드를 입력하세요 !");
			f.userPwd.focus();
			return;
		}

		f.submit();

	}
</script>

<style>
body.table{
	font-size: 12pt;
}

table.td {
	font-size: 12pt;
}
</style>
</head>
<body style="font-size: 9pt;">

	<table border="1" width="600" align="center" style="font-size: 9pt;">
		<tr height="20">
			<td colspan="2" align="right">|게시판|
			
			<% if(userId == null){ %>
			일정관리
			<%} else {%>
			<a href="schedule.jsp">일정관리</a>
			<%} %>
			</td>
		</tr>

		<tr height="400">
			<td width="100" valign="top">
				<% if(userId == null){ %>
				<form action="login_ok.jsp" method="post" name="myForm">

					아이디 : <input type="text" name="userId" size="10" /><br /> 
					패스워드 : <input type="password" name="userPwd" size="10" /><br /> 
					<input type="button" value="로그인" onclick="sendIt()" />
				</form>
				<%} else{ %>
					<%=userId %> 님 하이 ^^ <br/><br/>
					<a href = "logout.jsp">로그아웃</a>
				<%} %>
			</td>
			
			<td valign="middle" align="center">
				<% if(userId ==null){ %>
					<b> 로그인하면 새로운 세상이 보입니다 !!</b>		
				<%} else{ %>
				
<%@page import="java.util.Calendar"%>

<%

	Calendar cal = Calendar.getInstance();

	// 오늘날짜
	int nowYear = cal.get(Calendar.YEAR);
	int nowMonth = cal.get(Calendar.MONTH) + 1;
	int nowDay = cal.get(Calendar.DAY_OF_MONTH);

	// 클라이언트에서 넘어온 데이터
	String strYear = request.getParameter("year");
	String strMonth = request.getParameter("month");
	

	
	//표시할 달력의 년과 월
	int year = nowYear;
	int month = nowMonth;

	if (strYear != null) {
		year = Integer.parseInt(strYear); // 클라이언트가 선택한 연도
	}

	if (strMonth != null) {
		month = Integer.parseInt(strMonth); // 클라이언트가 선택한 월
	}

	int preYear = year;
	int preMonth = month - 1;

	if (preMonth < 1) {
		preYear = year - 1;
		preMonth = 12;
	}
	int nextYear = year;
	int nextMonth = month + 1;
	if (nextMonth > 12) {
		nextYear = year + 1;
		nextMonth = 1;
	}

	//표시할 달력 세팅
	cal.set(year, month - 1, 1);
	int startDay = 1;
	int endDay = cal.getActualMaximum(Calendar.DAY_OF_MONTH);

	int week = cal.get(Calendar.DAY_OF_WEEK);
%>
<script type="text/javascript">
	function changed() {

		var f = document.myForm;

		var length1 = f.year.options.length;

		var cvalue1 = f.year.selectedIndex;

		year = f.year.options[cvalue1].value;
		
		var length = f.month.options.length;

		var cvalue = f.month.selectedIndex;

		month = f.month.options[cvalue].value;

		f.action = "login.jsp?year=" + year + "&month=" + month;
		f.submit();

	}
</script>		
		<form name="myForm">
		<table align="center" width="210" cellpadding="1" cellspacing="1">
			<tr>
				<td align="center"><a
					href="login.jsp?year=<%=nowYear%>&month=<%=nowMonth%>">
						<img src="./image/img1.PNG" align="left">
				</a> <select name="year" onchange="changed();">

						<option value=<%=year - 5%>><%=year - 5%></option>
						<option value=<%=year - 4%>><%=year - 4%></option>
						<option value=<%=year - 3%>><%=year - 3%></option>
						<option value=<%=year - 2%>><%=year - 2%></option>
						<option value=<%=year - 1%>><%=year - 1%></option>
						<option value=<%=year%> selected="selected"><%=year%></option>
						<option value=<%=year + 1%>><%=year + 1%></option>
						<option value=<%=year + 2%>><%=year + 2%></option>
						<option value=<%=year + 3%>><%=year + 3%></option>
						<option value=<%=year + 4%>><%=year + 4%></option>
						<option value=<%=year + 5%>><%=year + 5%></option>
				</select> <b>년</b> <select name="month" onchange="changed();">
	<!-- 
<%-- 						<% --%>
// 							switch (month) {
// 							case 1:
<%-- 						%> --%>
						<option value="1" selected ="selected">1</option>
						<option value ="2" >2</option>
						<option value ="3" >3</option>
						<option value ="4" >4</option>
						<option value ="5" >5</option>
						<option value ="6" >6</option>
						<option value ="7" >7</option>
						<option value ="8" >8</option>
						<option value ="9" >9</option>
						<option value ="10" >10</option>
						<option value ="11" >11</option>
						<option value ="12" >12</option>
						
<%-- 						<%break; --%>
// 							case 2:
<%-- 						%> --%>
						<option value ="1" >1</option>
						<option value="2" selected ="selected">2</option>
						<option value ="3" >3</option>
						<option value ="4" >4</option>
						<option value ="5" >5</option>
						<option value ="6" >6</option>
						<option value ="7" >7</option>
						<option value ="8" >8</option>
						<option value ="9" >9</option>
						<option value ="10" >10</option>
						<option value ="11" >11</option>
						<option value ="12" >12</option>
						
<%-- 						<% break; --%>
// 							case 3:
<%-- 						%> --%>
						
						<option value ="1" >1</option>
						<option value ="2" >2</option>
						<option value="3" selected ="selected">3</option>	
						<option value ="4" >4</option>
						<option value ="5" >5</option>
						<option value ="6" >6</option>
						<option value ="7" >7</option>
						<option value ="8" >8</option>
						<option value ="9" >9</option>
						<option value ="10" >10</option>
						<option value ="11" >11</option>
						<option value ="12" >12</option>
<%-- 						<%break; --%>
// 							case 4:
<%-- 						%> --%>
						<option value ="1" >1</option>
						<option value ="2" >2</option>
						<option value ="3" >3</option>
						<option value="4" selected ="selected">4</option>
						<option value ="5" >5</option>
						<option value ="6" >6</option>
						<option value ="7" >7</option>
						<option value ="8" >8</option>
						<option value ="9" >9</option>
						<option value ="10" >10</option>
						<option value ="11" >11</option>
						<option value ="12" >12</option>
<%-- 						<%break; --%>
// 							case 5:
<%-- 						%> --%>
						<option value ="1" >1</option>
						<option value ="2" >2</option>
						<option value ="3" >3</option>
						<option value ="4" >4</option>
						<option value="5" selected ="selected">5</option>
						<option value ="6" >6</option>
						<option value ="7" >7</option>
						<option value ="8" >8</option>
						<option value ="9" >9</option>
						<option value ="10" >10</option>
						<option value ="11" >11</option>
						<option value ="12" >12</option>
<%-- 						<%break; --%>
// 							case 6:
<%-- 						%> --%>
						<option value ="1" >1</option>
						<option value ="2" >2</option>
						<option value ="3" >3</option>
						<option value ="4" >4</option>
						<option value ="5" >5</option>
						<option value="6" selected ="selected">6</option>
						<option value ="7" >7</option>
						<option value ="8" >8</option>
						<option value ="9" >9</option>
						<option value ="10" >10</option>
						<option value ="11" >11</option>
						<option value ="12" >12</option>
<%-- 						<%break; --%>
// 							case 7:
<%-- 						%> --%>
						<option value ="1" >1</option>
						<option value ="2" >2</option>
						<option value ="3" >3</option>
						<option value ="4" >4</option>
						<option value ="5" >5</option>
						<option value ="6" >6</option>
						<option value="7" selected ="selected">7</option>
						<option value ="8" >8</option>
						<option value ="9" >9</option>
						<option value ="10" >10</option>
						<option value ="11" >11</option>
						<option value ="12" >12</option>
<%-- 						<%break; --%>
// 							case 8:
<%-- 						%> --%>
						<option value ="1" >1</option>
						<option value ="2" >2</option>
						<option value ="3" >3</option>
						<option value ="4" >4</option>
						<option value ="5" >5</option>
						<option value ="6" >6</option>
						<option value ="7" >7</option>
						<option value="8" selected ="selected">8</option>
						<option value ="9" >9</option>
						<option value ="10" >10</option>
						<option value ="11" >11</option>
						<option value ="12" >12</option>
<%-- 						<%break; --%>
// 							case 9:
<%-- 						%> --%>
						<option value ="1" >1</option>
						<option value ="2" >2</option>
						<option value ="3" >3</option>
						<option value ="4" >4</option>
						<option value ="5" >5</option>
						<option value ="6" >6</option>
						<option value ="7" >7</option>
						<option value ="8" >8</option>
						<option value="9" selected ="selected">9</option>
						<option value ="10" >10</option>
						<option value ="11" >11</option>
						<option value ="12" >12</option>
<%-- 						<%break; --%>
// 							case 10:
<%-- 						%> --%>
						<option value ="1" >1</option>
						<option value ="2" >2</option>
						<option value ="3" >3</option>
						<option value ="4" >4</option>
						<option value ="5" >5</option>
						<option value ="6" >6</option>
						<option value ="7" >7</option>
						<option value ="8" >8</option>
						<option value ="9" >9</option>
						<option value="10" selected ="selected">10</option>
						<option value ="11" >11</option>
						<option value ="12" >12</option>
<%-- 						<%break; --%>
// 							case 11:
<%-- 						%> --%>

						<option value ="1" >1</option>
						<option value ="2" >2</option>
						<option value ="3" >3</option>
						<option value ="4" >4</option>
						<option value ="5" >5</option>
						<option value ="6" >6</option>
						<option value ="7" >7</option>
						<option value ="8" >8</option>
						<option value ="9" >9</option>
						<option value ="10" >10</option>
						<option value="11" selected ="selected">11</option>
						<option value ="12" >12</option>
<%-- 						<%break; --%>
// 							case 12:
<%-- 						%> --%>
						<option value ="1" >1</option>
						<option value ="2" >2</option>
						<option value ="3" >3</option>
						<option value ="4" >4</option>
						<option value ="5" >5</option>
						<option value ="6" >6</option>
						<option value ="7" >7</option>
						<option value ="8" >8</option>
						<option value ="9" >9</option>
						<option value ="10" >10</option>
						<option value ="11" >11</option>
						<option value="12" selected ="selected">12</option>
<%-- 						<% --%>
// 							}
<%-- 						%> --%>
 -->
 
 		<%
			for(int i = 1 ; i <= 12 ; i++){
				if(i == month){
		%>
					<option value = "<%=i %>"  selected="selected"> <%=i %> </option>
				<%} else {
				%>
					<option value= "<%=i %>" > <%=i %> </option>
				<%} 
				%>
		<%} 
		%>
				</select> <b>월</b></td>

			</tr>
		</table>

		<table align="center" width="210" cellpadding="0" cellspacing="1"
			bgcolor="#cccccc">

			<tr>

				<td bgcolor="#e6e4e6" align="center"><font color="red">일</font></td>
				<td bgcolor="#e6e4e6" align="center">월</td>
				<td bgcolor="#e6e4e6" align="center">화</td>
				<td bgcolor="#e6e4e6" align="center">수</td>
				<td bgcolor="#e6e4e6" align="center">목</td>
				<td bgcolor="#e6e4e6" align="center">금</td>
				<td bgcolor="#e6e4e6" align="center"><font color="blue">토</font></td>
			</tr>
			<%
				int newLine = 0;
				out.print("<tr height = '20'>");
				for (int i = 1; i < week; i++) {
					out.print("<td bgcolor ='#ffffff'>&nbsp;</td>");
					newLine++;

				}

				for (int i = startDay; i <= endDay; i++) {
					String fontColor = (newLine == 0) ? "red"
							: (newLine == 6) ? "blue" : "black";
					String bgColor = (nowYear == year) && (nowMonth == month)
							&& (nowDay == i) ? "#e6e4e6" : "ffffff";
					out.print("<td align = 'center' bgcolor='" + bgColor
							+ "'><font color = '" + fontColor + "'>" + i
							+ "</font></td>");

					newLine++;
					if (newLine == 7 && i != endDay) {
						out.print("<tr/><tr height = '20'>");
						newLine = 0;
					}

				}

				while (newLine > 0 && newLine < 7) {
					out.print("<td bgColor = '#ffffff'>&nbsp;</td>");
					newLine++;
				}
				out.print("</tr>");
			%>
			<tr>
				<td></td>
			</tr>

		</table>
	</form>	
					
					
				<%} %>
			
			</td>

		</tr>
	</table>

</body>
</html>