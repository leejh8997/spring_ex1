package com.example.test1.controller;

import java.util.HashMap;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

import com.example.test1.dao.TestService;
import com.google.gson.Gson;

@Controller
public class TestController {
	
	@Autowired
	TestService testService;
	// get, select
		// add, insert
		// edit, update
		// remove, delete
	@RequestMapping("/test/list.do")
	public String StuList(Model model) throws Exception{
		return "/test/stu-list";
	}
	
	//로그인
	@RequestMapping(value = "/test/list.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String StuList(Model model, @RequestParam HashMap<String, Object> map) throws Exception {
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		resultMap = testService.getStuList(map);
		return new Gson().toJson(resultMap); 
	}
}
