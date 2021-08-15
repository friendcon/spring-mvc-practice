<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ include file="../includes/header.jsp" %>
<script type="text/javascript" src="/resources/js/reply.js"></script>
<script>
	/* console.log("=============");
	console.log("JS TEST");
	
	var bnoValue = '${board.bno}';
	 */
	// add(reply객체, callback 함수, err) 
	/* replyService.add(
		{reply:"JS TEST", replyer:"tester", bno:bnoValue}
		, 
		function(result){
			alert("RESULT : " + result);
		}
	); */
	
	// 댓글 리스트 가져오기
	// getList(param, callback, err)
	/* replyService.getList({bno:bnoValue, page:1}, function(list) {
		for(var i=0, len = list.length||0; i<len; i++){
			console.log(list[i]);
		}
	}); */
	
	// 댓글 삭제 테스트 
	/* replyService.remove(9, function(count) {
		console.log(count);
		if(count === "success") {
			alert("REMOVED");
		}
	}, function(err) {
		alert("Error. . .");
	});
	 */
	// 댓글 수정 테스트
/* 	replyService.update({
		rno:13,
		bno:bnoValue,
		reply:"Modified Reply. . . ."
	}, function(result){
		alert("수정완료. . .");
	});
	 
	 replyService.get(10, function(data){
		 console.log(data);
	 }); */
</script>
<script>
// 게시글 조회와 동시에 댓글 목록 조회도 가능해야한다. 
	$(document).ready(function(){
		var bnoValue = ${board.bno};
		var replyUL = $('.chat');
		
		showList(1);
		function showList(page) {
			replyService.getList({bno:bnoValue, page: page || 1}, function(list) {
				var str ="";
				if(list == null || list.length == 0){
					replyUL.html("");
					return;
				}
				
				for(var i=0, len = list.length || 0; i<len; i++){
					str += "<li class='left clearfix' data-rno='" + list[i].rno + "'>";
					str += "<div><div class='header'><strong class='primary-font'>" + list[i].replyer+"</strong>";
					str += "<small class='pull-right text-muted'>" + replyService.displayTime(list[i].replyDate) + "</small></div>";
					str += "<p>" + list[i].reply + "</p></div></li>";
				}
				
				replyUL.html(str);
			}); // end showList function 
		}
		
		var modal = $(".modal");
		var modalInputReply = modal.find("input[name='reply']"); // 댓글
		var modalInputReplyer = modal.find("input[name='replyer']"); // 댓글작성자
		var modalInputReplyDate = modal.find("input[name='replyDate']"); // 댓글작성날짜
		
		var modalModBtn = $("#modalModBtn"); // modify 버튼
		var modalRemoveBtn = $("#modalRemoveBtn"); // remove 버튼
		var modalRegisterBtn = $("#modalRegisterBtn"); // register 버튼
		
		// 댓글 작성 버튼 클릭시 이벤트 처리
		$("#addReplyBtn").on("click", function(e){
			modal.find("input").val(""); // 모달에 있는 input 값들 초기화 
			modalInputReplyDate.closest("div").hide(); // 댓글단 날짜를 숨겨야한다
			modal.find("button[id != 'modalCloseBtn']").hide(); // 숨김
			modalRegisterBtn.show(); // 등록버튼 보여줌
			$(".modal").modal("show"); // 모달 보여줌
		});
		
		// 등록 버튼 클릭시 이벤트 처리
		modalRegisterBtn.on("click", function(e){
			var reply = {
					reply: modalInputReply.val(),
					replyer: modalInputReplyer.val(),
					bno: bnoValue
			};
			
			replyService.add(reply, function(result) {
				alert(result); // result는 서버에서 가져온 값
				modal.find("input").val(""); // modal 의 input 값 전부 삭제 
				modal.modal("hide"); // 모달창 숨기기
				showList(1);
			})
		})
		
		// 댓글 한개 클릭시 이벤트 처리
		$(".chat").on("click", "li", function(e){
			var rno = $(this).data("rno");
			console.log(rno);
			replyService.get(rno, function(reply){
				modalInputReply.val(reply.reply);
				modalInputReplyer.val(reply.replyer);
				modalInputReplyDate.val(replyService.displayTime(reply.replyDate)).attr("readonly", "readonly");
				modal.data("rno", reply.rno);
				modal.find("button[id != 'modalCloseBtn']").hide(); // modal에서 닫기버튼을 제외한 것을 숨긴다.
				modalModBtn.show();
				modalRemoveBtn.show();
				$(".modal").modal("show"); // 초기화 후 모달창을 보여준다
			});
		});
		
		// 변경버튼 클릭시 이벤트 처리
		modalModBtn.on("click", function(e){
			// 댓글 객체 가져오기
			var reply = {
					rno:modal.data("rno"),
					reply:modalInputReply.val()
			};
			replyService.update(reply, function(result){
				alert(result);
				modal.modal("hide");
				showList(1);
			});
		});
		
		// 삭제버튼 클릭시 이벤트 처리
		modalRemoveBtn.on("click", function(e){
			var rno = modal.data("rno");
			replyService.remove(rno, function(result) {
				alert(result);
				modal.modal("hide");
				showList(1);
			});
		});
	});
