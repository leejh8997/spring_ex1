package com.example.test1.dao;
import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.example.test1.model.Board;
import com.example.test1.model.File;
import com.example.test1.model.Member;
import com.example.test1.model.Comment;
import com.example.test1.mapper.AreaMapper;
import com.example.test1.model.Area;

@Service
public class AreaService {
	@Autowired
	AreaMapper areaMapper;

	public HashMap<String, Object> getSiList(HashMap<String, Object> map) {
			// TODO Auto-generated method stub
			HashMap<String, Object> resultMap = new HashMap<String, Object>();
			try {
				List<Area> siList = areaMapper.selectSiList(map);
				String result = "success";
				resultMap.put("siList", siList);
				resultMap.put("result", result);
			} catch (Exception e) {
				System.out.println(e.getMessage());
				resultMap.put("result", "fail");
			}
			return resultMap;
	}

	public HashMap<String, Object> getGuList(HashMap<String, Object> map) {
		// TODO Auto-generated method stub
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		try {
			List<Area> guList = areaMapper.selectGuList(map);
			String result = "success";
			resultMap.put("guList", guList);
			resultMap.put("result", result);
		} catch (Exception e) {
			System.out.println(e.getMessage());
			resultMap.put("result", "fail");
		}
		return resultMap;
	}

	public HashMap<String, Object> getDongList(HashMap<String, Object> map) {
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		try {
			List<Area> dongList = areaMapper.selectDongList(map);
			String result = "success";
			resultMap.put("dongList", dongList);
			resultMap.put("result", result);
		} catch (Exception e) {
			System.out.println(e.getMessage());
			resultMap.put("result", "fail");
		}
		return resultMap;
	}
}
