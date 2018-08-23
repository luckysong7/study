<%@page import="com.score.ScoreDTO"%>
<%@page import="com.score.ScoreDAO"%>
<%@page import="util.DBConn"%>
<%@page import="java.sql.Connection"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<% 
	request.setCharacterEncoding("UTF-8");

	String cp = request.getContextPath();

%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>성적처리 수정화면</title>

<script type="text/javascript">

	function sendIt(){
		
		var f = document.myForm;
		
		if(!f.kor.value){
			alert("국어성적을 입력해 주세요 !");
			f.kor.focus();
			return;
		}
		if(!f.eng.value){
			alert("영어성적을 입력해 주세요 !");
			f.eng.focus();
			return;
		}
		if(!f.mat.value){
			alert("수학성적을 입력해 주세요 !");
			f.mat.focus();
			return;
		}
		
		// http://192.168.16.26:8080/study/score/write_ok.jsp
		// study 까지 생략되어 있음 
		f.action = "<%=cp%>/sscore/update_ok.do" ; 
		f.submit();

	}

</script>


<style type="text/css">

	*{
		padding : 0px;
		margin : px;
		
		
	}
	
	body{
		font-size : 9pt;
		
	}
	
	td{
		font-size : 9pt;
	}

	.txtField{
		font-size : 1px solid;
	}
	
	.btn{
		font-size: 9pt;
		background: #e6e6e6;
	}

</style>

</head>
<body>


<br/><br/>

<form  name = "myForm" method="post" >
	
	<table width="500" cellpadding="0" cellspacing="3" align ="center" bgcolor="#e4e4e4">
		<tr height = "50" >
			<td bgcolor="#ffffff" style = "padding-left: 10px;">
				<b>성적처리 수정화면</b>
		</tr>
	
	
	</table>
	
<br/>
	
	
	<table width="500" cellpadding="0" cellspacing="0" align="center">
			<tr height="2">
				<td colspan="2" bgcolor="#cccccc">
				
				</td>
			</tr>
			
			<tr height="30">
				<td align="center" width="100" bgcolor="#e6e6e6">
					<b>학번</b> 
				</td>
				
				<td style ="padding-left: 5px;"> 
					${dto.hak }
				</td>
			</tr>
			
			<tr height="2">
				<td colspan="2" bgcolor="#cccccc">
				
				</td>
			</tr>
			
			<tr height="30">
				<td align="center" width="100" bgcolor="#e6e6e6">
					<b>이름</b> 
				</td>
				
				<td style ="padding-left: 5px;"> 
					${dto.name }
				</td>
			</tr>
			
			<tr height="2">
				<td colspan="2" bgcolor="#cccccc">
				
				</td>
			</tr>
			
			<tr height="30">
				<td align="center" width="100" bgcolor="#e6e6e6">
					<b>국어</b> 
				</td>
				
				<td style ="padding-left: 5px;"> 
					<input type="text" name = "kor" value = "${dto.kor }" size ="20" maxlength="3" class ="txtField">
				</td>
			</tr>
			
			<tr height="2">
				<td colspan="2" bgcolor="#cccccc">
				
				</td>
			</tr>
			
			<tr height="30">
				<td align="center" width="100" bgcolor="#e6e6e6">
					<b>영어</b> 
				</td>
				
				<td style ="padding-left: 5px;"> 
					<input type="text" name = "eng" value = "${dto.eng }"  size ="20" maxlength="3" class ="txtField">
				</td>
			</tr>
			
			<tr height="2">
				<td colspan="2" bgcolor="#cccccc">
				
				</td>
			</tr>
			
			<tr height="30">
				<td align="center" width="100" bgcolor="#e6e6e6">
					<b>수학</b> 
				</td>
				
				<td style ="padding-left: 5px;"> 
					<input type="text" name = "mat"  value = "${dto.mat }" size ="20" maxlength="3" class ="txtField">
				</td>
			</tr>
			
			<tr height="2">
				<td colspan="2" bgcolor="#cccccc">
				
				</td>
			</tr>
		
			<tr heigth = "35">
				<td align="center" colspan="2">
						<input type="hidden" name = "hak" value ="${dto.hak }" />
						<input type ="button" class="btn" value ="수정완료" onclick="sendIt();" />
						<input type ="button" class = "btn" value ="수정취소" onclick="javascript:location.href='<%=cp%>/sscore/list.do';"/>
				</td>
			</tr>
			
			

		</table>

</form>
	




</body>
</html>