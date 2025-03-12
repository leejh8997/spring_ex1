package com.example.test1.controller;

import java.io.File;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import com.example.test1.common.Common;
import com.example.test1.dao.BoardService;

@Controller
public class UploadController {
	
	@Autowired
	BoardService boardService;
	
	@RequestMapping("/fileUpload.dox")
	public String result(@RequestParam("file1") List<MultipartFile> multi, @RequestParam("boardNo") int boardNo, HttpServletRequest request,HttpServletResponse response, Model model)
	{
		
//		System.out.println(multi.size());
		String url = null;
		String path="c:\\img";
		List<HashMap<String, Object>> fileList = new ArrayList<>();
		try {
			for(MultipartFile file : multi) {			
				//String uploadpath = request.getServletContext().getRealPath(path);
				String uploadpath = path;
				String originFilename = file.getOriginalFilename();
				String extName = originFilename.substring(originFilename.lastIndexOf("."),originFilename.length());
				long size = file.getSize();
				String saveFileName = Common.genSaveFileName(extName);
				
//				System.out.println("uploadpath : " + uploadpath);
//				System.out.println("originFilename : " + originFilename);
//				System.out.println("extensionName : " + extName);
//				System.out.println("size : " + size);
//				System.out.println("saveFileName : " + saveFileName);
				String path2 = System.getProperty("user.dir");
				System.out.println("Working Directory = " + path2 + "\\src\\webapp\\img");
				if(!multi.isEmpty())
				{
					File imgfile = new File(path2 + "\\src\\main\\webapp\\img", saveFileName);
					file.transferTo(imgfile);
					
					HashMap<String, Object> map = new HashMap<String, Object>();
					map.put("filename", saveFileName);
					map.put("path", "../img/" + saveFileName);
					map.put("originFilename", originFilename);
					map.put("extName", extName);
					map.put("size", size);
					System.out.println("boardNO===>"+boardNo);
					map.put("boardNo", boardNo);
					
					// insert 쿼리 실행
					fileList.add(map);				
//					model.addAttribute("filename", file.getOriginalFilename());
//					model.addAttribute("uploadPath", imgfile.getAbsolutePath());
				}	
			}
			boardService.addBoardFile(fileList);
		}catch(Exception e) {
			System.out.println(e);
		}
		return "redirect:/board/list.do";
	}
}
