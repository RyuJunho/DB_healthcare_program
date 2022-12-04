package Control;

import java.sql.ResultSet;
import java.sql.SQLException;

import DB.DB_Conn_Query;

public class ComboBoxData {
	DB_Conn_Query db = new DB_Conn_Query();
	public ComboBoxData() {	}
	public String[] getData(String s, String s2) {
		String sql = "SELECT DISTINCT " + s + " FROM 질환 ";
		String where = "";
		if(s2!=null) {
			s2=s2.trim();
			if(s=="질환명")where = "WHERE 검진항목" + " = '" + s2 + "'";
			else if(s=="조사항목")where = "WHERE 질환명" + " = '" + s2 + "'";
		}
		sql+=where;
		String c = "SELECT COUNT(*) FROM(" + sql + ")";
		int n=10;
		System.out.println(c);
		ResultSet rs = db.executeQuery(c);
		try {
			while(rs.next()) {
				n=rs.getInt(1);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		String[] data = new String[n];
		int i=0;
		ResultSet rs2 = db.executeQuery(sql);
		try {
			while(rs2.next()) {
				data[i++]=rs2.getString(1);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return data;
	}
}
