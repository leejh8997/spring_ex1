package com.example.test1.model;
import lombok.Data;

@Data
public class Student {
	private String stuNo;
	private String stuName;
	private String stuDept;
	private int stuGrade;
	private String stuClass;
	private String stuGender;
	private int stuHeight;
	private int stuWeight;
	public String getStuNo() {
		return stuNo;
	}
	public void setStuNo(String stuNo) {
		this.stuNo = stuNo;
	}
	public String getStuName() {
		return stuName;
	}
	public void setStuName(String stuName) {
		this.stuName = stuName;
	}
	public String getStuDept() {
		return stuDept;
	}
	public void setStuDept(String stuDept) {
		this.stuDept = stuDept;
	}
	public int getStuGrade() {
		return stuGrade;
	}
	public void setStuGrade(int stuGrade) {
		this.stuGrade = stuGrade;
	}
	public String getStuClass() {
		return stuClass;
	}
	public void setStuClass(String stuClass) {
		this.stuClass = stuClass;
	}
	public String getStuGender() {
		return stuGender;
	}
	public void setStuGender(String stuGender) {
		this.stuGender = stuGender;
	}
	public int getStuHeight() {
		return stuHeight;
	}
	public void setStuHeight(int stuHeight) {
		this.stuHeight = stuHeight;
	}
	public int getStuWeight() {
		return stuWeight;
	}
	public void setStuWeight(int stuWeight) {
		this.stuWeight = stuWeight;
	}
}
