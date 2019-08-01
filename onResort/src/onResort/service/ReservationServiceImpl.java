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
				reservationdto.getRoom(), reservationdto.getAddr(), reservationdto.getTelnum(),
				reservationdto.getIn_name(), reservationdto.getComment(), reservationdto.getWrite_date(),
				reservationdto.getProcessing());
		return ReservationDao.insert(r);
	}

	@Override
	public ReservationDto selectOne(Date resv_date, int room) {
		Reservation r = ReservationDao.getRecordById(resv_date, room);
		return new ReservationDto(r.getName(), r.getResv_date(), r.getRoom(), r.getAddr(), r.getTelnum(),
				r.getIn_name(), r.getComment(), r.getWrite_date(), r.getProcessing());
	}

	@Override
	public List<ReservationDto> selectAll() {
		List<Reservation> reservations = ReservationDao.getAllRecords();
		List<ReservationDto> dtos = new ArrayList<ReservationDto>();
		for (Reservation r : reservations) {
			dtos.add(new ReservationDto(r.getName(), r.getResv_date(), r.getRoom(), r.getAddr(), r.getTelnum(),
					r.getIn_name(), r.getComment(), r.getWrite_date(), r.getProcessing()));
		}
		return dtos;
	}
	
	@Override
	public String[][] selectAllReservation() {
		return ReservationDao.getAllReservation();
	}

	@Override
	public int update(ReservationDto reservationdto) {
		return ReservationDao.updateReservation(
				new Reservation(reservationdto.getName(), reservationdto.getResv_date(), reservationdto.getRoom(),
						reservationdto.getAddr(), reservationdto.getTelnum(), reservationdto.getIn_name(),
						reservationdto.getComment(), reservationdto.getWrite_date(), reservationdto.getProcessing()));
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
						reservationdto.getAddr(), reservationdto.getTelnum(), reservationdto.getIn_name(),
						reservationdto.getComment(), reservationdto.getWrite_date(), reservationdto.getProcessing()));
	}

}
