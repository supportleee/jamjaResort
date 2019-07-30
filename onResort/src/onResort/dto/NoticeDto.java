package onResort.dto;

import java.util.Date;

public class NoticeDto {
	private int id;
	private String title;
	private String content;
	private Date dayOfRegister;
	private String imgname;
	private String orgimgname;
	private int viewcnt;

	public NoticeDto() {
	}

	public NoticeDto(String title, String content, String imgname, String orgimgname) {
		super();
		this.title = title;
		this.content = content;
		this.imgname = imgname;
		this.orgimgname = orgimgname;
	}

	public NoticeDto(int id, String title, String content, Date dayOfRegister, String imgname, String orgimgname,
			int viewcnt) {
		super();
		this.id = id;
		this.title = title;
		this.content = content;
		this.dayOfRegister = dayOfRegister;
		this.imgname = imgname;
		this.orgimgname = orgimgname;
		this.viewcnt = viewcnt;
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public Date getDayOfRegister() {
		return dayOfRegister;
	}

	public void setDayOfRegister(Date dayOfRegister) {
		this.dayOfRegister = dayOfRegister;
	}

	public String getImgname() {
		return imgname;
	}

	public void setImgname(String imgname) {
		this.imgname = imgname;
	}

	public String getOrgimgname() {
		return orgimgname;
	}

	public void setOrgimgname(String orgimgname) {
		this.orgimgname = orgimgname;
	}

	public int getViewcnt() {
		return viewcnt;
	}

	public void setViewcnt(int viewcnt) {
		this.viewcnt = viewcnt;
	}
}
