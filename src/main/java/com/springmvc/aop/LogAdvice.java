package com.springmvc.aop;

import org.aspectj.lang.annotation.Aspect;
import org.aspectj.lang.annotation.Before;
import org.springframework.stereotype.Component;

import com.springmvc.domain.BoardVO;

import lombok.extern.log4j.Log4j;

@Aspect
@Log4j
@Component
public class LogAdvice {
	
	private static String xssfilter(String str) {
		str = str.replaceAll("<", "&lt;");
		str = str.replaceAll(">", "&gt;");
		str = str.replaceAll("&", "&amp;");
		str = str.replaceAll("\"", "&quot;");
		return str;
	}
	
	// execution : 접근제한자와 특정 클래스의 메서드를 지정할 수 있다. 
	@Before("execution(* com.springmvc.service.BoardService*.register(..)) && args(board)")
	public void logBefore(BoardVO board){
		log.info("======================");
		String title = board.getTitle();
		String content = board.getContent();
		String writer = board.getWriter();
		board.setTitle(xssfilter(title));
		board.setContent(xssfilter(content));
		board.setWriter(xssfilter(writer));
		log.info("======================");
	}
}
