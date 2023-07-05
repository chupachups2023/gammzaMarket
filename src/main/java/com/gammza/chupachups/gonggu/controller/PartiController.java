package com.gammza.chupachups.gonggu.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.gammza.chupachups.gonggu.model.service.PartiService;

@Controller
@RequestMapping("/gonggu")
public class PartiController {
	@Autowired
	private PartiService partiService;
}
