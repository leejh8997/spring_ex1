package com.example.test1.mapper;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.example.test1.model.Board;
import com.example.test1.model.Member;

@Mapper // xml 호출하려면 반드시 명시
public interface BoardMapper {

	List<Board> selectBoardList(HashMap<String, Object> map);

	int insertBoardList(HashMap<String, Object> map);

	Board selectBoard(HashMap<String, Object> map);

	Board updateBoard(HashMap<String, Object> map);

	void updateCnt(HashMap<String, Object> map);

	void deleteBoard(HashMap<String, Object> map);

	Member selectUser(HashMap<String, Object> map);

	
	
}
