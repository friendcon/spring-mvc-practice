package com.springmvc.mapper;

import com.springmvc.domain.BoardVO;
import com.springmvc.domain.Criteria;

import org.apache.ibatis.annotations.Select;

import java.util.List;

public interface BoardMapper {
    //@Select("select * from tbl_board where bno > 0")
    // getList() : �Խñ� ��� -> ����¡ �ʿ�
    public List<BoardVO> getList();
    
    // ������ ��������
    public List<BoardVO> getListWithPaging(Criteria cri);

    // �Խñ� �ۼ�
    public void insert(BoardVO board);

    // �Խñ� �ۼ� primary key�� �̸� ������ �� ����
    public void insertSelectKey(BoardVO board);

    // �Խñ� 1�� �б�
    public BoardVO read(Long bno);

    // ����
    public int delete(Long bno);

    // ����
    public int update(BoardVO board);
}
