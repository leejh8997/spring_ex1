package com.example.test1.mapper;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.example.test1.model.Board;
import com.example.test1.model.Member;

@Mapper // xml 호출하려면 반드시 명시
public interface MemberMapper {

	Member getMember(HashMap<String, Object> map);
	
	
}
