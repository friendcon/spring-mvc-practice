package com.springmvc.mapper;

import com.springmvc.domain.BoardVO;
import com.springmvc.domain.Criteria;

import org.apache.ibatis.annotations.Select;

import java.util.List;

public interface BoardMapper {
    //@Select("select * from tbl_board where bno > 0")
    // getList() : 게시글 목록 -> 페이징 필요
    public List<BoardVO> getList();
    
    // 페이지 가져오기
    public List<BoardVO> getListWithPaging(Criteria cri);

    // 게시글 작성
    public void insert(BoardVO board);

    // 게시글 작성 primary key를 미리 가져올 수 있음
    public void insertSelectKey(BoardVO board);

    // 게시글 1개 읽기
    public BoardVO read(Long bno);

    // 삭제
    public int delete(Long bno);

    // 수정
    public int update(BoardVO board);
}
