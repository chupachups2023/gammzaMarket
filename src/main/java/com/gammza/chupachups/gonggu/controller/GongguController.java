package com.gammza.chupachups.gonggu.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;

import org.springframework.web.bind.annotation.RequestMapping;

import com.gammza.chupachups.gonggu.model.service.GongguService;

@Controller
@RequestMapping("/gonggu")
public class GongguController {
	@Autowired
	private GongguService gongguService;
	
	@PostMapping("/ggWriteRequestEnroll.go")
	public String ggWriteRequestEnroll() {
		
		return null;
	}

}
