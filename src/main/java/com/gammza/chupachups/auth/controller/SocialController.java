package com.gammza.chupachups.auth.controller;

import java.util.UUID;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpMethod;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.LinkedMultiValueMap;
import org.springframework.util.MultiValueMap;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.bind.support.SessionStatus;
import org.springframework.web.client.RestTemplate;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.JsonMappingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.gammza.chupachups.auth.OAuthToken;
import com.gammza.chupachups.auth.model.vo.KakaoProfile;
import com.gammza.chupachups.auth.model.vo.NaverProfile;
import com.gammza.chupachups.member.model.service.MemberService;
import com.gammza.chupachups.member.model.vo.Member;

@Controller
@SessionAttributes({"loginMember"})
public class SocialController {
	
			@Autowired
			private MemberService memberService;
			
			// KAKAO
			@GetMapping(value = "/auth/kakao/callback", produces = "text/json; charset=UTF-8")
			//@ResponseBody
			public String kakaoCallback(String code, Member member, Model model, RedirectAttributes redirectAtt, HttpSession session, SessionStatus status) {
				
				/*
					POST 방식으로 데이터를 요청(토큰 관련) 
						-> RestTemplate 클래스 사용  
						-> HttpURLConnection 도 사용 가능
				 */
				RestTemplate rt = new RestTemplate();
				
				// HttpHeader object 생성
				HttpHeaders headers = new HttpHeaders();
				headers.add("Content-type", "application/x-www-form-urlencoded;charset=utf-8");

				// HttpBody object 생성
				MultiValueMap<String, String> params = new LinkedMultiValueMap<String, String>();
				params.add("grant_type", "authorization_code");
				params.add("client_id", "{ REST API 키 }");
				params.add("redirect_uri", "http://localhost:8095/chupachups/auth/kakao/callback");
				params.add("code", code);

				// HttpHeader와 HttpBody를 하나의 object에 담음
				HttpEntity<MultiValueMap<String, String>> kakaoTokenRequest = new HttpEntity<MultiValueMap<String, String>>(params, headers);
				
				// 요청 
				ResponseEntity<String> response = rt.exchange(
						"https://kauth.kakao.com/oauth/token", 
						HttpMethod.POST, 
						kakaoTokenRequest, 
						String.class); // 응답받을 타입 
				
				// 정보를 OAuthToken 객체에 저장 
				// JSON 데이터를 Java로 처리하기 위해서 바꿔준 것 
				ObjectMapper objectMapper = new ObjectMapper();
				OAuthToken oauthToken = null;
				
				try {
					oauthToken = objectMapper.readValue(response.getBody(), OAuthToken.class);
				} catch (JsonMappingException e) {
					e.printStackTrace();
				} catch (JsonProcessingException e) {
					e.printStackTrace();
				}
				// System.out.println("KAKAO ACCESS TOKEN: " + oauthToken.getAccess_token());
				
				
				RestTemplate rt2 = new RestTemplate();

				HttpHeaders headers2 = new HttpHeaders();
				headers2.add("Authorization", "Bearer " + oauthToken.getAccess_token());
				headers2.add("Content-type", "application/x-www-form-urlencoded;charset=utf-8");

				HttpEntity<MultiValueMap<String, String>> kakaoProfileRequest2 = new HttpEntity(headers2);

				ResponseEntity<String> response2 = rt2.exchange(
						"https://kapi.kakao.com/v2/user/me", 
						HttpMethod.POST,
						kakaoProfileRequest2, 
						String.class);
				
				ObjectMapper objectMapper2 = new ObjectMapper();
				KakaoProfile kakaoProfile = null;
				
				try {
					kakaoProfile = objectMapper2.readValue(response2.getBody(), KakaoProfile.class);
				} catch (JsonMappingException e) {
					e.printStackTrace();
				} catch (JsonProcessingException e) {
					e.printStackTrace();
				}
				//System.out.println("KAKAO_IDKEY: " + kakaoProfile.getId());
				//System.out.println("KAKAO_NICKNAME: " + kakaoProfile.getKakao_account().getProfile().getNickname());
				
				// Member
				// System.out.println("GAMMZA_USERNAME: " + kakaoProfile.getKakao_account().getProfile().getNickname() + "_" + kakaoProfile.getId());
				// UUID garbagePassword = UUID.randomUUID();
				// System.out.println("GAMMZA_PASSWORD: " + garbagePassword);
					
				member.setKakaoIdkey(kakaoProfile.getId());
				member.setName(kakaoProfile.getKakao_account().getProfile().getNickname());
				member.setBirthday(kakaoProfile.getKakao_account().getBirthday());
				member.setName(kakaoProfile.getProperties().getNickname()); // 카카오는 이름 대신 닉네임 
				member.setEmail(kakaoProfile.getKakao_account().getEmail());
				//System.out.println(member);
				
				Member loginMember=memberService.selectMemberByKakao(kakaoProfile.getId());
				
				if (loginMember == null) { // 카카오 연동을 최초로 하는 신규/기존 회원  (KAKAO_IDKEY == NULL)
					session.setAttribute("kakaoIdkey", kakaoProfile.getId());
					redirectAtt.addFlashAttribute("msg", "카카오 간편로그인 최초 1회 연결이 필요합니다.");
					return "redirect:/socialLogin.me";
				} else { // 카카오 연동 완료한 회원 
					model.addAttribute("loginMember", loginMember);
					redirectAtt.addFlashAttribute("msg", member.getName()+ "님 환영합니다💚");
					return "redirect:/";
				}
			}
			
			 @GetMapping("/socialLogin.me") 
			 public String socialLogin() {
				 return "/member/socialLogin"; 
			 }
			
