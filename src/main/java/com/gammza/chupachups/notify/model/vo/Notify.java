package com.gammza.chupachups.notify.model.vo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.ToString;

@Data
@AllArgsConstructor
@NoArgsConstructor
@ToString
public class Notify {
	private String notiNum;
	private String notifyMember;
	private String notiContent;
	private int status;
	private String createAt;
}
