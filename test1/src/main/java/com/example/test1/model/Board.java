package com.example.test1.model;

import lombok.Data;

@Data
public class Board {
	private String boardNo;
    private String title;
    private String contents;
    private String userId;
    private String kind;       // 추가
    private String favorite;   // 추가
    private String cnt;
    private String subtitle;   // 추가
    private String deleteYn;   // 추가
    private String cdateTime;
    private String udateTime;
    private String userName;
    private String commentCount;
}
