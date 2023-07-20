package com.gammza.chupachups.location.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.HashSet;
import java.util.Iterator;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import org.springframework.web.servlet.view.RedirectView;

import com.gammza.chupachups.location.model.service.LocationService;
import com.gammza.chupachups.location.model.vo.Location;
import com.gammza.chupachups.member.model.service.MemberService;
import com.gammza.chupachups.member.model.vo.Member;

@Controller
@SessionAttributes({"loginMember"})
public class LocationController {
	
	@Autowired
	private LocationService locationService;
	@Autowired
	private MemberService memberService;
	
	public Location selectLocation(Location map) {
		Location fullLocation=locationService.selectLocation(map);
		ArrayList<Location> less=locationService.selectLocationLess(map);
		
		if(fullLocation != null) {
			return fullLocation;
		}else if(less.size()!=0){
			return less.get(0);
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
	public ModelAndView enrollLocation(Location location, HttpSession session,Model model, RedirectAttributes redirectAttr,
			@RequestParam String longitude,@RequestParam String latitude) {
//		System.out.println(location);
		Location fullLocation=selectLocation(location);
		
		Member mem=(Member)session.getAttribute("loginMember");
		String userId=mem.getUserId();
		
		HashMap<String,String> memUp=new HashMap<String,String>();
		memUp.put("longitude", longitude);
		memUp.put("latitude", latitude);
		memUp.put("userId", userId);
		memUp.put("locationNo", String.valueOf(fullLocation.getLocationNo()));
		
		int result=locationService.updateLocation(memUp);
		Member member=memberService.selectOneMember(userId);
		model.addAttribute("loginMember", member);
		
		ModelAndView mav=new ModelAndView();
		mav.setView(new RedirectView("/chupachups/location/location.lo"));
		
		if(result==1) {
			redirectAttr.addFlashAttribute("msg","위치가 정상적으로 업데이트 되었습니다.");
			return mav;
		}else {
			redirectAttr.addFlashAttribute("msg","위치 업데이트에 실패했습니다.");
			return mav;
		}
	}
	
	@GetMapping("/location/location.lo")
	public String location(Model model,HttpSession session) {
		Member mem=(Member)session.getAttribute("loginMember");
		if(mem != null) {
			Location loginLocation=locationService.selectLocationByNo(mem.getLocation());
			model.addAttribute("loginLocation", loginLocation);
		}
		return "/member/location";
	}
	
	@PostMapping("/location/nearDong.lo")
	@ResponseBody
	public Map<String,String[]> nearDong(HttpServletRequest request) {
		String address[]=request.getParameterValues("address");
		String place[]=request.getParameterValues("place");
		
		HashSet<String> returnValue=new HashSet<>();
		for(int i=0;i<address.length;i++) {
			String tem[]=address[i].split(" ");
			String tem2[]=place[i].split("주민");
			Location location=new Location();
			location.setSidoNm(tem[0]);
			location.setSggNm(tem[1]);
			location.setAdmNm(tem2[0]);
			location.setLegNm(tem[2]);
			
			String name=SelectLocationName(location);
			returnValue.add(name);
		}
		Iterator<String> ir=returnValue.iterator();
		String dongName[]=new String[returnValue.size()];
		for(int i=0;i<returnValue.size();i++) {
			dongName[i]=ir.next();
		}
		Map<String,String[]> returnV=new HashMap<String,String[]>();
		returnV.put("returnValue", dongName);
		return returnV;
	}
	
}
