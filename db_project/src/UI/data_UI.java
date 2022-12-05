package UI;

import java.awt.*;
import java.awt.event.*;

import javax.swing.*;
import javax.swing.table.*;

import DB.DB_Conn_Query;
import Control.DataSystem;

import java.sql.*;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.Date;

public class data_UI extends JFrame{
	DB_Conn_Query db = new DB_Conn_Query();		// DB 클래스
	DataSystem Data = new DataSystem();			// Control 클래스
	
	JTextField tf_arr[] = new JTextField[25];	// 들어갈 값은 조사항목 오름차순
	JLabel lb_arr[] = new JLabel[25];
	String [] checkup = {"ALT","AST","B형간염항원","B형간염항체","HDL-콜레스테롤","LDL-콜레스테롤","감마지티피","감염검사경과","시력 (우)","시력 (좌)","식전혈당","신장",
			"요단백","청력 (좌)","청력 (우)","체중","체질량지수","총콜레스테롤","트리글리세라이드","허리둘레","혈색소","혈압","혈청크레아티닌","흉부방사선검사"};
	//생성자
	public data_UI(String user_id, String user_pw) {
	
		
		Container c = getContentPane();	// 컨텐트팬 추출
		c.setLayout(null);		// 배치관리자 제거 -> 절대위치 지정
		
		
		//데이터 입력 문구
		JLabel  data_lb = new JLabel("회원님의 데이터");
		data_lb.setBounds(210,10,200,20);
		add(data_lb);
		
		// 회원데이터 테이블
		String colName[] = {"검사날짜","검진항목","질환명","조사항목","수치값"};
		DefaultTableModel model = new DefaultTableModel(colName, 0);
		JTable data_table = new JTable(model);
		JScrollPane data_table_pan = new JScrollPane(data_table);
		data_table_pan.setBounds(10,50,460,550);

		// 회원테이블(JTable)에 데이터 삽입
		try {
			// 쿼리문
			String sql = "SELECT 회원수치.검사날짜, 질환.검진항목, 질환.질환명, 질환.조사항목, 회원수치.수치값 "
					+"FROM 질환,회원수치 "
					+"WHERE 질환.조사항목 = 회원수치.조사항목 AND "
					+"질환.성별값 = 회원수치.성별값 AND "
					+"회원수치.ID = " + user_id
					+" ORDER BY 검사날짜 ASC, 조사항목 ASC";
			
			ResultSet rs = db.executeQuery(sql);
			// 결과를 변수에 저장
			while(rs.next()) {
				String row[] = new String[5];
				row[0] = rs.getString(1);
				row[1] = rs.getString(2);
				row[2] = rs.getString(3);
				row[3] = rs.getString(4);
				row[4] = rs.getString(5);

				model.addRow(row);		//JTable 에 한줄 삽입
			}
		}catch(SQLException e2){ System.out.println("데이터 삽입 실패");}
	
		c.add(data_table_pan);
		
			
		//데이터 입력 문구
		JLabel registration_lb = new JLabel("데이터를 입력하세요");
		registration_lb.setBounds(900,10,200,20);
		c.add(registration_lb);

		// 입력창 레이블, 텍스트필드 배열 배치
		for (int i=0;i<24;i++) {
			lb_arr[i] = new JLabel(checkup[i]);
			tf_arr[i] = new JTextField();
			if (i < 12) { 
				lb_arr[i].setBounds(600,20 + (i*40),500,80);
				tf_arr[i].setBounds(700,50 + (i*40) ,170,20); 
			}
			else { 
				lb_arr[i].setBounds(1000,20 + (i-12)*40,500,80);
				tf_arr[i].setBounds(1100,50 + (i-12)*40 ,170,20); 
			}
			c.add(lb_arr[i]);
			c.add(tf_arr[i]);
		}
		
		
		// 회원테이블(JTable) 클릭 시
		data_table.addMouseListener(new MouseAdapter() {
			public void mouseClicked(MouseEvent e) {
				// 클릭한 열의 날짜 가져옴
				String date = data_table.getValueAt(data_table.getSelectedRow(),0).toString();
				date = date.substring(2,10).replaceAll("-","");		// ex) "221202"
				
				// 날짜에 해당하는 회원수치 데이터 가져옴 (문자열 배열을 반환받음)
				String[] data_arr = new String[25];
				Data.GetTableData(date, user_id, data_arr);
				
				// 텍스트필드에 값 채우기
				for (int i=0;i<24;i++) { tf_arr[i].setText(data_arr[i]); }		
			}
		});
		
		//등록 버튼
		JButton registration_btn = new JButton("등록");
		registration_btn.setBounds(800,550,60,30);
		c.add(registration_btn);
		// 등록 버튼 클릭 시
		registration_btn.addActionListener(new ActionListener(){
		public void actionPerformed(ActionEvent e){
				System.out.println("등록버튼 클릭");
				
				boolean flag = true;
				// 비어있는 텍스트필드가 있으면
				for (int i=0;i<24;i++) {
					if (tf_arr[i].getText().equals("")) {
						flag = false;
						break;
					}		
				}
				
				if (flag) {
					//회원수치 등록
					// 멈춰버림
					for (int i=0;i<24;i++) {
						Data.RegistrationData(Integer.parseInt(user_id),lb_arr[i].getText(),Integer.parseInt(tf_arr[i].getText()));
					}
				
				}
			}
		});
				
		//수정 버튼
		JButton correction_btn = new JButton("수정");
		correction_btn.setBounds(900,550,60,30);
		c.add(correction_btn);
		// 수정 버튼 클릭 시
		correction_btn.addActionListener(new ActionListener() {
			public void actionPerformed(ActionEvent e) {
				System.out.println("수정버튼 클릭");
					
				//회원수치 수정
				Data.CorrectionData();
			}
		});
		
		//삭제 버튼
		JButton delete_btn = new JButton("삭제");
		delete_btn.setBounds(1000,550,60,30);
		c.add(delete_btn);
		// 삭제 버튼 클릭 시
		delete_btn.addActionListener(new ActionListener() {
			public void actionPerformed(ActionEvent e) {
				System.out.println("삭제버튼 클릭");
				
				// 클릭한 열의 날짜 가져옴
				String date = data_table.getValueAt(data_table.getSelectedRow(),0).toString();
				date = date.substring(2,10).replaceAll("-","");		// ex) "221202"
				
				// 회원수치 삭제
				Data.DeleteData(Integer.parseInt(user_id), date);
			}
		});
		
		
		//화면 설정
		setTitle("회원 데이터 화면");		// 타이틀
		setSize(1500,700);				//사이즈
		setLocationRelativeTo(null);	//화면 중앙 배치
		setResizable(false);			// 화면 사이즈 고정
		setVisible(true);				//화면 출력
		
		
	}
	

	public static void main(String[] args) {
		// 로그인 화면 생성
		data_UI data = new data_UI("1","1111");
	}

}