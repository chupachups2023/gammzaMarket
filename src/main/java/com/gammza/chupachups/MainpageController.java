package com.gammza.chupachups;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

/**
 * Handles requests for the application home page.
 */
@Controller
public class MainpageController {
	
	private static final Logger logger = LoggerFactory.getLogger(MainpageController.class);
	
	
	@RequestMapping(value = "/", method = RequestMethod.GET)
	public String mainpage() {
		return "forward:gonggu/mainList.go";
	}
	
}
