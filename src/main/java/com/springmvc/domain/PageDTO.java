package com.springmvc.domain;

import lombok.Getter;
import lombok.ToString;

@Getter
@ToString
public class PageDTO {
	private int startPage; // ����������
	private int endPage; // �� ������
	private boolean prev, next; // ����, ���������� ���� ����
	
	private int total; // ��ü �� ��
	private Criteria cri; // ����¡
	
	public PageDTO(Criteria cri, int total) {
		this.total = total;
		this.cri = cri;
		this.endPage = (int)(Math.ceil(cri.getPageNum() / 10.0)) * 10; // �������� �� ��ȣ 
		this.startPage = this.endPage - 9;// �������� �չ�ȣ
		int realEnd = (int)(Math.ceil((total*1.0) / cri.getAmount())); // ��¥ �� ������ 
		// ��¥ �� �������� ���� ������������ �۴ٸ� 
		if(realEnd < this.endPage) {
			this.endPage = realEnd;
		}
		this.prev = this.startPage > 1; // true��� ��������
		this.next = this.endPage < realEnd; // true��� ���ķ�
		
	}
	
	
}
