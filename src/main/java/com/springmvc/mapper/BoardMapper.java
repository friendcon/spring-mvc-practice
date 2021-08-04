package com.springmvc.mapper;

import com.springmvc.domain.BoardVO;
import org.apache.ibatis.annotations.Select;

import java.util.List;

public interface BoardMapper {
    //@Select("select * from tbl_board where bno > 0")
    // getList() : 게시판 글 가져오기
    public List<BoardVO> getList();

    // insert 처리되고 primary key 를 알 필요가 없는 경우
    public void insert(BoardVO board);

    // insert 처리되고 primary key 값을 알 필요가 있는 경우
    public void insertSelectKey(BoardVO board);

    // 게시글 읽기
    public BoardVO read(Long bno);

    // 게시글 삭제
    public int delete(Long bno);

    // 게시글 수정
    public int update(BoardVO board);
}
