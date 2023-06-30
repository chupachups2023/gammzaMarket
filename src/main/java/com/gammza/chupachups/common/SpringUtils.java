package com.gammza.chupachups.common;

import java.text.DecimalFormat;
import java.text.SimpleDateFormat;
import java.util.Date;

import org.springframework.web.multipart.MultipartFile;

public class SpringUtils {
	/*
	 	파일명: yyyyMMdd_HHmmssSSS_123.jpg
	 */
	public static String changeMultipartFile(MultipartFile upFile) {
		String oFilename=upFile.getOriginalFilename();
		int beginIndex=oFilename.lastIndexOf("."); //맨 뒤에 있는 점 인덱스번호
		String ext="";
		if(beginIndex >-1) {
			ext=oFilename.substring(beginIndex); //확장자만 가져오기
		}
		SimpleDateFormat sdf=new SimpleDateFormat("yyyyMMdd_HHmmss_");
		DecimalFormat df=new DecimalFormat("000");
		return "gammza"+sdf.format(new Date())+df.format(Math.random()*1000)+ext;
	}
}
