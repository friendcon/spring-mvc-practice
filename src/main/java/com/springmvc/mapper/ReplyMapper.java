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
	// �Ķ���Ͱ� 2�� �̻��� ��� @Param�� ����Ѵ�
	public List<ReplyVO> getListWithPaging(@Param("cri") Criteria cri, @Param("bno") Long bno);
}
