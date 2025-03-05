package com.example.test1.dao;

import java.util.HashMap;
import java.util.List;

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
	
	public HashMap<String, Object> memberList(HashMap<String, Object> map) {
		// TODO Auto-generated method stub
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
			List<Member> list = memberMapper.getUserList(map);
			resultMap.put("list", list);
		return resultMap;
	}

	public HashMap<String, Object> memberAdd(HashMap<String, Object> map) {
		// TODO Auto-generated method stub
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		try {
			memberMapper.memberJoin(map);
		} catch (Exception e) {
			System.out.println(e.getMessage());
		}
		return null;
	}
	
	public HashMap<String, Object> memberRemove(HashMap<String, Object> map) {
		// TODO Auto-generated method stub
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		try {
		int result = memberMapper.memberDelete(map);
		resultMap.put("result", result);
		} catch(Exception e) {
			System.out.println(e.getMessage());
		}
		return resultMap;
	}
	// 중복체크를 위한 멤버 조회
	public HashMap<String, Object> searchMember(HashMap<String, Object> map) {
		// TODO Auto-generated method stub
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		try {
			Member member = memberMapper.selectMember(map);
			int count = member != null ? 1 : 0;
			resultMap.put("count",count);
		} catch (Exception e) {
			System.out.println(e.getMessage());
		}
		return resultMap;
	}
	// 멤버 조회만(중복체크 매퍼 사용)
	public HashMap<String, Object> getMember(HashMap<String, Object> map) {
		// TODO Auto-generated method stub
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		Member member = memberMapper.selectMember(map);
		if(member!=null) {
			resultMap.put("member",member);
			resultMap.put("result","success");
		}
		return null;
	}

	public HashMap<String, Object> memberListRemove(
			HashMap<String, Object> map) {
		// TODO Auto-generated method stub
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		memberMapper.memberListDelete(map);	
		return null;
	}
}
