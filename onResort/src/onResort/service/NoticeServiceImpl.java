// 공지게시판의 Service interface를 실제 구현한 부분
package onResort.service;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import onResort.dao.NoticeDao;
import onResort.domain.Notice;
import onResort.dto.NoticeDto;

public class NoticeServiceImpl implements NoticeService {

	// DAO의 insert를 사용하기 위해 받아온 dto를 domain으로 변환하여 실행
	@Override
	public int insert(NoticeDto noticedto) {
		Notice n = new Notice(noticedto.getId(), noticedto.getTitle(), noticedto.getContent(), noticedto.getDayOfRegister(), noticedto.getImgname(), noticedto.getOrgimgname(), noticedto.getViewcnt());
		return NoticeDao.insert(n);
	}

	// 받아온 id값으로 DAO의 getRecordById()를 호출하여 notice 객체로 값을 받아온 후 DTO로 변환하여 return
	@Override
	public NoticeDto selectOne(int id) {
		Notice notice = NoticeDao.getRecordById(id);
		return new NoticeDto(notice.getId(), notice.getTitle(), notice.getContent(), notice.getDayOfRegister(), notice.getImgname(), notice.getOrgimgname(), notice.getViewcnt());
	}

	// notice의 모든 record를 받아오는 메소드
	@Override
	public List<NoticeDto> selectAll() {
		List<Notice> notices = NoticeDao.getAllRecords(); // DAO에서 getAllRecords()메소드로 모든 record를 list에 받아오기(notices)
		List<NoticeDto> noticedtos = new ArrayList<NoticeDto>(); // 받아온 값을 DTO로 변환하기 위해 List변수 선언
		for(Notice notice : notices) { // 전체 list size만큼 반복 실행
			//dto 리스트에 dto 객체료 변환한 내용 넣기
			noticedtos.add(new NoticeDto(notice.getId(), notice.getTitle(), notice.getContent(), notice.getDayOfRegister(), notice.getImgname(), notice.getOrgimgname(), notice.getViewcnt()));
		}
		return noticedtos; // dto 리스트 return
	}

	// 새로 추가된 글을 보여주기 위한 max_id 받는 메소드
	@Override
	public int selectOneLastest() {
		int max_id = NoticeDao.getRecordByLastest();
		return max_id;
	}

	// DAO의 update를 실행하기 위한 메소드(파라미터로 key(id)값과 noticedto를 받음)
	@Override
	public int update(int key, NoticeDto noticedto) {
		return NoticeDao.update(new Notice(key, noticedto.getTitle(), noticedto.getContent(), noticedto.getDayOfRegister(), noticedto.getImgname(), noticedto.getOrgimgname(), noticedto.getViewcnt()));
	}

	// DAO의 update를 실행하기 위한 메소드(파라미터로 noticedto 받기)
	@Override
	public int update(NoticeDto noticedto) {
		return NoticeDao.update(new Notice(noticedto.getId(), noticedto.getTitle(), noticedto.getContent(), noticedto.getDayOfRegister(), noticedto.getImgname(), noticedto.getOrgimgname(), noticedto.getViewcnt()));
	}

	// 조회수 update를 위한 메소드
	@Override
	public int updateViewcnt(int key) {
		return NoticeDao.updateViewcnt(key);
	}

	// id값을 파라미터로 받아 delete 실행하는 메소드
	@Override
	public int delete(int id) {
		// 받아온 id값으로 select한 객체를 notice에 넣기
		Notice notice = NoticeDao.getRecordById(id);
		return NoticeDao.delete(notice); // 세팅된 notice로 delete 메소드 실행
	}

	// dto객체를 파라미터로 받아 delete를 실행하는 메소드
	@Override
	public int delete(NoticeDto noticedto) {
		// dto를 domain으로 변환하여 delete 메소드 실행
		return NoticeDao.delete(new Notice(noticedto.getId(), noticedto.getTitle(), noticedto.getContent(), noticedto.getDayOfRegister(), noticedto.getImgname(), noticedto.getOrgimgname(), noticedto.getViewcnt()));
	}

}
