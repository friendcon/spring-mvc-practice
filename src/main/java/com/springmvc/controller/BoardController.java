package com.springmvc.controller;

import com.springmvc.domain.BoardVO;
import com.springmvc.service.BoardService;
import com.sun.javafx.iio.common.SmoothMinifier;
import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

@Controller
@Log4j
@RequestMapping("/board/*")
@AllArgsConstructor
public class BoardController {
    private BoardService service;

    // 목록 페이지
    @GetMapping("/list")
    public void list(Model model){
        log.info("list page. . . . . .");
        model.addAttribute("list", service.getList());
    }

    // 등록 페이지
    @GetMapping("/register")
    public void register() {
    	
    }
    
    // RedirectAttribute 객체의 addFlashAttribute method : 데이터를 한번만 사용할 수 있게 보관한다. 
    @PostMapping("/register")
    public String register(BoardVO board, RedirectAttributes rttr){
        log.info("register : " + board);
        service.register(board);
        rttr.addFlashAttribute("result", board.getBno());
        return "redirect:/board/list";
    }

    // 조회페이지 & 수정페이지
    @GetMapping({"/get", "/modify"})
    public void get(@RequestParam("bno") Long bno, Model model){
        log.info("/get or /modify");
        model.addAttribute("board", service.get(bno));
    }
 
    @PostMapping("/modify")
    public String modify(BoardVO board, RedirectAttributes rttr) {
        log.info("/modify : " + board);
        if(service.modify(board)){
            rttr.addFlashAttribute("result", "success");
        }
        return "redirect:/board/list"; 
    }

    @PostMapping("/remove")
    public String remove(@RequestParam("bno") Long bno, RedirectAttributes rttr){
        log.info("remove..." + bno);
        if(service.remove(bno)){
            rttr.addFlashAttribute("result", "success");
        }
        return "redirect:/board/list";
    }
}
