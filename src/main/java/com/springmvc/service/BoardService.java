package com.springmvc.service;

import com.springmvc.domain.BoardVO;
import com.springmvc.domain.Criteria;

import java.util.List;

public interface BoardService {
    // �Խñ� ���
    public void register(BoardVO board);
    // �Խñ� 1�� ��ȸ
    public BoardVO get(Long bno);
    // �Խñ� ����
    public boolean modify(BoardVO board);
    // �Խñ� ����
    public boolean remove(Long bno);
    // �Խñ� ��� ��ȸ
    // public List<BoardVO> getList();
    // ����¡ ó���� �Խñ� ��� ��ȸ
    public List<BoardVO> getList(Criteria cri);
    
}
