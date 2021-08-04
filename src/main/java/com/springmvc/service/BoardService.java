package com.springmvc.service;

import com.springmvc.domain.BoardVO;

import java.util.List;

public interface BoardService {
    // 게시글 등록
    public void register(BoardVO board);
    // 게시글 1개 읽기
    public BoardVO get(Long bno);
    // 게시글 수정
    public boolean modify(BoardVO board);
    // 게시글 삭제
    public boolean remove(Long bno);
    // 게시글 목록
    public List<BoardVO> getList();
}
