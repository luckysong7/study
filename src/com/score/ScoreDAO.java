package com.score;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import util.DBConn;

public class ScoreDAO {

	// DI(의존성 주입)
	private Connection conn;

	// 생성자 오버로딩
	public ScoreDAO(Connection conn) {
		this.conn = conn;
	}

	// 1. 입력(write.jsp,write_ok.jsp)

	public int insertData(ScoreDTO dto) {
		int result = 0;

		PreparedStatement pstmt = null;

		String sql;

		try {

			sql = "insert into score (hak, name, kor, eng, mat) ";
			sql += "values(?,?,?,?,?)";

			pstmt = conn.prepareStatement(sql);

			pstmt.setString(1, dto.getHak());
			pstmt.setString(2, dto.getName());
			pstmt.setInt(3, dto.getKor());
			pstmt.setInt(4, dto.getEng());
			pstmt.setInt(5, dto.getMat());
			
			result = pstmt.executeUpdate();
			
			pstmt.close();

		}catch(java.sql.SQLIntegrityConstraintViolationException e2){
			System.out.println("이미 학번이 존재 합니다.");
			result = 3;
		
			return result;
		}
		 
		catch (Exception e) {
			try {pstmt.close();} catch (Exception e2) {}
			try {DBConn.close();} catch (Exception e2) {}
			System.out.println(e.toString());
		}

		return result;

	}

	// 2. 데이터 가져오기(list.jsp)
	
	public List<ScoreDTO> getList(){
		List<ScoreDTO> lists = new ArrayList<ScoreDTO>();

		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql ;
		
		try {
			sql = "select hak, name, kor, eng, mat, (kor+eng+mat) as tot , (kor+eng+mat)/3 as ave, rank() over (order by (kor+mat+eng) desc) as rank from score";
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			
			while(rs.next()){
				ScoreDTO dto = new ScoreDTO();
				dto.setHak(rs.getString("hak"));
				dto.setName(rs.getString("name"));
				dto.setKor(rs.getInt("kor"));
				dto.setEng(rs.getInt("eng"));
				dto.setMat(rs.getInt("mat"));
				dto.setTot(rs.getInt("tot"));
				dto.setAve(rs.getInt("ave"));
				dto.setRank(rs.getInt("rank"));
				
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
	public ScoreDTO getReadData(String hak){
		
		ScoreDTO dto = null;
		PreparedStatement pstmt = null;
		ResultSet rs =null;
		String sql;
		
		try {
			sql = "select hak, name, kor, eng, mat from score where hak = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, hak);
			
			
			rs = pstmt.executeQuery();
			
			if(rs.next()){
				dto = new ScoreDTO();
				dto.setHak(rs.getString("hak"));
				dto.setName(rs.getString("name"));
				dto.setKor(rs.getInt("kor"));
				dto.setEng(rs.getInt("eng"));
				dto.setMat(rs.getInt("mat"));
				
			}
			
			rs.close();
			pstmt.close();
			
		}
		catch (Exception e) {
			System.out.println(e.toString());
		}
		
		return dto;
		
	}
	
	// 4. 수정(update_ok.jsp)
	public int updateData(ScoreDTO dto){
		int result = 0;
		PreparedStatement pstmt = null;
		String sql;
		
		try {
			sql = "update score set kor = ?, eng = ?, mat = ? where hak = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, dto.getKor());
			pstmt.setInt(2, dto.getEng());
			pstmt.setInt(3, dto.getMat());
			pstmt.setString(4, dto.getHak());
			
			result = pstmt.executeUpdate();
			pstmt.close();
		
			
		} catch (Exception e) {
			System.out.println(e.toString());
		}
		
		return result;
		
	}
	
	
	// 5.삭제 (delete_ok.jsp)
	public int deleteData(String hak){
		int result = 0;
		PreparedStatement pstmt = null;
		
		String sql ;
		try {
			sql = "delete from score where hak = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, hak);
			
			result= pstmt.executeUpdate();
			
			pstmt.close();
			
		} catch (Exception e) {
			System.out.println(e.toString());
		}
		
		return result;
		
	}

}





























