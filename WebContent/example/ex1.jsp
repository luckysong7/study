<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix ="c" uri="http://java.sun.com/jsp/jstl/core" %>
<% 
	request.setCharacterEncoding("UTF-8");
	
	String cp = request.getContextPath();
	
	
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<style type="text/css">
	.checkbox-wrap{
		cursor: pointer;
	
	}
	.checkbox-wrap .check-icon {
		display: inline-block;
		width: 18px;
	 	height: 18px; 
	 	background: url(./image/normalSeat.PNG) left center no-repeat; 
	 	vertical-align: middle; 
	 	transition-duration: .3s; 
	 }
	.checkbox-wrap input[type=checkbox] { 
		display: none; 
	 }
	.checkbox-wrap input[type=checkbox]:checked + .check-icon {
	    background-image: url(./image/noSeat.PNG);
	 }
	
	

</style>

</head>
<body>

<label class="checkbox-wrap">
	<input type="checkbox" name="transportation[]" value="자가용"><i class="check-icon"></i> 자가용
</label>
<label class="checkbox-wrap">
	<input type="checkbox" name="transportation[]" value="대중교통"><i class="check-icon"></i> 대중교통
</label>
<label class="checkbox-wrap">
	<input type="checkbox" name="transportation[]" value="도보"><i class="check-icon"></i> 도보
</label>




</body>
</html>