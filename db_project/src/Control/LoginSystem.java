package Control;

import java.sql.ResultSet;
import java.sql.SQLException;

import DB.DB_Conn_Query;

public class LoginSystem {

	public  LoginSystem(){ }
	public boolean LoginSystem(String id, String pw) {
		DB_Conn_Query db = new DB_Conn_Query();
		String sql = "SELECT ID, PW FROM 회원";
		ResultSet src = db.executeQuery(sql);
		try {
			while(src.next()) {
				if(id.equals(src.getString("ID"))&&pw.equals(src.getString("PW"))) {
					//회원테이블 DB의 ID, PW가 일치할 경우
					return true;
				}
			}
		}catch(SQLException e) {
			e.printStackTrace();
		}
		return false;
	}

}
