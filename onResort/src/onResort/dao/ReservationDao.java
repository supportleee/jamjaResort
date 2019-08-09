// 리조트 예약 DAO
package onResort.dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.sql.*;

import onResort.domain.Reservation;

public class ReservationDao {
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

	// 예약 내역을 reservation table에 insert하는 메소드
	public static int insert(Reservation r) { // 파라미터로는 Reservation 객체 받음
		int status = 0; // query 결과상태용 변수
		try {
			Connection con = getConnection(); // DB와 연결
			// PreparedStatement로 query문 세팅
			PreparedStatement ps = con
					.prepareStatement("insert into reservation values (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, now(), 1);");
			// 예약일자는 입력 당시 시간으로 넣기 때문에 now()를 사용
			// 나머지 값은 파라미터로 받은 객체에서 getter를 이용해 세팅
			ps.setString(1, r.getName());
			// query 세팅시 setDate는 java.sql.Date 형식의 객체만 파라미터로 받기 때문에
			// reservation 객체(java.util.Date)의 date를 java.sql.Date 형식으로 변환하여 넣는다
			ps.setDate(2, new java.sql.Date(r.getResv_date().getTime()));
			ps.setInt(3, r.getRoom());
			ps.setString(4, r.getPostcode());
			ps.setString(5, r.getRoadAddress());
			ps.setString(6, r.getDetailAddress());
			ps.setString(7, r.getExtraAddress());
			ps.setString(8, r.getTelnum());
			ps.setString(9, r.getIn_name());
			ps.setString(10, r.getComment());
			// 결과값을 받아올 필요가 없는 query는 executeUpdate()메소드로 query 실행
			// query 실행 후 상태를 status에 저장
			status = ps.executeUpdate();
			ps.close(); // 다 쓴 preparedStatement close
			con.close(); // 다 쓴 connection close
		} catch (SQLIntegrityConstraintViolationException e) { // insert할 때 이미 예약된 방일 경우
			status = -2; // status를 -2로 설정
		} catch (Exception e) { // 그외의 에러 발생시
			System.out.println(e);
			status = -1; // status를 -1로 설정
		} // 정상 실행 시 status = 1
		return status; // 상태 return
	}

	// 이미 예약된 내역 수정하는 메소드 (파라미터로 reservation 객체와 변경전 예약일자/방번호를 받음)
	public static int updateReservation(Reservation r, Date resv_date_before, int room_before) {
		int status = 0; // query 결과상태용 변수
		try {
			Connection con = getConnection(); // DB와 연결
			// PreparedStatement로 query문 세팅
			PreparedStatement ps = con.prepareStatement(
					"update reservation set name=?, resv_date=?, room=?, postcode=?, roadAddress=?, detailAddress=?, extraAddress=?, telnum=?, in_name=?, comment=?, write_date=now(), processing=? where resv_date=? and room=?");
			// 바꿀 record는 변경 전 예약일자/방번호를 기준으로 바꾸기 때문에 where에 사용함
			// 나머지 내용은 파라미터로 받아온 reservation 객체의 getter를 이용해 세팅
			ps.setString(1, r.getName());
			// query 세팅시 setDate는 java.sql.Date 형식의 객체만 파라미터로 받기 때문에
			// reservation 객체(java.util.Date)의 date를 java.sql.Date 형식으로 변환하여 넣는다
			ps.setDate(2, new java.sql.Date(r.getResv_date().getTime()));
			ps.setInt(3, r.getRoom());
			ps.setString(4, r.getPostcode());
			ps.setString(5, r.getRoadAddress());
			ps.setString(6, r.getDetailAddress());
			ps.setString(7, r.getExtraAddress());
			ps.setString(8, r.getTelnum());
			ps.setString(9, r.getIn_name());
			ps.setString(10, r.getComment());
			ps.setInt(11, r.getProcessing());
			// query 세팅시 setDate는 java.sql.Date 형식의 객체만 파라미터로 받기 때문에
			// reservation 객체(java.util.Date)의 date를 java.sql.Date 형식으로 변환하여 넣는다
			ps.setDate(12, new java.sql.Date(resv_date_before.getTime()));
			ps.setInt(13, room_before);
			// 결과값을 받아올 필요가 없는 query는 executeUpdate()메소드로 query 실행
			// query 실행 후 상태를 status에 저장
			status = ps.executeUpdate();
			ps.close(); // 다 쓴 preparedStatement close
			con.close(); // 다 쓴 connection close
		} catch (SQLIntegrityConstraintViolationException e) { // update 시 이미 예약된 방이면
			status = -2; // status를 -2로 설정
		} catch (Exception e) { // 그 외의 에러 발생 시
			System.out.println(e);
			status = -1; // status를 -1로 설정
		}
		return status; // 상태 return
	}

