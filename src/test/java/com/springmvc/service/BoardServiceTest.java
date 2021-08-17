package com.springmvc.service;

import com.springmvc.domain.BoardVO;
import com.springmvc.domain.Criteria;

import lombok.Setter;
import lombok.extern.log4j.Log4j;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import java.util.List;

import static org.junit.Assert.assertNotNull;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")
@Log4j
public class BoardServiceTest {
    @Setter(onMethod_ = @Autowired)
    private BoardService service;

    // testExist() : service 객체가 잘 주입되었는지 확인
    /*@Test
    public void testExist() {
        log.info(service);
        assertNotNull(service);
    }

    @Test
    public void testRegister() {
        BoardVO board = new BoardVO();
        board.setTitle("새로 작성하는 글");
        board.setContent("새로 작성하는 내용");
        board.setWriter("newbie");
        service.register(board);
        log.info("생성된 게시물의 번호 : " + board.getBno());
    }

    @Test
    public void testGetList(){
        service.getList().forEach(board -> log.info(board));
    }

    @Test
    public void testGetListWithPaging() {
    	service.getList(new Criteria(2, 10)).forEach(board -> log.info(board));
    }

   @Test
    public void testGet(){
        log.info(service.get(4L));
    }

    @Test
    public void testModify() {
        BoardVO board = service.get(4L);
        if(board == null){
            return;
        }
        board.setTitle("수정된 제목 4L");
        log.info("modify result. . . . . ." + service.modify(board));
    }

    @Test
    public void testDelete(){
        log.info("remove result. . . . . ." + service.remove(4L));
    }*/
    
    @Test
    public void testClass(){
    	log.info(service);
    	log.info(service.getClass().getName());
    	BoardVO board = new BoardVO();
    	board.setTitle("<script>");
    	board.setContent("aop를 테스트하자");
    	board.setWriter("aop");
    	service.register(board);
    }
    
}
