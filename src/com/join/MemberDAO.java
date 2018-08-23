package com.join;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class MemberDAO {

	private Connection conn;

	// DI (의존성 주입)
	public MemberDAO(Connection conn) {
		this.conn = conn;
	}

	// 1. 회원가입
	public int insertData(MemberDTO dto) {

		int result = 0;

		PreparedStatement pstmt = null;
		String sql;

		try {
			sql = "insert into member(userId, userPwd, userName, userBirth, userTel) ";
			sql += "values(?,?,?,?,?)";

			pstmt = conn.prepareStatement(sql);

			pstmt.setString(1, dto.getUserId());
			pstmt.setString(2, dto.getUserPwd());
			pstmt.setString(3, dto.getUserName());
			pstmt.setString(4, dto.getUserBirth());
			pstmt.setString(5, dto.getUserTel());

			result = pstmt.executeUpdate();
			pstmt.close();

		} catch (Exception e) {
			System.out.println(e.toString());
		}

		return result;
	}

	// 회원정보 수정
	public int updateData(MemberDTO dto){
		int result = 0 ;
		
		PreparedStatement pstmt = null;
		String sql;
		System.out.println(dto.getUserId());
		System.out.println(dto.getUserName());
		System.out.println(dto.getUserTel());
		
		try {
			sql = "update member set userPwd = ? , userTel = ? , userBirth = ? "
					+ "where userId = ?";
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setString(1, dto.getUserPwd());
			pstmt.setString(2, dto.getUserTel());
			pstmt.setString(3, dto.getUserBirth());
			pstmt.setString(4, dto.getUserId());
			
			result = pstmt.executeUpdate();
			pstmt.close();
			
		} catch (Exception e) {
			System.out.println(e.toString());
		}
		
		return result ;
	}

	// 데이터 읽기

	public MemberDTO getReadData(String userId) {
		MemberDTO dto = null;

		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql;

		try {
			sql = "select userId, userPwd, userName, userBirth, userTel "
					+ "from member where userId = ?";

			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, userId);

			rs = pstmt.executeQuery();

			if (rs.next()) {
				dto = new MemberDTO();
				dto.setUserId(rs.getString("userId"));
				dto.setUserPwd(rs.getString("userPwd"));
				dto.setUserName(rs.getString("userName"));
				dto.setUserBirth(rs.getString("userBirth"));
				dto.setUserTel(rs.getString("userTel"));
			}

			rs.close();
			pstmt.close();

		} catch (Exception e) {
			System.out.println(e.toString());
		}

		return dto;
	}

}
