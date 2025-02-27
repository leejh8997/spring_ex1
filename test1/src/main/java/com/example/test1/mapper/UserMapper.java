package com.example.test1.mapper;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.example.test1.model.Member;
import com.example.test1.model.User;

@Mapper // xml 호출하려면 반드시 명시
public interface UserMapper {
	
	User userMapperLogin(HashMap<String, Object> map);


	List<Member> getUserList(HashMap<String, Object> map);


	int memberDelete(HashMap<String, Object> map);


	int testDelete(HashMap<String, Object> map);
	
	
}
