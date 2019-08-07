package onResort.service;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import onResort.dao.Review_boardDao;
import onResort.domain.Review_board;
import onResort.dto.Review_boardDto;

public class Review_boardServiceImpl implements Review_boardService {

	@Override
	public int insert(Review_boardDto reviewdto) {
		return Review_boardDao.insert(new Review_board(reviewdto.getId(), reviewdto.getTitle(), reviewdto.getContent(),
				reviewdto.getDayOfRegister(), reviewdto.getImgname(), reviewdto.getOrgimgname(), reviewdto.getRootid(),
				reviewdto.getRelevel(), reviewdto.getRecnt(), reviewdto.getViewcnt()));
	}

	@Override
	public int reinsert(Review_boardDto reviewdto) {
		Review_boardDao.updateRecnt(reviewdto.getRecnt(), reviewdto.getRootid());
		return Review_boardDao.reinsert(new Review_board(reviewdto.getId(), reviewdto.getTitle(),
				reviewdto.getContent(), reviewdto.getDayOfRegister(), reviewdto.getImgname(), reviewdto.getOrgimgname(),
				reviewdto.getRootid(), reviewdto.getRelevel(), reviewdto.getRecnt(), reviewdto.getViewcnt()));
	}

	@Override
	public Review_boardDto selectOne(int id) {
		Review_board review = Review_boardDao.getRecordById(id);
		return new Review_boardDto(review.getId(), review.getTitle(), review.getContent(), review.getDayOfRegister(),
				review.getImgname(), review.getOrgimgname(), review.getRootid(), review.getRelevel(), review.getRecnt(),
				review.getViewcnt());
	}

	@Override
	public List<Review_boardDto> selectAll() {
		List<Review_board> reviews = Review_boardDao.getAllRecords();
		List<Review_boardDto> reviewdtos = new ArrayList<Review_boardDto>();
		//String title = "";
		SimpleDateFormat date = new SimpleDateFormat("yyyy-MM-dd");
		for (Review_board review : reviews) {
			//title = "";
			//if (review.getRelevel() > 0) {
			//	for (int i = 0; i < review.getRelevel(); i++) {
			//		title += "  ";
			//	}
				
			//	review.setTitle(review.getTitle());
			//}
			//if (date.format(review.getDayOfRegister()).equals(date.format(new Date()))) {
			//	review.setTitle(review.getTitle() + "[NEW]");
			//}
			reviewdtos.add(new Review_boardDto(review.getId(), review.getTitle(), review.getContent(), review.getDayOfRegister(),
					review.getImgname(), review.getOrgimgname(), review.getRootid(), review.getRelevel(), review.getRecnt(),
					review.getViewcnt()));
		}
		return reviewdtos;
	}

	@Override
	public int selectOneLastest() {
		int max_id = Review_boardDao.getRecordByLastest();
		return max_id;
	}

	@Override
	public int update(int key, Review_boardDto reviewdto) {
		return Review_boardDao.update(new Review_board(key, reviewdto.getTitle(),
				reviewdto.getContent(), reviewdto.getDayOfRegister(), reviewdto.getImgname(), reviewdto.getOrgimgname(),
				reviewdto.getRootid(), reviewdto.getRelevel(), reviewdto.getRecnt(), reviewdto.getViewcnt()));
	}

	@Override
	public int update(Review_boardDto reviewdto) {
		return Review_boardDao.update(new Review_board(reviewdto.getId(), reviewdto.getTitle(),
				reviewdto.getContent(), reviewdto.getDayOfRegister(), reviewdto.getImgname(), reviewdto.getOrgimgname(),
				reviewdto.getRootid(), reviewdto.getRelevel(), reviewdto.getRecnt(), reviewdto.getViewcnt()));
	}

	@Override
	public int updateViewcnt(int key) {
		return Review_boardDao.updateViewcnt(key);
	}

	@Override
	public int delete(int id) {
		Review_board review = Review_boardDao.getRecordById(id);
		return Review_boardDao.deleteAllReply(review);
	}

	@Override
	public int delete(Review_boardDto reviewdto) {
		return Review_boardDao.deleteAllReply(new Review_board(reviewdto.getId(), reviewdto.getTitle(),
				reviewdto.getContent(), reviewdto.getDayOfRegister(), reviewdto.getImgname(), reviewdto.getOrgimgname(),
				reviewdto.getRootid(), reviewdto.getRelevel(), reviewdto.getRecnt(), reviewdto.getViewcnt()));
	}

}
