//package com.example.test1.controller;
//
//import java.util.HashMap;
//
//import org.springframework.beans.factory.annotation.Autowired;
//import org.springframework.stereotype.Controller;
//import org.springframework.ui.Model;
//import org.springframework.web.bind.annotation.RequestMapping;
//import org.springframework.web.bind.annotation.RequestMethod;
//import org.springframework.web.bind.annotation.RequestParam;
//import org.springframework.web.bind.annotation.ResponseBody;
//
//import com.example.test1.dao.UserService;
//import com.google.gson.Gson;
//
//@Controller
//public class UserController {
//
//	@Autowired
//	UserService userService;
//	
//	@RequestMapping("/login.do") //브라우저로 들어가는 주소
//    public String login(Model model) throws Exception{
//
//        return "/login"; // login.jsp 파일 실행
//    }
//	
//	@RequestMapping("/member/list.do")
//	public String list(Model model) throws Exception{
//		return "/member-list";
//	}
//	@RequestMapping("/test.do")
//	public String test(Model model) throws Exception{
//		return "/test1";
//	}
//	
//	
//	@RequestMapping(value = "/login.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
//	@ResponseBody
//	public String login(Model model, @RequestParam HashMap<String, Object> map) throws Exception {
//
//		HashMap<String, Object> resultMap = new HashMap<String, Object>();
//		resultMap = userService.userLogin(map);
//		
//		return new Gson().toJson(resultMap); //받는 타입을 json으로 정의해서 json 형태로 변환
//	}
//	
//	@RequestMapping(value = "/member/list.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
//	@ResponseBody
//	public String memberList(Model model, @RequestParam HashMap<String, Object> map) throws Exception {
//
//		HashMap<String, Object> resultMap = new HashMap<String, Object>();
//		resultMap = userService.memberList(map);
//		
//		return new Gson().toJson(resultMap); //받는 타입을 json으로 정의해서 json 형태로 변환
//	}
//	
//	@RequestMapping(value = "/member/remove.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
//	@ResponseBody
//	public String memberRemove(Model model, @RequestParam HashMap<String, Object> map) throws Exception {
//
//		HashMap<String, Object> resultMap = new HashMap<String, Object>();
//		resultMap = userService.memberRemove(map);
//		
//		return new Gson().toJson(resultMap); //받는 타입을 json으로 정의해서 json 형태로 변환
//	}
//	
//	@RequestMapping(value = "/test.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
//	@ResponseBody
//	public String testRemove(Model model, @RequestParam HashMap<String, Object> map) throws Exception {
//
//		HashMap<String, Object> resultMap = new HashMap<String, Object>();
//		resultMap = userService.testRemove(map);
//		
//		return new Gson().toJson(resultMap); //받는 타입을 json으로 정의해서 json 형태로 변환
//	}
//	
//}
//
