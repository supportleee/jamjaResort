package onResort.dto;

import java.util.Date;

public class Review_boardDto {
	private int id;
	private String title;
	private String content;
	private Date dayOfRegister;
	private String imgname;
	private String orgimgname;
	private int rootid;
	private int relevel;
	private int recnt;
	private int viewcnt;

	public Review_boardDto() {

	}
	
	public Review_boardDto(String title, String content, String imgname, String orgimgname) {
		super();
		this.title = title;
		this.content = content;
		this.imgname = imgname;
		this.orgimgname = orgimgname;
	}
	
	public Review_boardDto(String title, String content, String imgname, String orgimgname, int rootid, int relevel, int recnt) {
		super();
		this.title = title;
		this.content = content;
		this.imgname = imgname;
		this.orgimgname = orgimgname;
		this.rootid = rootid;
		this.relevel = relevel;
		this.recnt = recnt;
	}

	public Review_boardDto(int id, String title, String content, Date dayOfRegister, String imgname, String orgimgname,
			int rootid, int relevel, int recnt, int viewcnt) {
		super();
		this.id = id;
		this.title = title;
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
