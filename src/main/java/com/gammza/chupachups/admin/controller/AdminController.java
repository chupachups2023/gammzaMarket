package com.gammza.chupachups.admin.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/admin")
public class AdminController {

	@RequestMapping("/adminMain.ad")
	public String adminMain() {
		return "adminpage/adminMain";
	}
}
