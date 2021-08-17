package com.springmvc.service;

import java.util.List;

import com.springmvc.domain.Criteria;
import com.springmvc.domain.ReplyPageDTO;
import com.springmvc.domain.ReplyVO;

public interface ReplyService {
	public int register(ReplyVO vo);
	public ReplyVO get(Long rno);
	public int modify(ReplyVO vo);
	public int remove(Long rno);
	//public List<ReplyVO> getList(Criteria cri, Long bno);
	public ReplyPageDTO getListPage(Criteria cri, Long bno);
	
}
