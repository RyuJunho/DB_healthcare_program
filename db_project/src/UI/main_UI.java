package UI;

import java.awt.*;
import java.awt.event.*;
import java.sql.DriverManager;

import javax.swing.*;
import org.knowm.xchart.*;

import DB.DB_Conn_Query;

import java.sql.*;

public class main_UI extends JFrame {
	private String [] disease = {"비만","고혈압","간 기능 이상","당뇨병","이상지질 혈증"};
	private String [] checkup = {""};
	private String user_id;
	private String user_pw;
	
	DB_Conn_Query db = new DB_Conn_Query();

	//생성자
	public main_UI(String id, String pw) {
		this.user_id = id;
		this.user_pw = pw;

		Container c = getContentPane();	// 컨텐트팬 추출
		c.setLayout(null);		// 배치관리자 제거
		
		//Main 문구
		JLabel main_lb = new JLabel("Main");
		main_lb.setBounds(30,20,200,20);
		c.add(main_lb);
		
		//회원탈퇴 버튼
		JButton withdrawal_btn = new JButton("회원탈퇴");
		withdrawal_btn.setBounds(800,20,100,30);
		c.add(withdrawal_btn);
		
		//회원정보 문구
		JLabel person_info_lb = new JLabel("회원정보");
		person_info_lb.setBounds(30,80,200,20);
		c.add(person_info_lb);
		
		
		// ID, PW를 바탕으로 회원정보를 불러와서 출력
		String name = "";				// 이름
		String person_number = "";		// 주민등록번호
		String sex = "";				// 성별
		
		try {
			// 쿼리문
			String sql = "select 이름,주민등록번호,성별 from 회원 "
					+ "where ID = " + id
					+ " and PW = " + user_pw;
			ResultSet rs = db.executeQuery(sql);
			
			// 결과를 변수에 저장
			while(rs.next()) {
				name = rs.getString("이름");
				person_number = rs.getString("주민등록번호");
				sex = rs.getString("성별");
			}
		}catch(SQLException e) { System.out.println("sql문 오류"); }
		
		
		//회원정보 패널
		person_info_Panel person_info = new person_info_Panel(name,person_number,sex);
		person_info.setBounds(30, 110, 400, 200);
		c.add(person_info);
		
		//chart
		double[] xData = new double[] {0.0, 1.0, 2.0};
		double[] yData = new double[] {2.0, 1.0, 0.0}; 
		XYChart chart = QuickChart.getChart("Sample Chart", "X", "Y", "y(x)", xData, yData);

		
		//그래프 패널
		JPanel graph = new XChartPanel(chart);
		graph.setBounds(450, 110, 500, 400);
		c.add(graph);
		
		//목표질환
		JComboBox<String> disease_combo = new JComboBox<String>(disease);
		disease_combo.setBounds(450, 520, 150,30);
		c.add(disease_combo);
		
		//검진항목
		JComboBox<String> checkup_combo = new JComboBox<String>(checkup);
		checkup_combo.setBounds(620, 520, 150,30);
		c.add(checkup_combo);
		
		//수치평균
		JLabel data_avg_lb = new JLabel("수치 평균 : ".concat("임시데이터"));
		data_avg_lb.setBounds(800,525,200,20);
		add(data_avg_lb);

		
		//건강검진 데이터 관리 버튼
		JButton data_btn = new JButton("건강검진 데이터 관리");
		data_btn.setBounds(30,700,200,40);
		c.add(data_btn);
		//건강검진 데이터 관리 버튼 클릭시 이벤트
		data_btn.addActionListener(new ActionListener(){
			public void actionPerformed(ActionEvent e){
				data_UI data = new data_UI(id);		//회원 데이터 화면 생성
				data.setVisible(true);
			}
		});
		
	
		
		//화면 설정
		setTitle("메인 화면");		// 타이틀
		setSize(1000,800);				//사이즈
		setLocationRelativeTo(null);	//화면 중앙 배치
		setResizable(false);			// 화면 사이즈 고정
		setVisible(true);				//화면 출력
		setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);	//닫기 누르면 종료
	}
	
	
	// 회원정보 패널 (이름, 주민등록번호, 성별)
	class person_info_Panel extends JPanel {
		public person_info_Panel(String name, String birth, String sex) {
			setLayout(null);
			
			//이름
			JLabel name_lb = new JLabel("이름 : ".concat(name));
			name_lb.setBounds(10,0,500,40);
			add(name_lb);

			//주민등록번호
			JLabel person_number_lb = new JLabel("주민등록번호 : ".concat(birth));
			person_number_lb.setBounds(10,40,500,40);
			add(person_number_lb);
			
			//성별 입력창
			JLabel sex_lb = new JLabel("성별 : ".concat(sex));
			sex_lb.setBounds(10,80,500,40);
			add(sex_lb);
			
			setBackground(Color.WHITE);
		}
	}

}
