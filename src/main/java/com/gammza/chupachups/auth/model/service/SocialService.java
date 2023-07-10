package com.gammza.chupachups.auth.model.service;

import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.OutputStreamWriter;
import java.net.HttpURLConnection;
import java.net.URL;
import java.util.HashMap;
import java.util.UUID;

import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Service;

import com.gammza.chupachups.auth.NaverAPI20;
import com.gammza.chupachups.member.model.vo.Member;
import com.github.scribejava.core.builder.ServiceBuilder;
import com.github.scribejava.core.model.OAuth2AccessToken;
import com.github.scribejava.core.model.OAuthRequest;
import com.github.scribejava.core.model.Response;
import com.github.scribejava.core.model.Verb;
import com.github.scribejava.core.oauth.OAuth20Service;
import com.google.gson.Gson;
import com.google.gson.JsonElement;
import com.google.gson.JsonObject;

@Service
public class SocialService {
	
	// KAKAO 
	public String getAccessToken(String authorize_code) {
		String access_Token = "";
		String refresh_Token = "";
		String reqURL = "https://kauth.kakao.com/oauth/token";
		
		try {
			URL url = new URL(reqURL);
            
			HttpURLConnection conn = (HttpURLConnection) url.openConnection();
            
			conn.setRequestMethod("POST");
			conn.setDoOutput(true); // POST 요청을 위해 기본값이 false인 setDoOutput을 true로 
			
			BufferedWriter bw = new BufferedWriter(new OutputStreamWriter(conn.getOutputStream()));
			StringBuilder sb = new StringBuilder();
			sb.append("grant_type=authorization_code");
			sb.append("&client_id=db32886cc653e7c143ebd36f56525b61"); 
			sb.append("&redirect_uri=http://localhost:8095/chupachups/auth/kakao/callback");
			sb.append("&code=" + authorize_code);
			bw.write(sb.toString());
			bw.flush();
            
			// 결과 코드가 200이라면 성공
			int responseCode = conn.getResponseCode();
			// System.out.println("responseCode : " + responseCode);
            
			// 요청을 통해 얻은 JSON타입의 Response 메세지 읽어오기
			BufferedReader br = new BufferedReader(new InputStreamReader(conn.getInputStream()));
			String line = "";
			String result = "";
            
			while ((line = br.readLine()) != null) {
				result += line;
			}
			// System.out.println("response body(카카오 토큰) : " + result);
            
			// Gson 라이브러리에 포함된 클래스로 JSON파싱 객체 생성
			// JsonArray parser = new Gson().fromJson("JsonArray 문자열", JsonArray.class);
			
			// JsonParser parser = new JsonParser();
			JsonElement element = new Gson().fromJson(result, JsonElement.class);
			access_Token = element.getAsJsonObject().get("access_token").getAsString();
			refresh_Token = element.getAsJsonObject().get("refresh_token").getAsString();
			// System.out.println("access_token : " + access_Token);
			// System.out.println("refresh_token : " + refresh_Token);
            
			br.close();
			bw.close();
		} catch (IOException e) {
			e.printStackTrace();
		}
		return access_Token;
	}
	
	public HashMap<String, Object> getUserInfo(String access_Token) {

		// 사용자마다 가진 정보가 다를 수 있으므로 HashMap타입으로 선언
		HashMap<String, Object> kakaoUserInfo = new HashMap<String, Object>();
		String reqURL = "https://kapi.kakao.com/v2/user/me";
		try {
			URL url = new URL(reqURL);
			HttpURLConnection conn = (HttpURLConnection) url.openConnection();
			conn.setRequestMethod("GET");

			// 요청에 필요한 Header에 포함될 내용
			conn.setRequestProperty("Authorization", "Bearer " + access_Token);

			int responseCode = conn.getResponseCode();
			// System.out.println("responseCode : " + responseCode); // 200 

			BufferedReader br = new BufferedReader(new InputStreamReader(conn.getInputStream()));
			String line = "";
			String result = "";
			
			while ((line = br.readLine()) != null) {
				result += line;
			}
			System.out.println("response body(카카오 사용자 정보) : " + result);

			JsonElement element = new Gson().fromJson(result, JsonElement.class);

			JsonObject properties = element.getAsJsonObject().get("properties").getAsJsonObject();
			String kakao_idkey = element.getAsJsonObject().get("id").getAsString();
			
			// JsonObject kakao_idkey = element.getAsJsonObject().get("id").getAsJsonObject();

			String nickname = properties.getAsJsonObject().get("nickname").getAsString();
			String id = kakao_idkey.toString();
			
			kakaoUserInfo.put("id", id);
			kakaoUserInfo.put("nickname", nickname);
			
				
			
			
			

		} catch (IOException e) {
			e.printStackTrace();
		}
		
		return kakaoUserInfo;
	}
	
