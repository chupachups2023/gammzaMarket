package com.gammza.chupachups.location.model.vo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.ToString;

@Data
@ToString
@NoArgsConstructor
@AllArgsConstructor 
public class Location {
	private int locationNo; 
	private String sidoNm;
	private String sggNm;
	private String admNm;
	private String legNm;

}
