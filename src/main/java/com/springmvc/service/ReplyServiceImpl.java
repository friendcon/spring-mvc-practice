package com.springmvc.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.springmvc.domain.Criteria;
import com.springmvc.domain.ReplyPageDTO;
import com.springmvc.domain.ReplyVO;
import com.springmvc.mapper.BoardMapper;
import com.springmvc.mapper.ReplyMapper;

import lombok.AllArgsConstructor;
import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Service
@Log4j
@AllArgsConstructor
public class ReplyServiceImpl implements ReplyService {

	// @Setter(onMethod_ = @Autowired)
	private ReplyMapper mapper;
	
	private BoardMapper boardMapper;
	
	@Override
	@Transactional
	public int register(ReplyVO vo) {
		log.info("register. . . . . ." + vo);
		boardMapper.updateReplyCnt(vo.getBno(), 1);
		return mapper.insert(vo);
	}

	@Override
	public ReplyVO get(Long rno) {
		log.info("get. . . . . ." + rno);
		return mapper.read(rno);
	}

	@Override
	public int modify(ReplyVO vo) {
		log.info("modify. . . . . ." + vo);
		return mapper.update(vo);
	}

	@Override
	@Transactional
	public int remove(Long rno) {
		log.info("remove. . . . . ." + rno);
		ReplyVO vo = mapper.read(rno);
		boardMapper.updateReplyCnt(vo.getBno(), -1);
		return mapper.delete(rno);
	}

	/*@Override
	public List<ReplyVO> getList(Criteria cri, Long bno) {
		log.info("get reply list. . . . . ." + bno);
		return mapper.getListWithPaging(cri, bno);
	}*/

	@Override
	public ReplyPageDTO getListPage(Criteria cri, Long bno) {
		return new ReplyPageDTO(mapper.getCountByBno(bno), mapper.getListWithPaging(cri, bno));
	}

}
