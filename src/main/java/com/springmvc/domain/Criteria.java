package com.springmvc.domain;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class Criteria {
	private int pageNum; // ������ ��ȣ 
	private int amount; // �� �������� ��� �����͸� ��������
	
	private String type; // �˻� ����
	private String keyword; // �˻� Ű����
	
	public Criteria() {
		this(1,10);
	}

	public Criteria(int pageNum, int amount) {
		this.pageNum = pageNum;
		this.amount = amount;
	}
	
	// �˻������� �������� �� �����Ƿ� �迭�� ����
	public String[] getTypeArr() {
		return type == null ? new String[] {} : type.split("");
	}
}
