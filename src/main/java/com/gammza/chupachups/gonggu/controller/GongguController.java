package com.gammza.chupachups.gonggu.controller;


import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Collections;

import java.util.List;


import javax.servlet.ServletContext;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.ResourceLoader;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import com.gammza.chupachups.common.ChangeDBTypeDate;
import com.gammza.chupachups.common.SpringUtils;
import com.gammza.chupachups.gonggu.model.service.GongguService;
import com.gammza.chupachups.gonggu.model.vo.Gonggu;

import com.gammza.chupachups.gonggu.model.vo.Parti_Tb;


@Controller
@RequestMapping("/gonggu")
public class GongguController {
	@Autowired
	private GongguService gongguService;
	@Autowired
	private ServletContext application;
	@Autowired
	private ResourceLoader resourceLoader;
	
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
	public String ggEnrollFrm(Gonggu gonggu, @RequestParam MultipartFile upPhoto1, @RequestParam MultipartFile upPhoto2, @RequestParam MultipartFile upPhoto3) {
		gonggu.setGongguWriter("USER01");
		System.out.println(gonggu.getEndTime());
		System.out.println(gonggu.getOpenTime());
		System.out.println(gonggu.getSendTime());
		if(gonggu.getOpenTime().equals("sysdate")) {
			gonggu.setEndTime(ChangeDBTypeDate.chageDate(gonggu.getEndTime()));
			gonggu.setSendTime(ChangeDBTypeDate.chageDate(gonggu.getSendTime()));
		}else {
			gonggu.setOpenTime(ChangeDBTypeDate.chageDate(gonggu.getOpenTime()));
			gonggu.setEndTime(ChangeDBTypeDate.chageDate(gonggu.getEndTime()));
			gonggu.setSendTime(ChangeDBTypeDate.chageDate(gonggu.getSendTime()));
		}
		
		String saveDirectory=application.getRealPath("/resources/upload");
		
		ArrayList<String> photo=new ArrayList<String>();
		
		if(upPhoto1.getSize()>0) {
			String changeFilename=SpringUtils.changeMultipartFile(upPhoto1);
			System.out.println("photo1: "+changeFilename);
			
			photo.add(0, changeFilename);
			
			File destFile=new File(saveDirectory, changeFilename);
			try {
				upPhoto1.transferTo(destFile);	//실제로 저장
			} catch (IOException e) {
				e.printStackTrace();
			}
		}
		if(upPhoto2.getSize()>0) {
			String changeFilename=SpringUtils.changeMultipartFile(upPhoto2);
			System.out.println("photo2: "+changeFilename);
			
			photo.add(1, changeFilename);
			
			File destFile=new File(saveDirectory, changeFilename);
			try {
				upPhoto2.transferTo(destFile);	//실제로 저장
			} catch (IOException e) {
				e.printStackTrace();
			}
		}
		if(upPhoto3.getSize()>0) {
			String changeFilename=SpringUtils.changeMultipartFile(upPhoto3);
			System.out.println("photo3: "+changeFilename);
			
			photo.add(2, changeFilename);
			
			File destFile=new File(saveDirectory, changeFilename);
			try {
				upPhoto3.transferTo(destFile);	//실제로 저장
			} catch (IOException e) {
				e.printStackTrace();
			}
		}
		for(int i=0;i<photo.size();i++) {
			System.out.println(photo.get(i));
		}
		if(!photo.isEmpty()) {
			Collections.sort(photo);
			
			photo.remove(null);
			
			if(photo.size()==1) {
				gonggu.setPhoto1(photo.get(0));
			}else if(photo.size()==2) {
				gonggu.setPhoto1(photo.get(0));
				gonggu.setPhoto2(photo.get(1));
			}else {
				gonggu.setPhoto1(photo.get(0));
				gonggu.setPhoto2(photo.get(1));
				gonggu.setPhoto3(photo.get(2));
			}
		}
		
		System.out.println(gonggu);
		
		int result=gongguService.insertGonggu(gonggu);
		
		return null;
	}
	


}
