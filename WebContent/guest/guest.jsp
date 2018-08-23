<%@page import="java.util.List"%>
<%@page import="util.MyUtil"%>
<%@page import="com.guest.GuestDAO"%>
<%@page import="util.DBConn"%>
<%@page import="java.sql.Connection"%>
<%@page import="com.guest.GuestDTO"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<% 
	request.setCharacterEncoding("UTF-8");
	
	String cp = request.getContextPath();
	
	Connection conn = DBConn.getConnection();
	GuestDAO dao = new GuestDAO(conn);
	
	MyUtil myUtil = new MyUtil();
	
	
	String pageNum = request.getParameter("pageNum");
	
	int currentPage = 1;
	
	// 처음 실행시 null
	if(pageNum != null){
		
		currentPage = Integer.parseInt(pageNum);
	}
	
	// 전체 데이터 개수 구하기
	int dataCount = dao.getDataCount();
	
	// 전체 데이터를 기준으로 총 페이지수 계산
	int numPerPage = 3;
	int totalPage = myUtil.getPageCount(numPerPage, dataCount);
	
	// 삭제가 되어 전체 페이지수보다 표시할 페이지수가 큰 경우 페이지조정
	if(currentPage > totalPage){
		currentPage = totalPage;
	}
	
	//데이터베이스에서 가져올 시작과 끝위치
	int start = (currentPage -1)* numPerPage +1;
	int end = (currentPage) * numPerPage;
	
	List<GuestDTO> lists =dao.getListData(start,end);
	
	//페이징 처리
	String listUrl = "guest.jsp";
		
	String pageIndexList = myUtil.pageIndexList(currentPage, totalPage, listUrl);
	
	
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<link rel= "stylesheet" href ="<%=cp%>/guest/data/style.css" type ="text/css"/>
<link rel= "stylesheet" href ="<%=cp%>/guest/data/list.css" type ="text/css"/>

<script type="text/javascript" >
function isValidEmail(email) {
	var format = /^((\w|[\-\.])+)@((\w|[\-\.])+)\.([A-Za-z]+)$/;
    if (email.search(format) != -1)
        return true; //올바른 포맷 형식
    return false;
}

String.prototype.trim = function() {
		var TRIM_PATTERN = /(^\s*)|(\s*$)/g;
		return this.replace(TRIM_PATTERN, "");
};

function sendIt() {
    f = document.myForm;
    str = f.name.value;
    str = str.trim();
    
    if(!str) {
        alert("이름을 입력하세요 !!!");
        f.name.focus();
        return;
    }
    f.name.value = str;

    str = f.email.value;
    str = str.trim();
    if(str) {
		if(!isValidEmail(str)) {
            alert("E-Mail을 정확히 입력하세요 !!!");
            f.email.focus();
            return;
		}
    }
    f.email.value = str;

    str = f.content.value;
    str = str.trim();
    if(!str) {
        alert("내용을 입력하세요 !!!");
        f.content.focus();
        return;
    }
     f.content.value = str;
    
    f.action="/study/guest/save.jsp?pageNum=<%=currentPage %>";
    f.submit();
}

</script>

<script type="text/javascript">


</script>
</head>
<body>

<div id="bbs">
	<div id="bbs_title">
	방 명 록(JDBC 사용)
	</div>

	<form name="myForm" method="post" action="">
	<div id="bbsCreated">
		<div class="bbsCreated_bottomLine">
			<dl>
				<dt>작&nbsp;성&nbsp;자</dt>
				<dd>
				      <input type="text" name="name" size="35" maxlength="100"  class="boxTF" />
				</dd>
			</dl>
		</div>

		<div class="bbsCreated_bottomLine">
			<dl>
				<dt>E-Mail</dt>
				<dd>
				      <input type="text" name="email" size="35" maxlength="50" class="boxTF" />
				</dd>
			</dl>
		</div>
		<div class="bbsCreated_bottomLine">
			<dl>
				<dt>홈페이지</dt>
				<dd>
				      <input type="text" name="homepage" value ="http://" size="35" maxlength="50" class="boxTF" />&nbsp;
				</dd>
			</dl>
		</div>
		<div id="bbsCreated_content">
			<dl>
				<dt>내&nbsp;&nbsp;&nbsp;용</dt>
				<dd>
				      <textarea name="content" cols="63" rows="12" class="boxTA"></textarea>
				</dd>
			</dl>
		</div>

	
	</div>

	<div id="bbsCreated_footer">
<%-- 		<input type="hidden" name ="pageNum" value = <%=currentPage %> /> --%>
        <input type="button" value=" 등록하기 " class="btn2" onclick="sendIt();"/>
        <input type="reset" value=" 다시입력 " class="btn2" onclick="document.myForm.name.focus();"/>    
	</div>
	</form>
   
</div>

<div align="center">
	<form action="" name ="myForm2">
	<div id="bbsList_list" style="width: 600px ; ">		
		<% for(GuestDTO dto : lists){ %>
		<div id="title">
			<dl>
				<dd>No <%=dto.getNum() %>.</dd>
				<dd> <%=dto.getName() %></dd>
				<dd> ( <%=dto.getEmail() %> ) </dd>
			</dl>
		</div>
			<dl>		
				<dd>작성일 : <%=dto.getDate() %></dd>
				<dd> ( <%=dto.getIpAddr() %> ) </dd>

				
				<dd style="margin-left: 350px;">
				
				<input type="button" name="delete" value="삭제" align="right" onclick="javascript:location.href='<%=cp%>/guest/delete.jsp?num=<%=dto.getNum()%>&pageNum=<%=currentPage%>'"/>
				
				</dd>
			</dl>
			<br/><br/>
			<dl>
				<dd><%=dto.getContent().replaceAll("\n", "<br/>") %></dd>
			</dl>
			
			<br/><br/>
		<% } %>
	
		<div id="footer">
			<p>
				<%if(dataCount != 0){ %>
				<%=pageIndexList %>
				<%} else{ %>
				등록된 게시물이 없습니다.
				<%} %>
			</p>
		</div>
	</div>
	 </form>
</div>



</body>
</html>