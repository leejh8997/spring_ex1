<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<script src="https://code.jquery.com/jquery-3.7.1.js" integrity="sha256-eKhayi8LEQwp4NKxN+CfCh+3qOVUtJn3QNZ0TciWLP4=" crossorigin="anonymous"></script>
	<script src="https://unpkg.com/vue@3/dist/vue.global.js"></script>
	<script src="/js/page-Change.js"></script>
	<title>첫번째 페이지</title>
</head>
<style>
</style>
<body>
	<div id="app">

		<div>
			번호 : {{info.boardNo}}
		</div>
		<div>
		    제목 : {{info.title}}
		</div>
		<div>
		    내용 : {{info.contents}}
		</div>
		<div>
		    작성자 : {{info.userId}}
		</div>
		<div>
		    조회수 : {{info.cnt}}
		</div>
		<div>
			작성일 : {{info.cdateTime}}
		</div>
		<div>
			<button @click="fnEdit()">수정</button>
		</div>
	</div>
</body>
</html>
<script>
    const app = Vue.createApp({
        data() {
            return {
				info :{},
               	boardNo : "${map.boardNo}"
			   
            };
        },
        methods: {
            fnGetBoard(){
				let self = this;
				let nparmap = {
					boardNo : self.boardNo
				};
				$.ajax({
					url:"/board/view.dox",
					dataType:"json",	
					type : "POST", 
					data : nparmap,
					success : function(data) { 
						console.log(data);
						self.info = data.info;
						console.log(self.info);
					}
				});
            },
			fnEdit : function(){
				let self = this;
				pageChange("/board/edit.do",{ boardNo : self.boardNo});
			}
        },
        mounted() {
            let self = this;
			self.fnGetBoard();
        }
    });
    app.mount('#app');
</script>