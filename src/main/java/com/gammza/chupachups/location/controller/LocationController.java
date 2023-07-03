package com.gammza.chupachups.location.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;

import com.gammza.chupachups.location.model.service.LocationService;
import com.gammza.chupachups.location.model.vo.Location;

@Controller
public class LocationController {
	
	@Autowired
	private LocationService locationService;
	
	public Location selectLocation(Location map) {
		return locationService.selectLocation(map);
	}
	
	public Location selectLocationByNo(int locationNo) {
		return locationService.selectLocationByNo(locationNo);
	}
	
	public String SelectLocationName(Location location) {
		int legCount=locationService.selectlegCount(location);
		int admCount=locationService.selectadmCount(location);
		
		if(legCount==1) {
			return location.getLegNm();
		}else if(admCount==1) {
			return location.getAdmNm();
		}else {
			return location.getLegNm();
		}
	}
	
}
