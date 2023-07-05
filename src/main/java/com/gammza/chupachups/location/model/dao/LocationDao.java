package com.gammza.chupachups.location.model.dao;

import java.util.ArrayList;
import java.util.HashMap;

import org.apache.ibatis.annotations.Mapper;

import com.gammza.chupachups.location.model.vo.Location;

@Mapper
public interface LocationDao {

	Location selectLocation(Location map);

	int selectlegCount(Location location);

	int selectadmCount(Location location);

	Location selectLocationByNo(int locationNo);

	int updateLocation(HashMap<String, String> memUp);

	ArrayList<Location> selectLocationLess(Location map);

	ArrayList<Location> selectLocationLest(Location map);
	
	

}
