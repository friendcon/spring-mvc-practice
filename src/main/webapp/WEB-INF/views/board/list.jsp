<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
			<%@include file="../includes/header.jsp" %>
			
        <script type="text/javascript">
        	$(document).ready(function(){
        		var result = '${result}';
        		checkModal(result);
        	
        		// 뒤로가기를 했을 때 반복되지 않게 하기위함!
        		history.replaceState({}, null, null);
        		
        		function checkModal(result) {
        			if(result === '' || history.state) {
        				return;
        			}
        			if(parseInt(result) > 0) {
        				$(".modal-body").html("게시글" + parseInt(result) + " 번이 등록되었습니다.");
        			}
        			$("#myModal").modal("show");
        		}
        		
        		$("#regBtn").on("click", function(){
        			self.location = "/board/register";
        		});
        		
        		var actionForm = $("#actionForm");
        		// 페이지 넘버 버튼 클릭시 
        		$(".paginate_button a").on("click", function(e){
        			e.preventDefault(); 
        			console.log("click");
        			// input 태그의 name이 pageNum value를 찾아서 a태그의 href값으로 변경한다. 
        			actionForm.find("input[name='pageNum']").val($(this).attr("href"));
        			// actionForm을 제출한다.
        			actionForm.submit();
        		});
        		
        		// 게시글 제목 클릭시 액션 폼
        		$(".move").on("click", function(e){
        			e.preventDefault();
        			// 액션폼에 hidden으로 name은 bno고 value 역시 bno인 태그를 추가한다
        			actionForm.append("<input type='hidden' name='bno' value='" + $(this).attr("href") + "'>");
        			actionForm.attr("action", "/board/get");
        			actionForm.submit();
        		});
        		
        		var searchForm = $("#searchForm");
        		
        		// 검색 버튼 클릭
        		$("#searchForm button").on("click", function(e){
        			// 옵션이 선택되지 ㅇ않은경우
        			if(!searchForm.find("option:selected").val()) {
        				alert("검색종류를 선택하세요");
        				return false; // 검색종류선택x시 제어
        			}
        			// 키워드가 null인 경우
        			if(!searchForm.find("input[name='keyword']").val()) {
        				alert("키워드를 입력하세요");
        				return false; // 키워드 없을시 제어 
        			}
        			// pagenum의 값을 1로 설정한다.
        			searchForm.find("input[name='pageNum']").val("1");
        			e.preventDefault(); // 기본이벤트제거 후 
        			searchForm.submit(); // 폼 제출 
        		})
        		
        	});
        </script>
        
            <div class="row">
                <div class="col-lg-12">
                    <h1 class="page-header">Tables</h1>
                </div>
                <!-- /.col-lg-12 -->
            </div>
            
            <!-- /.row -->
            <div class="row">
                <div class="col-lg-12">
                    <div class="panel panel-default">
                    	<div class="panel-heading">Board List Page
                    		<button id="regBtn" type="button" class="btn btn-xs pull-right">Register New Board</button>
                    	</div>
                    	
                    	<div class="panel-body">
                    		<table class="table table-striped table-bordered table-hover">
                    			<thead>
                    				<tr>
                    					<td>번호</td>
                    					<td>제목</td>
                    					<td>작성자</td>
                    					<td>작성일</td>
                    					<td>수정일</td>
                    				</tr>
                    			</thead>
                    			<c:forEach items="${list }" var="board">
                    				<tr>
                    					<td>${board.bno }</td>
                    					<%-- <td><a href='/board/get?bno=${board.bno }'>${board.title }</a></td> --%>
                    					<td><a class="move" href='${board.bno }'>${board.title }
                    					<b>[ ${ board.replyCnt} ]</b></b></a></td>
                    					<td>${board.writer }</td>
                    					<td>${board.regdate }</td><%-- 
                    					<td><fmt:formatDate pattern="yyyy-MM-dd" value="${board.updateDate }"/></td> --%>
                    				</tr>
                    			</c:forEach>
                    		</table>
                    		<div class="row">
                    			<div class="col-lg-12">
                    				<form id="searchForm" action="/board/list" method="get">
                    					<select name="type">
                    						<option value="" <c:out value="${pageMaker.cri.type == null? 'selected' : '' }" />>--</option>
                    						<option value="T" <c:out value="${pageMaker.cri.type eq 'T'? 'selected' : '' }" />>제목</option>
                    						<option value="C" <c:out value="${pageMaker.cri.type eq 'C'? 'selected' : '' }" />>내용</option>
                    						<option value="W" <c:out value="${pageMaker.cri.type eq 'W'? 'selected' : '' }" />>작성자</option>
                    						<option value="TC" <c:out value="${pageMaker.cri.type eq 'TC'? 'selected' : '' }" />>제목 OR 내용</option>
                    						<option value="TW" <c:out value="${pageMaker.cri.type eq 'TW'? 'selected' : '' }" />>제목 OR 작성자</option>
                    						<option value="TWC" <c:out value="${pageMaker.cri.type eq 'TWC'? 'selected' : '' }" />>제목 OR 작성자 OR 내용</option>
                    					</select>
                    					<input type="text" name="keyword" value="${pageMaker.cri.keyword }" />
                    					<input type="hidden" name="pageNum" value="${pageMaker.cri.pageNum }" />
                    					<input type="hidden" name="amount" value="${pageMaker.cri.amount }" />
                    					<button class="btn btn-default">Search</button>
                    				</form>
                    			</div>
                    		</div>
                    		<div class="pull-right">
                    			<ul class="pagination">
                    				<c:if test="${pageMaker.prev }">
                    					<li class="paginate_button previous"><a href="${pageMaker.startPage -1 }">Previous</a></li>
                    				</c:if>
                    				<c:forEach var="num" begin="${pageMaker.startPage }" end="${pageMaker.endPage }">
                    					<li class="paginate_button ${pageMaker.cri.pageNum == num ? "active" : "" }"><a href="${num }">${num }</a></li>
                    				</c:forEach>
                    				<c:if test="${pageMaker.next }">
                    					<li class="paginate_button next"><a href="${pageMaker.endPage + 1 }">NEXT</a></li>
                    				</c:if>
                    			</ul>
                    		</div>
                    		
                    		<!-- Modal 추가-->
			                <div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
			                    <div class="modal-dialog">
			                        <div class="modal-content">
			                            <div class="modal-header">
			                                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
			                                <h4 class="modal-title" id="myModalLabel">Modal title</h4>
			                            </div>
			                            <div class="modal-body">처리가 완료되었습니다.</div>
			                            <div class="modal-footer">
			                                <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
			                                <button type="button" class="btn btn-primary">Save changes</button>
			                            </div>
			                        </div>
			                        <!-- /.modal-content -->
			                    </div>
			                    <!-- /.modal-dialog -->
			                </div>
                    	</div>
                    </div>
                    <!-- /.panel -->
                </div>
                <!-- /.col-lg-12 -->
            </div>
            <form id="actionForm" action="/board/list" method="get">
            	<input type="hidden" name="type" value="${pageMaker.cri.type }">
            	<input type="hidden" name="keyword" value="${pageMaker.cri.keyword }">
            	<input type="hidden" name="pageNum" value="${pageMaker.cri.pageNum }">
            	<input type="hidden" name="amount" value="${pageMaker.cri.amount }">
            </form>
        <%@include file="../includes/footer.jsp"%>
        