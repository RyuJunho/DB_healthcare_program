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
	int [] num_arr = {11,15,19,16,9,8,14,13,21,12,20,10,17,4,18,5,22,1,0,6,2,3,7,23};
	String [] checkup = {"ALT","AST","B형간염항원","B형간염항체","HDL-콜레스테롤","LDL-콜레스테롤","감마지티피","감염검사경과","시력 (우)","시력 (좌)","식전혈당","신장",
			"요단백","청력 (우)","청력 (좌)","체중","체질량지수","총콜레스테롤","트리글리세라이드","허리둘레","혈색소","혈압","혈청크레아티닌","흉부방사선검사"};
	String [] checkup_2 = {"신장","체중","허리둘레","체질량지수","시력(좌)","시력(우)","청력(좌)","청력(우)","혈압","요단백","혈색소","식전혈당",
			"총콜레스테롤","HDL-콜레스테롤","트리글리세라이드","LDL-콜레스테롤","혈청크레아티닌","AST(SGOT)","ALT(SGPT)","감마지티피(y-GTP)","B형간염항원","B형간염항체","감염검사결과","흉부방사선검사"};
	//생성자
	public data_UI(String user_id) {
	
		
		Container c = getContentPane();	// 컨텐트팬 추출
		c.setLayout(null);		// 배치관리자 제거 -> 절대위치 지정
		
		
		// 회원데이터 테이블
		String colName[] = {"검사날짜"};
		DefaultTableModel model = new DefaultTableModel(colName, 0);
		JTable data_table = new JTable(model);
		
		DefaultTableCellRenderer dtcr = new DefaultTableCellRenderer();
		dtcr.setHorizontalAlignment(SwingConstants.CENTER);
		TableColumnModel tcm = data_table.getColumnModel();
		
		JScrollPane data_table_pan = new JScrollPane(data_table);
		data_table_pan.setBounds(50,80,200,300);
		
		
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
		
		c.add(data_table_pan);
		
		// --------------------------------------------------------------------------------------------------------
			
		//데이터 입력 문구
		JLabel registration_lb = new JLabel("데이터를 입력하세요");
		registration_lb.setBounds(850,10,200,80);
		c.add(registration_lb);

		JLabel research_lb = new JLabel("검진항목");
		research_lb.setBounds(310, 10, 500, 80);
		add(research_lb);

		JLabel disease_lb = new JLabel("질환명");
		disease_lb.setBounds(500, 10, 500, 80);
		add(disease_lb);
		
		JLabel checkup_lb = new JLabel("조사항목");
		checkup_lb.setBounds(700, 10, 500, 80);
		add(checkup_lb);
		
		// 스크롤 부착할 패널
		JPanel scroll_panel = new JPanel();
		scroll_panel.setPreferredSize(new Dimension(1500,1000));
		scroll_panel.setLayout(new BorderLayout());
		
		input_panel i_p = new input_panel();	// 입력창 패널
		scroll_panel.add(i_p,BorderLayout.CENTER);
		
		// 스크롤
		JScrollPane scroll = new JScrollPane(JScrollPane.VERTICAL_SCROLLBAR_ALWAYS,JScrollPane.HORIZONTAL_SCROLLBAR_NEVER);
		scroll.setBounds(300,80,750,400);
		scroll.setViewportView(scroll_panel);	//패널에 스크롤 부착
		c.add(scroll);
		
		// --------------------------------------------------------------------------------------------------------

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
		registration_btn.setBounds(500,550,60,30);
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
						JOptionPane.showMessageDialog(null, "빈칸이 있습니다","등록 실패",JOptionPane.ERROR_MESSAGE);
						break;
					}		
				}
				
				if (flag) {
					//회원수치 등록
					for (int i=0;i<24;i++) {
						Data.RegistrationData(Integer.parseInt(user_id),lb_arr[i].getText(),Integer.parseInt(tf_arr[num_arr[i]].getText()));
					}
					JOptionPane.showMessageDialog(null, "등록 완료","등록 완료",JOptionPane.INFORMATION_MESSAGE);
					Data.Table_F5(data_table, model, Integer.parseInt(user_id));
				}
			}
		});
				
		//수정 버튼
		JButton correction_btn = new JButton("수정");
		correction_btn.setBounds(600,550,60,30);
		c.add(correction_btn);
		// 수정 버튼 클릭 시
		correction_btn.addActionListener(new ActionListener() {
			public void actionPerformed(ActionEvent e) {
				System.out.println("수정버튼 클릭");
					
				// 클릭한 열의 날짜 가져옴
				String date = data_table.getValueAt(data_table.getSelectedRow(),0).toString();
				date = date.substring(2,10).replaceAll("-","");		// ex) "221202"
				
				boolean flag = true;
				// 비어있는 텍스트필드가 있으면
				for (int i=0;i<24;i++) {
					if (tf_arr[i].getText().equals("")) {
						flag = false;
						JOptionPane.showMessageDialog(null, "빈칸이 있습니다","등록 실패",JOptionPane.ERROR_MESSAGE);
						break;
					}		
				}
				
				// 비어있는 텍스트필드가 없으면
				if (flag) {
					for (int i=0;i<24;i++) {
						// 텍스트필드값이 데이터베이스 값과 다르면
						if (Data.data_not_equal(Integer.parseInt(user_id),lb_arr[i].getText(),tf_arr[num_arr[i]].getText(),date)) {
							// 회원수치 수정
							Data.CorrectionData(Integer.parseInt(user_id),lb_arr[i].getText(),tf_arr[num_arr[i]].getText(),date);
						}
					}
					JOptionPane.showMessageDialog(null, "수정 완료","수정 완료",JOptionPane.INFORMATION_MESSAGE);
					Data.Table_F5(data_table, model, Integer.parseInt(user_id));
				}
			}
		});
		
		//삭제 버튼
		JButton delete_btn = new JButton("삭제");
		delete_btn.setBounds(700,550,60,30);
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
				Data.Table_F5(data_table, model, Integer.parseInt(user_id));
			}
		});
		
		
		//화면 설정
		setTitle("회원 데이터 화면");		// 타이틀
		setSize(1100,700);				//사이즈
		setLocationRelativeTo(null);	//화면 중앙 배치
		setResizable(false);			// 화면 사이즈 고정
		setVisible(true);				//화면 출력
		
		
	}
	
	// -------------------------------------------회원수치 입력창 패널 클래스 <시작>---------------------------------------------------- 
	class input_panel extends JPanel{
		input_panel(){
			// 입력창 레이블, 텍스트필드 배열 배치
			setLayout(null);
			
			// 검진항목 -------------------------------------------------------------
			JLabel metrology_lb = new JLabel("계측검사");
			metrology_lb.setBounds(10, 0, 500, 80);
			add(metrology_lb);
			
			JLabel urine_lb = new JLabel("요검사");
			urine_lb.setBounds(10, 360, 500, 80);
			add(urine_lb);
			
			JLabel blood_lb = new JLabel("혈액검사");
			blood_lb.setBounds(10, 400, 500, 80);
			add(blood_lb);
			
			JLabel imaging_lb = new JLabel("영상검사");
			imaging_lb.setBounds(10, 920, 500, 80);
			add(imaging_lb);
			
			// 질환명 ---------------------------------------------------------------
			
			JLabel d1_lb = new JLabel("비만");
			d1_lb.setBounds(200, 0, 500, 80);
			add(d1_lb);
			
			JLabel d2_lb = new JLabel("시각 이상");
			d2_lb.setBounds(200, 160, 500, 80);
			add(d2_lb);
			
			JLabel d3_lb = new JLabel("청각 이상");
			d3_lb.setBounds(200, 240, 500, 80);
			add(d3_lb);
			
			JLabel d4_lb = new JLabel("고혈압");
			d4_lb.setBounds(200, 320, 500, 80);
			add(d4_lb);
			
			JLabel d5_lb = new JLabel("신장힐환");
			d5_lb.setBounds(200, 360, 500, 80);
			add(d5_lb);
			
			JLabel d6_lb = new JLabel("빈혈 등");
			d6_lb.setBounds(200, 400, 500, 80);
			add(d6_lb);
			
			JLabel d7_lb = new JLabel("당뇨병");
			d7_lb.setBounds(200, 440, 500, 80);
			add(d7_lb);
			
			JLabel d8_lb = new JLabel("고혈압,이상지질혈증,동맥경화");
			d8_lb.setBounds(200, 480, 500, 80);
			add(d8_lb);
			
			JLabel d9_lb = new JLabel("만성신장질환");
			d9_lb.setBounds(200, 640, 500, 80);
			add(d9_lb);
			
			JLabel d10_lb = new JLabel("간장질환");
			d10_lb.setBounds(200, 680, 500, 80);
			add(d10_lb);
			
			JLabel d11_lb = new JLabel("폐결핵흉부질환");
			d11_lb.setBounds(200, 920, 500, 80);
			add(d11_lb);
			
			// 조사항목 --------------------------------------------------------------
			for (int i=0;i<24;i++) {
				lb_arr[i] = new JLabel(checkup_2[i]);
				tf_arr[num_arr[i]] = new JTextField();
				lb_arr[i].setBounds(400,0 + i*40,500,80);
				tf_arr[num_arr[i]].setBounds(550,30 + i*40 ,170,20); 
				add(lb_arr[i]);
				add(tf_arr[num_arr[i]]);
			}

			
		}
	}

	// -------------------------------------------회원수치 입력창 패널 클래스 <끝>---------------------------------------------------- 
	public static void main(String[] args) {
		// 로그인 화면 생성
		data_UI data = new data_UI("1");
	}

}