package com.imageTest;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import com.fileTest.FileTestDTO;

public class ImageTestDAO {

	private Connection conn;

	public ImageTestDAO(Connection conn) {
		this.conn = conn;
	}

	// num의 MAX 값 구하기
	public int getMaxNum() {
		int maxNum = 0;

		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql;

		try {

			sql = "select nvl(max(num),0) from imageTest";

			pstmt = conn.prepareStatement(sql);

			rs = pstmt.executeQuery();

			if (rs.next()) {
				maxNum = rs.getInt(1);
			}

			rs.close();
			pstmt.close();

		} catch (Exception e) {
			System.out.println(e.toString());
		}
		return maxNum;
	}

	// 입력
	public int insertData(ImageTestDTO dto) {
		int result = 0;

		PreparedStatement pstmt = null;
		String sql;

		try {
			sql = "insert into imageTest(num, subject, saveFileName) values(?,?,?)";

			pstmt = conn.prepareStatement(sql);

			pstmt.setInt(1, dto.getNum());
			pstmt.setString(2, dto.getSubject());
			pstmt.setString(3, dto.getSaveFileName());

			result = pstmt.executeUpdate();

			pstmt.close();

		} catch (Exception e) {
			System.out.println(e.toString());
		}
		return result;

	}

	// 한개의 데이터

	public ImageTestDTO getReadData(int num) {
		ImageTestDTO dto = null;

		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql;

		try {

			sql = "select num, subject, saveFileName from imageTest where num = ?";

			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, num);

			rs = pstmt.executeQuery();

			if (rs.next()) {
				dto = new ImageTestDTO();
				dto.setNum(rs.getInt("num"));
				dto.setSubject(rs.getString("subject"));
				dto.setSaveFileName(rs.getString("saveFileName"));

			}

			pstmt.close();
			rs.close();

		} catch (Exception e) {
			System.out.println(e.toString());
		}

		return dto;

	}

	// 모든 데이터

	public List<ImageTestDTO> getList(int start, int end) {
		List<ImageTestDTO> lists = new ArrayList<ImageTestDTO>();

		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql;

		try {

			sql = "select * from (";
			sql += "select rownum rnum, data.* from (";
			sql += "select num, subject, saveFileName from imageTest order by num desc) data)";
			sql += "where rnum >= ? and rnum <= ?";

			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, start);
			pstmt.setInt(2, end);

			rs = pstmt.executeQuery();

			while (rs.next()) {
				ImageTestDTO dto = new ImageTestDTO();
				dto.setNum(rs.getInt("num"));
				dto.setSubject(rs.getString("subject"));
				dto.setSaveFileName(rs.getString("saveFileName"));

				lists.add(dto);
			}

			pstmt.close();
			rs.close();

		} catch (Exception e) {
			System.out.println(e.toString());
		}

		return lists;

	}

	// 삭제

	public int deleteData(int num) {
		int result = 0;

		PreparedStatement pstmt = null;
		String sql;

		try {
			sql = "delete imageTest where num =?";
			pstmt = conn.prepareStatement(sql);

			pstmt.setInt(1, num);

			result = pstmt.executeUpdate();

			pstmt.close();

		} catch (Exception e) {
			System.out.println(e.toString());
		}

		return result;

	}
	
	// 데이터 개수
		public int getDataCount(){
			
			int dataCount = 0;
			
			PreparedStatement pstmt = null;
			
			ResultSet rs = null;
			
			String sql;
			
			try {
				sql = "select nvl(count(*),0) from imageTest";
				pstmt = conn.prepareStatement(sql);
				rs = pstmt.executeQuery();
				
				if(rs.next()){
					dataCount = rs.getInt(1);
					
				}
				rs.close();
				pstmt.close();
			} catch (Exception e) {
				e.toString();
			}
			
			return dataCount;	
		}
}
