package UI;

import javax.swing.*;

import Control.ComboBoxData;
import DB.DB_Conn_Query;

import java.awt.*;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.awt.event.MouseAdapter;
import java.awt.event.MouseEvent;
import java.awt.event.ActionListener;
import java.awt.event.ActionEvent;
public class mainUI extends JFrame {
	DB_Conn_Query db = new DB_Conn_Query();
	JComboBox checkUpBox;
	JComboBox diseaseBox;
	JComboBox examinationBox;
	public mainUI(String id) {
		setTitle("Main");
		getContentPane().setLayout(null);
		
		JPanel userInfoPanel = new JPanel();
		userInfoPanel.setBackground(SystemColor.inactiveCaptionBorder);
		userInfoPanel.setBounds(35, 96, 408, 483);
		getContentPane().add(userInfoPanel);
		userInfoPanel.setLayout(null);
		
		JLabel lblNewLabel_3 = new JLabel("이름 : ");
		lblNewLabel_3.setFont(new Font("맑은 고딕", Font.PLAIN, 12));
		lblNewLabel_3.setBounds(12, 10, 127, 29);
		userInfoPanel.add(lblNewLabel_3);
		
		JLabel lblNewLabel_3_1 = new JLabel("주민등록번호 : ");
		lblNewLabel_3_1.setFont(new Font("맑은 고딕", Font.PLAIN, 12));
		lblNewLabel_3_1.setBounds(12, 49, 127, 29);
		userInfoPanel.add(lblNewLabel_3_1);
		
		JLabel lblNewLabel_3_2 = new JLabel("성별 : ");
		lblNewLabel_3_2.setFont(new Font("맑은 고딕", Font.PLAIN, 12));
		lblNewLabel_3_2.setBounds(12, 88, 127, 29);
		userInfoPanel.add(lblNewLabel_3_2);
		//------------------------회원 정보 가져오기-------------------------------
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
		nameLabel.setFont(new Font("맑은 고딕", Font.PLAIN, 12));
		nameLabel.setBounds(102, 10, 170, 29);
		userInfoPanel.add(nameLabel);
		
		JLabel personNumLabel = new JLabel(person_number);
		personNumLabel.setFont(new Font("맑은 고딕", Font.PLAIN, 12));
		personNumLabel.setBounds(102, 49, 170, 29);
		userInfoPanel.add(personNumLabel);
		
		JLabel sexLabel = new JLabel(sex);
		sexLabel.setFont(new Font("맑은 고딕", Font.PLAIN, 12));
		sexLabel.setBounds(102, 88, 170, 29);
		userInfoPanel.add(sexLabel);
		//--------------------------회원 정보 가져오기 end---------------------------
		JPanel graphPanel = new JPanel();
		graphPanel.setBackground(SystemColor.inactiveCaptionBorder);
		graphPanel.setBounds(455, 96, 700, 483);
		getContentPane().add(graphPanel);
		graphPanel.setLayout(null);
		//-------------------------콤보박스 데이터 가져오기--------------------------------
		ComboBoxData combo = new ComboBoxData();
		
		String[] checkUpData = combo.getData("검진항목",null);
		
		checkUpBox = new JComboBox(checkUpData);
		diseaseBox = new JComboBox();
		examinationBox = new JComboBox();
		
		checkUpBox.addActionListener(new ActionListener() {
			public void actionPerformed(ActionEvent e) {
				//검진항목이 선택되면 그에 따른 질환명 데이터 콤보박스 출력
				String[] diseaseData = combo.getData("질환명",checkUpBox.getSelectedItem().toString());
				diseaseBox.setModel(new DefaultComboBoxModel(diseaseData));
				//검진항목 바뀌었을 때 조사항목 콤보박스 비우기??
				
			}
		});
		
		diseaseBox.addActionListener(new ActionListener() {
			public void actionPerformed(ActionEvent e) {
				//질환명이 선택되면 그에 따른 조사항목 데이터 콤보박스 출력
				String[] examinationData = combo.getData("조사항목",diseaseBox.getSelectedItem().toString());
				examinationBox.setModel(new DefaultComboBoxModel(examinationData));
			}
		});
		
		examinationBox.addActionListener(new ActionListener() {
			public void actionPerformed(ActionEvent e) {
				//조사항목이 선택되면 차트 업데이트
				System.out.println("조사항목 선택됨");
				
			}
		});
		
		checkUpBox.setFont(new Font("맑은 고딕", Font.PLAIN, 10));
		checkUpBox.setBounds(12, 451, 160, 22);
		
		diseaseBox.setFont(new Font("맑은 고딕", Font.PLAIN, 10));
		diseaseBox.setBounds(184, 451, 160, 22);
		
		examinationBox.setFont(new Font("맑은 고딕", Font.PLAIN, 10));
		examinationBox.setBounds(356, 451, 160, 22);
		
		graphPanel.add(checkUpBox);
		graphPanel.add(diseaseBox);
		graphPanel.add(examinationBox);
		//--------------------------콤보박스 데이터 가져오기 end----------------------------
		
		JLabel checkUpLabel = new JLabel("검진 항목");
		checkUpLabel.setFont(new Font("맑은 고딕", Font.PLAIN, 12));
		checkUpLabel.setBounds(12, 421, 127, 29);
		graphPanel.add(checkUpLabel);
		
		JLabel diseaseLabel = new JLabel("질환");
		diseaseLabel.setFont(new Font("맑은 고딕", Font.PLAIN, 12));
		diseaseLabel.setBounds(184, 421, 127, 29);
		graphPanel.add(diseaseLabel);
		
		JLabel examinationLabel = new JLabel("조사 항목");
		examinationLabel.setFont(new Font("맑은 고딕", Font.PLAIN, 12));
		examinationLabel.setBounds(356, 421, 127, 29);
		graphPanel.add(examinationLabel);
		
		//-----------------------------수치 평균 구하기---------------------------------
		JLabel avgValueLabel = new JLabel("0");
		avgValueLabel.setHorizontalAlignment(SwingConstants.RIGHT);
		avgValueLabel.setFont(new Font("맑은 고딕", Font.PLAIN, 10));
		avgValueLabel.setBounds(528, 451, 127, 22);
		graphPanel.add(avgValueLabel);
		
		
		
		//------------------------------수치 평균 구하기 end-----------------------------------
		JLabel avgLabel = new JLabel("수치 평균");
		avgLabel.setFont(new Font("맑은 고딕", Font.PLAIN, 12));
		avgLabel.setBounds(528, 421, 127, 29);
		graphPanel.add(avgLabel);
		
		JLabel lblNewLabel = new JLabel("회원 정보");
		lblNewLabel.setFont(new Font("맑은 고딕", Font.PLAIN, 15));
		lblNewLabel.setBounds(35, 59, 92, 36);
		getContentPane().add(lblNewLabel);
		
		JLabel lblNewLabel_1 = new JLabel("회원 수치값");
		lblNewLabel_1.setFont(new Font("맑은 고딕", Font.PLAIN, 15));
		lblNewLabel_1.setBounds(455, 59, 138, 36);
		getContentPane().add(lblNewLabel_1);
		
		JLabel lblNewLabel_2 = new JLabel("건강 관리 프로그램");
		lblNewLabel_2.setFont(new Font("맑은 고딕", Font.BOLD, 25));
		lblNewLabel_2.setBounds(35, 10, 280, 52);
		getContentPane().add(lblNewLabel_2);
		
		JButton dropBtn = new JButton("회원 탈퇴");
		dropBtn.setFont(new Font("맑은 고딕", Font.PLAIN, 12));
		dropBtn.setBounds(932, 25, 107, 31);
		getContentPane().add(dropBtn);
		
		JButton dataBtn = new JButton("건강검진 데이터 관리");
		dataBtn.addMouseListener(new MouseAdapter() {
			@Override
			public void mouseClicked(MouseEvent e) {
				new data_UI(id);
			}
		});
		dataBtn.setFont(new Font("맑은 고딕", Font.PLAIN, 12));
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
		logoutBtn.setFont(new Font("맑은 고딕", Font.PLAIN, 12));
		logoutBtn.setBounds(1051, 26, 107, 31);
		getContentPane().add(logoutBtn);
		
		//화면 설정
		setSize(1200,700);
		setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);	//닫기 누르면 종료
		setLocationRelativeTo(null);	//화면 중앙 배치
		setResizable(false);			// 화면 사이즈 고정
		setVisible(true);				//화면 출력
		
	}
	public static void main(String[] args) {
		mainUI main = new mainUI("1");
	}
}
