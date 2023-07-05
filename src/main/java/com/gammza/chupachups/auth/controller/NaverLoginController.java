package com.gammza.chupachups.auth.controller;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.gammza.chupachups.auth.model.service.SocialService;

@Controller
public class NaverLoginController {
	private SocialService socialService;
	private String apiResult = null;
	
	@Autowired
	private void setSocialService(SocialService socialService) {
		this.socialService = socialService;
	}
	
	/*
	@RequestMapping(value = "member/memberLogin.me", method = { RequestMethod.GET, RequestMethod.POST})
	public String login(Model model, HttpSession session) {
		String naverAuthUrl = socialService.getAuthorizationUrl(session);
		
		System.out.println("네이버: " + naverAuthUrl);
		model.addAttribute("urlNaver", naverAuthUrl);
		
		return "member/memberLogin";
		
	}
	*/
	
	/* 230704 din 
	@RequestMapping(value = "/chupachups/auth/naver/callback", method = { RequestMethod.GET, RequestMethod.POST})
	public String callbackNaver(Model model, @RequestParam String code, @RequestParam String state, HttpSession session) throws Exception {
		System.out.println("로그인 성공 callbackNaver");
		
		OAuth2AccessToken oauthToken;
		oauthToken = socialService.getAccessToken(session, code, state);
		
		apiResult = socialService.getUserProfile(oauthToken);
		
		// JSONParser jsonParser = new JsonParser();
		// JSONObject jsonObj;
		
		// jsonObj = (JSONObject) JsonParser.parse(apiResult);
		JsonElement jsonObj = new Gson().fromJson(apiResult, JsonElement.class);
		JsonObject response_obj = jsonObj.getAsJsonObject().get("response").getAsJsonObject();
		
		String id = (String) response_obj.get("id");
		
		session.setAttribute("id", id);
		
		return "redirect:/loginSuccess.do";
	}
	
	@RequestMapping("/loginSuccess.do")
	public String loginSuccess() {
		return "loginSuccess";
	}
	*/
	
	
	
	
	
	

}
