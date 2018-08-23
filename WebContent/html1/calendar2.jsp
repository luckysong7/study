<%@page import="java.util.Calendar"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<%
	
	request.setCharacterEncoding("UTF-8");

	
	Calendar cal = Calendar.getInstance();
	
	//오늘 날짜 
	int nowYear = cal.get(Calendar.YEAR);
	int nowMonth = cal.get(Calendar.MONTH)+1;
	int nowDay = cal.get(Calendar.DAY_OF_MONTH);
	
	//클라이언트에서 넘어온 데이터를 받을때
	String strYear = request.getParameter("year");
	String strMonth = request.getParameter("month");
	
	//표시할 달력에 년,월
	int year = nowYear;
	int month = nowMonth;
	
	if(strYear!=null)
		year = Integer.parseInt(strYear);//클라이언트가 선택한 년도
		
	if(strMonth!=null)
		month = Integer.parseInt(strMonth);//클라이언트가 선택한 월
		//년도가 12보다 크면 년도에 +1 년도가 1보다 작아지면 년도에-1을 해준다.그리고 월은 1이나 12로 바꿔줘야한다
		
	cal.set(year,month-1,1); //출력할 년도 월

	year = cal.get(Calendar.YEAR);
	month = cal.get(Calendar.MONTH)+1;
	
	int startDay = 1;
	int endDay = cal.getActualMaximum(Calendar.DAY_OF_MONTH);
	
	int week = cal.get(Calendar.DAY_OF_WEEK);
	
	


%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<style type="text/css">

	body{
	font-size: 12pt;
		
	}
	td{
	font-size: 12pt;
	}

	</style>

	<script type="text/javascript">
	   function sendIt()
       {
           var f = document.myForm;
           f.submit();
       }

	</script>

</head>
<body>
<br/><br/>

<table align="center"width="210"cellpadding="2"cellspacing="1">

	<tr>
		<td align="center">
			<form action="calendar2.jsp" method="get" name="myForm">
				<select name="year" onchange="sendIt()">
                                    <%for(int i=year-5; i<year; i++) { %>
                                        <option value="<%=i%>" > <%=i%>년</option>
                                    <%} %>
                                    <option value="<%=year%>" selected="selected"><%=year%>년</option>
                                    <%for(int i=year+1; i<year+5; i++) { %>
                                        <option value="<%=i%>" > <%=i%>년</option>
                                    <%} %>
        
                            </select>
                            
                            <select name="month" onchange="sendIt()">
                                <% for(int i=1; i<=12; i++) {%>
                                    <option value="<%=i%>" <%=month==i?"selected='selected'":"" %>> <%=i%>월 </option>
                                <%} %>
                            </select>	
			
			
			</form>
		</td>
	</tr>
</table>

<table align="center" width="210" cellpadding="0"
cellspacing="1"bgcolor="#cccccc">

	<tr>
		<td bgcolor="#e6e4e6"align="center"><font color="red">일</font></td>
		<td bgcolor="#e6e4e6"align="center">월</td>
		<td bgcolor="#e6e4e6"align="center">화</td>
		<td bgcolor="#e6e4e6"align="center">수</td>
		<td bgcolor="#e6e4e6"align="center">목</td>
		<td bgcolor="#e6e4e6"align="center">금</td>
		<td bgcolor="#e6e4e6"align="center"><font color="blue">토</font></td>
	</tr>
<%

	int newLine = 0;
	out.print("<tr height='20'>");
	for(int i=1;i<week;i++){
		out.print("<td bgcolor='#ffffff'>&nbsp</td>");
		newLine++; //넣을때마다 하나식 라인을 올려라
		}
	for(int i=startDay;i<=endDay;i++){
		
		String fontColor = (newLine==0)?"red":
			(newLine==6)?"blue":"black";//삼항연산자 :뉴라인이 0이면 레드 그렇지 않으면 6이면 블루 그렇지 않으면 블랙
			
		String bgColor = (nowYear==year)&&(nowMonth==month)&&(nowDay==i)?"#e6e4e6":"#ffffff";
		//나우이어가 이어가나 나우먼스가 먼스거나 나우데이가 i이면 색을 표시하고 아니면 화이트로
		out.print("<td align='center' bgcolor='"+bgColor+"'><font color='" +fontColor +"'>"+i+ "</font></td>");		
		//<td align ='center' bgcolor='#ffffff'>
		//<font color='red'>26</font></td> 이게 위에 코딩이다.
		
		
		newLine++;
		
		
		//줄바꿈
		if(newLine==7&&i!=endDay){
			out.print("</tr><tr height='20'>");
			newLine=0;
		}
		
	}
	while(newLine>0&&newLine<7){
		
		out.print("<td bgcolor='#ffffff'>&nbsp;</td>");
		newLine++;
		
	}
	out.print("</tr>");







%>	
	
	
	
	
</table>











</body>
</html>