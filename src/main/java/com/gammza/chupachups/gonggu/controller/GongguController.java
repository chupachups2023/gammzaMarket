package com.gammza.chupachups.gonggu.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.multipart.MultipartFile;

import com.gammza.chupachups.gonggu.model.service.GongguService;
import com.gammza.chupachups.gonggu.model.vo.Gonggu;

@Controller
@RequestMapping("/gonggu")
public class GongguController {
	@Autowired
	private GongguService gongguService;
	
	@GetMapping("/ggWrite.go")
	public void ggWrite() {}
	
	@GetMapping("/ggListView.go")
	public void ggListView() {}
	

	@GetMapping("/ggRead_Partic.go")
	public String ggRead_Partic() {
		
		return null;
	}
	

	@PostMapping("/ggEnrollFrm.go")
	public String ggWriteRequestEnroll(Gonggu gonggu, MultipartFile upFile) {
		System.out.println(gonggu);
		return null;
	}
	
	


}
