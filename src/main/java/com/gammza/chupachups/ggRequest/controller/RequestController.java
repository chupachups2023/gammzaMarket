package com.gammza.chupachups.ggRequest.controller;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;

import javax.servlet.ServletContext;

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
import com.gammza.chupachups.location.controller.LocationController;
import com.gammza.chupachups.location.model.vo.Location;


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
		model.addAttribute("request", ggrequest);
		
		ArrayList<RequestMember> reqMember=requestService.selectRequestMember(requestNo);
		
		
		return "/others/requestRead";
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
}
