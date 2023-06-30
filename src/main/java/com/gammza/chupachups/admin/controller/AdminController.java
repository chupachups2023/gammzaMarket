package com.gammza.chupachups.admin.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/adminpage")
public class AdminController {

	@GetMapping("/adminMain.ad")
	public void adminMain() {}
}
