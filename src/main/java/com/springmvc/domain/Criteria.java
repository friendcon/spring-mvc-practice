package com.springmvc.domain;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class Criteria {
	private int pageNum; // 페이지 번호 
	private int amount; // 한 페이지에 몇개의 데이터를 보여줄지
	
	private String type; // 검색 조건
	private String keyword; // 검색 키워드
	
	public Criteria() {
		this(1,10);
	}

	public Criteria(int pageNum, int amount) {
		this.pageNum = pageNum;
		this.amount = amount;
	}
	
	// 검색조건이 여러개일 수 있으므로 배열로 리턴
	public String[] getTypeArr() {
		return type == null ? new String[] {} : type.split("");
	}
}
