package Control;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.time.*;
import java.util.Date;

import javax.swing.JOptionPane;
import javax.swing.JTable;
import javax.swing.SwingConstants;
import javax.swing.table.DefaultTableCellRenderer;
import javax.swing.table.DefaultTableModel;
import javax.swing.table.TableColumnModel;

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
	
	// JTable 갱신
	public void Table_F5 (JTable table, DefaultTableModel model, int user_id) {

		model.setNumRows(0);	//테이블 초기화
		
		DefaultTableCellRenderer dtcr = new DefaultTableCellRenderer();
		dtcr.setHorizontalAlignment(SwingConstants.CENTER);
		TableColumnModel tcm = table.getColumnModel();
	
		// 회원테이블(JTable)에 데이터 삽입
				try {
					// 쿼리문
					String sql = "SELECT 검사날짜 "
							+"FROM 회원수치 "
							+"WHERE 회원수치.ID = " + user_id
							+" GROUP BY 검사날짜"
							+" ORDER BY 검사날짜 ASC";
					
					ResultSet rs = db.executeQuery(sql);
					// 결과를 변수에 저장
					while(rs.next()) {
						String row[] = new String[1];
						row[0] = rs.getString(1).substring(0,10);
						model.addRow(row);		//JTable 에 한줄 삽입
					}
				}catch(SQLException e2){ System.out.println("데이터 삽입 실패");}
			
				// 테이블 값 중앙정렬
				for(int i =0;i<tcm.getColumnCount();i++) {
					tcm.getColumn(i).setCellRenderer(dtcr);
				}	
	}
	
	// 회원수치 등록
	public void RegistrationData(int id, String checkup, int checkup_value) {
		
		// 현재날짜
		SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd");
		Date now = new Date();
		String nowDate = sdf.format(now);
		nowDate = nowDate.substring(2,8);
		
		
		// 질환의 성별값 
		String sex = "";
		try {
			String sql = "SELECT 성별값 FROM 질환 where 조사항목 = '"+ checkup+"'";
			System.out.println(sql);
			ResultSet src = db.executeQuery(sql);

			while(src.next()) {
				sex = src.getString(1);
			}
			System.out.println(sex);
			
		}catch(SQLException e2) {System.out.println("질환의 성별 가져오는 과정에서 sql에러");}
		

		// 질환의 성별값이 공통이 아니면 회원의 성별값과 동일하게함
		// 공백 안주니 비교 못함;;
		if (!sex.equals("공통 ")){
			// 회원의 성별
			try {
				String sql = "SELECT 성별 FROM 회원 where ID = " + id;
				ResultSet src = db.executeQuery(sql);
				while(src.next()) {
					sex = src.getString(1);
				}
			}catch(SQLException e2) {System.out.println("회원의 성별 가져오는 과정에서 sql에러");}
		}
		
		
		// 값 등록
		try {
		//값 insert
		Connection con = db.getConnection();
		PreparedStatement pstmt = con.prepareStatement("insert into 회원수치 values(?,?,'"+checkup+"',?,?,?)");
		
		pstmt.setString(1, nowDate);
		pstmt.setInt(2, id);
		//pstmt.setString(3, checkup);
		pstmt.setString(3, sex);
		pstmt.setInt(4, checkup_value);
		pstmt.setString(5, "0");
	
	
		pstmt.executeUpdate();
		
		
		}catch(SQLException e3) {System.out.println("등록 실패"); JOptionPane.showMessageDialog(null, "등록 실패","등록 실패",JOptionPane.ERROR_MESSAGE);}
	}
	
	// 회원수치 비교 (수정과정에서 사용)
	public boolean data_not_equal(int id, String checkup, String checkup_value, String date) {
		
		try {
			Connection con = db.getConnection();
			PreparedStatement pstmt = con.prepareStatement("SELECT 수치값 FROM 회원수치 WHERE ID = ?  AND 검사날짜 = ? AND 조사항목 = '" + checkup + "' ");
			

			pstmt.setInt(1, id);
			pstmt.setString(2, date);
			//pstmt.setString(3, checkup);
			
			ResultSet src = pstmt.executeQuery();
			
			String value = "";
			while(src.next()) {
				value = src.getString(1);
			}
			
			
			if (value.equals(checkup_value)) {return false;}
			else {return true;}
		}catch(SQLException e2) {System.out.println("비교 실패"); return false;}
	}
	
	// 회원수치 수정
	public void CorrectionData(int id, String checkup, String checkup_value, String date) {
		
		try {
			
			//값 수정
			Connection con = db.getConnection();
			PreparedStatement pstmt = con.prepareStatement("update 회원수치 set 수치값 = ? where ID = ? and 조사항목 = '"+checkup+"' and 검사날짜 = ?");

			pstmt.setInt(1, Integer.parseInt(checkup_value));
			pstmt.setInt(2, id);
			//pstmt.setString(3, checkup);
			pstmt.setString(3, date);
		
			pstmt.executeUpdate();
			
		
		}catch(SQLException e2) {System.out.println("수정 실패"); JOptionPane.showMessageDialog(null, "수정 실패","수정 실패",JOptionPane.ERROR_MESSAGE);}
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
			JOptionPane.showMessageDialog(null, "삭제 완료","삭제 완료",JOptionPane.INFORMATION_MESSAGE);
		
		}catch(SQLException e2) {System.out.println("삭제 실패"); JOptionPane.showMessageDialog(null, "삭제 실패","삭제 실패",JOptionPane.ERROR_MESSAGE);}
	}
}
