package db_project;
import java.awt.*;
import java.awt.event.*;
import javax.swing.*;


public class login_UI extends JFrame{
	
	//생성자
	public login_UI() {
		Container c = getContentPane();	// 컨텐트팬 추출
		c.setLayout(null);		// 배치관리자 제거
		
		//로그인 문구
		JLabel login_lb = new JLabel("로그인");
		login_lb.setBounds(230,30,100,10);
		c.add(login_lb);
		
		//아이디 입력창
		id_pw_Panel id = new id_pw_Panel("     아이디");
		id.setBounds(0,40,500,80);
		c.add(id);
		//비밀번호 입력창
		id_pw_Panel pw = new id_pw_Panel("비밀번호");
		pw.setBounds(0,80,500,80);
		c.add(pw);
		
		//회원가입 버튼
		JButton sign_up_btn = new JButton("회원가입");
		sign_up_btn.setBounds(120,200,100,30);
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
		login_btn.setBounds(280,200,100,30);
		c.add(login_btn);
		//로그인 버튼 클릭시 이벤트
		login_btn.addActionListener(new ActionListener(){
			public void actionPerformed(ActionEvent e){
				main_UI main = new main_UI();		//메인 화면 생성
				main.setVisible(true);
				setVisible(false);					//로그인창 닫음
			}
		});
		
		
		//화면 설정
		setTitle("로그인 화면");		// 타이틀
		setSize(500,300);				//사이즈
		setLocationRelativeTo(null);	//화면 중앙 배치
		setResizable(false);			// 화면 사이즈 고정
		setVisible(true);				//화면 출력
		setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);	//닫기 누르면 종료
	}
	

	// 중앙 패널 (ID, PW 입력창)
	class id_pw_Panel extends JPanel {
		public id_pw_Panel(String id_or_pw) {
			setLayout(new FlowLayout(FlowLayout.CENTER, 30, 40));
	
			JLabel id_lb = new JLabel(id_or_pw.concat(" : "));
			add(id_lb);
			JTextField id_tf = new JTextField(20);
			add(id_tf);
		}
	}
	

	public static void main(String[] args) {
		// 로그인 화면 생성
		login_UI login = new login_UI();
	}

}