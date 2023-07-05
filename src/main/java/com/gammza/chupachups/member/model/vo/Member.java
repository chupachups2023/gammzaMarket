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
	private int zipcode;
	private String address;
	private String addressDetail;
	private int location;
	private String email;
	private LocalDateTime createAt;
	private LocalDateTime updateAt;
	private boolean status;
	private int point;
	private double temperature;
	private int kakaoIdkey;
	private String naverIdkey;
	private int category;
	@DateTimeFormat(pattern="yyyy-MM-dd")
	private LocalDate birthday;

}
