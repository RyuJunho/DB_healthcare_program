package Control;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.time.*;
import java.util.Date;

import DB.DB_Conn_Query;

public class DataSystem {
	DB_Conn_Query db = new DB_Conn_Query();
	
	// 클릭한 테이블의 날짜에 해당하는 데이터 출력
	public void GetTableData(String date, String id, String[] data_arr) {
		try {
			// 해달 날짜의 회원 수치 검색
			System.out.println("클릭한 열의 날짜에 해당하는 데이터 출력");
			
			// 쿼리문
			String sql = "SELECT 조사항목, 수치값 FROM 회원수치 "
					+ "WHERE 검사날짜 = '" + date
					+ "' AND ID = " + id
					+ " ORDER BY 조사항목 ASC";
			ResultSet rs = db.executeQuery(sql);
			
			int i = 0;
			// 결과를 변수에 저장
			while(rs.next()) {
					String A = rs.getString(1);
					String B = rs.getString(2);
					data_arr[i] = B;
					i++;		
			}
		}catch(SQLException e2) {System.out.println("데이터 출력 실패");}
	}
	
	// 회원수치 등록
	public void RegistrationData(int id, String checkup, int checkup_value) {
		// 현재날짜
		SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd");
		Date now = new Date();
		String nowDate = sdf.format(now);
		nowDate = nowDate.substring(2,8);
		
		// 회원의 성별
		String sex = "";
		try {
			DB_Conn_Query db = new DB_Conn_Query();
			String sql = "SELECT 성별 FROM 회원 where ID = " + id;
			ResultSet src = db.executeQuery(sql);
			while(src.next()) {
				sex = src.getString(1);
			}
		}catch(SQLException e2) {System.out.println("등록 실패1");}
		
		// 값 등록
		try {
		//값 insert
		Connection con = db.getConnection();
		PreparedStatement pstmt = con.prepareStatement("insert into 회원수치 values(?,?,?,?,?,?)");
		
		System.out.println(nowDate);
		System.out.println(id);
		System.out.println(checkup);
		System.out.println(sex);
		System.out.println(checkup_value);
		
		pstmt.setString(1, nowDate);
		pstmt.setInt(2, id);
		pstmt.setString(3, checkup);
		pstmt.setString(4, sex);
		pstmt.setInt(5, checkup_value);
		pstmt.setString(6, "0");
	
	
		pstmt.executeUpdate();
			
		con.close();	//DB 연결 해제
		}catch(SQLException e3) {System.out.println("등록 실패2");}
	}
	
	// 회원수치 수정
	public void CorrectionData() {
		try {
			
			//값 수정
			Connection con = db.getConnection();
			PreparedStatement pstmt = con.prepareStatement("update 회원수치 set 수치값 = 99 where ID = 1 and 조사항목 = '혈압'");

			pstmt.executeUpdate();
			
			con.close();	//DB 연결 해제
		}catch(SQLException e2) {System.out.println("수정 실패");}
	}
	
	// 회원수치 삭제
	public void DeleteData(int id, String date) {
		try {
			
			//값 삭제
			Connection con = db.getConnection();
			PreparedStatement pstmt = con.prepareStatement("DELETE 회원수치 WHERE ID = ? AND 검사날짜 = ?");
			
			pstmt.setInt(1, id);
			pstmt.setString(2, date);
			
			pstmt.executeUpdate();
			
			con.close();	//DB 연결 해제
		}catch(SQLException e2) {System.out.println("삭제 실패");}
	}
}
