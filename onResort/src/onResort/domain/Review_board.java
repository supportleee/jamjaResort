// 이용후기게시판 Domain (DB와 1:1대응)

package onResort.domain;

import java.util.Date;

public class Review_board {
	private int id; // 게시글 번호
	private String title; // 게시글 제목
	private String content; // 게시글 내용
	private Date dayOfRegister; // 게시글 등록일자
	private String imgname; // 게시글에 업로드한 파일 이름(중복문제 처리 후 이름)
	private String orgimgname; // 게시글에 업로드한 파일 이름(원본)
	private int rootid; // 답글 작성시 원글 id(새 글일 경우 본인 id와 같고 답글일 경우 답글달 원글의 id)
	private int relevel; // 답글의 깊이
	private int recnt; // 원글포함 답글의 순서
	private int viewcnt; // 조회수

	public Review_board() {

	}

	public Review_board(int id, String title, String content, Date dayOfRegister, String imgname, String orgimgname,
			int rootid, int relevel, int recnt, int viewcnt) {
		super();
		this.id = id;
		this.title = title;
		this.content = content;
		this.dayOfRegister = dayOfRegister;
		this.imgname = imgname;
		this.orgimgname = orgimgname;
		this.rootid = rootid;
		this.relevel = relevel;
		this.recnt = recnt;
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

	public int getRootid() {
		return rootid;
	}

	public void setRootid(int rootid) {
		this.rootid = rootid;
	}

	public int getRelevel() {
		return relevel;
	}

	public void setRelevel(int relevel) {
		this.relevel = relevel;
	}

	public int getRecnt() {
		return recnt;
	}

	public void setRecnt(int recnt) {
		this.recnt = recnt;
	}

	public int getViewcnt() {
		return viewcnt;
	}

	public void setViewcnt(int viewcnt) {
		this.viewcnt = viewcnt;
	}

}
