// 공지게시판 domain (DB와 1:1 대응)

package onResort.domain;

import java.util.Date;

public class Notice {
	private int id; // 게시글 번호
	private String title; // 게시글 제목
	private String content; // 게시글 내용
	private Date dayOfRegister; // 게시글 등록일
	private String imgname; // 게시글 이미지이름(중복 문제 처리된 이름)
	private String orgimgname; // 게시글 이미지이름(원본)
	private int viewcnt; // 게시글 조회수

	public Notice() {
	}

	public Notice(int id, String title, String content, Date dayOfRegister, String imgname, String orgimgname,
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
