package com.gammza.chupachups.parti_Tb.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;

import com.gammza.chupachups.parti_Tb.model.service.Parti_TbService;

@Controller
public class Parti_TbController {

	@Autowired
	private Parti_TbService parti_TbService;
}
