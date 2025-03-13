package com.example.test1.dao;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.example.test1.model.Board;
import com.example.test1.model.File;
import com.example.test1.model.Member;
import com.example.test1.model.Menu;
import com.example.test1.model.Comment;
import com.example.test1.mapper.CommonMapper;
@Service
public class CommonService {
	@Autowired
	CommonMapper commonMapper;

	public HashMap<String, Object> getMenuList(HashMap<String, Object> map) {
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		try {
			map.put("depth", 1);
	        List<Menu> mainList = commonMapper.selectMenuList(map); // INSERT 결과 개수
	        map.put("depth", 2);
	        List<Menu> subList = commonMapper.selectMenuList(map);
	        System.out.println("=================>"+mainList);
	        resultMap.put("mainList",mainList);
	        resultMap.put("subList",subList);
	        resultMap.put("result", "success");
	    } catch (Exception e) {
	        resultMap.put("result", "fail");
	    }
		return resultMap;
	}
}
