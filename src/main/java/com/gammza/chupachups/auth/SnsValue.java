package com.gammza.chupachups.auth;

import org.apache.commons.lang.StringUtils;

import com.github.scribejava.core.builder.api.DefaultApi20;

import lombok.Data;

@Data
public class SnsValue implements SnsUrls {
	
	private String service;
	private String clientId;
	private String clientSecret;
	private String redirectUrl;
	private DefaultApi20 api20Instance;
	private String profileUrl;
	
	public SnsValue(String service, String clientId, String clientSecret, String redirectUrl) {
		this.service = service;
		this.clientId = clientId;
		this.clientSecret = clientSecret;
		this.redirectUrl = redirectUrl;
		
		if (StringUtils.equalsIgnoreCase(service, "naver")) {
			this.api20Instance = NaverAPI20.instance();
//			this.profileUrl = NAVER_PROFILE_URL;
		} else if (StringUtils.equalsIgnoreCase(service, "kakao")) {
			// this.api20Instance = KakaoAPI20.instance();
			
		}
	}

	public String getProfileUrl() {
		// TODO Auto-generated method stub
		return null;
	}

}
