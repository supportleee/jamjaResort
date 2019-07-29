package onResort.service;

import java.util.List;

import onResort.dto.Review_boardDto;

public interface Review_boardService {
	// Create
	int insert(Review_boardDto reviewdto);
	int reinsert(Review_boardDto reviewdto);
	
	// Read
	Review_boardDto selectOne(int id);
	List<Review_boardDto> selectAll();
	int selectOneLastest();
	
	// Update
	int update(int key, Review_boardDto reviewdto);
	int update(Review_boardDto reviewdto);
	int updateViewcnt(int key);
	
	// Delete
	int delete(int id);
	int delete(Review_boardDto reviewdto);
}
