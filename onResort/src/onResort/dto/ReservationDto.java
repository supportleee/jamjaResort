package onResort.dto;

import java.util.Date;

public class ReservationDto {
	private String name;
	private Date resv_date;
	private int room;
	private String postcode;
	private String roadAddress;
	private String detailAddress;
	private String extraAddress;
	private String telnum;
	private String in_name;
	private String comment;
	private Date write_date;
	private int processing;

	public ReservationDto() {

	}

	public ReservationDto(String name, Date resv_date, int room) {
		super();
		this.name = name;
		this.resv_date = resv_date;
		this.room = room;
	}

	public ReservationDto(String name, Date resv_date, int room, String postcode, String roadAddress,
			String detailAddress, String extraAddress, String telnum, String in_name, String comment) {
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
	}
	
	public ReservationDto(String name, Date resv_date, int room, String postcode, String roadAddress,
			String detailAddress, String extraAddress, String telnum, String in_name, String comment, int processing) {
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
		this.processing = processing;
	}

	public ReservationDto(String name, Date resv_date, int room, String postcode, String roadAddress,
			String detailAddress, String extraAddress, String telnum, String in_name, String comment, Date write_date,
			int processing) {
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
