package com.example.test1.controller;

import java.util.HashMap;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.example.test1.dao.BoardService;
import com.google.gson.Gson;

@Controller
public class BoardController {

	@Autowired
	BoardService boardService;		
	// get, select
	// add, insert
	// edit, update
	// remove, delete
	
	@RequestMapping("/board/list.do")
	public String boardList(HttpServletRequest request,Model model, @RequestParam HashMap<String, Object> map) throws Exception{
		request.setAttribute("map", map);
		return "/board/board-list";
	}
	@RequestMapping("/board/add.do")
	public String boardAdd(Model model) throws Exception{
		return "/board/board-add";
	}
	@RequestMapping("/board/view.do")
	public String boardView(HttpServletRequest request,Model model, @RequestParam HashMap<String, Object> map) throws Exception{
		request.setAttribute("map", map);
		return "/board/board-view";
	}
	@RequestMapping("/board/edit.do")
	public String boardEdit(HttpServletRequest request,Model model, @RequestParam HashMap<String, Object> map) throws Exception{
		request.setAttribute("map", map);
		return "/board/board-edit";
	}
	
	@RequestMapping("/board/user.do")
	public String boardUser(HttpServletRequest request,Model model, @RequestParam HashMap<String, Object> map) throws Exception{
		request.setAttribute("map", map);
		return "/board/board-user";
	}
	
	// 게시글 목록
	@RequestMapping(value = "/board/list.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String boardList(Model model, @RequestParam HashMap<String, Object> map) throws Exception {

		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		resultMap = boardService.getBoardList(map);
		
		return new Gson().toJson(resultMap); //받는 타입을 json으로 정의해서 json 형태로 변환
	}
	
	// 게시글 추가
	@RequestMapping(value = "/board/add.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String boardAdd(Model model, @RequestParam HashMap<String, Object> map) throws Exception {

		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		resultMap = boardService.addBoardList(map);
		
		return new Gson().toJson(resultMap); //받는 타입을 json으로 정의해서 json 형태로 변환
	}
	
	// 게시글 상세보기
	@RequestMapping(value = "/board/view.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String boardInfo(Model model, @RequestParam HashMap<String, Object> map) throws Exception {

		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		resultMap = boardService.getBoard(map);
		
		return new Gson().toJson(resultMap); //받는 타입을 json으로 정의해서 json 형태로 변환
	}
	
	//게시글 수정
	@RequestMapping(value = "/board/edit.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String boardEdit(Model model, @RequestParam HashMap<String, Object> map) throws Exception {

		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		resultMap = boardService.boardEdit(map);
		
		return new Gson().toJson(resultMap); //받는 타입을 json으로 정의해서 json 형태로 변환
	}
	
	//게시글 삭제
	@RequestMapping(value = "/board/remove.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String boardRemove(Model model, @RequestParam HashMap<String, Object> map) throws Exception {
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		resultMap = boardService.boardRemove(map);
		
		return new Gson().toJson(resultMap); //받는 타입을 json으로 정의해서 json 형태로 변환
	}
	
	//유저 정보
	@RequestMapping(value = "/board/user.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String boardUser(Model model, @RequestParam HashMap<String, Object> map) throws Exception {
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		resultMap = boardService.getUser(map);
		
		return new Gson().toJson(resultMap); //받는 타입을 json으로 정의해서 json 형태로 변환
	}
}

