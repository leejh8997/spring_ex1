package com.example.test1.dao;

import java.util.HashMap;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.example.test1.mapper.MemberMapper;
import com.example.test1.model.Member;

@Service
public class MemberService {
	@Autowired
	MemberMapper memberMapper;
	
	@Autowired
	HttpSession session;
	
	public HashMap<String, Object> memberLogin(HashMap<String, Object> map) {
		// TODO Auto-generated method stub
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		try {
			Member member = memberMapper.getMember(map);
			session.setAttribute("sessionId", member.getUserId());
			session.setAttribute("sessionStatus", member.getStatus());
			String result = "success";
			resultMap.put("member", member);
			resultMap.put("result", result);
		} catch (Exception e) {
			System.out.println(e.getMessage());
			resultMap.put("result", "fail");
		}
		return resultMap;
	}
}
