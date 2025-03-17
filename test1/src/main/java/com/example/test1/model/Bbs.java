package com.example.test1.model;

import lombok.Data;

@Data
public class Bbs {
	private String bbsNum;
	private String title;
	private String contents;
	private int hit;
	private String userId;
	private String cDateTime;
	private String uDateTime;
}
