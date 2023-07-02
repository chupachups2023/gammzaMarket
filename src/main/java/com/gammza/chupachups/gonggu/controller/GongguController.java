package com.gammza.chupachups.gonggu.controller;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Collections;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.ResourceLoader;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.gammza.chupachups.common.ChangeDate;
import com.gammza.chupachups.common.SpringUtils;
import com.gammza.chupachups.common.model.vo.PageInfo;
import com.gammza.chupachups.common.template.Pagination;
import com.gammza.chupachups.gonggu.model.service.GongguService;
import com.gammza.chupachups.gonggu.model.vo.Gonggu;
import com.gammza.chupachups.member.model.vo.Member;

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
	public void ggWrite() {
	}

	@GetMapping("/ggListView.go")
	public String ggListView(Model model) {
		ArrayList<Gonggu> ggListView = gongguService.selectggListView();
		model.addAttribute("ggListView", ggListView);
		
		return "/gonggu/ggListView";
	}
	
	@GetMapping("/homeList.go")
	public String homeList(Model model) {
		ArrayList<Gonggu> homeList = gongguService.selectHomeList();
		model.addAttribute("homeList", homeList);
		
		int totalRecord=gongguService.selectTotalRecored();
		
		PageInfo pi=Pagination.getPageInfo(totalRecord, 1, 1, 8);
		model.addAttribute("pi", pi);
		
		return "/home";
	}
	
	 @GetMapping("/ggRead.go") 
	 public String ggRead_Partic(@RequestParam int gongguNo, Model model, HttpSession session) {
		 Member loginMember=(Member)session.getAttribute("loginMember");
		 Gonggu gonggu = gongguService.selectOneGonggu(gongguNo);
		 model.addAttribute("gonggu", gonggu);

		 if(loginMember != null) {	//로그인 한 사람일 경우
			 if(gonggu.getGongguWriter().equals(loginMember.getUserId())) { //글쓴사람이면
				 return "/gonggu/ggRead_Leader"; 
			 }else { //글쓴사람 아니면
				 return "/gonggu/ggRead_Partic"; 
			 }
		 }else {				//로그인 안한 사람
			 return "/gonggu/ggRead_Partic"; 
		 }
	 }
	 
	@PostMapping("/ggEnrollFrm.go")
	public String ggEnrollFrm(Gonggu gonggu, @RequestParam MultipartFile upPhoto1, @RequestParam MultipartFile upPhoto2,
			@RequestParam MultipartFile upPhoto3, Model model,RedirectAttributes redirectAttr) {
		if (gonggu.getOpenTime().equals("sysdate")) {
			gonggu.setEndTime(ChangeDate.chageDate(gonggu.getEndTime()));
			gonggu.setSendTime(ChangeDate.chageDate(gonggu.getSendTime()));
		} else {
			gonggu.setOpenTime(ChangeDate.chageDate(gonggu.getOpenTime()));
			gonggu.setEndTime(ChangeDate.chageDate(gonggu.getEndTime()));
			gonggu.setSendTime(ChangeDate.chageDate(gonggu.getSendTime()));
		}

		String saveDirectory = application.getRealPath("/resources/upload");

		ArrayList<String> photo = new ArrayList<String>();

		if (upPhoto1.getSize() > 0) {
			String changeFilename = SpringUtils.changeMultipartFile(upPhoto1);

			photo.add(changeFilename);

			File destFile = new File(saveDirectory, changeFilename);

			try {
				upPhoto1.transferTo(destFile); // 실제로 저장
			} catch (IOException e) {
				e.printStackTrace();
			}
		}

		if(upPhoto2.getSize()>0) {
			String changeFilename=SpringUtils.changeMultipartFile(upPhoto2);
			photo.add(changeFilename);
			
			File destFile=new File(saveDirectory, changeFilename);

			try {
				upPhoto2.transferTo(destFile); // 실제로 저장
			} catch (IOException e) {
				e.printStackTrace();
			}
		}
		if(upPhoto3.getSize()>0) {
			String changeFilename=SpringUtils.changeMultipartFile(upPhoto3);
			
			photo.add(changeFilename);
			
			File destFile=new File(saveDirectory, changeFilename);
			try {
				upPhoto3.transferTo(destFile); // 실제로 저장
			} catch (IOException e) {
				e.printStackTrace();
			}
		}
		if (!photo.isEmpty()) {
			Collections.sort(photo);

			photo.remove(null);

			if (photo.size() == 1) {
				gonggu.setPhoto1(photo.get(0));
			} else if (photo.size() == 2) {
				gonggu.setPhoto1(photo.get(0));
				gonggu.setPhoto2(photo.get(1));
			} else {
				gonggu.setPhoto1(photo.get(0));
				gonggu.setPhoto2(photo.get(1));
				gonggu.setPhoto3(photo.get(2));
			}
		}
		int result = gongguService.insertGonggu(gonggu);
		if(result>0) {
			int gongguNo=gongguService.selectLastNum();
			Gonggu newGonggu=gongguService.selectOneGonggu(gongguNo);
			model.addAttribute("gonggu", newGonggu);
			return "/gonggu/ggRead_Leader";
		}else {
			redirectAttr.addFlashAttribute("msg","글 작성에 실패했습니다ㅠ");
			return "/gonggu/ggWrite";
		}
	}

	
	
	
}
