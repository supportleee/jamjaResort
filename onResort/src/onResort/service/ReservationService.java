package onResort.service;

import java.util.Date;
import java.util.List;

import onResort.dto.ReservationDto;

public interface ReservationService {
	// Create
	int insert(ReservationDto reservationdto);

	// Read
	ReservationDto selectOne(Date resv_date, int room);

	List<ReservationDto> selectAll();
	
	String[][] selectAllReservation();

	// Update
	int update(ReservationDto reservationdto);

	int updateProcessing(Date resv_date, int room);

	// Delete
	int delete(Date resv_date, int room);

	int delete(ReservationDto reservationdto);

}
