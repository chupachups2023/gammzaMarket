package com.gammza.chupachups.auth.model.vo;

import lombok.Data;

@Data
public class NaverProfile {
	public String resultcode;
	public String message;
	public Response response;

	@Data
	public class Response {
		public String id;
		public String email;
		public String name;
		public String birthday;

		}
}
