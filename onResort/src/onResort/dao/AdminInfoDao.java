// 관리자 정보 DAO

package onResort.dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import onResort.domain.AdminInfo;

public class AdminInfoDao {
	// DB Connection
	public static Connection getConnection() {
		Connection con = null; // connection 저장용 변수
		try {
			Class.forName("com.mysql.cj.jdbc.Driver");  // 메모리에 jdbc클래스 동적 로딩, 드라이버가 알아서 DriverManager에 등록됨
			// DriverManager로 DB와 connection
			con = DriverManager.getConnection("jdbc:mysql://3.13.15.154:3306/onResort", "root", "kopo24");
		} catch (Exception e) {
			System.out.println(e);
		}
		return con;
	}

	// AdminInfo insert용 메소드
	public static int insert(AdminInfo a) {
		return 0;
	}
	
	// AdminInfo update용 메소드
	public static int update(AdminInfo a) {
		return 0;
	}
	
	// AdminInfo delete용 메소드
	public static int delete(AdminInfo a) {
		return 0;
	}
	
	// AdminInfo에서 모든 record 가져오는 메소드
	public static List<AdminInfo> getAllRecords() {
		List<AdminInfo> list = new ArrayList<AdminInfo>(); // 받아온 결과를 저장할 list 선언

		try {
			Connection con = getConnection(); // DB와 연결
			// PreparedStatement로 query문 세팅
			PreparedStatement ps = con.prepareStatement("select * from adminInfo;");
			ResultSet rs = ps.executeQuery(); // query 실행 후 결과값 ResultSet에 저장
			while (rs.next()) { // resultSet에 더 이상 내용이 없을 때까지 실행
				AdminInfo a = new AdminInfo(); // resultSet에 저장된 내용을 저장할 adminInfo 객체 생성
				// 생성해둔 객체에 각 값 집어넣기
				a.setId(rs.getString("id"));
				a.setPw(rs.getString("pw"));
				list.add(a); // 세팅한 객체를 list에 넣기
			}
			rs.close(); // 다 쓴 resultset close
			ps.close(); // 다 쓴 preparedStatement close
			con.close(); // 다 쓴 connection close
		} catch (Exception e) {
			System.out.println(e);
		}
		return list; // 세팅된 list return
	}

	// AdminInfo에서 id값으로 select하는 메소드
	public static AdminInfo getRecordById(String id) {
		AdminInfo a = new AdminInfo(); // select 결과를 담을 AdminInfo 객체 생성
		try {
			Connection con = getConnection(); // DB와 연결
			// PreparedStatement로 query문 세팅
			PreparedStatement ps = con.prepareStatement("select * from adminInfo where id=?");
			ps.setString(1, id);
			ResultSet rs = ps.executeQuery(); // query 실행 후 결과값 ResultSet에 저장
			if (rs.next()) { // resultSet에 결과가 있으면
				// 생성해둔 객체에 각 값 집어넣기
				a.setId(rs.getString("id"));
				a.setPw(rs.getString("pw")); 
			}
			rs.close(); // 다 쓴 resultset close
			ps.close(); // 다 쓴 preparedStatement close
			con.close(); // 다 쓴 connection close
		} catch (Exception e) {
			System.out.println(e);
		}
		return a; // 세팅된 객체 return
	}
}
