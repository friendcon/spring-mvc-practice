package com.springmvc.service;

import com.springmvc.domain.BoardVO;
import com.springmvc.domain.Criteria;
import com.springmvc.mapper.BoardMapper;
import lombok.AllArgsConstructor;
import lombok.Setter;
import lombok.extern.log4j.Log4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;


@Service
@AllArgsConstructor
@Log4j
public class BoardServiceImpl implements BoardService {
    @Setter(onMethod_ = @Autowired)
    private BoardMapper mapper;

    @Override
    public void register(BoardVO board) {
        log.info("register. . . . . . " + board);
        mapper.insertSelectKey(board);
    }

    @Override
    public BoardVO get(Long bno) {
        log.info("get List. . . . . .");
        return mapper.read(bno);
    }

    @Override
    public boolean modify(BoardVO board) {
        log.info("modify. . . . . ." + board);
        return mapper.update(board) == 1;
    }

    @Override
    public boolean remove(Long bno) {
        log.info("delete. . . . . ." + bno);
        return mapper.delete(bno) == 1;
    }

    /*@Override
    public List<BoardVO> getList() {
        log.info("get List. . . . . .");
        return mapper.getList();
    }*/

	@Override
	public List<BoardVO> getList(Criteria cri) {
		log.info("get List with Paging. . . . . ." + cri);
		return mapper.getListWithPaging(cri);
	}
}
