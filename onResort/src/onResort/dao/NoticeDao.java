// 공지게시판 DAO

package onResort.dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import onResort.domain.Notice;

public class NoticeDao {
	// DB Connection
	public static Connection getConnection() {
		Connection con = null; // connection 저장용 변수
		try {
			Class.forName("com.mysql.cj.jdbc.Driver"); // 메모리에 jdbc클래스 동적 로딩, 드라이버가 알아서 DriverManager에 등록됨
			// DriverManager로 DB와 connection
			con = DriverManager.getConnection("jdbc:mysql://3.13.15.154:3306/onResort", "root", "kopo24");
		} catch (Exception e) {
			System.out.println(e);
		}
		return con;
	}
	
	// notice table에 record insert하는 메소드
	public static int insert(Notice n) { // notice 객체를 파라미터로 받음
		int status = 0; // query 결과상태용 변수
		try {
			Connection con = getConnection(); // DB와 연결
			// PreparedStatement로 query문 세팅
			PreparedStatement ps = con
					.prepareStatement("insert into notice (title, dayOfRegister, content, imgname, orgimgname) values (?, now(), ?, ?, ?)");
			// dayOfRegister는 입력 당시 시간으로 넣기 때문에 now()를 사용
			// 나머지 값은 파라미터로 받은 객체에서 getter를 이용해 세팅
			ps.setString(1, n.getTitle());
			ps.setString(2, n.getContent());
			ps.setString(3, n.getImgname());
			ps.setString(4, n.getOrgimgname());
			// 결과값을 받아올 필요가 없는 query는 executeUpdate()메소드로 query 실행
			// query 실행 후 상태를 status에 저장
			status = ps.executeUpdate(); 
			ps.close(); // 다 쓴 preparedStatement close
			con.close(); // 다 쓴 connection close
		} catch (Exception e) {
			System.out.println(e);
		}
		return status; // 상태 return
	}
	
	// notice table의 record를 update하는 메소드
	public static int update(Notice n) { // notice 객체를 파라미터로 받음
		int status = 0; // query 결과상태용 변수
		try {
			Connection con = getConnection(); // DB와 연결
			// PreparedStatement로 query문 세팅
			PreparedStatement ps = con.prepareStatement("update notice set title=?, content=?, imgname=?, orgimgname=? where id=?");
			// 파라미터로 받은 객체에서 getter를 이용해 세팅
			ps.setString(1, n.getTitle());
			ps.setString(2, n.getContent());
			ps.setString(3, n.getImgname());
			ps.setString(4, n.getOrgimgname());
			ps.setInt(5, n.getId());
			// 결과값을 받아올 필요가 없는 query는 executeUpdate()메소드로 query 실행
			// query 실행 후 상태를 status에 저장
			status = ps.executeUpdate(); 
			ps.close(); // 다 쓴 preparedStatement close
			con.close(); // 다 쓴 connection close
		} catch (Exception e) {
			System.out.println(e);
		}
		return status; // 상태 return
	}
	
	// 게시글의 조회수를 update 해주는 메소드
	public static int updateViewcnt(int id) { // 게시글 번호를 파라미터로 받음
		int status = 0; // query 결과상태용 변수
		try {
			Connection con = getConnection(); // DB와 연결
			// PreparedStatement로 query문 세팅
			PreparedStatement ps = con.prepareStatement("update notice set viewcnt=viewcnt+1 where id=?");
			// 조회수는 이전 조회수 + 1이므로 값 세팅을 viewcnt=viewcnt+1로 함
			ps.setInt(1, id);
			// 결과값을 받아올 필요가 없는 query는 executeUpdate()메소드로 query 실행
			// query 실행 후 상태를 status에 저장
			status = ps.executeUpdate();
			ps.close(); // 다 쓴 preparedStatement close
			con.close(); // 다 쓴 connection close
		} catch (Exception e) {
			System.out.println(e);
		}
		return status; // 상태 return
	}
	
