package com.example.test1.controller;
import java.io.File;
import java.util.Calendar;
import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.example.test1.common.Common;
import com.example.test1.dao.ProductService;
import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.google.gson.Gson;

@Controller
public class ProductController {
	@Autowired
	ProductService productService;
	
	@RequestMapping("/product/list.do")
	public String pay(Model model) throws Exception{
		return "/product/product-list";
	}
	
	@RequestMapping("/product/view.do")
	public String productView(HttpServletRequest request,Model model, @RequestParam HashMap<String, Object> map) throws Exception{
		request.setAttribute("map", map);
		return "/product/product-view";
	}
	
	@RequestMapping("/product/add.do")
	public String add(Model model) throws Exception{
		return "/product/product-add";
	}
	
	@RequestMapping(value = "/product/list.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String productList(Model model, @RequestParam HashMap<String, Object> map) throws Exception {
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		resultMap = productService.productList(map);
		return new Gson().toJson(resultMap); 
	}
	@RequestMapping(value = "/product/view.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String productView(Model model, @RequestParam HashMap<String, Object> map) throws Exception {
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		resultMap = productService.productView(map);
		return new Gson().toJson(resultMap); 
	}
	@RequestMapping(value = "/product/add.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String productAdd(Model model, @RequestParam HashMap<String, Object> map) throws Exception {
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		resultMap = productService.productAdd(map);
		return new Gson().toJson(resultMap); 
	}
	
	@RequestMapping("/product/fileUpload.dox")
	public String result(@RequestParam("file1") List<MultipartFile> multi, @RequestParam("itemNo") int itemNo, HttpServletRequest request,HttpServletResponse response, Model model)
	{
		
//		System.out.println(multi.size());
		String url = null;
		String path="c:\\img";
		int count=0;
		try {
			
			for(MultipartFile file : multi) {			
				//String uploadpath = request.getServletContext().getRealPath(path);
				String uploadpath = path;
				String originFilename = file.getOriginalFilename();
				String extName = originFilename.substring(originFilename.lastIndexOf("."),originFilename.length());
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
					String thumbNail = count == 0 ? "Y" : "N";
					map.put("fileName", saveFileName);
					map.put("path", "../img/" + saveFileName);
					map.put("thumbNail", thumbNail);
					map.put("itemNo", itemNo);
					
					// insert 쿼리 실행
					productService.addProductFile(map);
					
					count++;
				}	
				
			}
		}catch(Exception e) {
			System.out.println(e);
		}
		return "redirect:/product/list.do";
	}
	    
	
}
