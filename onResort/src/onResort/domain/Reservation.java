// 예약정보 domain (DB와 1:1 대응)

package onResort.domain;

import java.util.Date;

public class Reservation {
	private String name; // 예약자명
	private Date resv_date; // 원하는 예약일
	private int room; // 방번호(1:퍼스트클래스, 2:비즈니스, 3:이코노미)
	private String postcode; // 우편번호
	private String roadAddress; // 도로명주소
	private String detailAddress; // 상세주소
	private String extraAddress; // 참고항목(ex. (구갈동))
	private String telnum; // 전화번호
	private String in_name; // 입금자명
	private String comment; // 남길 말
	private Date write_date; // 예약한 날짜
	private int processing; // 예약진행상태 (1:예약완료, 2:예약확정, 3.환불...)
	
	public Reservation() {
		
	}
	
	public Reservation(String name, Date resv_date, int room, String postcode, String roadAddress,
			String detailAddress, String extraAddress, String telnum, String in_name, String comment, Date write_date, int processing) {
		super();
		this.name = name;
		this.resv_date = resv_date;
		this.room = room;
		this.postcode = postcode;
		this.roadAddress = roadAddress;
		this.detailAddress = detailAddress;
		this.extraAddress = extraAddress;
		this.telnum = telnum;
		this.in_name = in_name;
		this.comment = comment;
		this.write_date = write_date;
		this.processing = processing;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public Date getResv_date() {
		return resv_date;
	}

	public void setResv_date(Date resv_date) {
		this.resv_date = resv_date;
	}

	public int getRoom() {
		return room;
	}

	public void setRoom(int room) {
		this.room = room;
	}

	

	public String getPostcode() {
		return postcode;
	}

	public void setPostcode(String postcode) {
		this.postcode = postcode;
	}

	public String getRoadAddress() {
		return roadAddress;
	}

	public void setRoadAddress(String roadAddress) {
		this.roadAddress = roadAddress;
	}

	public String getDetailAddress() {
		return detailAddress;
	}

	public void setDetailAddress(String detailAddress) {
		this.detailAddress = detailAddress;
	}

	public String getExtraAddress() {
		return extraAddress;
	}

	public void setExtraAddress(String extraAddress) {
		this.extraAddress = extraAddress;
	}

	public String getTelnum() {
		return telnum;
	}

	public void setTelnum(String telnum) {
		this.telnum = telnum;
	}

	public String getIn_name() {
		return in_name;
	}

	public void setIn_name(String in_name) {
		this.in_name = in_name;
	}

	public String getComment() {
		return comment;
	}

	public void setComment(String comment) {
		this.comment = comment;
	}

	public Date getWrite_date() {
		return write_date;
	}

	public void setWrite_date(Date write_date) {
		this.write_date = write_date;
	}

	public int getProcessing() {
		return processing;
	}

	public void setProcessing(int processing) {
		this.processing = processing;
	}
	
	
}
