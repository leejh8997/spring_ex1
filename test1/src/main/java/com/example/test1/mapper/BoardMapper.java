package com.example.test1.mapper;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.example.test1.model.Board;
import com.example.test1.model.Member;

import com.example.test1.model.Comment;
import com.example.test1.model.File;

@Mapper // xml 호출하려면 반드시 명시
public interface BoardMapper {

	List<Board> selectBoardList(HashMap<String, Object> map);

	int insertBoardList(HashMap<String, Object> map);

	Board selectBoard(HashMap<String, Object> map);

	void updateBoard(HashMap<String, Object> map);

	void updateCnt(HashMap<String, Object> map);

	void deleteBoard(HashMap<String, Object> map);

	Member selectUser(HashMap<String, Object> map);

	void deleteBoardList(HashMap<String, Object> map);

	int selectBoardCnt(HashMap<String, Object> map);

	List<Comment> selectCmtList(HashMap<String, Object> map);

	void cmtInsert(HashMap<String, Object> map);

	void cmtUpdate(HashMap<String, Object> map);

	void cmtDelete(HashMap<String, Object> map);

	void insertBoardFile(HashMap<String, Object> map);

	List<File> selectFile(HashMap<String, Object> map);

	
	
}
