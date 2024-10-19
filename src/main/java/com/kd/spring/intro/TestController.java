package com.kd.spring.intro;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class TestController {

	@GetMapping("/")
	public String welcomeMsg(Model model)
	{
		
		return "index";
		
	}
}