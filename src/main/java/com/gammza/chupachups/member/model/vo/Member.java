package com.gammza.chupachups.member.model.vo;

import java.time.LocalDate;
import java.time.LocalDateTime;

import org.springframework.format.annotation.DateTimeFormat;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@ToString
public class Member {
	private String userId;
	private String userPwd;
	private String name;
	private String phone;
	private int location;
	private String email;
	private LocalDateTime createAt;
	private LocalDateTime updateAt;
	private int status;
	private int point;
	private double temperature;
	private long kakaoIdkey;
	private String naverIdkey;
	private int category;
	// @DateTimeFormat(pattern="yyyy-MM-dd")
	private String birthday;
	private String latitude;
	private String longitude;
	
	
	private String createAt2;
	private String status2;
	private String newUserId;
}
