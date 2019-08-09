// AdminInfo Service단에서 사용되는 DTO

package onResort.dto;

public class AdminInfoDto {
	private String id; // 관리자 id
	private String pw; // 관리자 비밀번호

	public AdminInfoDto() {

	}

	public AdminInfoDto(String id) {
		super();
		this.id = id;
	}

	public AdminInfoDto(String id, String pw) {
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
