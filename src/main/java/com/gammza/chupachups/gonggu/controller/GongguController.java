package com.gammza.chupachups.gonggu.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/gonggu")
public class GongguController {
	
	@GetMapping("ggEnd.re")
	public void ggEnd() {}
	
	@GetMapping("/ggRead_Partic.go")
	public String ggRead_Partic() {
		
		return null;
	}
	
}
