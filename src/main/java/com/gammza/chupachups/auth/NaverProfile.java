package com.gammza.chupachups.auth;

import java.util.LinkedHashMap;
import java.util.Map;
import com.fasterxml.jackson.annotation.JsonIgnoreProperties;

import lombok.Data;

@Data
public class NaverProfile {

	public String resultcode;
	public String message;
	public Response response;
	private Map<String, Object> additionalProperties = new LinkedHashMap<String, Object>();

	public Map<String, Object> getAdditionalProperties() {
	return this.additionalProperties;
	}

	public void setAdditionalProperty(String name, Object value) {
	this.additionalProperties.put(name, value);
	}

}
	class Response {

		public String id;
		private Map<String, Object> additionalProperties = new LinkedHashMap<String, Object>();

		public Map<String, Object> getAdditionalProperties() {
		return this.additionalProperties;
		}

		public void setAdditionalProperty(String name, Object value) {
		this.additionalProperties.put(name, value);
		}

}




/*
@Data
// public class NaverProfile {
	
	public Long id;
	*/
	// public String connected_at;
	// public Properties properties;
	// public NaverAccount naver_account;
	// private Map<String, Object> additionalProperties = new LinkedHashMap<String, Object>();
	
	/*
	public Map<String, Object> getAdditionalProperties() {
	return this.additionalProperties;
	}
	
	public void setAdditionalProperty(String name, Object value) {
	this.additionalProperties.put(name, value);
	}
	*/
	
	/*
	@Data
	class Properties {
		public String nickname;
		private Map<String, Object> additionalProperties = new LinkedHashMap<String, Object>();
		
		public Map<String, Object> getAdditionalProperties() {
		return this.additionalProperties;
		}
		
		public void setAdditionalProperty(String name, Object value) {
		this.additionalProperties.put(name, value);
		}

	}
	*/
	
	/*
	@Data
	class NaverAccount {
		public Boolean profile_nickname_needs_agreement;
		public Profile profile;
		public Boolean has_email;
		public Boolean email_needs_agreement;
		public Boolean has_birthday;
		public Boolean birthday_needs_agreement;
		private Map<String, Object> additionalProperties = new LinkedHashMap<String, Object>();
		
		public Map<String, Object> getAdditionalProperties() {
		return this.additionalProperties;
		}
		
		public void setAdditionalProperty(String name, Object value) {
		this.additionalProperties.put(name, value);
		}
		
		/*
		@Data
		class Profile {
			public String nickname;
			private Map<String, Object> additionalProperties = new LinkedHashMap<String, Object>();
			
			public Map<String, Object> getAdditionalProperties() {
			return this.additionalProperties;
			}
			
			public void setAdditionalProperty(String name, Object value) {
			this.additionalProperties.put(name, value);
			}
		}
}
		
		

}
*/



