package com.example.test1.mapper;
import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.example.test1.model.Bbs;
import com.example.test1.model.Board;
import com.example.test1.model.File;

@Mapper
public interface BbsMapper {

	List<Bbs> selectBbsList(HashMap<String, Object> map);

	void insertBbsList(HashMap<String, Object> map);

	void insertBoardFile(HashMap<String, Object> map);

	void deleteBbs(HashMap<String, Object> map);

	void updateCnt(HashMap<String, Object> map);

	List<File> selectFile(HashMap<String, Object> map);

	Bbs selectBbs(HashMap<String, Object> map);

	void updateBbs(HashMap<String, Object> map);

	int selectBbsCnt(HashMap<String, Object> map);

}
