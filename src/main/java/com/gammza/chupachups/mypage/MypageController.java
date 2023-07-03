package com.gammza.chupachups.mypage;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/mypage")
public class MypageController {
	
	@GetMapping("/mypageMain.me")
	public void mypageMain() {}
}
