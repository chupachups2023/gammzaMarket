package com.gammza.chupachups.location.model.service;

import java.util.ArrayList;
import java.util.HashMap;

import com.gammza.chupachups.location.model.vo.Location;

public interface LocationService {

	public Location selectLocation(Location map);
	
	public Location selectLocationByNo(int locationNo);

	public int selectlegCount(Location location);//

	public int selectadmCount(Location location);//

	public int updateLocation(HashMap<String, String> memUp);

	public ArrayList<Location> selectLocationLess(Location map);

	public ArrayList<Location> selectLocationLest(Location map);
}
