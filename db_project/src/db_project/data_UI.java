package db_project;

import java.awt.*;
import java.awt.event.*;

import javax.swing.*;
import javax.swing.table.*;
import java.sql.*;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.Date;

public class data_UI extends JFrame{
	
	Connection con = null;
	
	public void DB_Connect() {
		//데이터베이스 연결
		String url = "jdbc:oracle:thin:@localhost:1521:XE";
		String id = "PROJECT";
		String pw = "1234qwer";
		//Connection con = null;
		try {
			Class.forName("oracle.jdbc.driver.OracleDriver");
			System.out.println("드라이버 적재 성공");
			con = DriverManager.getConnection(url, id, pw);
			System.out.println("데이터베이스 연결 성공");
		}catch(ClassNotFoundException e) {
			System.out.println("드라이버를 찾을 수 없음");
		}catch(SQLException e) {
			System.out.println("연결에 실패");
		}
	}
	
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

		
		try {
			
			DB_Connect();	//DB 접속
			
			System.out.println("테이블 데이터 삽입");
			
			
			Statement stmt = con.createStatement();
			// 쿼리문
			ResultSet rs = stmt.executeQuery("SELECT 회원수치.검사날짜, 질환.검진항목, 질환.질환명, 질환.조사항목, 회원수치.수치값 "
					+"FROM 질환,회원수치 "
					+"WHERE 질환.조사항목 = 회원수치.조사항목 AND "
					+"질환.성별값 = 회원수치.성별값 AND "
					+"회원수치.ID = " + user_id);
			
			// 결과를 변수에 저장
			while(rs.next()) {
				String row[] = new String[5];
				row[0] = rs.getString(1);
				row[1] = rs.getString(2);
				row[2] = rs.getString(3);
				row[3] = rs.getString(4);
				row[4] = rs.getString(5);

				model.addRow(row);
			}
			
			con.close();	//DB 연결 해제
		}catch(SQLException e2){ System.out.println("데이터 삽입 실패");}
	
		c.add(data_table_pan);
		
		
		
		//데이터 입력 문구
		JLabel registration_lb = new JLabel("데이터를 입력하세요");
		registration_lb.setBounds(900,10,200,20);
		add(registration_lb);
		
		
		//데이터 입력창
		//신장 입력창
		input_Panel height = new input_Panel("신장");
		height.setBounds(500,20,500,80);
		add(height);
		//체중 입력창
		input_Panel weight = new input_Panel("체중");
		weight.setBounds(500,60,500,80);
		add(weight);
		//허리둘레 입력창
		input_Panel waist = new input_Panel("허리둘레");
		waist.setBounds(500,100,500,80);
		add(waist);
		//체질량지수 입력창
		input_Panel bmi = new input_Panel("체질량지수");
		bmi.setBounds(500,140,500,80);
		add(bmi);
		//시력(좌) 입력창
		input_Panel vision_left = new input_Panel("시력 (좌)");
		vision_left.setBounds(500,180,500,80);
		add(vision_left);
		//시력(우) 입력
		input_Panel vision_right = new input_Panel("시력 (우)");
		vision_right.setBounds(500,220,500,80);
		add(vision_right);
		//청력(좌) 입력
		input_Panel hearing_left = new input_Panel("청력 (좌)");
		hearing_left.setBounds(500,260,500,80);
		add(hearing_left);
		//청력(우) 입력
		input_Panel hearing_right = new input_Panel("청력 (우)");
		hearing_right.setBounds(500,300,500,80);
		add(hearing_right);
		//혈압 입력
		input_Panel Blood_pressure = new input_Panel("혈압");
		Blood_pressure.setBounds(500,340,500,80);
		add(Blood_pressure);
		//요단백 입력
		input_Panel urine_protein = new input_Panel("요단백");
		urine_protein.setBounds(500,380,500,80);
		add(urine_protein);
		//혈색소 입력
		input_Panel hemoglobin = new input_Panel("혈색소");
		hemoglobin.setBounds(500,420,500,80);
		add(hemoglobin);
		//식전혈당 입력
		input_Panel blood_sugar = new input_Panel("식전혈당");
		blood_sugar.setBounds(1000, 20,500,80);
		add(blood_sugar);
		//총콜레스테롤 입력
		input_Panel total_cholesterol = new input_Panel("총콜레스테롤");
		total_cholesterol.setBounds(1000,60,500,80);
		add(total_cholesterol);
		//HDL-콜레스테롤 입력
		input_Panel HDL = new input_Panel("HDL-콜레스테롤");
		HDL.setBounds(1000,100,500,80);
		add(HDL);
		//트리글리세라이드 입력
		input_Panel ldl = new input_Panel("트리글리세라이드");
		ldl.setBounds(1000,140,500,80);
		add(ldl);
		//LDL-콜레스테롤 입력
		input_Panel LDL = new input_Panel("LDL-콜레스테롤");
		LDL.setBounds(1000,180,500,80);
		add(LDL);
		//혈청크레아티닌 입력
		input_Panel serum_creatinine = new input_Panel("혈청크레아티닌");
		serum_creatinine.setBounds(1000,220,500,80);
		add(serum_creatinine);
		//AST 입력
		input_Panel AST = new input_Panel("AST");
		AST.setBounds(1000,260,500,80);
		add(AST);
		//감마지티피 입력
		input_Panel Y_GTP = new input_Panel("감마지티피");
		Y_GTP.setBounds(1000,300,500,80);
		add(Y_GTP);
		//B형간염항원 입력
		input_Panel hepatitis_B_antigen = new input_Panel("B형간염항원");
		hepatitis_B_antigen.setBounds(1000,340,500,80);
		add(hepatitis_B_antigen);
		//감염검사결과 입력
		input_Panel hepatitis_result = new input_Panel("감염검사경과");
		hepatitis_result.setBounds(1000,380,500,80);
		add(hepatitis_result);
		//흉부방사선검사 입력
		input_Panel chest_radiograph = new input_Panel("흉부방사선검사");
		chest_radiograph.setBounds(1000,420,500,80);
		add(chest_radiograph);
		
		
		//등록 버튼
		JButton registration_btn = new JButton("등록");
		registration_btn.setBounds(900,550,60,30);
		c.add(registration_btn);
		// 등록 버튼 클릭 시
		registration_btn.addActionListener(new ActionListener(){
		public void actionPerformed(ActionEvent e){
				try {
					
					DB_Connect();	//DB 접속
					
					System.out.println("등록버튼 클릭");
					
					
					//값 insert
					// 수정 필요
					PreparedStatement pstmt = con.prepareStatement("insert into 회원수치 values(?,?,?,?,?,?)");
					
					LocalDate date = LocalDate.now();
				    DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yy-MM-dd");
				    
				    String a= date.format(formatter);
				    
					pstmt.setString(1, a);
					pstmt.setInt(2, 1);
					pstmt.setString(3, "조사항목");
					pstmt.setString(4, "성별값");
					pstmt.setInt(5, 999);
					pstmt.setString(6, "0");
					
					
					pstmt.executeUpdate();
					
					con.close();	//DB 연결 해제
				}catch(SQLException e2){ System.out.println("등록 실패");}
			}
		});
				
