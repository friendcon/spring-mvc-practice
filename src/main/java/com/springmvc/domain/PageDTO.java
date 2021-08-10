package com.springmvc.domain;

import lombok.Getter;
import lombok.ToString;

@Getter
@ToString
public class PageDTO {
	private int startPage; // 시작페이지
	private int endPage; // 끝 페이지
	private boolean prev, next; // 이전, 다음페이지 존재 여부
	
	private int total; // 전체 글 수
	private Criteria cri; // 페이징
	
	public PageDTO(Criteria cri, int total) {
		this.total = total;
		this.cri = cri;
		this.endPage = (int)(Math.ceil(cri.getPageNum() / 10.0)) * 10; // 페이지의 끝 번호 
		this.startPage = this.endPage - 9;// 페이지의 앞번호
		int realEnd = (int)(Math.ceil((total*1.0) / cri.getAmount())); // 진짜 끝 페이지 
		// 진짜 끝 페이지가 현재 끝페이지보다 작다면 
		if(realEnd < this.endPage) {
			this.endPage = realEnd;
		}
		this.prev = this.startPage > 1; // true라면 이전으로
		this.next = this.endPage < realEnd; // true라면 이후로
		
	}
	
	
}
