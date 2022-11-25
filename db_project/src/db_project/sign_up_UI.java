package db_project;
import java.awt.*;
import javax.swing.*;


public class sign_up_UI extends JFrame{

	public sign_up_UI() {
		Container c = getContentPane();	// 컨텐트팬 추출
		c.setLayout(null);		// 배치관리자 제거
		
		//회원가입 문구
		JLabel sign_up_lb = new JLabel("회원가입");
		sign_up_lb.setBounds(230,30,100,10);
		c.add(sign_up_lb);
		
		//이름 입력창
		input_Panel name = new input_Panel("                이름");
		name.setBounds(0,40,500,80);
		c.add(name);
		//주민등록번호 입력창
		input_Panel person_number = new input_Panel("주민등록번호");
		person_number.setBounds(0,80,500,80);
		c.add(person_number);
		//성별 입력창
		input_Panel sex = new input_Panel("                성별");
		sex.setBounds(0,120,500,80);
		c.add(sex);
		//ID 입력창
		input_Panel id = new input_Panel("             아이디");
		id.setBounds(0,160,500,80);
		c.add(id);
		//PW 입력
		input_Panel pw = new input_Panel("        비밀번호");
		pw.setBounds(0,200,500,80);
		c.add(pw);
		
		
		//가입 버튼
		JButton sign_up_btn = new JButton("가입");
		sign_up_btn.setBounds(200,300,80,30);
		c.add(sign_up_btn);

		
		//화면 설정
		setTitle("회원가입 화면");		// 타이틀
		setSize(500,400);				//사이즈
		setLocationRelativeTo(null);	//화면 중앙 배치
		setResizable(false);			// 화면 사이즈 고정
		setVisible(true);				//화면 출력
		setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);	//닫기 누르면 종료
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
		// TODO Auto-generated method stub
		sign_up_UI sign_up = new sign_up_UI();
	}

}
