<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>



<%@ include file="../includes/header.jsp" %>
<script type="text/javascript">
	$(document).ready(function(){
		// form 객체를 가져온다
		var formObj = $("form");
		$('button').on("click", function(e){
			e.preventDefault(); // form이 제출되는 것을 막기 위함
			var operation = $(this).data("oper"); // this는 현재 클릭한 버튼
			console.log(operation);
			if(operation === 'remove'){
				formObj.attr("action", "/board/remove");
			} else if(operation === 'list') {
				formObj.attr("action", "/board/list").attr("method", "get");
				// /board/list는 파라미터가 없기 때문에 비워둔 상태에서 제출되어야 한다 (BoardVO 정보가 넘어가면 안된다)
				var keyWordTag = $("input[name='keyword']").clone();
				var typeTag = $("input[name='type']").clone();
				var pageNumTag = $("input[name='pageNum']").clone();
				var amountTag = $("input[name='amount']").clone();
				formObj.empty();
				formObj.append(pageNumTag);
				formObj.append(amountTag);
				formObj.append(keyWordTag);
				formObj.append(typeTag);
			}
			formObj.submit();
		});
	});
</script>
			<div class="row">
                <div class="col-lg-12">
                    <h1 class="page-header">Board Modify</h1>
                </div>
                <!-- /.col-lg-12 -->
            </div>
            
            <div class="row">
                <div class="col-lg-12">
                    <div class="panel panel-default">
                    	<div class="panel-heading">Board Modify Page</div>
                    	<div class="panel-body">
                    		<form role="form" action="/board/modify" method="post">
                    			<div class="form-group">
                    				<label>Bno</label>
                    				<input class="form-control" name="bno"
                    				value="${board.bno }" readonly="readonly">
                    			</div>
                    			<div class="form-group">
                    				<label>Title</label>
                    				<input class="form-control" name="title"
                    				value="${board.title }">
                    			</div>
                    			<div class="form-group">
                    				<label>Text Area</label>
                    				<input class="form-control" rows="3" name="content"
                    				value="${board.content }">
                    			</div>
                    			<div class="form-group">
                    				<label>Writer</label>
                    				<input class="form-control" name="writer"
                    				value="${board.writer }">
                    			</div>
                    			<!-- 400 에러 해결 :  -->
                    			<div class="form-group">
                    				<label>RegDate</label>
                    				<input class="form-control" name="regDate"
                    				value='<fmt:formatDate pattern="yyyy/MM/dd" value="${board.regdate }" />' readonly="readonly">
                    			</div>
                    			<div class="form-group">
                    				<label>Update Date</label>
                    				<input class="form-control" name="updateDate"
                    				value='<fmt:formatDate pattern="yyyy/MM/dd" value="${board.updateDate }" />' readonly="readonly">
                    			</div>
                    			<!-- modify버튼 클릭시 해당 글번호에 해당하는 게시글 조회 가능 -->
                    			<button type="submit" data-oper="modify" class="btn btn-default">Modify</button>
                    			<button type="submit" data-oper="remove" class="btn btn-danger">Remove</button>
                    			<button type="submit" data-oper="list" class="btn btn-info">List</button>
                    			
                    			<!-- 수정페이지에도 목록으로 가기가 있어서 hidden으로 pageNum과 amount를 넘겨줘야한다. -->
                    			<input type="hidden" name="pageNum" value="${cri.pageNum }">
                    			<input type="hidden" name="amount" value="${cri.amount }">
                    			<input type="hidden" name="keyword" value="${cri.keyword }">
                    			<input type="hidden" name="type" value="${cri.type }">
                    		</form>
                    	</div>
                    </div>
                    <!-- /.panel -->
                </div>
                <!-- /.col-lg-12 -->
            </div>
            
            <%@include file="../includes/footer.jsp"%>