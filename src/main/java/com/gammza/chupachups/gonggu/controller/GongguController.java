package com.gammza.chupachups.gonggu.controller;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Collections;
import java.util.List;

import javax.servlet.ServletContext;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import com.gammza.chupachups.gonggu.model.service.GongguService;
import com.gammza.chupachups.gonggu.model.vo.Gonggu;
import com.gammza.chupachups.gonggu.model.vo.Parti_Tb;

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
	public String ggRead_Partic(Model model, @RequestParam int gongguNo) {

		Parti_Tb parti_tb  = gongguService.selectOneParti_Tb(gongguNo);
		model.addAttribute("parti_tb", parti_tb);
		return "ggRead_Partic";
	}
	

	@PostMapping("/ggEnrollFrm.go")
	public String ggWriteRequestEnroll(Gonggu gonggu, MultipartFile upFile) {
		System.out.println(gonggu);
		return null;
	}
	
	


}
