package com.example.test1.dao;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.example.test1.model.Board;
import com.example.test1.model.Member;
import com.example.test1.model.Comment;
import com.example.test1.mapper.BoardMapper;

@Service
public class BoardService {

	@Autowired
	BoardMapper boardMapper;

	public HashMap<String, Object> getBoardList(HashMap<String, Object> map) {
		// TODO Auto-generated method stub
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		try {
			List<Board> list = boardMapper.selectBoardList(map);
			int count = boardMapper.selectBoardCnt(map);
			
			String result = "success";
			resultMap.put("list", list);
			resultMap.put("result", result);
			resultMap.put("count", count);
		} catch (Exception e) {
			System.out.println(e.getMessage());
			resultMap.put("result", "fail");
		}
		return resultMap;
	}

	public HashMap<String, Object> addBoardList(HashMap<String, Object> map) {
		// TODO Auto-generated method stub
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		try {
	        int result = boardMapper.insertBoardList(map); // INSERT 결과 개수
	        resultMap.put("result", result > 0 ? "success" : "fail");
	    } catch (Exception e) {
	        resultMap.put("result", "fail");
	    }
		return resultMap;
		
	}

	public HashMap<String, Object> getBoard(HashMap<String, Object> map) {
		// TODO Auto-generated method stub
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		try {
				if(map.containsKey("option")) {
				boardMapper.updateCnt(map);
				}
				
			Board info = boardMapper.selectBoard(map);
			List<Comment> cmtList = boardMapper.selectCmtList(map);
			String result = "success";
			resultMap.put("info", info);
			resultMap.put("cmtList", cmtList);
			resultMap.put("result", result);
		} catch (Exception e) {
			System.out.println(e.getMessage());
			resultMap.put("result", "fail");
		}
		return resultMap;
	}

	public HashMap<String, Object> editBoard(HashMap<String, Object> map) {
		// TODO Auto-generated method stub
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		try {
			boardMapper.updateBoard(map);
			String result = "success";	
			resultMap.put("result", result);
		} catch (Exception e) {
			System.out.println(e.getMessage());
			resultMap.put("result", "fail");
		}
		return resultMap;
	}

	public HashMap<String, Object> boardRemove(HashMap<String, Object> map) {
		// TODO Auto-generated method stub
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		try {
			boardMapper.deleteBoard(map);
		} catch (Exception e) {
			System.out.println(e.getMessage());
		}
		return null;
	}
	
	public HashMap<String, Object> getUser(HashMap<String, Object> map) {
		// TODO Auto-generated method stub
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		try {			
			Member info = boardMapper.selectUser(map);
			String result = "success";
			resultMap.put("info", info);
			resultMap.put("result", result);
		} catch (Exception e) {
			System.out.println(e.getMessage());
			resultMap.put("result", "fail");
		}
		return resultMap;
	}

	public HashMap<String, Object> boardListRemove(HashMap<String, Object> map) {
		// TODO Auto-generated method stub
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		try {
			boardMapper.deleteBoardList(map);
		} catch (Exception e) {
			System.out.println(e.getMessage());
		}
		return null;
	}

	public HashMap<String, Object> cmtEdit(HashMap<String, Object> map) {
		// TODO Auto-generated method stub
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		boardMapper.cmtInsert(map);
		return null;
	}

	public HashMap<String, Object> cmtUpdate(HashMap<String, Object> map) {
		// TODO Auto-generated method stub
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		boardMapper.cmtUpdate(map);
		return null;
	}

	public HashMap<String, Object> cmtRemove(HashMap<String, Object> map) {
		// TODO Auto-generated method stub
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		boardMapper.cmtDelete(map);
		return null;
	}


}
