<%@page import="com.naver.NaverDAO"%>
<%@page import="util.DBConn"%>
<%@page import="java.sql.Connection"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<% 
	request.setCharacterEncoding("UTF-8");

// 	String name = request.getParameter("name"); // 이름 파라미터값으로 받아오기 
// 	String id = request.getParameter("id"); // 아이디 받아오기
// 	String id2 = id+"@naver.com";
// 	String nickname = request.getParameter("nickname");
// 	String pw1 = request.getParameter("pw1");
// 	String question = request.getParameter("question");
// 	String question2 = request.getParameter("question2");
// 	String ans = request.getParameter("ans");
// 	String email = request.getParameter("email");
// 	String email1 = request.getParameter("email1");
// 	String email2 = email +"@" + email1;
// 	String tel = request.getParameter("tel");
// 	String tel1 = request.getParameter("tel1");
// 	String tel2 = request.getParameter("tel2");
// 	String phone = tel+"-"+tel1+"-"+tel2; 
// 	String agreecheckbox = request.getParameter("agreecheckbox");
// 	if(question.equals("직접입력")){
// 		question = question2;
// 	}
// 	if(agreecheckbox == null){
// 		agreecheckbox = "거부";
// 	}
%>

<jsp:useBean id="dto" class = "com.naver.NaverDTO"></jsp:useBean>
<jsp:setProperty property="*" name="dto"/>

<% 
	
	Connection conn = DBConn.getConnection();
	
	NaverDAO dao = new NaverDAO(conn);
	
	int result = dao.insertData(dto);
	
	DBConn.close();
	if(result != 0 ){
		response.sendRedirect("membership.jsp");
	}
		
%>

입력오류입니다 !!
