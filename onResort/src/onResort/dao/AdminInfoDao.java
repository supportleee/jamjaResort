package onResort.dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import onResort.domain.AdminInfo;
import onResort.domain.Notice;

public class AdminInfoDao {
	public static Connection getConnection() {
		Connection con = null;
		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
			con = DriverManager.getConnection("jdbc:mysql://3.13.15.154:3306/onResort", "root", "kopo24");
		} catch (Exception e) {
			System.out.println(e);
		}
		return con;
	}

	public static int insert(AdminInfo a) {
		return 0;
	}
	
	public static int update(AdminInfo a) {
		return 0;
	}
	
	public static int delete(AdminInfo a) {
		return 0;
	}
	
	public static List<AdminInfo> getAllRecords() {
		List<AdminInfo> list = new ArrayList<AdminInfo>();

		try {
			Connection con = getConnection();
			PreparedStatement ps = con.prepareStatement("select * from adminInfo;");
			ResultSet rs = ps.executeQuery();
			while (rs.next()) {
				AdminInfo a = new AdminInfo();
				a.setId(rs.getString("id"));
				a.setPw(rs.getString("pw"));
				list.add(a);
			}
			rs.close();
			ps.close();
			con.close();
		} catch (Exception e) {
			System.out.println(e);
		}
		return list;
	}

	public static AdminInfo getRecordById(String id) {
		AdminInfo a = new AdminInfo();
		try {
			Connection con = getConnection();
			PreparedStatement ps = con.prepareStatement("select * from adminInfo where id=?");
			ps.setString(1, id);
			ResultSet rs = ps.executeQuery();
			if (rs.next()) {
				a.setId(rs.getString("id"));
				a.setPw(rs.getString("pw"));
			}
			rs.close();
			ps.close();
			con.close();
		} catch (Exception e) {
			System.out.println(e);
		}
		return a;
	}
}
