package com.gammza.chupachups.common;

public class ChangeDate {
	 public static String chageDate(String date) {
		 String datepart=date.substring(0, 10);
		 String timepart=date.substring(11);
		 
		return "TO_DATE('"+datepart+" "+timepart+"', 'YYYY-MM-DD HH24:MI')";
	}
	 public static String chageDateToJsp(String date) {
		 String datepart=date.substring(0, 10);
		 String timepart=date.substring(11);
		 
		 return datepart+"T"+timepart;
	 }

}