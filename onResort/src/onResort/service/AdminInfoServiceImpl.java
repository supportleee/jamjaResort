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

	@Override
	public AdminInfoDto selectOne(String id) {
		AdminInfo a = AdminInfoDao.getRecordById(id);
		return new AdminInfoDto(a.getId(), a.getPw());
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
