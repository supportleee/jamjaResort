package onResort.dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.List;
import java.sql.*;

import onResort.domain.Reservation;

public class ReservationDao {
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

	public static int insert(Reservation r) {
		int status = 0;
		try {
			Connection con = getConnection();
			PreparedStatement ps = con
					.prepareStatement("insert into reservation values (?, ?, ?, ?, ?, ?, ?, now(), 1);");
			ps.setString(1, r.getName());
			ps.setDate(2, new java.sql.Date(r.getResv_date().getTime()));
			ps.setInt(3, r.getRoom());
			ps.setString(4, r.getAddr());
			ps.setString(5, r.getTelnum());
			ps.setString(6, r.getIn_name());
			ps.setString(7, r.getComment());
			status = ps.executeUpdate();
			ps.close();
			con.close();
		} catch (SQLIntegrityConstraintViolationException e) {
			status = -2;
		} catch (Exception e) {
			System.out.println(e);
			status = -1;
		}
		return status;
	}

	public static int updateReservation(Reservation r) {
		int status = 0;
		try {
			Connection con = getConnection();
			PreparedStatement ps = con.prepareStatement(
					"update reservation set name=?, resv_date=?, room=?, addr=?, telnum=?, in_name=?, comment=?, write_date=now() where resv_date=? and room=?");
			ps.setString(1, r.getName());
			ps.setDate(2, new java.sql.Date(r.getResv_date().getTime()));
			ps.setInt(3, r.getRoom());
			ps.setString(4, r.getAddr());
			ps.setString(5, r.getTelnum());
			ps.setString(6, r.getIn_name());
			ps.setString(7, r.getComment());
			ps.setDate(8, new java.sql.Date(r.getResv_date().getTime()));
			ps.setInt(9, r.getRoom());
			status = ps.executeUpdate();
			ps.close();
			con.close();
		} catch (Exception e) {
			System.out.println(e);
		}
		return status;
	}

	public static int updateResvProcessing(Reservation r) {
		int status = 0;
		try {
			Connection con = getConnection();
			PreparedStatement ps = con
					.prepareStatement("update reservation set processing=? where resv_date=? and room=?");
			ps.setInt(1, r.getProcessing());
			ps.setDate(2, new java.sql.Date(r.getResv_date().getTime()));
			ps.setInt(3, r.getRoom());
			status = ps.executeUpdate();
			ps.close();
			con.close();
		} catch (Exception e) {
			System.out.println(e);
		}
		return status;
	}

	public static int delete(Reservation r) {
		int status = 0;
		try {
			Connection con = getConnection();
			PreparedStatement ps = con.prepareStatement("delete from reservation where resv_date=? and room=?;");
			ps.setDate(1, new java.sql.Date(r.getResv_date().getTime()));
			ps.setInt(2, r.getRoom());
			status = ps.executeUpdate();
			ps.close();
			con.close();
		} catch (Exception e) {
			System.out.println(e);
		}
		return status;
	}

	public static List<Reservation> getAllRecords() {
		List<Reservation> list = new ArrayList<Reservation>();

		try {
			Connection con = getConnection();
			PreparedStatement ps = con.prepareStatement("select * from reservation;");
			ResultSet rs = ps.executeQuery();
			while (rs.next()) {
				Reservation r = new Reservation();
				r.setName(rs.getString("name"));
				r.setResv_date(rs.getDate("resv_date"));
				r.setRoom(rs.getInt("room"));
				r.setAddr(rs.getString("addr"));
				r.setTelnum(rs.getString("telnum"));
				r.setIn_name(rs.getString("in_name"));
				r.setComment(rs.getString("comment"));
				r.setWrite_date(rs.getDate("write_date"));
				r.setProcessing(rs.getInt("processing"));
				list.add(r);
			}
			rs.close();
			ps.close();
			con.close();
		} catch (Exception e) {
			System.out.println(e);
		}
		return list;
	}
	
