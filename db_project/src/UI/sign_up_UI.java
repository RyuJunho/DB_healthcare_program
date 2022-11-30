package UI;
import java.awt.*;
import java.awt.event.*;
import javax.swing.*;

import Control.SignUpSystem;



public class sign_up_UI extends JFrame{
	private JTextField idTextField;
	private JTextField pwTextField;
	private JTextField nameTextField;
	private JTextField personNumTextField;
	private JTextField sexTextField;

	public sign_up_UI() {
		Container c = getContentPane();	// 컨텐트팬 추출
		c.setLayout(null);		// 배치관리자 제거
		
		//회원가입 문구
		JLabel sign_up_lb = new JLabel("회원가입");
		sign_up_lb.setHorizontalAlignment(SwingConstants.CENTER);
		sign_up_lb.setFont(new Font("나눔고딕", Font.BOLD, 15));
		sign_up_lb.setBounds(142,10,80,30);
		c.add(sign_up_lb);
		
		
		//가입 버튼
		JButton sign_up_btn = new JButton("가입");
		sign_up_btn.setBounds(142,271,80,30);
		c.add(sign_up_btn);
		
		JLabel idLabel = new JLabel("아이디");
		idLabel.setBounds(45, 65, 92, 15);
		getContentPane().add(idLabel);
		
		JLabel pwLabel = new JLabel("비밀번호");
		pwLabel.setBounds(45, 105, 92, 15);
		getContentPane().add(pwLabel);
		
		JLabel nameLabel = new JLabel("이름");
		nameLabel.setBounds(45, 145, 92, 15);
		getContentPane().add(nameLabel);
		
		JLabel personNumLabel = new JLabel("주민등록번호");
		personNumLabel.setBounds(45, 185, 92, 15);
		getContentPane().add(personNumLabel);
		
		JLabel sexLabel = new JLabel("성별");
		sexLabel.setBounds(45, 225, 92, 15);
		getContentPane().add(sexLabel);
		
		idTextField = new JTextField();
		idTextField.setBounds(149, 62, 169, 21);
		getContentPane().add(idTextField);
		idTextField.setColumns(10);
		
		pwTextField = new JTextField();
		pwTextField.setColumns(10);
		pwTextField.setBounds(149, 102, 169, 21);
		getContentPane().add(pwTextField);
		
		nameTextField = new JTextField();
		nameTextField.setColumns(10);
		nameTextField.setBounds(149, 142, 169, 21);
		getContentPane().add(nameTextField);
		
		personNumTextField = new JTextField();
		personNumTextField.setColumns(10);
		personNumTextField.setBounds(149, 182, 169, 21);
		getContentPane().add(personNumTextField);
		
		sexTextField = new JTextField();
		sexTextField.setColumns(10);
		sexTextField.setBounds(149, 222, 169, 21);
		getContentPane().add(sexTextField);
		
		//가입 버튼 클릭시 이벤트
		sign_up_btn.addActionListener(new ActionListener(){
			public void actionPerformed(ActionEvent e){
				String id = idTextField.getText();
				String pw = pwTextField.getText();
				String name = nameTextField.getText();
				String personNum = personNumTextField.getText();
				String sex = sexTextField.getText();
				
				SignUpSystem signup = new SignUpSystem();
				boolean success = signup.SignUpSystem(id,pw,name,personNum,sex);
				if(success) {
					JOptionPane.showMessageDialog(null,"회원가입 성공");
					login_UI login = new login_UI();		//로그인 화면 생성
					login.setVisible(true);
					setVisible(false);						//회원가입창 닫음
				}
				else {
					JOptionPane.showMessageDialog(null,"회원가입 실패");
				}
			}
		});
		
		
		//화면 설정
		setTitle("회원가입 화면");		// 타이틀
		setSize(380,370);				//사이즈
		setLocationRelativeTo(null);	//화면 중앙 배치
		setResizable(false);			// 화면 사이즈 고정
		setVisible(true);				//화면 출력
		setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);	//닫기 누르면 종료
	}
	
	
	public static void main(String[] args) {
		// TODO Auto-generated method stub
		sign_up_UI sign_up = new sign_up_UI();
	}
}
