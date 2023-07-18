package com.gammza.chupachups.notify.controller;

import java.util.ArrayList;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.gammza.chupachups.member.model.vo.Member;
import com.gammza.chupachups.notify.model.service.NotifyService;
import com.gammza.chupachups.notify.model.vo.Notify;

@Controller
@RequestMapping("/notify")
public class NotifyController {
	
	@Autowired
	private NotifyService notifyService;
	
	@GetMapping("/selectNotifyList.no")
	public String selectNotifyList(Model model,HttpSession session) {
		String userId=((Member)session.getAttribute("loginMember")).getUserId();
		ArrayList<Notify> notifyList=notifyService.selectNotifyList(userId);
		model.addAttribute("notifyList", notifyList);
		
		return "jsonView";
	}
	
	@GetMapping("/updateNotifyStatus.no")
	public void updateNotifyStatus(HttpSession session) {
		String userId=((Member)session.getAttribute("loginMember")).getUserId();
		int update=notifyService.updateNotifyStatus(userId);
	}
	
	@GetMapping("/selectNewNotify.no")
	public String selectNewNotify(Model model,HttpSession session) {
		String userId=((Member)session.getAttribute("loginMember")).getUserId();
		int newNoti=notifyService.selectNewNotify(userId);
		
		model.addAttribute("newNoti", newNoti);
		
		return "jsonView";
	}
}
