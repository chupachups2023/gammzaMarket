package com.gammza.chupachups.request.controller;

import java.util.ArrayList;
import java.util.HashMap;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.gammza.chupachups.request.model.service.RequestService;

import okhttp3.Request;

@Controller
@RequestMapping("/request")
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
		
		return "/others/gongguRequest";
	}

}
