package com.gammza.chupachups.location.model.service;

import com.gammza.chupachups.location.model.vo.Location;

public interface LocationService {

	public Location selectLocation(Location map);
	
	public Location selectLocationByNo(int locationNo);

	public int selectlegCount(Location location);//

	public int selectadmCount(Location location);//
}
