package onResort.service;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.List;

import onResort.dao.ReservationDao;
import onResort.domain.Reservation;
import onResort.dto.ReservationDto;

public class ReservationServiceImpl implements ReservationService {

	@Override
	public int insert(ReservationDto reservationdto) {
		Reservation r = new Reservation(reservationdto.getName(), reservationdto.getResv_date(),
				reservationdto.getRoom(), reservationdto.getPostcode(), reservationdto.getRoadAddress(), reservationdto.getDetailAddress(),reservationdto.getExtraAddress(), reservationdto.getTelnum(),
				reservationdto.getIn_name(), reservationdto.getComment(), reservationdto.getWrite_date(),
				reservationdto.getProcessing());
		return ReservationDao.insert(r);
	}

	@Override
	public ReservationDto selectOne(Date resv_date, int room) {
		Reservation r = ReservationDao.getRecordById(resv_date, room);
		return new ReservationDto(r.getName(), r.getResv_date(), r.getRoom(), r.getPostcode(), r.getRoadAddress(), r.getDetailAddress(), r.getExtraAddress(), r.getTelnum(),
				r.getIn_name(), r.getComment(), r.getWrite_date(), r.getProcessing());
	}

	@Override
	public List<ReservationDto> selectAll() {
		List<Reservation> reservations = ReservationDao.getAllRecords();
		List<ReservationDto> dtos = new ArrayList<ReservationDto>();
		for (Reservation r : reservations) {
			dtos.add(new ReservationDto(r.getName(), r.getResv_date(), r.getRoom(), r.getPostcode(), r.getRoadAddress(), r.getDetailAddress(), r.getExtraAddress(), r.getTelnum(),
					r.getIn_name(), r.getComment(), r.getWrite_date(), r.getProcessing()));
		}
		return dtos;
	}
	
	@Override
	public String[][] selectAllReservation() {
		List<Reservation> reservations = ReservationDao.getAllReservation();
		String[][] resv_arr = new String[30][5];
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
			resv_arr[i][0] = sdf.format(cal.getTime());
			resv_arr[i][1] = korDayOfWeek;
			cal.add(cal.DATE, +1);
		}
		int i=0;
		String rs_date= "";
		String rs_next_date = "";
		for(Reservation r : reservations) {
			rs_next_date = r.getResv_date().toString();
			if(!rs_date.equals("")) {
				if(!rs_date.equals(rs_next_date)) {
					i++;
				}
			}
			if(resv_arr[i][0].equals(rs_next_date)) {
				if(r.getRoom()==1) {
					resv_arr[i][2] = r.getName();
				} else if(r.getRoom()==2) {
					resv_arr[i][3] = r.getName();
				} else if(r.getRoom()==3) {
					resv_arr[i][4] = r.getName();
				}
			}				
			rs_date = rs_next_date;
		}
		return resv_arr;
	}

	@Override
	public int update(ReservationDto reservationdto, Date resv_date_before, int room_before) {
		return ReservationDao.updateReservation(
				new Reservation(reservationdto.getName(), reservationdto.getResv_date(), reservationdto.getRoom(),
						reservationdto.getPostcode(), reservationdto.getRoadAddress(), reservationdto.getDetailAddress(),reservationdto.getExtraAddress(), reservationdto.getTelnum(), reservationdto.getIn_name(),
						reservationdto.getComment(), reservationdto.getWrite_date(), reservationdto.getProcessing()),resv_date_before, room_before);
	}

	@Override
	public int updateProcessing(Date resv_date, int room) {
		Reservation r = ReservationDao.getRecordById(resv_date, room);
		return ReservationDao.updateResvProcessing(r);
	}

	@Override
	public int delete(Date resv_date, int room) {
		Reservation r = ReservationDao.getRecordById(resv_date, room);
		return ReservationDao.delete(r);
	}

	@Override
	public int delete(ReservationDto reservationdto) {
		return ReservationDao.delete(new Reservation(reservationdto.getName(), reservationdto.getResv_date(), reservationdto.getRoom(),
				reservationdto.getPostcode(), reservationdto.getRoadAddress(), reservationdto.getDetailAddress(),reservationdto.getExtraAddress(), reservationdto.getTelnum(), reservationdto.getIn_name(),
						reservationdto.getComment(), reservationdto.getWrite_date(), reservationdto.getProcessing()));
	}

}
