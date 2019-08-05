package onResort.service;

import java.util.List;

import onResort.dto.AdminInfoDto;

public interface AdminInfoService {
	// C
	int insert(AdminInfoDto dto);
	
	// R
	AdminInfoDto selectOne(String id);
	List<AdminInfoDto> selectAll();
	
	// U
	int update(AdminInfoDto dto);
	
	// D
	int delete(AdminInfoDto dto);
	int delete(String id);
}
