<%@page import="java.net.URLEncoder"%>
<%@page import="java.net.URLDecoder"%>
<%@page import="com.board.BoardDTO"%>
<%@page import="com.board.BoardDAO"%>
<%@page import="util.DBConn"%>
<%@page import="java.sql.Connection"%>
<%@ page contentType="text/html; charset=UTF-8"%>

<%
	request.setCharacterEncoding("utf-8");
	String cp = request.getContextPath();
	
	Connection conn = DBConn.getConnection();
	
	BoardDAO dao = new BoardDAO(conn);
	
	int num = Integer.parseInt(request.getParameter("num"));
	String pageNum = request.getParameter("pageNum");
	
	String searchKey = request.getParameter("searchKey");
	String searchValue = request.getParameter("searchValue");
	
	
	//기본값처리
	if(searchKey!= null){
		if(request.getMethod().equalsIgnoreCase("GET")){
			searchValue = URLDecoder.decode(searchValue, "UTF-8");
		}
	}else{
		searchKey="subject";
		searchValue ="";
	}
	
	
	
	
	// 조회수 증가
	dao.updateHitCount(num);
		
	//글 가져오기 (한개의 게시물에 대한 정보 담겨있음)
	BoardDTO dto = dao.getReadData(num);
	
	if(dto == null){
		response.sendRedirect("list.jsp");
		
	}
	

	// 글 라인 수 
	
	int lineSu = dto.getContent().split("\n").length;
	
	//엔터(/n)를 <br/> 로 변경
	dto.setContent(dto.getContent().replaceAll("\n", "<br/>"));
	
	DBConn.close();
	
	//검색 ---------------------------------
	String param = "";
	if(searchValue != null || !searchValue.equals("")){
		param ="&searchKey="+searchKey;
		param +="&searchValue=" + URLEncoder.encode(searchValue,"UTF-8");
		
	}
	
	
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>게 시 판</title>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>

<link rel="stylesheet" href="<%=cp%>/board/css/style.css" type="text/css"/>
<link rel="stylesheet" href="<%=cp%>/board/css/article.css" type="text/css"/>

</head>

<body>

<div id="bbs">
	<div id="bbs_title">
	게 시 판
	</div>
	<div id="bbsArticle">
		<div id="bbsArticle_header">
			<%=dto.getSubject() %>
		</div>
		<div class="bbsArticle_bottomLine">
			<dl>
				<dt>작성자</dt>
				<dd><%=dto.getName() %></dd>
				<dt>줄수</dt>
				<dd><%=lineSu %></dd>
			</dl>
		</div>
		<div class="bbsArticle_bottomLine">
			<dl>
				<dt>등록일</dt>
				<dd><%=dto.getCreated() %></dd>
				<dt>조회수</dt>
				<dd><%=dto.getHitCount() %></dd>
			</dl>
		</div>
		<div id="bbsArticle_content">
			<table width="600" border="0">
			<tr><td style="padding: 20px 80px 20px 62px;" valign="top" height="200">
			<%=dto.getContent() %>
			</td></tr>
			</table>
		</div>
		
	</div>
	<div class="bbsArticle_noLine" style="text-align:right">
		    <%=dto.getIpAddr() %>
	</div>
	<div id="bbsArticle_footer">
		<div id="leftFooter">
		<input type="hidden" name ="param" value ="<%=param %>" />
               <input type="button" value=" 수정 " class="btn2" 
               onclick="javascript:location.href='<%=cp%>/board/update.jsp?num=<%=num%>&pageNum=<%=pageNum%><%=param%>'"/>
               <input type="button" value=" 삭제 " class="btn2" 
               onclick="javascript:location.href='<%=cp%>/board/delete_ok.jsp?num=<%=num%>&pageNum=<%=pageNum%><%=param%>'"/>
		</div>
		<div id="rightFooter">
               <input type="button" value=" 리스트 " class="btn2" onclick="javascript:location.href ='<%=cp%>/board/list.jsp?pageNum=<%=pageNum%><%=param%>';"/>
		</div>
	</div>

</div>

<br/>&nbsp;<br/>
</body>

</html>