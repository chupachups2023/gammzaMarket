package com.gammza.chupachups.auth.controller;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.MalformedURLException;
import java.net.URL;
import java.util.HashMap;
import java.util.Map;
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
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.client.RestTemplate;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.JsonMappingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.gammza.chupachups.auth.OAuthToken;
import com.gammza.chupachups.auth.model.dao.KakaoProfile;
import com.gammza.chupachups.auth.model.service.SocialService;
import com.gammza.chupachups.member.model.service.MemberService;
import com.gammza.chupachups.member.model.vo.Member;

@Controller
@SessionAttributes({"loginMember"})
public class SocialController {
	
			@Autowired
			private MemberService memberService;
			
			// KAKAO
			@GetMapping(value = "/auth/kakao/callback", produces = "text/json; charset=UTF-8")
			public @ResponseBody String kakaoCallback(String code, Member member, Model model, RedirectAttributes redirectAtt, HttpSession session) {
				
				// POST 방식으로 데이터를 요청(토큰 관련) 
				/* 
					(POST이므로 url에 파라미터로 넣을 수도 없고, a 태그로 전달할 수도 없다) 
						-> RestTemplate 클래스 사용  
						-> HttpURLConnection 도 사용 가능하지만 복잡해짐.. 
				 */
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

				System.out.println("KAKAO ACCESS TOKEN: " + oauthToken.getAccess_token());
				
				
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
				
				System.out.println("KAKAO_IDKEY: " + kakaoProfile.getId());
				System.out.println("KAKAO_NICKNAME: " + kakaoProfile.getKakao_account().getProfile().getNickname());
				// System.out.println("KAKAO_EMAIL: " + kakaoProfile.getKakao_account().getHas_email());
				
				
				// Member
				System.out.println("GAMMZA_USERNAME: " + kakaoProfile.getKakao_account().getProfile().getNickname() + "_" + kakaoProfile.getId());
				UUID garbagePassword = UUID.randomUUID();
				System.out.println("GAMMZA_PASSWORD: " + garbagePassword);
				
				
				/*
				 * member를 조회했을 때, kakao_idkey == null 이면 그대로 진행
				 * kakao_idkey != null 이면 강제 로그인 처리 
				 */
				
//				if (member.getKakaoIdkey() == 0) { // DB kakao_idkey default 0 ? 
//				}
					
				member.setKakaoIdkey(kakaoProfile.getId());
				member.setName(kakaoProfile.getKakao_account().getProfile().getNickname());
				System.out.println(member);
				
				
				int result = memberService.insertKakaoMember(member);
				
				
				// kakaoProfile.setId(kakaoProfile.getId());
				
				// model.addAttribute("kakaoProfile", kakaoProfile);
				
				session.setAttribute("id", kakaoProfile.getId());
				
				
			return "redirect:/member/loginSuccess.do";
			}
			
			@RequestMapping("/member/loginSuccess.do")
			public String loginSuccess() {
				return "redirect:/";
			}
			
			
			
			
			
			/*
			// NAVER 
			@GetMapping(value = "/auth/naver/callback", produces = "text/json; charset=UTF-8")
			public String naverCallback(String code, Member member) {
				// System.out.println("kakao code: " + code);
				
			String access_Token = socialService.getAccessToken2(code);
			// System.out.println("NAVER_access_Token: " + access_Token);
				
			HashMap<String, Object> naverUserInfo = socialService.getUserInfo2(access_Token, member);
			// System.out.println("NAVER_access_Token: " + access_Token);
			System.out.println("NAVER_IDKEY: " + naverUserInfo.get("id"));	
			// System.out.println("NAVER_nickname: " + naverUserInfo.get("nickname"));
				
				
			return "redirect:/";
			// return "member/addInfo"
			}
			
			
	
	

	
	
	
	
	
	
	
	
	
	
	
	
	
	
	/*
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
		HttpEntity<MultiValueMap<String, String>> kakaoTokenRequest = new HttpEntity<MultiValueMap<String, String>>(
				params, headers);

		// Http 요청하기(카카오에 토큰 요청): POST 방식으로 & response 변수의 응답 받음
		ResponseEntity<String> response = rt.exchange("https://kauth.kakao.com/oauth/token", HttpMethod.POST,
				kakaoTokenRequest, String.class);

		// JSON 데이터를 Java object로 처리
		ObjectMapper objectMapper = new ObjectMapper();
		OAuthToken oauthToken = null;

		System.out.println("response: " + response);

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

		// Http 요청하기(카카오 자원서버에 사용자 정보 요청): POST 방식으로 & response2 변수의 응답 받음
		ResponseEntity<String> response2 = rt2.exchange("https://kapi.kakao.com/v2/user/me", HttpMethod.POST,
				kakaoProfileRequest2, String.class);

		// JSON 데이터를 Java object로 처리
		ObjectMapper objectMapper2 = new ObjectMapper();
		KakaoProfile kakaoProfile = null;

		System.out.println("response2: " + response2);

		try {
			kakaoProfile = objectMapper2.readValue(response2.getBody(), KakaoProfile.class);
		} catch (JsonMappingException e) {
			e.printStackTrace();
		} catch (JsonProcessingException e) {
			e.printStackTrace();
		}

		// member object: KAKAO_IDKEY 관련
		System.out.println("KAKAO_IDKEY: " + kakaoProfile.getId());
		// System.out.println("카카오 닉네임: " + kakaoProfile.getKakao_account().getProfile().getNickname()); // 삭제 예정

		/* 
		System.out.println("감자마켓 사용자이름: " + kakaoProfile.getKakao_account().getProfile().getNickname() + "_"
				+ kakaoProfile.getId());
				*/ 
				
