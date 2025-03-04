<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<script src="https://code.jquery.com/jquery-3.7.1.js" integrity="sha256-eKhayi8LEQwp4NKxN+CfCh+3qOVUtJn3QNZ0TciWLP4=" crossorigin="anonymous"></script>
	<script src="https://unpkg.com/vue@3/dist/vue.global.js"></script>
	<title>첫번째 페이지</title>
</head>
<style>
</style>
<body>
	<div id="app">
		<div v-if="member!=null">중복되었습니다.</div>
		<div v-else>사용가능합니다.</div>
	</div>
</body>
</html>
<script>
    const app = Vue.createApp({
        data() {
            return {
				userId:"",
				member:{}
            };
        },
        methods: {
            fnCheck(){
				let self = this;
				let nparmap = {
					userId: self.userId
				};
				$.ajax({
					url:"/member/check.dox",
					dataType:"json",	
					type : "POST", 
					data : nparmap,
					success : function(data) { 
						console.log(data.member);
						self.member = data.member;
					}
				});
            }
        },
        mounted() {
            let self = this;
			const queryParams = new URLSearchParams(window.location.search);
            self.userIdn = queryParams.get('userId');
			self.fnCheck();
        }
    });
    app.mount('#app');
</script>