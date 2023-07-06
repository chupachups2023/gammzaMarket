package com.gammza.chupachups.gonggu.controller;

import java.io.File;
import java.io.IOException;
import java.text.ParseException;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.Collections;
import java.util.List;

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

import com.gammza.chupachups.chatRoom.model.service.ChatRoomService;
import com.gammza.chupachups.common.ChangeDate;
import com.gammza.chupachups.common.SpringUtils;
import com.gammza.chupachups.common.model.vo.PageInfo;
import com.gammza.chupachups.common.template.Pagination;
import com.gammza.chupachups.gonggu.model.service.GongguService;
import com.gammza.chupachups.gonggu.model.vo.Gonggu;
import com.gammza.chupachups.likeList.controller.LikeListController;
import com.gammza.chupachups.likeList.model.vo.Zzim;
import com.gammza.chupachups.location.controller.LocationController;
import com.gammza.chupachups.location.model.service.LocationService;
import com.gammza.chupachups.location.model.vo.Location;
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
	@Autowired
	private LocationService locationService;
	@Autowired
	private LocationController locationController;
	@Autowired
	private LikeListController likeListController;
	@Autowired
	private ChatRoomService chatRoomService;

	@GetMapping("/ggWrite.go")
	public void ggWrite() {
	}

	@GetMapping("/ggListView.go")
	public String ggListView(Model model) {
		ArrayList<Gonggu> ggListView = gongguService.selectggListView();
		for(int i=0;i<ggListView.size();i++) {
			Location tempLocal=locationService.selectLocationByNo(ggListView.get(i).getLocationNo());
			String locationName=locationController.SelectLocationName(tempLocal);
			ggListView.get(i).setLocationName(locationName);
		}
		model.addAttribute("ggListView", ggListView);
		
		return "/gonggu/ggListView";
	}
	
	@GetMapping("/homeList.go")
	public String homeList(Model model) {
		ArrayList<Gonggu> homeList = gongguService.selectHomeList();
		for(int i=0;i<homeList.size();i++) {
			Location tempLocal=locationService.selectLocationByNo(homeList.get(i).getLocationNo());
			String locationName=locationController.SelectLocationName(tempLocal);
			homeList.get(i).setLocationName(locationName);
		}
		model.addAttribute("homeList", homeList);
		int totalRecord=gongguService.selectTotalRecored();
		
		PageInfo pi=Pagination.getPageInfo(totalRecord, 1, 1, 8);
		model.addAttribute("pi", pi);
		
		return "/home";
	}
	
	 @GetMapping("/ggRead.go") 
	 public String ggRead_Partic(@RequestParam int gongguNo, Model model, HttpSession session) throws ParseException {
		 Member loginMember=(Member)session.getAttribute("loginMember");
		 List<Zzim> zzimList=likeListController.selectZzim(gongguNo);
		 model.addAttribute("zzimCount", zzimList.size());
		 
		 gongguService.updateGongguCount(gongguNo);
		 Gonggu gonggu = gongguService.selectOneGonggu(gongguNo);
		 
		 LocalDateTime today = LocalDateTime.now();
		 LocalDateTime endTime = LocalDateTime.parse(ChangeDate.chageDateToJsp(gonggu.getEndTime()));
		 if(today.isAfter(endTime) && gonggu.getEndStatus()==1) {
			 gongguService.updateEndStatus(gongguNo);
			 gonggu = gongguService.selectOneGonggu(gongguNo);
		 }
		 
		 model.addAttribute("gonggu", gonggu);
		 
		 if(gonggu.getEndStatus()==1) {
			 return "/gonggu/ggRead"; 
		 }else {
			 return "/gonggu/ggEnd"; 
		 }
		 
	 }
	 
	 
	 
	 @PostMapping("/ggEnrollFrm.go")
	 public String ggEnrollFrm(Gonggu gonggu, Location map,@RequestParam MultipartFile upPhoto1, @RequestParam MultipartFile upPhoto2,
			@RequestParam MultipartFile upPhoto3, Model model,RedirectAttributes redirectAttr) {
		System.out.println(map);
		 int locationNo=locationController.selectLocation(map).getLocationNo();
		 System.out.println("로케넘"+ locationNo);
		 gonggu.setLocationNo(locationNo);
		 gonggu.setPrice(gonggu.getPrice());
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
			chatRoomService.insertChatRoom(newGonggu);
			//model.addAttribute("chatRoom", chatRoomService.insertChatRoom(newGonggu));
			return "/gonggu/ggRead";
		}else {
			redirectAttr.addFlashAttribute("msg","글 작성에 실패했습니다ㅠ");
			return "/gonggu/ggWrite";
		}
	}
	 @GetMapping("/update.go")
	 public String gongguUpdate(@RequestParam int gongguNo, Model model) {
		 Gonggu gonggu=gongguService.selectOneGonggu(gongguNo);
		 model.addAttribute("gonggu", gonggu);
		 Location location=locationService.selectLocationByNo(gonggu.getLocationNo());
		 model.addAttribute("location", location);
		 
		 return "/gonggu/ggUpdate";
	 }
	
	 @PostMapping("/ggUpdate.go")
	 public String ggUpdate(Gonggu newGonggu, Location map, @RequestParam MultipartFile upPhoto1, @RequestParam MultipartFile upPhoto2,
			@RequestParam MultipartFile upPhoto3, Model model, RedirectAttributes redirectAttr) {
		 Gonggu Ogonggu=gongguService.selectOneGonggu(newGonggu.getGongguNo());
		 
		 newGonggu.setPrice(newGonggu.getPrice());
		 
		 int locationNo=locationService.selectLocation(map).getLocationNo();
		 newGonggu.setLocationNo(locationNo);
		 //공구 바로 시작하기 처리
		if (newGonggu.getOpenTime().equals("sysdate")) {
			newGonggu.setEndTime(ChangeDate.chageDate(newGonggu.getEndTime()));
			newGonggu.setSendTime(ChangeDate.chageDate(newGonggu.getSendTime()));
		} else {
			newGonggu.setOpenTime(ChangeDate.chageDate(newGonggu.getOpenTime()));
			newGonggu.setEndTime(ChangeDate.chageDate(newGonggu.getEndTime()));
			newGonggu.setSendTime(ChangeDate.chageDate(newGonggu.getSendTime()));
		}
		
		String saveDirectory = application.getRealPath("/resources/upload");

		ArrayList<String> photo = new ArrayList<String>();

		if (upPhoto1.getSize() > 0) {
			System.out.println("들어옴");
			if(Ogonggu.getPhoto1() != null) {
				File file=new File(saveDirectory, Ogonggu.getPhoto1());
				file.delete();
			}
			
			String changeFilename = SpringUtils.changeMultipartFile(upPhoto1);
			photo.add(changeFilename);
			File destFile = new File(saveDirectory, changeFilename);

			try {
				upPhoto1.transferTo(destFile); // 실제로 저장
			} catch (IOException e) {
				e.printStackTrace();
			}
		}else {
			newGonggu.setPhoto1(Ogonggu.getPhoto1());
		}
		if(upPhoto2.getSize()>0) {
			String changeFilename=SpringUtils.changeMultipartFile(upPhoto2);
			photo.add(changeFilename);
			
			File destFile=new File(saveDirectory, changeFilename);
			if(Ogonggu.getPhoto2() != null) {
				File file=new File(saveDirectory, Ogonggu.getPhoto2());
				file.delete();
			}

			try {
				upPhoto2.transferTo(destFile); // 실제로 저장
			} catch (IOException e) {
				e.printStackTrace();
			}
		}else {
			newGonggu.setPhoto2(Ogonggu.getPhoto2());
		}
		if(upPhoto3.getSize()>0) {
			String changeFilename=SpringUtils.changeMultipartFile(upPhoto3);
			photo.add(changeFilename);
			
			File destFile=new File(saveDirectory, changeFilename);
			if(Ogonggu.getPhoto3() != null) {
				File file=new File(saveDirectory, Ogonggu.getPhoto3());
				file.delete();
			}
			
			try {
				upPhoto3.transferTo(destFile); // 실제로 저장
			} catch (IOException e) {
				e.printStackTrace();
			}
		}else {
			newGonggu.setPhoto3(Ogonggu.getPhoto3());
		}
		//사진 정렬
		if (!photo.isEmpty()) {
			Collections.sort(photo);

			photo.remove(null);
			
			if (photo.size() == 1) {
				newGonggu.setPhoto1(photo.get(0));
			} else if (photo.size() == 2) {
				newGonggu.setPhoto1(photo.get(0));
				newGonggu.setPhoto2(photo.get(1));
			} else {
				newGonggu.setPhoto1(photo.get(0));
				newGonggu.setPhoto2(photo.get(1));
				newGonggu.setPhoto3(photo.get(2));
			}
		}
		int result = gongguService.updateGonggu(newGonggu);
		if(result>0) {
			Gonggu updateGonggu=gongguService.selectOneGonggu(newGonggu.getGongguNo());
			model.addAttribute("gonggu", updateGonggu);
			return "/gonggu/ggRead";
		}else {
			redirectAttr.addFlashAttribute("msg","글 수정에 실패했습니다ㅠ");
			return "/gonggu/ggRead";
		}
	}
	
}
