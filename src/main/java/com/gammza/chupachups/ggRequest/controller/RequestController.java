package com.gammza.chupachups.ggRequest.controller;

import java.util.ArrayList;
import java.util.HashMap;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.gammza.chupachups.ggRequest.model.service.RequestService;
import com.gammza.chupachups.ggRequest.model.vo.Request;
import com.gammza.chupachups.ggRequest.model.vo.RequestMember;
import com.gammza.chupachups.location.model.vo.Location;


@Controller
@RequestMapping("/ggRequest")
public class RequestController {
	
	@Autowired
	private RequestService requestService;
	
	@GetMapping("/requestView.req")
	public String requestView(@RequestParam(defaultValue="127.0016985") String longitude,@RequestParam(defaultValue="37.5642135") String latitude, Model model) {
		HashMap<String,String> map=new HashMap<String,String>();
		map.put("latitude", latitude);
		map.put("longitude", longitude);
		ArrayList<Request> requestList=requestService.selectAllRequestList(map);
		model.addAttribute("requestList", requestList);
		
		return "/others/requestView";
	}
	
	@GetMapping("/requestRead.req")
	public String requestRead(@RequestParam int requestNo, Model model) {
		
		requestService.updateRequestCount(requestNo);
		Request ggrequest=requestService.selectRequest(requestNo);
		//System.out.println("요청글 제목: "+request.get);
		model.addAttribute("request", ggrequest);
		
		ArrayList<Location> reqLocation=new ArrayList<Location>();
		ArrayList<RequestMember> reqMember=requestService.selectRequestMember(requestNo);
		System.out.println("참여자 크기: "+reqMember.size());
		
		return "/others/requestRead";
	}

}
