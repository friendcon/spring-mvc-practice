console.log("Reply Module. . . . . .");

var replyService = (function(){
	// 댓글 추가
	function add(reply, callback, error){
		console.log("add reply. . . . . .");
		$.ajax({
			type: 'post', // 댓글작성 post요청
			url: '/replies/new', // /replies/new 로 요청
			data: JSON.stringify(reply), // 전송되는 데이터 타입. js객체를 json 타입으로 변환해서 서버로 전송
			contentType: "application/json; charset=utf-8",
			success: function(result, status, xhr) {
				if(callback){
					callback(result); // ajax 호출이 성공하면 callback에서 함수가 존재한다면 그 해당 함수를 실행한다
				}
			},
			error: function(xhr, status, er){
				if(error){
					error(er);
				}
			}
		})
	};
	
	// 댓글 목록 가져오기
	function getList(param, callback, error){
		var bno = param.bno;
		var page = param.page || 1;
		// getJSON : JSON파일을 읽어오는 함수 /replies/pages/글번호/페이지 번호.json
		$.getJSON("/replies/pages/" + bno + "/" + page + ".json", 
			function(data){
				if(callback) {
					callback(data);
				}
			}).fail(function(xhr, status, err){
				if(error) {
					error();
				}
			});		
	}
	
	function remove(rno, callback, error){
		$.ajax({
			type: 'delete',
			url : '/replies/' + rno,
			success: function(deleteResult, status, xhr) {
				if(callback){
					callback(deleteResult);
				}
			},
			error: function(xhr, status, er){
				if(error){
					error(er);
				}
			}
		});
	}
	
	function update(reply, callback, error) {
		console.log("RNO : " + reply.rno);
		
		$.ajax({
			type: 'put',
			url: '/replies/' + reply.rno,
			data : JSON.stringify(reply),
			contentType: "application/json; charset=utf-8",
			success: function(result, status, xhr){
				if(callback){
					callback(result);
				}
			},
			error : function(xhr, status, er) {
				if(error) {
					error(er);
				}
			}
		});
	}
	
	// 특정번호 댓글 조회 
	function get(rno, callback, error) {
		$.get("/replies/" + rno + ".json", function(result) {
			if(callback){
				callback(result);
			}
		}).fail(function(xhr, status, err){
			if(error) {
				error();
			}
		});
	}
	return {
		add:add,
		getList : getList,
		remove : remove,
		update: update,
		get: get
	};
})();

