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
	<jsp:include page="../common/header.jsp" />
	<div id="app">
		
	</div>
</body>
</html>
<script>
    const app = Vue.createApp({
        data() {
            return {
               
            };
        },
        methods: {
            fn(){
				let self = this;
				let nparmap = {

				};
				$.ajax({
					url:"member/list.dox",
					dataType:"json",	
					type : "POST", 
					data : nparmap,
					success : function(data) { 
						console.log(data);
						
					}
				});
            }
        },
        mounted() {
            let self = this;
        }
    });
    app.mount('#app');
</script>