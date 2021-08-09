<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ include file="../includes/header.jsp" %>
<script type="text/javascript">
	$(document).ready(function(){
		// form 객체를 가져온다
		var openForm = $("#operForm");
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
                    			
                    			<form id="openForm" action="/board/modify" method="get">
                    				<input type="hidden" id="bno" name="bno" value="${board.bno }" />
                    			</form>
                    	</div>
                    </div>
                    <!-- /.panel -->
                </div>
                <!-- /.col-lg-12 -->
            </div>
            
            <%@include file="../includes/footer.jsp"%>