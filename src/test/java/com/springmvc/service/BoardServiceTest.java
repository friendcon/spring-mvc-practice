package com.springmvc.service;

import com.springmvc.domain.BoardVO;
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

    // testExist() : service ��ü�� �� ���ԵǾ����� Ȯ��
    @Test
    public void testExist() {
        log.info(service);
        assertNotNull(service);
    }

    @Test
    public void testRegister() {
        BoardVO board = new BoardVO();
        board.setTitle("���� �ۼ��ϴ� ��");
        board.setContent("���� �ۼ��ϴ� ����");
        board.setWriter("newbie");
        service.register(board);
        log.info("������ �Խù��� ��ȣ : " + board.getBno());
    }

    @Test
    public void testGetList(){
        service.getList().forEach(board -> log.info(board));
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
        board.setTitle("������ ���� 4L");
        log.info("modify result. . . . . ." + service.modify(board));
    }

    @Test
    public void testDelete(){
        log.info("remove result. . . . . ." + service.remove(4L));
    }
}
