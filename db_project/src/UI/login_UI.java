package UI;
import java.awt.*;
import java.awt.event.*;
import javax.swing.*;

import Control.LoginSystem;


public class login_UI extends JFrame{
	JLabel id_lb;
	JTextField id_tf;
	private JTextField idTextField;
	private JTextField pwTextField;
	//생성자
	public login_UI() {
		Container c = getContentPane();	// 컨텐트팬 추출
		c.setLayout(null);		// 배치관리자 제거
		
		//로그인 문구
		JLabel titleLabel = new JLabel("건강 관리 프로그램");
		titleLabel.setFont(new Font("나눔고딕", Font.BOLD, 20));
		titleLabel.setBounds(102,32,179,30);
		c.add(titleLabel);
		
		
		
		//회원가입 버튼
		JButton sign_up_btn = new JButton("회원가입");
		sign_up_btn.setBounds(58,200,125,30);
		c.add(sign_up_btn);
		//회원가입 버튼 클릭시 이벤트
		sign_up_btn.addActionListener(new ActionListener(){
			public void actionPerformed(ActionEvent e){
				sign_up_UI sign_up = new sign_up_UI();		//회원가입 화면 생성
				sign_up.setVisible(true);
				setVisible(false);							//로그인창 닫음
			}
		});
		
		//로그인 버튼
		JButton login_btn = new JButton("로그인");
		login_btn.setBounds(195,200,125,30);
		c.add(login_btn);
		
		JLabel idLabel = new JLabel("아이디");
		idLabel.setBounds(58, 104, 57, 15);
		getContentPane().add(idLabel);
		
		JLabel pwLabel = new JLabel("비밀번호");
		pwLabel.setBounds(58, 143, 57, 15);
		getContentPane().add(pwLabel);
		
		idTextField = new JTextField();
		idTextField.setBounds(127, 101, 193, 21);
		getContentPane().add(idTextField);
		idTextField.setColumns(10);
		
		pwTextField = new JTextField();
		pwTextField.setColumns(10);
		pwTextField.setBounds(127, 140, 193, 21);
		getContentPane().add(pwTextField);
		//로그인 버튼 클릭시 이벤트
		login_btn.addActionListener(new ActionListener(){
			public void actionPerformed(ActionEvent e){
				String id = idTextField.getText();
				String pw = pwTextField.getText();
				
				LoginSystem login = new LoginSystem();
				if(login.LoginSystem(id,pw)) {
					JOptionPane.showMessageDialog(null,"로그인 성공");
					mainUI main = new mainUI(id);		//메인 화면 생성
					main.setVisible(true);
					setVisible(false);					//로그인창 닫음
				}
				else {
					JOptionPane.showMessageDialog(null,"로그인 실패");
				}
			}
		});
		
		
		//화면 설정
		setTitle("로그인 화면");		// 타이틀
		setSize(390,300);				//사이즈
		setLocationRelativeTo(null);	//화면 중앙 배치
		setResizable(false);			// 화면 사이즈 고정
		setVisible(true);				//화면 출력
		setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);	//닫기 누르면 종료
	}
	

	public static void main(String[] args) {
		// 로그인 화면 생성
		login_UI login = new login_UI();
	}
}
