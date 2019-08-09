// 이용후기게시판 Service interface를 실제 구현한 부분
package onResort.service;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.List;

import onResort.dao.Review_boardDao;
import onResort.domain.Review_board;
import onResort.dto.Review_boardDto;

public class Review_boardServiceImpl implements Review_boardService {

	// DAO의 insert를 사용하기 위해 받아온 dto를 domain으로 변환하여 실행
	@Override
	public int insert(Review_boardDto reviewdto) {
		return Review_boardDao.insert(new Review_board(reviewdto.getId(), reviewdto.getTitle(), reviewdto.getContent(),
				reviewdto.getDayOfRegister(), reviewdto.getImgname(), reviewdto.getOrgimgname(), reviewdto.getRootid(),
				reviewdto.getRelevel(), reviewdto.getRecnt(), reviewdto.getViewcnt()));
	}

	// DAO의 reinsert를 사용하기 위해 받아온 dto를 domain으로 변환하여 실행
	@Override
	public int reinsert(Review_boardDto reviewdto) {
		Review_boardDao.updateRecnt(reviewdto.getRecnt(), reviewdto.getRootid());
		return Review_boardDao.reinsert(new Review_board(reviewdto.getId(), reviewdto.getTitle(),
				reviewdto.getContent(), reviewdto.getDayOfRegister(), reviewdto.getImgname(), reviewdto.getOrgimgname(),
				reviewdto.getRootid(), reviewdto.getRelevel(), reviewdto.getRecnt(), reviewdto.getViewcnt()));
	}

	// 받아온 id값으로 DAO의 getRecordById()를 호출하여 review_board 객체로 값을 받아온 후 DTO로 변환하여 return
	@Override
	public Review_boardDto selectOne(int id) {
		Review_board review = Review_boardDao.getRecordById(id);
		return new Review_boardDto(review.getId(), review.getTitle(), review.getContent(), review.getDayOfRegister(),
				review.getImgname(), review.getOrgimgname(), review.getRootid(), review.getRelevel(), review.getRecnt(),
				review.getViewcnt());
	}

	// review_board의 모든 record를 받아오는 메소드
	@Override
	public List<Review_boardDto> selectAll() {
		List<Review_board> reviews = Review_boardDao.getAllRecords(); // DAO에서 getAllRecords()메소드로 모든 record를 list에 받아오기(reviews)
		List<Review_boardDto> reviewdtos = new ArrayList<Review_boardDto>(); // 받아온 값을 DTO로 변환하기 위해 List변수 선언
		for (Review_board review : reviews) { // 전체 list size만큼 반복 실행
			//dto 리스트에 dto 객체료 변환한 내용 넣기
			reviewdtos.add(new Review_boardDto(review.getId(), review.getTitle(), review.getContent(), review.getDayOfRegister(),
					review.getImgname(), review.getOrgimgname(), review.getRootid(), review.getRelevel(), review.getRecnt(),
					review.getViewcnt()));
		}
		return reviewdtos; // dto 리스트 return
	}

	// 새로 추가된 글을 보여주기 위한 max_id 받는 메소드
	@Override
	public int selectOneLastest() {
		int max_id = Review_boardDao.getRecordByLastest();
		return max_id;
	}

	// DAO의 update를 실행하기 위한 메소드(파라미터로 key(id)값과 reviewdto를 받음)
	@Override
	public int update(int key, Review_boardDto reviewdto) {
		return Review_boardDao.update(new Review_board(key, reviewdto.getTitle(),
				reviewdto.getContent(), reviewdto.getDayOfRegister(), reviewdto.getImgname(), reviewdto.getOrgimgname(),
				reviewdto.getRootid(), reviewdto.getRelevel(), reviewdto.getRecnt(), reviewdto.getViewcnt()));
	}

	// DAO의 update를 실행하기 위한 메소드(파라미터로 reviewdto 받기)
	@Override
	public int update(Review_boardDto reviewdto) {
		return Review_boardDao.update(new Review_board(reviewdto.getId(), reviewdto.getTitle(),
				reviewdto.getContent(), reviewdto.getDayOfRegister(), reviewdto.getImgname(), reviewdto.getOrgimgname(),
				reviewdto.getRootid(), reviewdto.getRelevel(), reviewdto.getRecnt(), reviewdto.getViewcnt()));
	}

	// 조회수 update를 위한 메소드
	@Override
	public int updateViewcnt(int key) {
		return Review_boardDao.updateViewcnt(key);
	}

	// id값을 파라미터로 받아 delete 실행하는 메소드
	@Override
	public int delete(int id) {
		// 받아온 id값으로 select한 객체를 review에 넣기
		Review_board review = Review_boardDao.getRecordById(id);
		return Review_boardDao.deleteAllReply(review); // 세팅된 review로 delete 메소드 실행
	}

	// dto객체를 파라미터로 받아 delete를 실행하는 메소드
	@Override
	public int delete(Review_boardDto reviewdto) {
		// dto를 domain으로 변환하여 delete 메소드 실행
		return Review_boardDao.deleteAllReply(new Review_board(reviewdto.getId(), reviewdto.getTitle(),
				reviewdto.getContent(), reviewdto.getDayOfRegister(), reviewdto.getImgname(), reviewdto.getOrgimgname(),
				reviewdto.getRootid(), reviewdto.getRelevel(), reviewdto.getRecnt(), reviewdto.getViewcnt()));
	}

}