	// 예약 처리 진행상태만 변경하고 싶을 때 사용하는 메소드
	public static int updateResvProcessing(Reservation r) { // 파라미터로 reservation 객체를 받음
		int status = 0; // query 결과상태용 변수
		try {
			Connection con = getConnection(); // DB와 연결
			// PreparedStatement로 query문 세팅
			PreparedStatement ps = con
					.prepareStatement("update reservation set processing=? where resv_date=? and room=?");
			// 파라미터로 받아온 reservation 객체의 getter를 이용해 세팅
			ps.setInt(1, r.getProcessing());
			// query 세팅시 setDate는 java.sql.Date 형식의 객체만 파라미터로 받기 때문에
			// reservation 객체(java.util.Date)의 date를 java.sql.Date 형식으로 변환하여 넣는다
			ps.setDate(2, new java.sql.Date(r.getResv_date().getTime()));
			ps.setInt(3, r.getRoom());
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

	// 예약 삭제 처리 메소드. 파라미터로 reservation 객체를 받음
	public static int delete(Reservation r) {
		int status = 0; // query 결과상태용 변수
		try {
			Connection con = getConnection(); // DB와 연결
			// PreparedStatement로 query문 세팅
			PreparedStatement ps = con.prepareStatement("delete from reservation where resv_date=? and room=?;");
			// query 세팅시 setDate는 java.sql.Date 형식의 객체만 파라미터로 받기 때문에
			// reservation 객체(java.util.Date)의 date를 java.sql.Date 형식으로 변환하여 넣는다
			ps.setDate(1, new java.sql.Date(r.getResv_date().getTime()));
			ps.setInt(2, r.getRoom());
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

	// reservation 테이블의 모든 record 조회하는 메소드
	public static List<Reservation> getAllRecords() {
		List<Reservation> list = new ArrayList<Reservation>(); // 받아온 결과를 저장할 list 선언

		try {
			Connection con = getConnection(); // DB와 연결
			// PreparedStatement로 query문 세팅
			PreparedStatement ps = con.prepareStatement("select * from reservation;");
			ResultSet rs = ps.executeQuery(); // query 실행 후 결과값 ResultSet에 저장
			while (rs.next()) { // resultSet에 더 이상 내용이 없을 때까지 실행
				// resultSet에 저장된 내용을 저장할 Reservation 객체 생성
				Reservation r = new Reservation();
				// 생성해둔 객체에 각 값 집어넣기
				r.setName(rs.getString("name"));
				r.setResv_date(rs.getDate("resv_date"));
				r.setRoom(rs.getInt("room"));
				r.setPostcode(rs.getString("postcode"));
				r.setRoadAddress(rs.getString("roadAddress"));
				r.setDetailAddress(rs.getString("detailAddress"));
				r.setExtraAddress(rs.getString("extraAddress"));
				r.setTelnum(rs.getString("telnum"));
				r.setIn_name(rs.getString("in_name"));
				r.setComment(rs.getString("comment"));
				r.setWrite_date(rs.getDate("write_date"));
				r.setProcessing(rs.getInt("processing"));
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

	// 실행 시 날짜부터 30일치의 예약되지 않은 방까지 모두 조회하는 메소드(예약되지 않은 방은 null로 결과가 옴)
	public static List<Reservation> getAllReservation() {
		List<Reservation> list = new ArrayList<Reservation>(); // select해 온 결과를 담을 list 선언
		try {
			Connection con = getConnection(); // DB와 연결
			// PreparedStatement로 query문 세팅
			// reservation 테이블과 오늘~30일치 날짜 테이블을 right join해서 전체 record 보는 쿼리
			PreparedStatement ps = con.prepareStatement(
					"select c.selected_date, r.room, r.name from reservation as r right join (select * from "
							+ "(select adddate('1970-01-01',t4.i*10000 + t3.i*1000 + t2.i*100 + t1.i*10 + t0.i) selected_date from"
							+ " (select 0 i union select 1 union select 2 union select 3 union select 4 union select 5 union select 6 union select 7 union select 8 union select 9) t0,"
							+ " (select 0 i union select 1 union select 2 union select 3 union select 4 union select 5 union select 6 union select 7 union select 8 union select 9) t1,"
							+ " (select 0 i union select 1 union select 2 union select 3 union select 4 union select 5 union select 6 union select 7 union select 8 union select 9) t2,"
							+ " (select 0 i union select 1 union select 2 union select 3 union select 4 union select 5 union select 6 union select 7 union select 8 union select 9) t3,"
							+ " (select 0 i union select 1 union select 2 union select 3 union select 4 union select 5 union select 6 union select 7 union select 8 union select 9) t4) v "
							+ "where selected_date between current_date() and current_date()+interval 29 day)c on r.resv_date = c.selected_date order by selected_date asc, room asc;");
			ResultSet rs = ps.executeQuery(); // query 실행 후 결과값 ResultSet에 저장
			while (rs.next()) { // resultSet에 더 이상 내용이 없을 때까지 실행
				// resultSet에 저장된 내용을 저장할 Reservation 객체 생성
				Reservation r = new Reservation();
				// 생성해둔 객체에 각 값 집어넣기
				r.setResv_date(rs.getDate(1));
				r.setRoom(rs.getInt(2));
				r.setName(rs.getString(3));
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

	// reservation 테이블에서 예약날짜와 방번호로 select하는 메소드 (파라미터로는 예약날짜와 방번호를 받음)
	public static Reservation getRecordById(Date resv_date, int room) {
		Reservation r = new Reservation(); // select 결과를 담을 Reservation 객체 생성
		try {
			Connection con = getConnection(); // DB와 연결
			// PreparedStatement로 query문 세팅
			PreparedStatement ps = con.prepareStatement("select * from reservation where resv_date=? and room=?;");
			ps.setDate(1, new java.sql.Date(resv_date.getTime()));
			ps.setInt(2, room);
			ResultSet rs = ps.executeQuery();  // query 실행 후 결과값 ResultSet에 저장
			if (rs.next()) { // resultSet에 결과가 있으면
				// 생성해둔 객체에 각 값 집어넣기
				r.setName(rs.getString("name"));
				r.setResv_date(rs.getDate("resv_date"));
				r.setRoom(rs.getInt("room"));
				r.setPostcode(rs.getString("postcode"));
				r.setRoadAddress(rs.getString("roadAddress"));
				r.setDetailAddress(rs.getString("detailAddress"));
				r.setExtraAddress(rs.getString("extraAddress"));
				r.setTelnum(rs.getString("telnum"));
				r.setIn_name(rs.getString("in_name"));
				r.setComment(rs.getString("comment"));
				r.setWrite_date(rs.getDate("write_date"));
				r.setProcessing(rs.getInt("processing"));
			}
			rs.close(); // 다 쓴 resultset close
			ps.close(); // 다 쓴 preparedStatement close
			con.close(); // 다 쓴 connection close
		} catch (Exception e) {
			System.out.println(e);
		}
		return r; // 세팅된 객체 return
	}

}
