package com.example.test1.mapper;
import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.example.test1.model.Board;
import com.example.test1.model.Member;

import com.example.test1.model.Comment;
import com.example.test1.model.File;
import com.example.test1.model.Area;

@Mapper
public interface AreaMapper {

	List<Area> selectSiList(HashMap<String, Object> map);

	List<Area> selectGuList(HashMap<String, Object> map);

	List<Area> selectDongList(HashMap<String, Object> map);


}
