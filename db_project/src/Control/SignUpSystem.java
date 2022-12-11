package Control;

import DB.DB_Conn_Query;

public class SignUpSystem {
	DB_Conn_Query db = new DB_Conn_Query();
	public boolean SignUpSystem(String id, String pw, String name
			, String personNum, String sex) {
		// TODO Auto-generated method stub
		if(id.length()==0||pw.length()==0||name.length()==0
				||personNum.length()==0||sex.length()==0) {
			return false;
		}
		else {
			String sql = "INSERT INTO 회원 VALUES("+id+",'"+pw+"','"
						+name+"','"+personNum+"','"+sex+"')";
			db.executeUpdate(sql);
			return true;
		}
	}

}
