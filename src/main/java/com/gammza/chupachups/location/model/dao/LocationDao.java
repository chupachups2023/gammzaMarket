package com.gammza.chupachups.location.model.dao;

import org.apache.ibatis.annotations.Mapper;

import com.gammza.chupachups.location.model.vo.Location;

@Mapper
public interface LocationDao {

	Location selectLocation(Location map);

	int selectlegCount(Location location);

	int selectadmCount(Location location);

	Location selectLocationByNo(int locationNo);
	
	

}
