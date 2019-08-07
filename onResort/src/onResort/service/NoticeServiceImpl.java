package onResort.service;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import onResort.dao.NoticeDao;
import onResort.domain.Notice;
import onResort.dto.NoticeDto;

public class NoticeServiceImpl implements NoticeService {

	@Override
	public int insert(NoticeDto noticedto) {
		Notice n = new Notice(noticedto.getId(), noticedto.getTitle(), noticedto.getContent(), noticedto.getDayOfRegister(), noticedto.getImgname(), noticedto.getOrgimgname(), noticedto.getViewcnt());
		return NoticeDao.insert(n);
	}

	@Override
	public NoticeDto selectOne(int id) {
		Notice notice = NoticeDao.getRecordById(id);
		return new NoticeDto(notice.getId(), notice.getTitle(), notice.getContent(), notice.getDayOfRegister(), notice.getImgname(), notice.getOrgimgname(), notice.getViewcnt());
	}

	@Override
	public List<NoticeDto> selectAll() {
		List<Notice> notices = NoticeDao.getAllRecords();
		List<NoticeDto> noticedtos = new ArrayList<NoticeDto>();
		for(Notice notice : notices) {
			noticedtos.add(new NoticeDto(notice.getId(), notice.getTitle(), notice.getContent(), notice.getDayOfRegister(), notice.getImgname(), notice.getOrgimgname(), notice.getViewcnt()));
		}
		return noticedtos;
	}

	@Override
	public int selectOneLastest() {
		int max_id = NoticeDao.getRecordByLastest();
		return max_id;
	}

	@Override
	public int update(int key, NoticeDto noticedto) {
		return NoticeDao.update(new Notice(key, noticedto.getTitle(), noticedto.getContent(), noticedto.getDayOfRegister(), noticedto.getImgname(), noticedto.getOrgimgname(), noticedto.getViewcnt()));
	}

	@Override
	public int update(NoticeDto noticedto) {
		return NoticeDao.update(new Notice(noticedto.getId(), noticedto.getTitle(), noticedto.getContent(), noticedto.getDayOfRegister(), noticedto.getImgname(), noticedto.getOrgimgname(), noticedto.getViewcnt()));
	}

	@Override
	public int updateViewcnt(int key) {
		return NoticeDao.updateViewcnt(key);
	}

	@Override
	public int delete(int id) {
		Notice notice = NoticeDao.getRecordById(id);
		return NoticeDao.delete(notice);
	}

	@Override
	public int delete(NoticeDto noticedto) {
		return NoticeDao.delete(new Notice(noticedto.getId(), noticedto.getTitle(), noticedto.getContent(), noticedto.getDayOfRegister(), noticedto.getImgname(), noticedto.getOrgimgname(), noticedto.getViewcnt()));
	}

}
