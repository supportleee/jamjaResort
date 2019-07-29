package onResort.service;

import java.util.List;

import onResort.dto.NoticeDto;

public interface NoticeService {
	// Create
	int insert(NoticeDto noticedto);

	// Read
	NoticeDto selectOne(int id);

	List<NoticeDto> selectAll();

	int selectOneLastest();

	// Update
	int update(int key, NoticeDto noticedto);

	int update(NoticeDto noticedto);

	int updateViewcnt(int key);

	// Delete
	int delete(int id);

	int delete(NoticeDto noticedto);

}
