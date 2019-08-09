// admininfo domain(DB와 1:1)

package onResort.domain;

public class AdminInfo {
	private String id; // 관리자계정 id 변수
	private String pw; // 관리자계정 비밀번호

	public AdminInfo() {

	}

	// 생성자
	public AdminInfo(String id, String pw) {
		super();
		this.id = id;
		this.pw = pw;
	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getPw() {
		return pw;
	}

	public void setPw(String pw) {
		this.pw = pw;
	}

}
