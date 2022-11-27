package db_project;

import java.awt.*;
import java.awt.event.*;
import javax.swing.*;
import javax.swing.table.*;



public class data_UI extends JFrame{
	
	//생성자
	public data_UI() {
		Container c = getContentPane();	// 컨텐트팬 추출
		c.setLayout(null);		// 배치관리자 제거 -> 절대위치 지정
		
		//등록 버튼
		JButton registration_btn = new JButton("등록");
		registration_btn.setBounds(260,10,60,30);
		c.add(registration_btn);
		
		registration_btn.addActionListener(new ActionListener(){
			public void actionPerformed(ActionEvent e){
				registration_Dialog r_Dialog = new registration_Dialog();
			}
		});
		
		//수정 버튼
		JButton correction_btn = new JButton("수정");
		correction_btn.setBounds(330,10,60,30);
		c.add(correction_btn);
		
		//삭제 버튼
		JButton delete_btn = new JButton("삭제");
		delete_btn.setBounds(400,10,60,30);
		c.add(delete_btn);
		
		// 회원데이터 테이블
		String colName[] = {"BMI검사", "이완기","수축기","AST.ALT","공복 혈당","HDL","LDL"};
		DefaultTableModel model = new DefaultTableModel(colName, 0);
		JTable data_table = new JTable(model);
		JScrollPane data_table_pan = new JScrollPane(data_table);
		data_table_pan.setBounds(10,50,460,300);
		c.add(data_table_pan);
		
		//화면 설정
		setTitle("회원 데이터 화면");		// 타이틀
		setSize(500,400);				//사이즈
		setLocationRelativeTo(null);	//화면 중앙 배치
		setResizable(false);			// 화면 사이즈 고정
		setVisible(true);				//화면 출력
		
		
	}
	
	// 등록 다이얼로그 화면
	class registration_Dialog extends JDialog{
		
		public registration_Dialog() {
			setLayout(null);
			
			//회원가입 문구
			JLabel registration_lb = new JLabel("데이터를 입력하세요");
			registration_lb.setBounds(190,10,200,10);
			add(registration_lb);
			
			//BMI 입력창
			input_Panel bmi = new input_Panel("BMI");
			bmi.setBounds(0,20,500,80);
			add(bmi);
			//이완기 입력창
			input_Panel name = new input_Panel("이완기");
			name.setBounds(0,60,500,80);
			add(name);
			//수축기 입력창
			input_Panel person_number = new input_Panel("수축기");
			person_number.setBounds(0,100,500,80);
			add(person_number);
			//AST.ALT 입력창
			input_Panel sex = new input_Panel("AST.ALT");
			sex.setBounds(0,140,500,80);
			add(sex);
			//공복 혈당 입력창
			input_Panel id = new input_Panel("공복 혈당");
			id.setBounds(0,180,500,80);
			add(id);
			//HDL 입력
			input_Panel hdl = new input_Panel("        HDL");
			hdl.setBounds(0,220,500,80);
			add(hdl);
			//LDL 입력
			input_Panel ldl = new input_Panel("        LDL");
			ldl.setBounds(0,260,500,80);
			add(ldl);
			
			//등록 버튼
			JButton registration_btn = new JButton("등록");
			registration_btn.setBounds(220,380,60,30);
			add(registration_btn);
			//등록 버튼 클릭시 이벤트
			registration_btn.addActionListener(new ActionListener(){
				public void actionPerformed(ActionEvent e){
					setVisible(false);		//등록 창 닫음
				}
			});
			
			setTitle("데이터 등록 화면");		// 타이틀
			setSize(500,500);				//사이즈
			setLocationRelativeTo(null);	//화면 중앙 배치
			setResizable(false);			// 화면 사이즈 고정
			setVisible(true);				//화면 출력
		}
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
		data_UI data = new data_UI();
	}

}
