package com.springmvc.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.springmvc.domain.Criteria;
import com.springmvc.domain.ReplyVO;

public interface ReplyMapper {
	public int insert(ReplyVO vo);
	public ReplyVO read(Long bno);
	public int delete(Long rno);
	public int update(ReplyVO vo);
	// 파라미터가 2개 이상일 경우 @Param을 사용한다
	public List<ReplyVO> getListWithPaging(@Param("cri") Criteria cri, @Param("bno") Long bno);
}