	// 게시글 삭제 메소드
	public static int delete(Notice n) { // notice 객체를 파라미터로 받음
		int status = 0; // query 결과상태용 변수
		try {
			Connection con = getConnection(); // DB와 연결
			// PreparedStatement로 query문 세팅
			PreparedStatement ps = con.prepareStatement("delete from notice where id=?;");
			ps.setInt(1, n.getId());
			// 결과값을 받아올 필요가 없는 query는 executeUpdate()메소드로 query 실행
			// query 실행 후 상태를 status에 저장
			status = ps.executeUpdate();
			ps.close(); // 다 쓴 preparedStatement close
			con.close(); // 다 쓴 connection close
		} catch (Exception e) { 
			System.out.println(e);
		}
		return status; // 상태 return
	}

	// notice에서 모든 record를 가져오는 메소드
	public static List<Notice> getAllRecords() {
		List<Notice> list = new ArrayList<Notice>(); // 받아온 결과를 저장할 list 선언

		try {
			Connection con = getConnection(); // DB와 연결
			// PreparedStatement로 query문 세팅
			PreparedStatement ps = con.prepareStatement("select * from notice order by id desc;");
			ResultSet rs = ps.executeQuery(); // query 실행 후 결과값 ResultSet에 저장
			while (rs.next()) { // resultSet에 더 이상 내용이 없을 때까지 실행
				Notice n = new Notice(); // resultSet에 저장된 내용을 저장할 notice 객체 생성
				// 생성해둔 객체에 각 값 집어넣기
				n.setId(rs.getInt("id"));
				n.setTitle(rs.getString("title"));
				n.setDayOfRegister(rs.getDate("dayOfRegister"));
				n.setContent(rs.getString("content"));
				n.setViewcnt(rs.getInt("viewcnt"));
				n.setImgname(rs.getString("imgname"));
				n.setOrgimgname(rs.getString("orgimgname"));
				list.add(n); // 세팅한 객체를 list에 넣기
			} 
			rs.close(); // 다 쓴 resultset close
			ps.close(); // 다 쓴 preparedStatement close
			con.close(); // 다 쓴 connection close
		} catch (Exception e) {
			System.out.println(e);
		}
		return list; // 세팅된 list return
	}

	// notice에서 id값으로 select하는 메소드
	public static Notice getRecordById(int id) {
		Notice n = new Notice(); // select 결과를 담을 Notice 객체 생성
		try {
			Connection con = getConnection(); // DB와 연결
			// PreparedStatement로 query문 세팅
			PreparedStatement ps = con.prepareStatement("select * from notice where id=?");
			ps.setInt(1, id);
			ResultSet rs = ps.executeQuery(); // query 실행 후 결과값 ResultSet에 저장
			if(rs.next()) { // resultSet에 결과가 있으면
				// 생성해둔 객체에 각 값 집어넣기
				n.setId(rs.getInt("id"));
				n.setTitle(rs.getString("title"));
				n.setDayOfRegister(rs.getDate("dayOfRegister"));
				n.setContent(rs.getString("content"));
				n.setViewcnt(rs.getInt("viewcnt"));
				n.setImgname(rs.getString("imgname"));
				n.setOrgimgname(rs.getString("orgimgname"));
			}
			rs.close(); // 다 쓴 resultset close
			ps.close(); // 다 쓴 preparedStatement close
			con.close(); // 다 쓴 connection close
		} catch (Exception e) {
			System.out.println(e);
		}
		return n; // 세팅된 객체 return
	}
	
	// insert 후 새로 생성한 글로 바로 보여주기 위해 새로 생성된 글의 id 찾는 메소드
	public static int getRecordByLastest() { // 가장 최근의 id return
		int max_id = 0; // return할 값 저장할 변수 선언 후 0으로 초기화
		try {
			Connection con = getConnection(); // DB와 연결
			// PreparedStatement로 query문 세팅
			// auto_increment로 설정되어있으므로 id의 max값을 가져옴
			PreparedStatement ps = con.prepareStatement("select max(id) from notice;");
			ResultSet rs = ps.executeQuery(); // query 실행 후 결과값 ResultSet에 저장
			if(rs.next()) {
				max_id = rs.getInt("max(id)"); // 가져온 결과를 max_id에 대입
			}
			rs.close(); // 다 쓴 resultset close
			ps.close(); // 다 쓴 preparedStatement close
			con.close(); // 다 쓴 connection close
		} catch (Exception e) {
			System.out.println(e);
		}
		return max_id; // 최근의 id return
		
	}
}