</script>
<script type="text/javascript">
	$(document).ready(function(){
		// form 객체를 가져온다
		var operForm = $("#operForm");
		// 수정버튼 클릭시 /board/modify 로 이동하도록 한다
		$("button[data-oper='modify']").on("click", function(e){
			operForm.attr("action", "/board/modify").submit();
		});
		// 목록버튼 클릭시 id가 bno인 요소를 삭제하고 action에 /board/list 속성을 추가하고 form을 제출한다. 
		$("button[data-oper='list']").on("click", function(e){
			operForm.find("#bno").remove();
			operForm.attr("action", "/board/list");
			operForm.submit();
		});
	});
</script>
			<div class="row">
                <div class="col-lg-12">
                    <h1 class="page-header">Board Read</h1>
                </div>
                <!-- /.col-lg-12 -->
            </div>
            
            <div class="row">
                <div class="col-lg-12">
                    <div class="panel panel-default">
                    	<div class="panel-heading">Board Read Page</div>
                    	<div class="panel-body">
                    			<div class="form-group">
                    				<label>Bno</label>
                    				<input class="form-control" name="bno"
                    				value="${board.bno }" readonly="readonly">
                    			</div>
                    			<div class="form-group">
                    				<label>Title</label>
                    				<input class="form-control" name="title"
                    				value="${board.title }" readonly="readonly">
                    			</div>
                    			<div class="form-group">
                    				<label>Text Area</label>
                    				<input class="form-control" rows="3" name="content"
                    				value="${board.content }" readonly="readonly">
                    			</div>
                    			<div class="form-group">
                    				<label>Writer</label>
                    				<input class="form-control" name="writer"
                    				value="${board.writer }" readonly="readonly">
                    			</div>
                    			<!-- modify버튼 클릭시 해당 글번호에 해당하는 게시글 조회 가능 -->
                    			<button data-oper="modify" class="btn btn-default"
                    			onclick="location.href='/board/modify?bno=${board.bno}'">Modify</button>
                    			<button data-oper="list" class="btn btn-info"
                    			onclick="location.href='/board/list'">List</button>
                    			
                    			<form id="operForm" action="/board/modify" method="get">
                    				<input type="hidden" id="bno" name="bno" value="${board.bno }" />
                    				<input type="hidden" name="pageNum" value="${cri.pageNum }" />
                    				<input type="hidden" name="amount" value="${cri.amount }" />
                    				<input type="hidden" name="keyword" value="${cri.keyword }"/>
                    				<input type="hidden" name="type" value="${cri.type }" />
                    			</form>
                    	</div>
                    </div>
                    <!-- /.panel -->
                </div>
                <!-- /.col-lg-12 -->
            </div>
            <div class="row">
            	<div class="col-lg-12">
            		<div class="panel panel-default">
            			<div class="panel-heading">
            				<i class="fa fa-comments fa-fw"></i> Reply
            				<!-- 댓글 추가 -->
            				<button id="addReplyBtn" class="btn btn-primary btn-xs pull-right">New Reply</button>
            			</div>
            			<div class="panel-body">
            				<ul class="chat">
            				</ul>
            			</div>
            		</div>
            	</div>
            </div>
            
            <!-- Modal 추가-->
			                <div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
			                    <div class="modal-dialog">
			                        <div class="modal-content">
			                            <div class="modal-header">
			                                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
			                                <h4 class="modal-title" id="myModalLabel">Reply Modal</h4>
			                            </div>
			                            <div class="modal-body">
											<div class="form-group">
												<label>Reply</label>
												<input class="form-control" name="reply" value="New Reply~!!!">
											</div>
											<div class="form-group">
												<label>Replyer</label>
												<input class="form-control" name="replyer" value="replyer">
											</div>
											<div class="form-group">
												<label>Reply Date</label>
												<input class="form-control" name="replyDate" value=''>
											</div>
										</div>
			                            <div class="modal-footer">
			                                <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
			                                <button type="button" class="btn btn-primary">Save changes</button>
			                            </div>
			                        </div>
			                  
			                        <!-- /.modal-content -->
			                        <div class="modal-footer">
			                        	<button id="modalModBtn" type="button" class="btn btn-warning">Modify</button>
			                        	<button id="modalRemoveBtn" type="button" class="btn btn-danger">Remove</button>
			                        	<button id="modalRegisterBtn" type="button" class="btn btn-default"
			                        	data-dismiss="modal">Register</button>
			                        	<button id="modalCloseBtn" type="button" class="btn btn-default"
			                        	data-dismiss="modal">Close</button>
			                        </div>
			                    </div>
			                    <!-- /.modal-dialog -->
			                </div>
            
            <%@include file="../includes/footer.jsp"%>