	public static String[][] getAllReservation() {
		String[][] resv_arr = new String[5][30];
		try {
			Connection con = getConnection();
			PreparedStatement ps = con.prepareStatement("select c.selected_date, r.room, r.name from reservation as r right join (select * from " + 
					"(select adddate('1970-01-01',t4.i*10000 + t3.i*1000 + t2.i*100 + t1.i*10 + t0.i) selected_date from" + 
					" (select 0 i union select 1 union select 2 union select 3 union select 4 union select 5 union select 6 union select 7 union select 8 union select 9) t0," + 
					" (select 0 i union select 1 union select 2 union select 3 union select 4 union select 5 union select 6 union select 7 union select 8 union select 9) t1," + 
					" (select 0 i union select 1 union select 2 union select 3 union select 4 union select 5 union select 6 union select 7 union select 8 union select 9) t2," + 
					" (select 0 i union select 1 union select 2 union select 3 union select 4 union select 5 union select 6 union select 7 union select 8 union select 9) t3," + 
					" (select 0 i union select 1 union select 2 union select 3 union select 4 union select 5 union select 6 union select 7 union select 8 union select 9) t4) v " + 
					"where selected_date between current_date() and current_date()+interval 29 day)c on r.resv_date = c.selected_date order by selected_date asc, room asc;");
			ResultSet rs = ps.executeQuery();
			Calendar cal = Calendar.getInstance();
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
			String korDayOfWeek = "";
			for(int i=0; i<30; i++) {
				switch(cal.get(Calendar.DAY_OF_WEEK)) {
				case 1:
					korDayOfWeek ="일";
					break;
				case 2:
					korDayOfWeek ="월";
					break;
				case 3:
					korDayOfWeek ="화";
					break;
				case 4:
					korDayOfWeek ="수";
					break;
				case 5:
					korDayOfWeek ="목";
					break;
				case 6:
					korDayOfWeek ="금";
					break;
				case 7:
					korDayOfWeek ="토";
					break;
				}
				resv_arr[0][i] = sdf.format(cal.getTime());
				resv_arr[1][i] = korDayOfWeek;
				cal.add(cal.DATE, +1);
			}
			int i=0;
			String rs_date= "";
			String rs_next_date = "";
			while(rs.next()) {
				rs_next_date = rs.getDate(1).toString();
				if(!rs_date.equals("")) {
					if(!rs_date.equals(rs_next_date)) {
						i++;
					}
				}
				if(resv_arr[0][i].equals(rs.getDate(1).toString())) {
					if(rs.getInt(2)==1) {
						resv_arr[2][i] = rs.getString(3);
					} else if(rs.getInt(2)==2) {
						resv_arr[3][i] = rs.getString(3);
					} else if(rs.getInt(2)==3) {
						resv_arr[4][i] = rs.getString(3);
					}
				}				
				rs_date = rs_next_date;
			}
			
		} catch(Exception e) {
			System.out.println(e);
		}
		return resv_arr;
	}

	public static Reservation getRecordById(Date resv_date, int room) {
		Reservation r = new Reservation();
		try {
			Connection con = getConnection();
			PreparedStatement ps = con.prepareStatement("select * from reservation where resv_date=?, room=?;");
			ps.setDate(1, new java.sql.Date(resv_date.getTime()));
			ps.setInt(2, room);
			ResultSet rs = ps.executeQuery();
			if (rs.next()) {
				r.setName(rs.getString("name"));
				r.setResv_date(rs.getDate("resv_date"));
				r.setRoom(rs.getInt("room"));
				r.setAddr(rs.getString("addr"));
				r.setTelnum(rs.getString("telnum"));
				r.setIn_name(rs.getString("in_name"));
				r.setComment(rs.getString("comment"));
				r.setWrite_date(rs.getDate("write_date"));
				r.setProcessing(rs.getInt("processing"));
			}
			rs.close();
			ps.close();
			con.close();
		} catch (Exception e) {
			System.out.println(e);
		}
		return r;
	}

}
