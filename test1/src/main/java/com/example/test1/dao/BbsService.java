package com.example.test1.dao;
import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.example.test1.mapper.BbsMapper;
import com.example.test1.model.Bbs;
import com.example.test1.model.Board;
import com.example.test1.model.Comment;
import com.example.test1.model.File;
import com.example.test1.model.Member;

@Service
public class BbsService {
	@Autowired
	BbsMapper bbsMapper;
	
	@Autowired
	HttpSession session;

	public HashMap<String, Object> getBbsList(HashMap<String, Object> map) {
		// TODO Auto-generated method stub
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		try {
			List<Bbs> list = bbsMapper.selectBbsList(map);
			int count = bbsMapper.selectBbsCnt(map);
			resultMap.put("count", count);
			resultMap.put("list", list);
			resultMap.put("result", "success");
		} catch (Exception e) {
			System.out.println(e.getMessage());
			resultMap.put("result", "fail");
		}
		return resultMap;
	}

	public HashMap<String, Object> bbsEdit(HashMap<String, Object> map) {
		// TODO Auto-generated method stub
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		try {
			bbsMapper.insertBbsList(map);
			resultMap.put("result", "success");
			resultMap.put("bbsNum", map.get("bbsNum"));
		} catch (Exception e) {
			System.out.println(e.getMessage());
			resultMap.put("result", "fail");
		}
		return resultMap;
	}

	public void addBbsFile(HashMap<String, Object> map) {
		// TODO Auto-generated method stub
		System.out.println(map);
		try {
			bbsMapper.insertBoardFile(map);
		} catch (Exception e) {
			// TODO: handle exception
			System.out.println(e.getMessage());
		}
		
	}

	public HashMap<String, Object> bbsRemove(HashMap<String, Object> map) {
		// TODO Auto-generated method stub
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		try {
			bbsMapper.deleteBbs(map);
			resultMap.put("result", "success");
		} catch (Exception e) {
			System.out.println(e.getMessage());
			resultMap.put("result", "fail");
		}
		return resultMap;
	}

	public HashMap<String, Object> getBbs(HashMap<String, Object> map) {
		// TODO Auto-generated method stub
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		try {
			if(map.containsKey("option")) {
			bbsMapper.updateCnt(map);
			}
		
			List<File> file = bbsMapper.selectFile(map);
			System.out.println(map);
			Bbs info = bbsMapper.selectBbs(map);
			String result = "success";
			resultMap.put("file", file);
			resultMap.put("info", info);
			resultMap.put("result", result);
		} catch (Exception e) {
			System.out.println(e.getMessage());
			resultMap.put("result", "fail");
		}
		return resultMap;
	}

	public HashMap<String, Object> bbsUpdate(HashMap<String, Object> map) {
		// TODO Auto-generated method stub
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		try {
			bbsMapper.updateBbs(map);
			resultMap.put("result", "success");
		} catch (Exception e) {
			System.out.println(e.getMessage());
			resultMap.put("result", "fail");
		}
		return resultMap;
	}
}
