package com.springmvc.controller;

import java.util.List;

import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

import com.springmvc.domain.Criteria;
import com.springmvc.domain.ReplyVO;
import com.springmvc.service.ReplyService;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@RequestMapping("/replies/*")
@RestController
@Log4j
@AllArgsConstructor
public class ReplyController {
	
	private ReplyService service;
	
	// ResponseEntitiy 타입은 데이터와 HTTP 상태 메세지를 함께 보내기 위한 객체이다.
	// RequestBody json 데이터를 replyvo 객체로 변환
	@PostMapping(value = "/new", consumes ="application/json", produces = { MediaType.TEXT_PLAIN_VALUE } )
	public ResponseEntity<String> create(@RequestBody ReplyVO vo){
		log.info("ReplyVO : " + vo);
		int insertCount = service.register(vo);
		log.info("Reply INSERT COUNT : " + insertCount);
		// 등록이 되었다면 HttpStatus.OK를 반환한다 아니라면 SERVER_ERROR을 반환한다.
		return insertCount == 1 ? new ResponseEntity<>("success", HttpStatus.OK)
				: new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
	}
	
	// 댓글목록 가져오기 /pages/글번호/댓글페이지
	// PathVariable은 URI경로의 일부를 파라미터로 사용하고자할 때.. 
	@GetMapping(value = "/pages/{bno}/{page}", produces = {
			MediaType.APPLICATION_XML_VALUE,
			MediaType.APPLICATION_JSON_UTF8_VALUE,
	})
	public ResponseEntity<List<ReplyVO>> getList(
			@PathVariable("page") int page,
			@PathVariable("bno") Long bno) {
		log.info("getList. . . . . . ");
		Criteria cri = new Criteria(page, 10);
		log.info(cri);
		return new ResponseEntity<>(service.getList(cri, bno), HttpStatus.OK);
	}
	
	// 댓글 수정
	@GetMapping(value = "/rno", 
			produces = {
					MediaType.APPLICATION_XML_VALUE,
					MediaType.APPLICATION_JSON_UTF8_VALUE
			})
	public ResponseEntity<ReplyVO> get(@PathVariable("rno") Long rno) {
		log.info("get : " + rno);
		return new ResponseEntity<>(service.get(rno), HttpStatus.OK);
	}
	
	// 댓글 삭제
	@DeleteMapping(value="/{rno}", produces = {
			MediaType.TEXT_PLAIN_VALUE
	})
	public ResponseEntity<String> remove(@PathVariable("rno") Long rno) {
		log.info("remove : " + rno);
		// 삭제 성공시 ok, 실패시 error 전송
		return service.remove(rno) == 1 ?
				new ResponseEntity<>("success", HttpStatus.OK)
				: new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
	}
	
	// 댓글 수정 PUT이다 PATCH 방식을 이용하도록 처리한다.
	@RequestMapping(method = { RequestMethod.PUT, RequestMethod.PATCH },
			value="/{rno}",
			consumes = "application/json",
			produces = { MediaType.TEXT_PLAIN_VALUE })
	public ResponseEntity<String> modify(
			@RequestBody ReplyVO vo,
			@PathVariable("rno") Long rno) {
		vo.setRno(rno);
		log.info("rno : " + rno);
		log.info("modify : " + vo);
		return service.modify(vo) == 1 ? new ResponseEntity<>("success", HttpStatus.OK)
				: new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
	}
}
