// adminInfo의 Service interface를 실제 구현한 부분

package onResort.service;

import java.util.List;

import onResort.dao.AdminInfoDao;
import onResort.domain.AdminInfo;
import onResort.dto.AdminInfoDto;

public class AdminInfoServiceImpl implements AdminInfoService {

	@Override
	public int insert(AdminInfoDto dto) {
		// TODO Auto-generated method stub
		return 0;
	}

	// 입력한 아이디와 비밀번호를 확인하기 위해 id값으로 select
	@Override
	public AdminInfoDto selectOne(String id) {
		AdminInfo a = AdminInfoDao.getRecordById(id); // DAO에서 select해온 값을 AdminInfo에 받아옴
		return new AdminInfoDto(a.getId(), a.getPw()); // View단으로 전달하기 위해 DTO로 변환하여 줌
	}

	@Override
	public List<AdminInfoDto> selectAll() {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public int update(AdminInfoDto dto) {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public int delete(AdminInfoDto dto) {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public int delete(String id) {
		// TODO Auto-generated method stub
		return 0;
	}

}
