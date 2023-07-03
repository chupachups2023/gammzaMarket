package com.gammza.chupachups.location.model.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.gammza.chupachups.location.model.dao.LocationDao;
import com.gammza.chupachups.location.model.vo.Location;

@Service
public class LocationServiceImpl implements LocationService {
	@Autowired
	private LocationDao locationDao;

	@Override
	public Location selectLocation(Location map) {
		return locationDao.selectLocation(map);
	}

	@Override
	public int selectlegCount(Location location) {
		return locationDao.selectlegCount(location);
	}

	@Override
	public int selectadmCount(Location location) {
		return locationDao.selectadmCount(location);
	}

	@Override
	public Location selectLocationByNo(int locationNo) {
		return locationDao.selectLocationByNo(locationNo);
	}

}
