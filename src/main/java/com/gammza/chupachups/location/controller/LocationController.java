package com.gammza.chupachups.location.controller;

import java.util.HashMap;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.gammza.chupachups.location.model.service.LocationService;
import com.gammza.chupachups.location.model.vo.Location;
import com.gammza.chupachups.member.model.vo.Member;

@Controller
public class LocationController {
	
	@Autowired
	private LocationService locationService;
	
	public Location selectLocation(Location map) {
		Location fullLocation=locationService.selectLocation(map);
		Location less=locationService.selectLocationLess(map).get(0);
		
		if(fullLocation != null) {
			return fullLocation;
		}else if(less !=null){
			return less;
		}else {
			return locationService.selectLocationLest(map).get(0);
		}
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
	
	@PostMapping("/location/EnrollLocation.lo")
	public String enrollLocation(Location location, HttpSession session,RedirectAttributes redirectAttr) {
		Location fullLocation=selectLocation(location);
		
		Member mem=(Member)session.getAttribute("loginMember");
		String userId=mem.getUserId();
		
		HashMap<String,String> memUp=new HashMap<String,String>();
		memUp.put("userId", userId);
		memUp.put("locationNo", String.valueOf(fullLocation.getLocationNo()));
		
		int result=locationService.updateLocation(memUp);
		if(result==1) {
			redirectAttr.addFlashAttribute("msg","위치가 정상적으로 업데이트 되었습니다.");
			return "/member/location";
		}else {
			redirectAttr.addFlashAttribute("msg","위치 업데이트에 실패했습니다.");
			return "/member/location";
		}
	}
	
}
