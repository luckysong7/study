package com.naver;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import util.DBConn;

public class NaverDAO {

	// DI (의존성 주입)
	private Connection conn;
	
	
	// 생성자 오버로딩
	public NaverDAO(Connection conn) {
		this.conn = conn;
		// TODO Auto-generated constructor stub
	}
	
	// 1. 입력(naver.jsp,naver_ok.jsp)
	
	public int insertData(NaverDTO dto){
		int result = 0 ;
		
		PreparedStatement pstmt = null;
		
		String sql;
		
		try {
			
			sql = "insert into naver(name, id, nickname, pw1, question, question2, ans, email, email2, tel, tel1, tel2, agreecheck) ";
			sql += "values(?,?,?,?,?,?,?,?,?,?,?,?,?)";
			
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setString(1, dto.getName());
			pstmt.setString(2, dto.getId());
			pstmt.setString(3, dto.getNickname());
			pstmt.setString(4, dto.getPw1());
			pstmt.setString(5, dto.getQuestion());
			pstmt.setString(6, dto.getQuestion2());			
			pstmt.setString(7, dto.getAns());
			pstmt.setString(8, dto.getEmail());
			pstmt.setString(9, dto.getEmail2());
			pstmt.setString(10, dto.getTel());
			pstmt.setString(11, dto.getTel1());
			pstmt.setString(12, dto.getTel2());
			pstmt.setString(13, dto.getAgreecheck());
			
			result = pstmt.executeUpdate();
			
			pstmt.close();
			
		} catch (Exception e) {
			try {pstmt.close();} catch (Exception e2) {}
			try {DBConn.close();} catch (Exception e2) {}
			System.out.println(e.toString());
		}
		
		return result;
		
	}
	
	// 2. 데이터 가져오기(Membership.jsp)
	public List<NaverDTO> getList(){
		List<NaverDTO> lists = new ArrayList<NaverDTO>();
		
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql ;
		
		try {
			sql = "select name, id, nickname, pw1, question, question2, ans, email, email2, tel, tel1, tel2, agreecheck from naver order by name";
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			
			while(rs.next()){
				NaverDTO dto = new NaverDTO();
				dto.setName(rs.getString("name"));
				dto.setId(rs.getString("id"));
				dto.setNickname(rs.getString("nickname"));
				dto.setPw1(rs.getString("pw1"));
				dto.setQuestion(rs.getString("question"));
				dto.setQuestion2(rs.getString("question2"));
				dto.setAns(rs.getString("ans"));
				dto.setEmail(rs.getString("email"));
				dto.setEmail2(rs.getString("email2"));
				dto.setTel(rs.getString("tel"));
				dto.setTel1(rs.getString("tel1"));
				dto.setTel2(rs.getString("tel2"));
				dto.setAgreecheck(rs.getString("agreecheck"));
				
				lists.add(dto);
				
			}
			
			pstmt.close();
			rs.close();
			
		} catch (Exception e) {
			System.out.println(e.toString());
		}
		
		return lists;
	}
	
	// 3. 수정할 데이터 가져오기
	public NaverDTO getReadData(String id){
		
		NaverDTO dto = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql;
	
		try {
			sql = "select name, id, nickname, pw1, question, question2"
					+ ", ans, email, email2, tel, tel1, tel2, agreecheck from naver "
					+ "where id = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, id);
			
			rs = pstmt.executeQuery();
			
			if(rs.next()){
				dto = new NaverDTO();
				dto.setName(rs.getString("name"));
				dto.setId(rs.getString("id"));
				
			}
			rs.close();
			pstmt.close();
			
		}
		
		catch (Exception e) {
			System.out.println(e.toString());
		}
		
		return dto;
	}
	
	// 4. 수정 (update_ok.jsp)
	public int updateData(NaverDTO dto){
		int result = 0;
		PreparedStatement pstmt = null;
		String sql;
		
		try {
			sql = "update naver set nickname = ? , pw1 = ? , tel = ? , "
					+ "tel1 = ? , tel2 = ? , agreecheck = ? where id = ? ";
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, dto.getNickname());
			pstmt.setString(2, dto.getPw1());
			pstmt.setString(3, dto.getTel());
			pstmt.setString(4, dto.getTel1());
			pstmt.setString(5, dto.getTel2());
			pstmt.setString(6, dto.getAgreecheck());
			pstmt.setString(7, dto.getId());
			
			
			result = pstmt.executeUpdate();
			pstmt.close();
			
			
		} catch (Exception e) {
			System.out.println(e.toString());
		}
		return result;
		
	}
	
	// 5. 삭제 
	
	public int deleteDate(String id){
		
		int result = 0 ;
		PreparedStatement pstmt = null;
		
		String sql ;
		
		try {
			sql = "delete from naver where id = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, id);
			result = pstmt.executeUpdate();
			
			pstmt.close();
			
		} catch (Exception e) {
			System.out.println(e.toString());
		}
		
		return result ;
	}
	
	// 6. 아이디 가져오기
	
	public boolean confirmId(String id){
		boolean result = false;
		PreparedStatement pstmt = null;
		String sql ;
		
		ResultSet rs = null ;
		try {
			sql = "select id from naver where id = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, id);
			rs = pstmt.executeQuery();
			if(rs.next()){
				result = true;
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally{
			try { rs.close();	} catch (SQLException s) {}
			try { pstmt.close();	} catch (SQLException s) {}
			try { conn.close();	} catch (SQLException s) {}
		}
		
		return result ;
		
	
		
	}
	
}























