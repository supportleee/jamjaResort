// reservation의 Service interface를 실제 구현한 부분
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

	// DAO의 insert를 사용하기 위해 받아온 dto를 domain으로 변환하여 실행
	@Override
	public int insert(ReservationDto reservationdto) {
		Reservation r = new Reservation(reservationdto.getName(), reservationdto.getResv_date(),
				reservationdto.getRoom(), reservationdto.getPostcode(), reservationdto.getRoadAddress(), reservationdto.getDetailAddress(),reservationdto.getExtraAddress(), reservationdto.getTelnum(),
				reservationdto.getIn_name(), reservationdto.getComment(), reservationdto.getWrite_date(),
				reservationdto.getProcessing());
		return ReservationDao.insert(r);
	}

	// 받아온 값으로 DAO의 getRecordById()를 호출하여 reservation 객체로 값을 받아온 후 DTO로 변환하여 return
	@Override
	public ReservationDto selectOne(Date resv_date, int room) {
		Reservation r = ReservationDao.getRecordById(resv_date, room);
		return new ReservationDto(r.getName(), r.getResv_date(), r.getRoom(), r.getPostcode(), r.getRoadAddress(), r.getDetailAddress(), r.getExtraAddress(), r.getTelnum(),
				r.getIn_name(), r.getComment(), r.getWrite_date(), r.getProcessing());
	}

	// reservation의 모든 record를 받아오는 메소드
	@Override
	public List<ReservationDto> selectAll() {
		List<Reservation> reservations = ReservationDao.getAllRecords(); // DAO에서 getAllRecords()메소드로 모든 record를 list에 받아오기(reservations)
		List<ReservationDto> dtos = new ArrayList<ReservationDto>(); // 받아온 값을 DTO로 변환하기 위해 List변수 선언
		for (Reservation r : reservations) { // 전체 list size만큼 반복 실행
			//dto 리스트에 dto 객체료 변환한 내용 넣기
			dtos.add(new ReservationDto(r.getName(), r.getResv_date(), r.getRoom(), r.getPostcode(), r.getRoadAddress(), r.getDetailAddress(), r.getExtraAddress(), r.getTelnum(),
					r.getIn_name(), r.getComment(), r.getWrite_date(), r.getProcessing()));
		}
		return dtos; // dto 리스트 return
	}
	
	// select한 결과를 배열로 처리하는 메소드(요일 넣기 등)
	@Override
	public String[][] selectAllReservation() {
		List<Reservation> reservations = ReservationDao.getAllReservation(); // DAO에서 getAllRecords()메소드로 모든 record를 list에 받아오기(reservations)
		String[][] resv_arr = new String[30][5]; // 값을 넣을 배열 선언(30일치의 5항목이므로 30*5)
		Calendar cal = Calendar.getInstance(); // 요일 계산을 위해 calendar 객체 선언
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd"); // 날짜 포맷을 yyyy-MM-dd형식으로 지정
		String korDayOfWeek = ""; // 요일 저장 변수
		for(int i=0; i<30; i++) { // 총 30일치이므로 30번 수행
			switch(cal.get(Calendar.DAY_OF_WEEK)) { // calendar의 요일 변수로 switch case 판별
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
			resv_arr[i][0] = sdf.format(cal.getTime()); // 배열의 첫번째 항에 날짜 입력
			resv_arr[i][1] = korDayOfWeek; // 배열의 두번째 항에 요일 입력
			cal.add(cal.DATE, +1); // 날짜 하루 추가
		}
		int i=0; // 30일만큼의 값을 바꾸기 위해 변수 선언
		// 가져온 데이터는 30개가 넘는 데이터일 경우가 있음
		// 한 날짜에 여러 방이 예약되어 있는 경우 각 방마다 레코드가 나옴
		String rs_date= ""; // 이전 list item의 예약일자 저장용 변수
		String rs_next_date = ""; // 현재 list item의 예약일자 저장 변수
		for(Reservation r : reservations) { // 전체 리스트 size만큼 수행
			rs_next_date = r.getResv_date().toString(); // 현재 item의 날짜를 rs_next_date에 저장
			if(!rs_date.equals("")) {
				if(!rs_date.equals(rs_next_date)) {
					i++; // 이전 저장한 값과 비교했을 때 다르면 카운트 늘리기(배열 다음 행으로 이동)
				}
			}
			if(resv_arr[i][0].equals(rs_next_date)) { // 이전 저장한 값과 똑같으면 해당 행에 값 넣기
				// room 번호에 따라 배열에 넣을 위치 지정하여 넣어줌
				if(r.getRoom()==1) {
					resv_arr[i][2] = r.getName();
				} else if(r.getRoom()==2) {
					resv_arr[i][3] = r.getName();
				} else if(r.getRoom()==3) {
					resv_arr[i][4] = r.getName();
				}
			}				
			rs_date = rs_next_date; // 다음 item으로 넘어가기 위해 현재 날짜를 rs_date에 넣어줌
		}
		return resv_arr; // 세팅된 배열 return
	}

	// DAO의 update를 실행하기 위한 메소드(파라미터로 key(resv_date_before, room_before)값과 reservationdto를 받음)
	@Override
	public int update(ReservationDto reservationdto, Date resv_date_before, int room_before) {
		return ReservationDao.updateReservation(
				new Reservation(reservationdto.getName(), reservationdto.getResv_date(), reservationdto.getRoom(),
						reservationdto.getPostcode(), reservationdto.getRoadAddress(), reservationdto.getDetailAddress(),reservationdto.getExtraAddress(), reservationdto.getTelnum(), reservationdto.getIn_name(),
						reservationdto.getComment(), reservationdto.getWrite_date(), reservationdto.getProcessing()),resv_date_before, room_before);
	}

	// 예약상황 처리만 update할 경우 사용하는 메소드
	@Override
	public int updateProcessing(Date resv_date, int room) {
		// 받아온 값으로 selectOne하여 객체 생성
		Reservation r = ReservationDao.getRecordById(resv_date, room);
		return ReservationDao.updateResvProcessing(r); // 생성된 객체를 파라미터로 전달하여 updateResvProcessing 실행
	}

	// key값을 파라미터로 받아 delete 실행하는 메소드
	@Override
	public int delete(Date resv_date, int room) {
		// 받아온 key값으로 select한 객체를 reservation에 넣기
		Reservation r = ReservationDao.getRecordById(resv_date, room);
		return ReservationDao.delete(r); // 세팅된 reservation으로 delete 메소드 실행
	}

	// dto객체를 파라미터로 받아 delete를 실행하는 메소드
	@Override
	public int delete(ReservationDto reservationdto) {
		// dto를 domain으로 변환하여 delete 메소드 실행
		return ReservationDao.delete(new Reservation(reservationdto.getName(), reservationdto.getResv_date(), reservationdto.getRoom(),
				reservationdto.getPostcode(), reservationdto.getRoadAddress(), reservationdto.getDetailAddress(),reservationdto.getExtraAddress(), reservationdto.getTelnum(), reservationdto.getIn_name(),
						reservationdto.getComment(), reservationdto.getWrite_date(), reservationdto.getProcessing()));
	}

}
