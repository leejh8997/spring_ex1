package com.example.test1.mapper;
import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.example.test1.model.File;
import com.example.test1.model.Product;
@Mapper
public interface ProductMapper {

	List<Product> selectProductList(HashMap<String, Object> map);

	Product selectViewInfo(HashMap<String, Object> map);

	List<Product> selectSubImage(HashMap<String, Object> map);

	int insertProduct(HashMap<String, Object> map);

	void insertProductFile(HashMap<String, Object> map);

	void insertPayHistory(HashMap<String, Object> map);

}
