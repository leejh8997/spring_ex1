package com.example.test1.model;

import lombok.Data;

@Data
public class Product {
	private String itemNo;
	private String	itemName;
	private int	price;
	private String filePath;
	private String fileName;
	private String thumbNail;
	private String itemInfo;
}
