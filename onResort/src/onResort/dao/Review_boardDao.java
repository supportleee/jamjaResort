package onResort.dao;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

import onResort.domain.Review_board;

public class Review_boardDao {
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

	// 후기 게시판에 새 글 작성 시 review_board 테이블에 record insert하는 메소드
	public static int insert(Review_board r) { // Review_board 객체를 파라미터로 받음
		int status = 0; // query 결과상태용 변수
		try {
			Connection con = getConnection(); // DB와 연결
			// PreparedStatement로 query문 세팅
			PreparedStatement ps = con.prepareStatement(
					"insert into review_board (title, dayOfRegister, content, rootid, imgname, orgimgname) values (?, now(), ?, (select auto_increment from information_schema.tables where table_name='review_board' and table_schema = database()), ?, ?)");
			// dayOfRegister는 입력 당시 시간으로 넣기 때문에 now()를 사용
			// 새 글의 rootid는 해당 record의 id값과 같으므로 현재 auto_increment값을 가져와서 넣는다.
			// 나머지 값은 파라미터로 받은 객체에서 getter를 이용해 세팅
			ps.setString(1, r.getTitle());
			ps.setString(2, r.getContent());
			ps.setString(3, r.getImgname());
			ps.setString(4, r.getOrgimgname());
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

	// 게시글에 답글을 달 경우 이 메소드로 record를 insert함
	public static int reinsert(Review_board r) { // Review_board 객체를 파라미터로 받음
		int status = 0; // query 결과상태용 변수
		try {
			Connection con = getConnection(); // DB와 연결
			// PreparedStatement로 query문 세팅
			PreparedStatement ps = con.prepareStatement(
					"insert into review_board (title, dayOfRegister, content, rootid, relevel, recnt, imgname, orgimgname) values (?, now(), ?, ?, ?, ?, ?, ?)");
			// dayOfRegister는 입력 당시 시간으로 넣기 때문에 now()를 사용
			// 답글의 rootid는 insert 페이지에서 넘어온 rootid 파라미터로 설정된 값으로 넣는다.
			// 나머지 값은 파라미터로 받은 객체에서 getter를 이용해 세팅
			ps.setString(1, r.getTitle());
			ps.setString(2, r.getContent());
			ps.setInt(3, r.getRootid());
			ps.setInt(4, r.getRelevel());
			ps.setInt(5, r.getRecnt());
			ps.setString(6, r.getImgname());
			ps.setString(7, r.getOrgimgname());
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

	// 게시글 수정 시 review_board tabled의 record를 update하는 메소드
	public static int update(Review_board r) { // Review_board 객체를 파라미터로 받음
		int status = 0; // query 결과상태용 변수
		try {
			Connection con = getConnection(); // DB와 연결
			// PreparedStatement로 query문 세팅
			PreparedStatement ps = con
					.prepareStatement("update review_board set title=?, content=?, imgname=?, orgimgname=? where id=?");
			// 파라미터로 받은 객체에서 getter를 이용해 세팅
			ps.setString(1, r.getTitle());
			ps.setString(2, r.getContent());
			ps.setString(3, r.getImgname());
			ps.setString(4, r.getOrgimgname());
			ps.setInt(5, r.getId());
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
			PreparedStatement ps = con.prepareStatement("update review_board set viewcnt=viewcnt+1 where id=?");
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

	// 답글 사이에 답글이 추가되거나 할 때 추가되는 답글 뒤 리스트의 recnt를 업데이트 해주는 메소드
	public static int updateRecnt(int recnt, int rootid) {
		int status = 0; // query 결과상태용 변수
		try {
			Connection con = getConnection(); // DB와 연결
			// PreparedStatement로 query문 세팅
			PreparedStatement ps = con
					.prepareStatement("update review_board set recnt=recnt+1 where rootid=? and recnt >= ?");
			// 들어온 recnt부터 마지막까지의 게시글의 모든 recnt를 +1해준다.
			ps.setInt(1, rootid);
			ps.setInt(2, recnt);
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
	public static int delete(Review_board r) { // review_board 객체를 파라미터로 받음
		int status = 0; // query 결과상태용 변수
		try {
			Connection con = getConnection(); // DB와 연결
			// PreparedStatement로 query문 세팅
			PreparedStatement ps = con.prepareStatement("delete from review_board where id=?;");
			ps.setInt(1, r.getId());
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

	// 글 삭제시 자식 글까지 모두 지워지도록 하는 메소드
	public static int deleteAllReply(Review_board r) { // review_board 객체를 파라미터로 받음
		int status = 0; // query 결과상태용 변수
		try {
			Connection con = getConnection(); // DB와 연결
			// 들어온 값의 rootid와 같고 recnt보다 큰 목록을 조회
			PreparedStatement ps = con.prepareStatement(
					"select title, rootid, relevel, recnt from review_board where rootid=? and recnt>? order by recnt asc;");
			ps.setInt(1, r.getRootid());
			ps.setInt(2, r.getRecnt());
			ResultSet rs = ps.executeQuery();
			int finalChild = r.getRecnt(); // 해당 게시글의 마지막 자식의 순서를 저장할 변수
			while (rs.next()) {
				if (rs.getInt("relevel") <= r.getRelevel()) { // 조회한 값에서 삭제하려는 글의 relevel보다 작거나 같은 relevel을 만나면 while문 나가기
					break;
				}
				finalChild = rs.getInt("recnt"); // recnt값으로 finalChild의 recnt 넣기

			}
			// rootid가 같고 recnt의 범위가 삭제하려는 글의 recnt부터 finalChild까지인 기록들 삭제하기
			ps = con.prepareStatement("delete from review_board where rootid=? and recnt between ? and ?;");
			ps.setInt(1, r.getRootid());
			ps.setInt(2, r.getRecnt());
			ps.setInt(3, finalChild);
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

	// review_board에서 모든 record를 가져오는 메소드
	public static List<Review_board> getAllRecords() {
		List<Review_board> list = new ArrayList<Review_board>(); // 받아온 결과를 저장할 list 선언

		try {
			Connection con = getConnection(); // DB와 연결
			// PreparedStatement로 query문 세팅
			// 최근 글이 위로 올라오므로 rootid는 내림차순으로, recnt는 오름차순으로 정렬해서 select
			PreparedStatement ps = con.prepareStatement("select * from review_board order by rootid desc, recnt asc;");
			ResultSet rs = ps.executeQuery(); // query 실행 후 결과값 ResultSet에 저장
			while (rs.next()) { // resultSet에 더 이상 내용이 없을 때까지 실행
				Review_board r = new Review_board(); // resultSet에 저장된 내용을 저장할 Review_board 객체 생성
				// 생성해둔 객체에 각 값 집어넣기
				r.setId(rs.getInt("id"));
				r.setTitle(rs.getString("title"));
				r.setDayOfRegister(rs.getDate("dayOfRegister"));
				r.setContent(rs.getString("content"));
				r.setRootid(rs.getInt("rootid"));
				r.setRelevel(rs.getInt("relevel"));
				r.setRecnt(rs.getInt("recnt"));
				r.setViewcnt(rs.getInt("viewcnt"));
				r.setImgname(rs.getString("imgname"));
				r.setOrgimgname(rs.getString("orgimgname"));
				list.add(r); // 세팅한 객체를 list에 넣기
			}
			rs.close(); // 다 쓴 resultset close
			ps.close(); // 다 쓴 preparedStatement close
			con.close(); // 다 쓴 connection close
		} catch (Exception e) {
			System.out.println(e);
		}
		return list; // 세팅된 list return
	}

	// review_board에서 id값으로 select하는 메소드
	public static Review_board getRecordById(int id) {
		Review_board r = new Review_board(); // select 결과를 담을 Review_board 객체 생성
		try {
			Connection con = getConnection(); // DB와 연결
			// PreparedStatement로 query문 세팅
			PreparedStatement ps = con.prepareStatement("select * from review_board where id=?");
			ps.setInt(1, id);
			ResultSet rs = ps.executeQuery(); // query 실행 후 결과값 ResultSet에 저장
			if (rs.next()) { // resultSet에 결과가 있으면
				// 생성해둔 객체에 각 값 집어넣기
				r.setId(rs.getInt("id"));
				r.setTitle(rs.getString("title"));
				r.setDayOfRegister(rs.getDate("dayOfRegister"));
				r.setContent(rs.getString("content"));
				r.setRootid(rs.getInt("rootid"));
				r.setRelevel(rs.getInt("relevel"));
				r.setRecnt(rs.getInt("recnt"));
				r.setViewcnt(rs.getInt("viewcnt"));
				r.setImgname(rs.getString("imgname"));
				r.setOrgimgname(rs.getString("orgimgname"));
			}
			rs.close(); // 다 쓴 resultset close
			ps.close(); // 다 쓴 preparedStatement close
			con.close(); // 다 쓴 connection close
		} catch (Exception e) {
			System.out.println(e); // 세팅된 객체 return
		}
		return r;
	}

	// insert 후 새로 생성한 글로 바로 보여주기 위해 새로 생성된 글의 id 찾는 메소드
	public static int getRecordByLastest() { // 가장 최근의 id return
		int max_id = 0; // return할 값 저장할 변수 선언 후 0으로 초기화
		try {
			Connection con = getConnection(); // DB와 연결
			// PreparedStatement로 query문 세팅
			// auto_increment로 설정되어있으므로 id의 max값을 가져옴
			PreparedStatement ps = con.prepareStatement("select max(id) from review_board;");
			ResultSet rs = ps.executeQuery(); // query 실행 후 결과값 ResultSet에 저장
			if (rs.next()) {
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
