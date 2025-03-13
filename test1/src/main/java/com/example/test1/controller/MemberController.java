package com.example.test1.controller;

import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.example.test1.dao.MemberService;
import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.google.gson.Gson;

@Controller
public class MemberController {
	@Autowired
	MemberService memberService;
	// get, select
		// add, insert
		// edit, update
		// remove, delete
		
	@RequestMapping("/member/login.do")
	public String memberLogin(Model model) throws Exception{
		return "/member/member-login";
	}
	
	@RequestMapping("/member/add.do")
	public String memberAdd(Model model) throws Exception{
		return "/member/member-add";
	}
	@RequestMapping("/member/check.do")
	public String memberCheck(Model model) throws Exception{
		return "/member/member-check";
	}
	@RequestMapping("/member/addr.do")
	public String memberAddr(Model model) throws Exception{
		return "/jusoPopup";
	}
	@RequestMapping("/member/list.do")
	public String list(Model model) throws Exception{
		return "/member/member-list";
	}
	//결제 테스트
	@RequestMapping("/pay.do")
	public String pay(Model model) throws Exception{
		return "/pay";
	}
	@RequestMapping("/auth.do")
	public String auth(Model model) throws Exception{
		return "/auth";
	}
	@RequestMapping("/member/pwd.do")
	public String pwd(Model model) throws Exception{
		return "/member/pwd-search";
	}
	
	@RequestMapping("/member/reset-pwd.do")
	public String resetPwd(HttpServletRequest request,Model model, @RequestParam HashMap<String, Object> map) throws Exception{
		request.setAttribute("map", map);
		return "/member/reset-pwd";
	}
		
	//로그인
	@RequestMapping(value = "/member/login.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String memberLogin(Model model, @RequestParam HashMap<String, Object> map) throws Exception {
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		resultMap = memberService.memberLogin(map);
		return new Gson().toJson(resultMap); 
	}
	
	//회원가입
	@RequestMapping(value = "/member/add.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String memberAdd(Model model, @RequestParam HashMap<String, Object> map) throws Exception {
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		resultMap = memberService.memberAdd(map);
		return new Gson().toJson(resultMap); 
	}
	
	//중복체크
	@RequestMapping(value = "/member/check.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String memberCheck(Model model, @RequestParam HashMap<String, Object> map) throws Exception {
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		resultMap = memberService.searchMember(map);
		return new Gson().toJson(resultMap); 
	}
	//멤버 리스트
	@RequestMapping(value = "/member/list.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String memberList(Model model, @RequestParam HashMap<String, Object> map) throws Exception {

		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		resultMap = memberService.memberList(map);
		
		return new Gson().toJson(resultMap); //받는 타입을 json으로 정의해서 json 형태로 변환
	}
	
	//멤버 삭제
	@RequestMapping(value = "/member/remove.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String memberRemove(Model model, @RequestParam HashMap<String, Object> map) throws Exception {

		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		resultMap = memberService.memberRemove(map);
		
		return new Gson().toJson(resultMap); //받는 타입을 json으로 정의해서 json 형태로 변환
	}
	// 멤버 조회
	@RequestMapping(value = "/member/get.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String memberGet(Model model, @RequestParam HashMap<String, Object> map) throws Exception {
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		resultMap = memberService.getMember(map);
		return new Gson().toJson(resultMap); 
	}
	
	// 다수의 멤버 삭제
	@RequestMapping(value = "/member/remove-list.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String memberListRemove(Model model, @RequestParam HashMap<String, Object> map) throws Exception {
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		
		String json = map.get("selectList").toString(); 
		ObjectMapper mapper = new ObjectMapper();
		List<Object> list = mapper.readValue(json, new TypeReference<List<Object>>(){});
		map.put("list", list);
		resultMap = memberService.memberListRemove(map);
		return new Gson().toJson(resultMap); //받는 타입을 json으로 정의해서 json 형태로 변환
	}
	// 비밀번호 변경
	@RequestMapping(value = "/member/reset-pwd.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String changePwd(Model model, @RequestParam HashMap<String, Object> map) throws Exception {
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		resultMap = memberService.changePwd(map);
		return new Gson().toJson(resultMap); 
	}
	
	@RequestMapping(value = "/member/logout.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String memberLogout(Model model, @RequestParam HashMap<String, Object> map) throws Exception {
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		resultMap = memberService.memberLogout(map);
		return new Gson().toJson(resultMap); 
	}
}