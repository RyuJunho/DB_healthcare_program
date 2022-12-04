package UI;

import javax.swing.*;

import DB.DB_Conn_Query;

import java.awt.*;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.awt.event.MouseAdapter;
import java.awt.event.MouseEvent;
public class mainUI extends JFrame {
	DB_Conn_Query db = new DB_Conn_Query();
	public mainUI(String id) {
		setTitle("Main");
		getContentPane().setLayout(null);
		
		JPanel userInfoPanel = new JPanel();
		userInfoPanel.setBackground(SystemColor.inactiveCaptionBorder);
		userInfoPanel.setBounds(35, 96, 408, 483);
		getContentPane().add(userInfoPanel);
		userInfoPanel.setLayout(null);
		
		JLabel lblNewLabel_3 = new JLabel("이름 : ");
		lblNewLabel_3.setFont(new Font("맑은 고딕", Font.PLAIN, 15));
		lblNewLabel_3.setBounds(12, 10, 127, 29);
		userInfoPanel.add(lblNewLabel_3);
		
		JLabel lblNewLabel_3_1 = new JLabel("주민등록번호 : ");
		lblNewLabel_3_1.setFont(new Font("맑은 고딕", Font.PLAIN, 15));
		lblNewLabel_3_1.setBounds(12, 49, 127, 29);
		userInfoPanel.add(lblNewLabel_3_1);
		
		JLabel lblNewLabel_3_2 = new JLabel("성별 : ");
		lblNewLabel_3_2.setFont(new Font("맑은 고딕", Font.PLAIN, 15));
		lblNewLabel_3_2.setBounds(12, 88, 127, 29);
		userInfoPanel.add(lblNewLabel_3_2);
		//---------------------------------------------------------------
		String name = "";				// 이름
		String person_number = "";		// 주민등록번호
		String sex = "";				// 성별
		String sql = "SELECT 이름, 주민등록번호, 성별 FROM 회원 WHERE ID = "+id;
		ResultSet rs = db.executeQuery(sql);
		try {
			while(rs.next()) {
				name = rs.getString("이름");
				person_number = rs.getString("주민등록번호");
				sex = rs.getString("성별");
			}
		}catch(SQLException e) { System.out.println("sql문 오류"); }
		
		JLabel nameLabel = new JLabel(name);
		nameLabel.setFont(new Font("맑은 고딕", Font.PLAIN, 15));
		nameLabel.setBounds(141, 10, 170, 29);
		userInfoPanel.add(nameLabel);
		
		JLabel personNumLabel = new JLabel(person_number);
		personNumLabel.setFont(new Font("맑은 고딕", Font.PLAIN, 15));
		personNumLabel.setBounds(141, 49, 170, 29);
		userInfoPanel.add(personNumLabel);
		
		JLabel sexLabel = new JLabel(sex);
		sexLabel.setFont(new Font("맑은 고딕", Font.PLAIN, 15));
		sexLabel.setBounds(141, 88, 170, 29);
		userInfoPanel.add(sexLabel);
		//----------------------------------------------------------------
		JPanel graphPanel = new JPanel();
		graphPanel.setBackground(SystemColor.inactiveCaptionBorder);
		graphPanel.setBounds(455, 96, 700, 483);
		getContentPane().add(graphPanel);
		graphPanel.setLayout(null);
		
		JComboBox checkUpBox = new JComboBox();
		checkUpBox.setFont(new Font("맑은 고딕", Font.PLAIN, 10));
		checkUpBox.setBounds(12, 443, 160, 30);
		graphPanel.add(checkUpBox);
		
		JComboBox diseaseBox = new JComboBox();
		diseaseBox.setFont(new Font("맑은 고딕", Font.PLAIN, 10));
		diseaseBox.setBounds(184, 443, 160, 30);
		graphPanel.add(diseaseBox);
		
		JComboBox examinationBox = new JComboBox();
		examinationBox.setFont(new Font("맑은 고딕", Font.PLAIN, 10));
		examinationBox.setBounds(356, 443, 160, 30);
		graphPanel.add(examinationBox);
		
		JLabel checkUpLabel = new JLabel("검진 항목");
		checkUpLabel.setFont(new Font("맑은 고딕", Font.PLAIN, 15));
		checkUpLabel.setBounds(12, 414, 127, 29);
		graphPanel.add(checkUpLabel);
		
		JLabel diseaseLabel = new JLabel("질환");
		diseaseLabel.setFont(new Font("맑은 고딕", Font.PLAIN, 15));
		diseaseLabel.setBounds(184, 414, 127, 29);
		graphPanel.add(diseaseLabel);
		
		JLabel examinationLabel = new JLabel("조사 항목");
		examinationLabel.setFont(new Font("맑은 고딕", Font.PLAIN, 15));
		examinationLabel.setBounds(356, 414, 127, 29);
		graphPanel.add(examinationLabel);
		
		JLabel avgValueLabel = new JLabel("0");
		avgValueLabel.setHorizontalAlignment(SwingConstants.RIGHT);
		avgValueLabel.setFont(new Font("맑은 고딕", Font.PLAIN, 10));
		avgValueLabel.setBounds(528, 444, 127, 29);
		graphPanel.add(avgValueLabel);
		
		JLabel avgLabel = new JLabel("수치 평균");
		avgLabel.setFont(new Font("맑은 고딕", Font.PLAIN, 15));
		avgLabel.setBounds(528, 414, 127, 29);
		graphPanel.add(avgLabel);
		
		JLabel lblNewLabel = new JLabel("회원 정보");
		lblNewLabel.setFont(new Font("맑은 고딕", Font.PLAIN, 20));
		lblNewLabel.setBounds(35, 59, 92, 36);
		getContentPane().add(lblNewLabel);
		
		JLabel lblNewLabel_1 = new JLabel("회원 수치값");
		lblNewLabel_1.setFont(new Font("맑은 고딕", Font.PLAIN, 20));
		lblNewLabel_1.setBounds(455, 59, 138, 36);
		getContentPane().add(lblNewLabel_1);
		
		JLabel lblNewLabel_2 = new JLabel("건강 관리 프로그램");
		lblNewLabel_2.setFont(new Font("맑은 고딕", Font.BOLD, 25));
		lblNewLabel_2.setBounds(35, 10, 280, 52);
		getContentPane().add(lblNewLabel_2);
		
		JButton dropBtn = new JButton("회원 탈퇴");
		dropBtn.setFont(new Font("맑은 고딕", Font.PLAIN, 10));
		dropBtn.setBounds(932, 25, 107, 23);
		getContentPane().add(dropBtn);
		
		JButton dataBtn = new JButton("건강검진 데이터 관리");
		dataBtn.addMouseListener(new MouseAdapter() {
			@Override
			public void mouseClicked(MouseEvent e) {
				new data_UI(id);
			}
		});
		dataBtn.setFont(new Font("맑은 고딕", Font.PLAIN, 10));
		dataBtn.setBounds(35, 608, 177, 31);
		getContentPane().add(dataBtn);
		
		JButton logoutBtn = new JButton("로그아웃");
		logoutBtn.addMouseListener(new MouseAdapter() {
			@Override
			public void mouseClicked(MouseEvent e) {
				setVisible(false);
				new login_UI();
			}
		});
		logoutBtn.setFont(new Font("맑은 고딕", Font.PLAIN, 10));
		logoutBtn.setBounds(1051, 26, 107, 23);
		getContentPane().add(logoutBtn);
		
		//화면 설정
		setSize(1200,700);
		setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);	//닫기 누르면 종료
		setLocationRelativeTo(null);	//화면 중앙 배치
		setResizable(false);			// 화면 사이즈 고정
		setVisible(true);				//화면 출력
		
	}
}
