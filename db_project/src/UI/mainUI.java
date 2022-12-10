package UI;

import javax.swing.*;

import org.knowm.xchart.QuickChart;
import org.knowm.xchart.XChartPanel;
import org.knowm.xchart.XYChart;

import Control.ComboBoxData;
import DB.DB_Conn_Query;

import java.awt.*;
import java.sql.CallableStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Types;
import java.awt.event.MouseAdapter;
import java.awt.event.MouseEvent;
import java.awt.event.ActionListener;
import java.awt.event.ActionEvent;

import javax.swing.table.DefaultTableCellRenderer;
import javax.swing.table.DefaultTableModel;
import javax.swing.table.TableCellRenderer;
import javax.swing.table.TableColumnModel;
import javax.swing.border.BevelBorder;
import javax.swing.border.LineBorder;
import javax.swing.table.TableModel;
public class mainUI extends JFrame {
	DB_Conn_Query db = new DB_Conn_Query();
	JComboBox checkUpBox;
	JComboBox diseaseBox;
	JComboBox examinationBox;
	
	String name;				// 이름
	String person_number;		// 주민등록번호
	String sex;				// 성별
	float avg;
	private JTable dataTable;
	private DefaultTableModel model;
	
	public mainUI(String id) {
		setTitle("Main");
		getContentPane().setLayout(null);
		
		JPanel userInfoPanel = new JPanel();
		userInfoPanel.setBackground(SystemColor.inactiveCaptionBorder);
		userInfoPanel.setBounds(25, 96, 300, 360);
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
		JPanel chartPanel = new JPanel();
		chartPanel.setBackground(SystemColor.inactiveCaptionBorder);
		chartPanel.setBounds(337, 96, 532, 360);
		getContentPane().add(chartPanel);
		chartPanel.setLayout(null);
		
		
		
		JLabel avgValueLabel = new JLabel("0");
		avgValueLabel.setHorizontalAlignment(SwingConstants.RIGHT);
		avgValueLabel.setFont(new Font("맑은 고딕", Font.PLAIN, 12));
		avgValueLabel.setBounds(355, 311, 160, 22);
		chartPanel.add(avgValueLabel);
		
		JLabel avgLabel = new JLabel("수치 평균");
		avgLabel.setFont(new Font("맑은 고딕", Font.PLAIN, 12));
		avgLabel.setBounds(355, 281, 127, 29);
		chartPanel.add(avgLabel);
		
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
				diseaseBox.setSelectedIndex(0);
				//검진항목 바뀌었을 때 조사항목 콤보박스 비우기
				examinationBox.removeAllItems();
			}
		});
		
		diseaseBox.addActionListener(new ActionListener() {
			public void actionPerformed(ActionEvent e) {
				//질환명이 선택되면 그에 따른 조사항목 데이터 콤보박스 출력
				String[] examinationData = combo.getData("조사항목",diseaseBox.getSelectedItem().toString());
				examinationBox.setModel(new DefaultComboBoxModel(examinationData));
				examinationBox.setSelectedIndex(0);
			}
		});
		
		examinationBox.addActionListener(new ActionListener() {
			public void actionPerformed(ActionEvent e) {
				model.setNumRows(0);
				//하나라도 선택되지 않으면 수치 평균 출력 x
				if(!(checkUpBox.getSelectedItem()==null||diseaseBox.getSelectedItem()==null||examinationBox.getSelectedItem()==null)) {
					//조사항목이 선택되면 차트 업데이트, 수치 평균 출력
					String checkUp = checkUpBox.getSelectedItem().toString();
					String disease = diseaseBox.getSelectedItem().toString();
					String examination = examinationBox.getSelectedItem().toString();
					//평균 구하기
					try {
						//----------------------------  CallableStatement 활용 ----------------------------
						CallableStatement cstmt = db.getConnection().prepareCall("{call User_avg(?,?,?)}");
						cstmt.setInt(1, Integer.parseInt(id));
						cstmt.setString(2, examination);
						cstmt.registerOutParameter(3, Types.FLOAT);
						cstmt.executeQuery();
						avg = cstmt.getFloat(3);
						avgValueLabel.setText(Float.toString(avg));
						cstmt.close();
						//--------------------------------------------------------------------------------
					} catch (SQLException e1) {
						e1.printStackTrace();
					}
					
					//JTable 행 추가
					String sql2 = "SELECT 검사날짜, 수치값, 이상유무 "
							+ "FROM 회원수치 "
							+ "WHERE ID = "+id+" AND "
							+ "조사항목 = '"+examination+"'";
					ResultSet rs = db.executeQuery(sql2);
					try {
						int i=0,j=0;
						while(rs.next()) {
							String date = rs.getDate(1).toString();
							String value = Float.toString(rs.getFloat(2));
							String tf = rs.getString(3);
							//TableCellRenderer render = dataTable.getCellRenderer(i++, j++);
							//render.setForeground(Color.red);
							model.addRow(new Object[] {date,value});
						}
					} catch (SQLException e1) {
						e1.printStackTrace();
					}
				}
				else {
					avgValueLabel.setText("0");
					model.setNumRows(0);
				}
			}
		});
		
		checkUpBox.setFont(new Font("맑은 고딕", Font.PLAIN, 12));
		checkUpBox.setBounds(355, 74, 160, 22);
		
		diseaseBox.setFont(new Font("맑은 고딕", Font.PLAIN, 12));
		diseaseBox.setBounds(355, 150, 160, 22);
		
		examinationBox.setFont(new Font("맑은 고딕", Font.PLAIN, 12));
		examinationBox.setBounds(355, 230, 160, 22);
		
		chartPanel.add(checkUpBox);
		chartPanel.add(diseaseBox);
		chartPanel.add(examinationBox);
		//--------------------------콤보박스 데이터 가져오기 end----------------------------
		
		JLabel checkUpLabel = new JLabel("검진 항목");
		checkUpLabel.setFont(new Font("맑은 고딕", Font.PLAIN, 12));
		checkUpLabel.setBounds(355, 44, 127, 29);
		chartPanel.add(checkUpLabel);
		
		JLabel diseaseLabel = new JLabel("질환");
		diseaseLabel.setFont(new Font("맑은 고딕", Font.PLAIN, 12));
		diseaseLabel.setBounds(355, 120, 127, 29);
		chartPanel.add(diseaseLabel);
		
		JLabel examinationLabel = new JLabel("조사 항목");
		examinationLabel.setFont(new Font("맑은 고딕", Font.PLAIN, 12));
		examinationLabel.setBounds(355, 200, 127, 29);
		chartPanel.add(examinationLabel);
		
		JLabel lblNewLabel_4 = new JLabel("날짜별 수치 기록");
		lblNewLabel_4.setFont(new Font("맑은 고딕", Font.PLAIN, 13));
		lblNewLabel_4.setBounds(22, 10, 188, 24);
		chartPanel.add(lblNewLabel_4);
		
		//------------------------- 회원 수치 테이블 --------------------------
		String colName[] = {"날짜","수치값"};
		model = new DefaultTableModel(colName,0);
		
		JPanel panel = new JPanel();
		panel.setBounds(22, 44, 310, 289);
		chartPanel.add(panel);
		panel.setLayout(new BorderLayout(0, 0));
		
		JScrollPane scrollPane = new JScrollPane();
		panel.add(scrollPane, BorderLayout.CENTER);
		
		dataTable = new JTable(model);
		dataTable.setBorder(new LineBorder(new Color(0, 0, 0)));
		scrollPane.setViewportView(dataTable);
		DefaultTableCellRenderer dtcr = new DefaultTableCellRenderer();
		dtcr.setHorizontalAlignment(SwingConstants.CENTER);
		
		//------------------------ 회원 수치 테이블 end ---------------------
		
		JLabel lblNewLabel = new JLabel("회원 정보");
		lblNewLabel.setFont(new Font("맑은 고딕", Font.PLAIN, 15));
		lblNewLabel.setBounds(25, 59, 92, 36);
		getContentPane().add(lblNewLabel);
		
		JLabel lblNewLabel_1 = new JLabel("회원 수치값");
		lblNewLabel_1.setFont(new Font("맑은 고딕", Font.PLAIN, 15));
		lblNewLabel_1.setBounds(337, 59, 138, 36);
		getContentPane().add(lblNewLabel_1);
		
		JLabel lblNewLabel_2 = new JLabel("건강 관리 프로그램");
		lblNewLabel_2.setFont(new Font("맑은 고딕", Font.BOLD, 25));
		lblNewLabel_2.setBounds(25, 10, 280, 52);
		getContentPane().add(lblNewLabel_2);
		//--------------------------회원 탈퇴 이벤트----------------------------------
		JButton dropBtn = new JButton("회원 탈퇴");
		dropBtn.addMouseListener(new MouseAdapter() {
			@Override
			public void mouseClicked(MouseEvent e) {
				int answer = JOptionPane.showConfirmDialog(null, "탈퇴하시겠습니까?", "회원 탈퇴",JOptionPane.YES_NO_OPTION );
				if(answer == 0) {	//회원 탈퇴
					String sql = "DELETE FROM 회원 WHERE ID = "+id;
					db.executeUpdate(sql);
					JOptionPane.showMessageDialog(null,"회원 탈퇴가 완료되었습니다.");
					setVisible(false);
					new login_UI();
				}
			}
		});
		//----------------------------------------------------------------------
		dropBtn.setFont(new Font("맑은 고딕", Font.PLAIN, 12));
		dropBtn.setBounds(643, 30, 107, 31);
		getContentPane().add(dropBtn);
		
		JButton dataBtn = new JButton("건강검진 데이터 관리");
		dataBtn.addMouseListener(new MouseAdapter() {
			@Override
			public void mouseClicked(MouseEvent e) {
				new data_UI(id);
			}
		});
		dataBtn.setFont(new Font("맑은 고딕", Font.PLAIN, 12));
		dataBtn.setBounds(25, 466, 177, 31);
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
		logoutBtn.setBounds(762, 31, 107, 31);
		getContentPane().add(logoutBtn);
		
		//화면 설정
		setSize(920,550);
		setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);	//닫기 누르면 종료
		setLocationRelativeTo(null);	//화면 중앙 배치
		setResizable(false);			// 화면 사이즈 고정
		setVisible(true);				//화면 출력
		
	}
	public static void main(String[] args) {
		mainUI main = new mainUI("1");
	}
}
