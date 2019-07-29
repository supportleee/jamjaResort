package onResort.dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import onResort.domain.Notice;

public class NoticeDao {
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
	
	public static int insert(Notice n) {
		int status = 0;
		try {
			Connection con = getConnection();
			PreparedStatement ps = con
					.prepareStatement("insert into notice (title, dayOfRegister, content, imgname, orgimgname) values (?, now(), ?, ?, ?)");
			ps.setString(1, n.getTitle());
			ps.setString(2, n.getContent());
			ps.setString(3, n.getImgname());
			ps.setString(4, n.getOrgimgname());
			status = ps.executeUpdate();
			ps.close();
			con.close();
		} catch (Exception e) {
			System.out.println(e);
		}
		return status;
	}
	
	public static int update(Notice n) {
		int status = 0;
		try {
			Connection con = getConnection();
			PreparedStatement ps = con.prepareStatement("update notice set title=?, content=? where id=?");
			ps.setString(1, n.getTitle());
			ps.setString(2, n.getContent());
			ps.setInt(3, n.getId());
			status = ps.executeUpdate();
			ps.close();
			con.close();
		} catch (Exception e) {
			System.out.println(e);
		}
		return status;
	}
	
	public static int updateViewcnt(int id) {
		int status = 0;
		try {
			Connection con = getConnection();
			PreparedStatement ps = con.prepareStatement("update notice set viewcnt=viewcnt+1 where id=?");
			ps.setInt(1, id);
			status = ps.executeUpdate();
			ps.close();
			con.close();
		} catch (Exception e) {
			System.out.println(e);
		}
		return status;
	}
	

	public static int delete(Notice n) {
		int status = 0;
		try {
			Connection con = getConnection();
			PreparedStatement ps = con.prepareStatement("delete from notice where id=?;");
			ps.setInt(1, n.getId());
			status = ps.executeUpdate();
			ps.close();
			con.close();
		} catch (Exception e) {
			System.out.println(e);
		}
		return status;
	}

	public static List<Notice> getAllRecords() {
		List<Notice> list = new ArrayList<Notice>();

		try {
			Connection con = getConnection();
			PreparedStatement ps = con.prepareStatement("select * from notice order by rootid desc, recnt asc;");
			ResultSet rs = ps.executeQuery();
			while (rs.next()) {
				Notice n = new Notice();
				n.setId(rs.getInt("id"));
				n.setTitle(rs.getString("title"));
				n.setDayOfRegister(rs.getDate("dayOfRegister"));
				n.setContent(rs.getString("content"));
				n.setViewcnt(rs.getInt("viewcnt"));
				n.setImgname(rs.getString("imgname"));
				n.setOrgimgname(rs.getString("orgimgname"));
				list.add(n);
			}
			rs.close();
			ps.close();
			con.close();
		} catch (Exception e) {
			System.out.println(e);
		}
		return list;
	}

	public static Notice getRecordById(int id) {
		Notice n = new Notice();
		try {
			Connection con = getConnection();
			PreparedStatement ps = con.prepareStatement("select * from notice where id=?");
			ps.setInt(1, id);
			ResultSet rs = ps.executeQuery();
			if(rs.next()) {
				n.setId(rs.getInt("id"));
				n.setTitle(rs.getString("title"));
				n.setDayOfRegister(rs.getDate("dayOfRegister"));
				n.setContent(rs.getString("content"));
				n.setViewcnt(rs.getInt("viewcnt"));
				n.setImgname(rs.getString("imgname"));
				n.setOrgimgname(rs.getString("orgimgname"));
			}
			rs.close();
			ps.close();
			con.close();
		} catch (Exception e) {
			System.out.println(e);
		}
		return n;
	}
	
	public static int getRecordByLastest() {
		int max_id = 0;
		try {
			Connection con = getConnection();
			PreparedStatement ps = con.prepareStatement("select max(id) from notice;");
			ResultSet rs = ps.executeQuery();
			if(rs.next()) {
				max_id = rs.getInt("max(id)");
			}
			rs.close();
			ps.close();
			con.close();
		} catch (Exception e) {
			System.out.println(e);
		}
		return max_id;
		
	}
}
