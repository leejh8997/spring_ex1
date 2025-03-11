package com.example.test1.dao;
import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.example.test1.mapper.ProductMapper;
import com.example.test1.model.Board;
import com.example.test1.model.Comment;
import com.example.test1.model.File;
import com.example.test1.model.Product;

@Service
public class ProductService {
	@Autowired
	ProductMapper productMapper;
	
	@Autowired
	HttpSession session;

	public HashMap<String, Object> productList(HashMap<String, Object> map) {
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		try {			
			List<Product> product = productMapper.selectProductList(map);
			String result = "success";
			resultMap.put("product", product);
			resultMap.put("result", result);
		} catch (Exception e) {
			System.out.println(e.getMessage());
			resultMap.put("result", "fail");
		}
		return resultMap;
	}

	public HashMap<String, Object> productView(HashMap<String, Object> map) {
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		try {
			
			Product info = productMapper.selectViewInfo(map);
			List<Product> subImage = productMapper.selectSubImage(map);
			String result = "success";
			resultMap.put("info", info);
			resultMap.put("subImage", subImage);
			resultMap.put("result", result);
		} catch (Exception e) {
			System.out.println(e.getMessage());
			resultMap.put("result", "fail");
		}
		return resultMap;
	}
}
