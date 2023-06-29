package com.gammza.chupachups.common;

public class ChangeDBTypeDate {
	 public static String chageDate(String date) {
		 String datepart=date.substring(0, 10);
		 String timepart=date.substring(11);
		 
		return "TO_DATE('"+datepart+" "+timepart+"', 'YYYY-MM-DD HH24:MI')";
	}

}
