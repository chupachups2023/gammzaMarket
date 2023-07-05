package com.gammza.chupachups.gonggu.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.gammza.chupachups.gonggu.model.service.GongguService;
import com.gammza.chupachups.gonggu.model.service.PartiService;
import com.gammza.chupachups.gonggu.model.vo.Gonggu;
import com.gammza.chupachups.location.model.service.LocationService;
import com.gammza.chupachups.location.model.vo.Location;

@Controller
@RequestMapping("/gonggu")
public class PartiController {
	@Autowired
	private PartiService partiService;
	@Autowired
	private GongguService gongguService;
	@Autowired
	private LocationService locationService;
	
	@GetMapping("/partiEnroll.pa")
	public String partiEnroll(@RequestParam int gongguNo, Model model) {
		Gonggu gonggu=gongguService.selectOneGonggu(gongguNo);
		model.addAttribute("gonggu", gonggu);
		Location location=locationService.selectLocationByNo(gonggu.getLocationNo());
		model.addAttribute("location", location);
		
		return "/gonggu/ggPartiEnroll";
	}
	
	
}