	/*
	// NAVER 
	private final static String CLIENT_ID = "GQGBjwaCzYQZZ_5XkE2o";
	private final static String CLIENT_SECRET = "y3TAUEyfZu";
	private final static String REDIRECT_URI = "http://localhost:8095/chupachups/auth/naver/callback";
	private final static String SESSION_STATE = "oauth_state";
	String reqURL = "https://openapi.naver.com/v1/nid/me";
	
	public String getAuthorizationUrl(HttpSession session) {
		String state = generateRandomString();
		setSession(session, state);
		
		OAuth20Service oauthService = new ServiceBuilder()
				.apiKey(CLIENT_ID)
				.apiSecret(CLIENT_SECRET)
				.callback(REDIRECT_URI)
				.state(state)
				.build(NaverAPI20.instance());
		return oauthService.getAuthorizationUrl();
	}
	
	public String getAccessToken2(String authorize_code) {
		String access_Token = "";
		String refresh_Token = "";
		String reqURL = "https://nid.naver.com/oauth2.0/token";
		
		try {
			URL url2 = new URL(reqURL);
            
			HttpURLConnection conn2 = (HttpURLConnection) url2.openConnection();
			conn2.setRequestMethod("POST");
			conn2.setDoOutput(true);
			
			BufferedWriter bw2 = new BufferedWriter(new OutputStreamWriter(conn2.getOutputStream()));
			StringBuilder sb2 = new StringBuilder();
			sb2.append("grant_type=authorization_code");
            
			sb2.append("&client_id=GQGBjwaCzYQZZ_5XkE2o"); 
			sb2.append("&redirect_uri=http://localhost:8095/chupachups/auth/naver/callback");
			sb2.append("&client_secret=y3TAUEyfZu");
			sb2.append("&code=" + authorize_code);
			bw2.write(sb2.toString());
			
			bw2.flush();
            
			int responseCode2 = conn2.getResponseCode();
			// System.out.println("responseCode(NAVER) : " + responseCode2); // 200이면 성공 
            
			// 요청을 통해 얻은 JSON타입의 Response 메세지 읽어오기
			BufferedReader br2 = new BufferedReader(new InputStreamReader(conn2.getInputStream()));
			String line2 = "";
			String result2 = "";
            
			while ((line2 = br2.readLine()) != null) {
				result2 += line2;
			}
			// System.out.println("response body(네이버 토큰) : " + result2);
            
			// Gson 라이브러리에 포함된 클래스로 JSON파싱 객체 생성
			// JsonArray parser = new Gson().fromJson("JsonArray 문자열", JsonArray.class);
			
			// JsonParser parser = new JsonParser();
			JsonElement element2 = new Gson().fromJson(result2, JsonElement.class);
			access_Token = element2.getAsJsonObject().get("access_token").getAsString();
			refresh_Token = element2.getAsJsonObject().get("refresh_token").getAsString();
			// System.out.println("access_token : " + access_Token);
			// System.out.println("refresh_token : " + refresh_Token);
            
			br2.close();
			bw2.close();
		} catch (IOException e) {
			e.printStackTrace();
		}
		return access_Token;
	}
	
	public HashMap<String, Object> getUserInfo2(String access_Token, Member member) {

		// 요청하는 클라이언트마다 가진 정보가 다를 수 있기에 HashMap타입으로 선언
		HashMap<String, Object> naverUserInfo = new HashMap<String, Object>();
		// String reqURL = "https://openapi.naver.com/v1/nid/me";
		try {
			URL url2 = new URL(reqURL);
			HttpURLConnection conn2 = (HttpURLConnection) url2.openConnection();
			conn2.setRequestMethod("GET");

			// 요청에 필요한 Header에 포함될 내용
			conn2.setRequestProperty("Authorization", "Bearer " + access_Token);

			int responseCode2 = conn2.getResponseCode();
			// System.out.println("responseCode : " + responseCode2);

			BufferedReader br2 = new BufferedReader(new InputStreamReader(conn2.getInputStream()));

			String line2 = "";
			String result2 = "";
			
			while ((line2 = br2.readLine()) != null) {
				result2 += line2;
			}
			System.out.println("response body(네이버 사용자 정보) : " + result2);

			JsonElement element = new Gson().fromJson(result2, JsonElement.class);

			JsonObject response = element.getAsJsonObject().get("response").getAsJsonObject();
			String naver_idkey = response.getAsJsonObject().get("id").getAsString();
			
			// JsonObject kakao_idkey = element.getAsJsonObject().get("id").getAsJsonObject();

			String id = response.getAsJsonObject().get("id").getAsString();
			
			naverUserInfo.put("id", id);
			// member.setNaverIdkey(naver_idkey);
			// System.out.println(naverUserInfo);

		} catch (IOException e) {
			e.printStackTrace();
		}
		return naverUserInfo;
	}
	
	
	// 세션 유효성 검증을 위한 난수 생성기 
	private String generateRandomString() {
		return UUID.randomUUID().toString();
	}
	
	// http session에 데이터 저장 
	private void setSession(HttpSession session, String state) {
		session.setAttribute(SESSION_STATE, state);
	}
	
	// http session에서 데이터 가져오기 
	private String getSession(HttpSession session) {
		return (String) session.getAttribute(SESSION_STATE);
	}
	
	// Access Token을 이용하여 네이버 사용자 프로필 API 호출 
	public String getUserProfile(OAuth2AccessToken oauthToken) throws IOException {
		OAuth20Service oauthService = new ServiceBuilder()
				.apiKey(CLIENT_ID)
				.apiSecret(CLIENT_SECRET)
				.callback(REDIRECT_URI)
				.build(NaverAPI20.instance());
		
		OAuthRequest request = new OAuthRequest(Verb.GET, reqURL, oauthService);
		oauthService.signRequest(oauthToken, request);
		Response response = request.send();
		return response.getBody();
	}
	*/
	
}
