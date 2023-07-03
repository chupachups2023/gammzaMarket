package com.gammza.chupachups.auth;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpMethod;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.util.LinkedMultiValueMap;
import org.springframework.util.MultiValueMap;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.client.RestTemplate;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.JsonMappingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.gammza.chupachups.member.model.service.MemberServiceImpl;

@Controller
public class SocialController {
	
	@Autowired
	private MemberServiceImpl memberServiceImpl;
	
	
	// KAKAO 
	@GetMapping(value = "/auth/kakao/callback", produces = "text/json; charset=UTF-8")
	public String kakaoCallback(String code) {
		System.out.println("kakao code: " + code);
		
		// POST 방식으로 key=value 데이터를 요청 (카카오쪽으로) 
		RestTemplate rt = new RestTemplate();
		
		// HttpHeader object 생성 
		HttpHeaders headers = new HttpHeaders();
		headers.add("Content-type", "application/x-www-form-urlencoded;charset=utf-8");
		
		// HttpBody object 생성 
		MultiValueMap<String, String> params = new LinkedMultiValueMap<String, String>();
		params.add("grant_type", "authorization_code");
		params.add("client_id", "db32886cc653e7c143ebd36f56525b61");
		params.add("redirect_uri", "http://localhost:8095/chupachups/auth/kakao/callback");
		params.add("code", code);
		
		// HttpHeader와 HttpBody를 하나의 object에 담음  
		HttpEntity<MultiValueMap<String, String>> kakaoTokenRequest = new HttpEntity<MultiValueMap<String, String>>(params, headers);
		
		// Http 요청하기: POST 방식으로 & response 변수의 응답 받음  
		ResponseEntity<String> response = rt.exchange(
				"https://kauth.kakao.com/oauth/token",
				HttpMethod.POST,
				kakaoTokenRequest,
				String.class
				);
		
		
		// JSON 데이터를 Java object로 처리 
		ObjectMapper objectMapper = new ObjectMapper();
		OAuthToken oauthToken = null;
		
		try {
			oauthToken = objectMapper.readValue(response.getBody(), OAuthToken.class);
		} catch (JsonMappingException e) {
			e.printStackTrace();
		} catch (JsonProcessingException e) {
			e.printStackTrace();
		}
		
		System.out.println("kakao access token: " + oauthToken.getAccess_token());
		
		
		RestTemplate rt2 = new RestTemplate();
		
		// HttpHeader object 생성 
		HttpHeaders headers2 = new HttpHeaders();
		headers2.add("Authorization", "Bearer " + oauthToken.getAccess_token());
		headers2.add("Content-type", "application/x-www-form-urlencoded;charset=utf-8");
		
		// HttpHeader와 HttpBody를 하나의 object에 담음  
		HttpEntity<MultiValueMap<String, String>> kakaoProfileRequest2 = new HttpEntity(headers2);
		
		
		// Http 요청하기: POST 방식으로 & response 변수의 응답 받음  
		ResponseEntity<String> response2 = rt2.exchange(
				"https://kapi.kakao.com/v2/user/me",
				HttpMethod.POST,
				kakaoProfileRequest2,
				String.class
				);
		
		// JSON 데이터를 Java object로 처리 
		ObjectMapper objectMapper2 = new ObjectMapper();
		KakaoProfile kakaoProfile = null;
		
		try {
			kakaoProfile = objectMapper2.readValue(response2.getBody(), KakaoProfile.class);
		} catch (JsonMappingException e) {
			e.printStackTrace();
		} catch (JsonProcessingException e) {
			e.printStackTrace();
		}
		
		// member object: KAKAO_IDKEY 관련 
		System.out.println("KAKAO_IDKEY: " + kakaoProfile.getId());
		System.out.println("카카오 닉네임: " + kakaoProfile.getKakao_account().getProfile().getNickname()); // 삭제 예정 
		
		System.out.println("감자마켓 사용자이름: " + kakaoProfile.getKakao_account().getProfile().getNickname() + "_" + kakaoProfile.getId());
		
		// Member kakaoMember = new Member();
		// kakaoMember.setUserId(kakaoProfile.getKakao_account().getProfile().getNickname() + "_" + kakaoProfile.getId());
		
		// 회원 or 비회원 체크해서 처리 
		// memberServiceImpl.selectOneMember(kakaoMember);
		
		
		// memberServiceImpl.selectOneMember(code);
		
		
		
		// return response2.getBody();
		return "/common/mainHeader";
	}
	
	
		// NAVER 
		@GetMapping(value = "/auth/naver/callback", produces = "text/json; charset=UTF-8")
		public String naverCallback(String code) {
			System.out.println("naver code: " + code);
		
		// POST 방식으로 key=value 데이터를 요청 (카카오쪽으로) 
		RestTemplate rt = new RestTemplate();
		
		
		// HttpHeader object 생성 
		HttpHeaders headersN1 = new HttpHeaders();
		// headersN1.add("Content-type", "application/x-www-form-urlencoded;charset=utf-8");
		
		
		// HttpBody object 생성 
		MultiValueMap<String, String> paramsN1 = new LinkedMultiValueMap<String, String>();
		paramsN1.add("grant_type", "authorization_code");
		paramsN1.add("client_id", "GQGBjwaCzYQZZ_5XkE2o");
		paramsN1.add("client_secret", "y3TAUEyfZu");
		paramsN1.add("redirect_uri", "http://localhost:8095/chupachups/auth/naver/callback");
		paramsN1.add("state", "test");
		paramsN1.add("code", code);
		
		// HttpHeader와 HttpBody를 하나의 object에 담음  
		HttpEntity<MultiValueMap<String, String>> naverTokenRequest = new HttpEntity<MultiValueMap<String, String>>(paramsN1, headersN1);
		
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
		
		System.out.println("naver access token: " + oauthToken2.getAccess_token());
		
		
		RestTemplate rt2 = new RestTemplate();
		
		// HttpHeader object 생성 
		HttpHeaders headersN2 = new HttpHeaders();
		headersN2.add("Authorization", "Bearer " + oauthToken2.getAccess_token());
		// headersN2.add("Content-type", "application/x-www-form-urlencoded;charset=utf-8");
		
		
		// HttpHeader와 HttpBody를 하나의 object에 담음  
		HttpEntity<MultiValueMap<String, String>> naverProfileRequest = new HttpEntity(headersN2);
		
		
		// Http 요청하기: POST 방식으로 & response 변수의 응답 받음  
		ResponseEntity<String> responseN2 = rt2.exchange(
				"https://nid.naver.com/oauth2.0/token",
				HttpMethod.POST,
				naverProfileRequest,
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
		
		// member object: NAVER_IDKEY 관련 
		System.out.println("NAVER_IDKEY: " + naverProfile.getId());
		
		
		/*
		System.out.println("네이버 닉네임: " + naverProfile.getKakao_account().getProfile().getNickname()); // 삭제 예정 
		
		System.out.println("감자마켓 사용자이름: " + naverProfile.getKakao_account().getProfile().getNickname() + "_" + naverProfile.getId());
		*/
		// Member kakaoMember = new Member();
		// kakaoMember.setUserId(kakaoProfile.getKakao_account().getProfile().getNickname() + "_" + kakaoProfile.getId());
		
		// 회원 or 비회원 체크해서 처리 
		// memberServiceImpl.selectOneMember(kakaoMember);
		
		
		// memberServiceImpl.selectOneMember(code);
		
		
		
		// return responseN2.getBody();
		return "/common/mainHeader";
	}
	
	
	
	/*
	@GetMapping("/auth/naver/callback")
	public String naverCallback(String code) {
		System.out.println("naver code: " + code);
		
		return "redirect:/";
	}
	*/
	
	/*
	@Inject
	private SnsValue naverSns;
	
		
	
	@RequestMapping(value = "/auth/naver/callback", method = { RequestMethod.POST, RequestMethod.GET })
	public String naverCallback(Model model, @RequestParam String code) throws Exception {
		
		// 1. code로 access_token 받기 
		// 2. access_token 이용해서 사용자 profile 정보 가져오기 
		
		
		
		
		// 3. DB 해당 유저가 존재하는지 체크(NAVER_IDKEY, KAKAO_IDKEY) 
		// 4. 존재하면 로그인, 미존재 시 가입 페이지로 
		
		
		
		
		
		return "loginResult";
	}
		
*/		
	

}