		// Member kakaoMember = new Member();
		// kakaoMember.setUserId(kakaoProfile.getKakao_account().getProfile().getNickname()
		// + "_" + kakaoProfile.getId());

		// 회원 or 비회원 체크해서 처리

		// return response2.getBody();
		
		/*
		System.out.println("----------------------------------------------------------------------------------------------");
		System.out.println("카카오 아이디(번호) : " + kakaoProfile.getId());

		System.out.println("감자마켓 사용자이름: " + kakaoProfile.getKakao_account().getProfile().getNickname() + "_" + kakaoProfile.getId());

		UUID garbagePassword = UUID.randomUUID();
		System.out.println("감자마켓 패스워드 : " + garbagePassword);
		System.out.println("----------------------------------------------------------------------------------------------");
		*/
		
		// return "redirect:/";
	// } 

/*
	// NAVER
	@GetMapping(value = "/auth/naver/callback", produces = "text/json; charset=UTF-8")
	public String naverCallback(String code) {
		System.out.println("naver code: " + code);

		// POST 방식으로 key=value 데이터를 요청 (카카오쪽으로)
		RestTemplate rt = new RestTemplate();

		// HttpHeader object 생성
		HttpHeaders headersN1 = new HttpHeaders();
		// headersN1.add("Content-type",
		// "application/x-www-form-urlencoded;charset=utf-8");

		// HttpBody object 생성
		MultiValueMap<String, String> paramsN1 = new LinkedMultiValueMap<String, String>();
		paramsN1.add("grant_type", "authorization_code");
		paramsN1.add("client_id", "GQGBjwaCzYQZZ_5XkE2o");
		paramsN1.add("client_secret", "y3TAUEyfZu");
		paramsN1.add("redirect_uri", "http://localhost:8095/chupachups/auth/naver/callback");
		paramsN1.add("state", "test");
		paramsN1.add("code", code);

		// HttpHeader와 HttpBody를 하나의 object에 담음
		HttpEntity<MultiValueMap<String, String>> naverTokenRequest = new HttpEntity<MultiValueMap<String, String>>(
				paramsN1, headersN1);

		// Http 요청하기: POST 방식으로 & response 변수의 응답 받음
		ResponseEntity<String> responseN1 = rt.exchange("https://nid.naver.com/oauth2.0/token", HttpMethod.POST,
				naverTokenRequest, String.class);

		// JSON 데이터를 Java object로 처리
		ObjectMapper objectMapper3 = new ObjectMapper();
		OAuthToken oauthToken3 = null;

		try {
			oauthToken3 = objectMapper3.readValue(responseN1.getBody(), OAuthToken.class);
		} catch (JsonMappingException e) {
			e.printStackTrace();
		} catch (JsonProcessingException e) {
			e.printStackTrace();
		}

		System.out.println("naver access token: " + oauthToken3.getAccess_token());

		RestTemplate rt2 = new RestTemplate();

		// HttpHeader object 생성

		String token = oauthToken3.getAccess_token(); // 네이버 로그인 접근 토큰;
		String header = "Bearer " + token; // Bearer 다음에 공백 추가

		String apiURL = "https://openapi.naver.com/v1/nid/me";

		Map<String, String> requestHeaders = new HashMap<String, String>();
		requestHeaders.put("Authorization", header);
		String responseBody = get(apiURL, requestHeaders);

		System.out.println("responseBody: " + responseBody);

		/*
		 * // member object: NAVER_IDKEY 관련 System.out.println("NAVER_IDKEY: " +
		 * oauthToken3.getAccess_token().);
		 */
		

		// return "redirect:/";
	// }
			
	/*
	private static String get(String apiUrl, Map<String, String> requestHeaders) {
		HttpURLConnection con = connect(apiUrl);
		try {
			con.setRequestMethod("GET");
			for (Map.Entry<String, String> header : requestHeaders.entrySet()) {
				con.setRequestProperty(header.getKey(), header.getValue());
			}

			int responseCode = con.getResponseCode();
			if (responseCode == HttpURLConnection.HTTP_OK) { // 정상 호출
				return readBody(con.getInputStream());
			} else { // 에러 발생
				return readBody(con.getErrorStream());
			}
		} catch (IOException e) {
			throw new RuntimeException("API 요청과 응답 실패", e);
		} finally {
			con.disconnect();
		}
	}

	/*
	private static HttpURLConnection connect(String apiUrl) {
		try {
			URL url = new URL(apiUrl);
			return (HttpURLConnection) url.openConnection();
		} catch (MalformedURLException e) {
			throw new RuntimeException("API URL이 잘못되었습니다. : " + apiUrl, e);
		} catch (IOException e) {
			throw new RuntimeException("연결이 실패했습니다. : " + apiUrl, e);
		}
	}
	
	/*
	private static String readBody(InputStream body) {
		InputStreamReader streamReader = new InputStreamReader(body);

		BufferedReader lineReader = null;
		StringBuilder responseBody = new StringBuilder();

		try {
			lineReader = new BufferedReader(streamReader);

			String line;
			while ((line = lineReader.readLine()) != null) {
				responseBody.append(line);
			}

			return responseBody.toString();
		} catch (IOException e) {
			throw new RuntimeException("API 응답을 읽는데 실패했습니다.", e);
		} finally {
			if (lineReader != null) {
				try {
					lineReader.close();
				} catch (IOException e) {
					// 오류 처리
				}
			}
		}
	}
	*/
}