			/*
			@GetMapping("/member/insertKakaoMember")
			public String insertKakaoMember(Member member, KakaoProfile kakaoProfile) {
				Member memberCheck = memberService.selectMemberByKakao(kakaoProfile.getId());
				if (memberCheck == null) {
					int result = memberService.insertKakaoMember(member);
				}
				return "redirect:/";
			}
			
			/*
			@GetMapping("/member/insertKakaoMember") 
			public String insertKakaoMember(Member member, KakaoProfile kakaoProfile, Model model) {
				Member memberCheck = memberService.selectMemberByKakao(kakaoProfile.getId());
				if (memberCheck == null) { int result = memberService.insertKakaoMember(member); 
				model.addAttribute("kakaoIdkey", kakaoProfile.getId()); 
				} 
				return "redirect:/";
			}
			*/
			

			// 230711 수정 
			//NAVER 
			@GetMapping(value = "/auth/naver/callback", produces = "text/json; charset=UTF-8")
			// @ResponseBody
			public String naverCallback(String code, Member member, Model model, RedirectAttributes redirectAtt, HttpSession session) {
				//System.out.println("NAVER code: " + code);
				
				// POST 방식으로 key=value 데이터를 요청 (네이버쪽으로) 
				RestTemplate rt = new RestTemplate();
				
				// HttpHeader object 생성 
				HttpHeaders headersN1 = new HttpHeaders();
				headersN1.add("Content-type", "application/x-www-form-urlencoded;charset=utf-8");
				
				// HttpBody object 생성 
				MultiValueMap<String, String> paramsN1 = new LinkedMultiValueMap<String, String>();
				paramsN1.add("grant_type", "authorization_code");
				paramsN1.add("client_id", "{ 애플리케이션 Client ID }");
				paramsN1.add("client_secret", "{ 애플리케이션 Client Secret }");
				paramsN1.add("redirect_uri", "http://localhost:8095/chupachups/auth/naver/callback");
				paramsN1.add("code", code);
				
				// HttpHeader와 HttpBody를 하나의 object에 담음  
				HttpEntity<MultiValueMap<String, String>> naverTokenRequest = new HttpEntity(paramsN1, headersN1);
				
				// Http 요청하기: POST 방식으로 & response 변수의 응답 받음  
				ResponseEntity<String> responseN1 = rt.exchange(
						"https://nid.naver.com/oauth2.0/token",
						HttpMethod.POST,
						naverTokenRequest,
						String.class
						);
				
				// JSON 데이터를 Java object로 처리 
				ObjectMapper objectMapper2 = new ObjectMapper();
				OAuthToken oauthToken2 = null;
				
				try {
					oauthToken2 = objectMapper2.readValue(responseN1.getBody(), OAuthToken.class);
				} catch (JsonMappingException e) {
					e.printStackTrace();
				} catch (JsonProcessingException e) {
					e.printStackTrace();
				}
				//System.out.println("NAVER ACCESS TOKEN: " + oauthToken2.getAccess_token());

				
				
				RestTemplate rt2 = new RestTemplate();
				
				// HttpHeader object 생성 
				HttpHeaders headersN2 = new HttpHeaders();
				headersN2.add("Authorization", "Bearer " + oauthToken2.getAccess_token());
				headersN2.add("Content-type", "application/x-www-form-urlencoded;charset=utf-8");
				
				// HttpHeader와 HttpBody를 하나의 object에 담음  
				HttpEntity<MultiValueMap<String, String>> naverProfileRequest2 = new HttpEntity(headersN2);
				
				// Http 요청하기: POST 방식으로 & response 변수의 응답 받음  
				ResponseEntity<String> responseN2 = rt2.exchange(
						"https://openapi.naver.com/v1/nid/me",
						HttpMethod.POST,
						naverProfileRequest2,
						String.class
						);
				
				// JSON 데이터를 Java object로 처리 
				ObjectMapper objectMapperN2 = new ObjectMapper();
				NaverProfile naverProfile = null;
				
				try {
					naverProfile = objectMapperN2.readValue(responseN2.getBody(), NaverProfile.class);
				} catch (JsonMappingException e) {
					e.printStackTrace();
				} catch (JsonProcessingException e) {
					e.printStackTrace();
				}
				
//				System.out.println("NAVER_IDKEY: " + naverProfile.getResponse().getId());
//				System.out.println("NAVER_NAME: " + naverProfile.getResponse().getName());
//				System.out.println("NAVER_BIRTHDAY: " + naverProfile.getResponse().getBirthday());
//				System.out.println("NAVER_EMAIL: " + naverProfile.getResponse().getEmail());
				
				member.setNaverIdkey(naverProfile.getResponse().getId());
				member.setName(naverProfile.getResponse().getName());
				member.setBirthday(naverProfile.getResponse().getBirthday());
				member.setEmail(naverProfile.getResponse().getEmail());
//				System.out.println("네이버 member: " + member); 
				
				Member loginMember=memberService.selectMemberByNaver(naverProfile.getResponse().getId());
				
				if (loginMember == null) { // 네이버 연동을 최초로 하는 신규/기존 회원  (NAVER_IDKEY == NULL) 
					session.setAttribute("naverIdkey", naverProfile.getResponse().getId());
					redirectAtt.addFlashAttribute("msg", "네이버 간편로그인 최초 1회 연결이 필요합니다.");
					return "redirect:/socialLogin.me";
				} else { // 네이버 연동 완료한 회원 
					model.addAttribute("loginMember", loginMember);
					redirectAtt.addFlashAttribute("msg", member.getName()+ "님 환영합니다💚");
					return "redirect:/";
				}
			}
}