		//수정 버튼
		JButton correction_btn = new JButton("수정");
		correction_btn.setBounds(1000,550,60,30);
		c.add(correction_btn);
		// 수정 버튼 클릭 시
		correction_btn.addActionListener(new ActionListener() {
			public void actionPerformed(ActionEvent e) {
				try {
					DB_Connect();	//DB 접속
					
					System.out.println("수정버튼 클릭");
					
					//값 수정
					PreparedStatement pstmt = con.prepareStatement("update 회원수치 set 수치값 = 99 where ID = 1 and 조사항목 = '혈압'");

					pstmt.executeUpdate();
					
					con.close();	//DB 연결 해제
				}catch(SQLException e2) {System.out.println("수정 실패");}
			}
			
		});
		
		//삭제 버튼
		JButton delete_btn = new JButton("삭제");
		delete_btn.setBounds(1100,550,60,30);
		c.add(delete_btn);
		// 삭제 버튼 클릭 시
		delete_btn.addActionListener(new ActionListener() {
			public void actionPerformed(ActionEvent e) {
				try {
					DB_Connect();	//DB 접속
					
					System.out.println("삭제버튼 클릭");
					
					//값 수정
					PreparedStatement pstmt = con.prepareStatement("update 회원수치 set 수치값 = 99 where ID = 1 and 조사항목 = '혈압'");

					pstmt.executeUpdate();
					
					con.close();	//DB 연결 해제
				}catch(SQLException e2) {System.out.println("수정 실패");}
			}
		});
		
		
		//화면 설정
		setTitle("회원 데이터 화면");		// 타이틀
		setSize(1800,700);				//사이즈
		setLocationRelativeTo(null);	//화면 중앙 배치
		setResizable(false);			// 화면 사이즈 고정
		setVisible(true);				//화면 출력
		
		
	}
	

	// 입력창 패널
	class input_Panel extends JPanel {
		public input_Panel(String text) {
			setLayout(new FlowLayout(FlowLayout.CENTER, 30, 40));
	
			JLabel text_lb = new JLabel(text.concat(" : "));
			add(text_lb);
			JTextField text_tf = new JTextField(20);
			add(text_tf);
		}
	}
	
	public static void main(String[] args) {
		// 로그인 화면 생성
		data_UI data = new data_UI("1","1111");
	}

}
