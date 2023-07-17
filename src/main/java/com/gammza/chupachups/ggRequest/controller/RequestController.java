package com.gammza.chupachups.ggRequest.controller;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.gammza.chupachups.common.SpringUtils;
import com.gammza.chupachups.ggRequest.model.service.RequestService;
import com.gammza.chupachups.ggRequest.model.vo.Request;
import com.gammza.chupachups.ggRequest.model.vo.RequestMember;
import com.gammza.chupachups.gonggu.model.vo.Gonggu;
import com.gammza.chupachups.location.controller.LocationController;
import com.gammza.chupachups.location.model.vo.Location;
import com.gammza.chupachups.member.model.vo.Member;

@Controller
@RequestMapping("/ggRequest")
public class RequestController {
	
	@Autowired
	private RequestService requestService;
	@Autowired
	private LocationController locationController;
	@Autowired
	private ServletContext application;
	
	@GetMapping("/requestView.req")
	public String requestView(@RequestParam(defaultValue="127.0016985") String longitude,@RequestParam(defaultValue="37.5642135") String latitude, 
			Model model,HttpSession session , @RequestParam(defaultValue="recent") String sort) {
		model.addAttribute("hiddenSort", sort);
		Member member=(Member)session.getAttribute("loginMember");
		HashMap<String,String> map=new HashMap<String,String>();
		if(member != null) {
			map.put("latitude", member.getLatitude());
			map.put("longitude", member.getLongitude());
		}else {
			map.put("latitude", latitude);
			map.put("longitude", longitude);
		}
		map.put("sort", sort);
		ArrayList<Request> requestList=requestService.selectAllRequestList(map);
		
		for(int i=0;i<requestList.size();i++) {
			Request request=requestList.get(i);
			String regAt=requestService.selectRequestMember(request.getRequestNo()).get(0).getRegAt();
			request.setRecentDate(regAt);
		}
		model.addAttribute("requestList", requestList);
		
		return "/others/requestView";
	}
	
	@GetMapping("/requestRead.req")
	public String requestRead(@RequestParam int requestNo, Model model) {
		
		requestService.updateRequestCount(requestNo);
		Request ggrequest=requestService.selectRequest(requestNo);
		model.addAttribute("request", ggrequest);
		
		return "/others/requestRead";
	}
	
	@PostMapping("/requestMember.req")
	public String requestMember(@RequestParam int requestNo, Model model) {
		ArrayList<RequestMember> reqMember=requestService.selectRequestMember(requestNo);
		model.addAttribute("reqMember", reqMember);
		
		return "jsonView";
	}
	
	@GetMapping("/writeRequest.req")
	public String writeRequest() {
		return "/others/writeRequest";
	}

	 //요청 글 작성
	 @PostMapping("/ggRequestFrm.req")
	 public String ggEnrollFrm(Request request, Location location, @RequestParam MultipartFile upPhoto1, @RequestParam MultipartFile upPhoto2,
			@RequestParam MultipartFile upPhoto3, Model model,RedirectAttributes redirectAttr) {
		 
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
			//Collections.sort(photo);

			photo.remove(null);

			if (photo.size() == 1) {
				request.setPhoto1(photo.get(0));
			} else if (photo.size() == 2) {
				request.setPhoto1(photo.get(0));
				request.setPhoto2(photo.get(1));
			} else {
				request.setPhoto1(photo.get(0));
				request.setPhoto2(photo.get(1));
				request.setPhoto3(photo.get(2));
			}
		}
		int result = requestService.insertRequest(request);
		
		int localCode=locationController.selectLocation(location).getLocationNo();
		
		
		if(result>0) {
			int requestNo=requestService.selectLastNum();
			Request newRequest=requestService.selectRequest(requestNo);
			model.addAttribute("request", newRequest);
			
			RequestMember reqMem=new RequestMember();
			reqMem.setLatitude(newRequest.getLatitude());
			reqMem.setLongitude(newRequest.getLongitude());
			reqMem.setLocalCode(localCode);
			reqMem.setRequestMember(newRequest.getRequestWriter());
			reqMem.setRequestNo(newRequest.getRequestNo());
			
			int insert=requestService.insertRequestMember(reqMem);
			
			return "/others/requestRead";
		}else {
			redirectAttr.addFlashAttribute("msg","글 작성에 실패했습니다ㅠ");
			return "/others/writeRequest";
		}
	}
	 
	 @GetMapping("/enrollRequest.req")
	 public String enrollRequest(HttpSession session, @RequestParam int requestNo,RedirectAttributes redirectAttr) {
		 Member loginMember=(Member)session.getAttribute("loginMember");
		 HashMap<String,String> map=new HashMap<String,String>();
		 map.put("requestNo", String.valueOf(requestNo));
		 map.put("userId",loginMember.getUserId());
		 
		 int count=requestService.selectRequestMemberByNo(map);
		 if(count>0) {
			redirectAttr.addFlashAttribute("msg","이미 참가한 요청입니다");
			return "redirect:/ggRequest/requestAfterEnroll.req?requestNo="+requestNo;
		 }else {
			 RequestMember reqMem=new RequestMember();
			 reqMem.setLatitude(loginMember.getLatitude());
			 reqMem.setLongitude(loginMember.getLongitude());
			 reqMem.setLocalCode(loginMember.getLocation());
			 reqMem.setRequestMember(loginMember.getUserId());
			 reqMem.setRequestNo(requestNo);
			requestService.insertRequestMember(reqMem);
			requestService.updateRequestNum(requestNo);
			redirectAttr.addFlashAttribute("msg","참가가 완료되었습니다.");
			return "redirect:/ggRequest/requestAfterEnroll.req?requestNo="+requestNo;
		 }
	 }
	 
	 @GetMapping("/requestAfterEnroll.req")
	 public String requestAfterEnroll(@RequestParam int requestNo, Model model) {
		 Request request=requestService.selectRequest(requestNo);
		 model.addAttribute("request", request);
		 return "/others/requestRead";
	 }
	 
	 @GetMapping("/gongguWrite.req")
	 public String gongguWrite(@RequestParam int requestNo,Model model,RedirectAttributes redirectAttr) {
		 Request request=requestService.selectRequest(requestNo);
		 Gonggu gonggu=new Gonggu();
		 gonggu.setGongguNo(requestNo);
		 gonggu.setCategory(request.getCategoryNo());
		 gonggu.setGongguName(request.getRequestName());
		 gonggu.setLink(request.getLink());
		 gonggu.setPhoto1(request.getPhoto1());
		 gonggu.setPhoto2(request.getPhoto2());
		 gonggu.setPhoto3(request.getPhoto3());
		 
		 redirectAttr.addFlashAttribute("gonggu",gonggu);
		 return "redirect:/gonggu/ggWrite.go";
	 }
	 
	 @GetMapping("/requestDelete.req")
	 public String requestDelete(@RequestParam int requestNo,RedirectAttributes redirectAttr) {
		 int updateRequestStatus=requestService.updateRequestStatus(requestNo);
		 
		 return "redirect:requestView.req";
	 }
	 
	 public int updateRequestReqStatus(int requestNo) {
		 return requestService.updateRequestReqStatus(requestNo);
	 }
  
  
}
