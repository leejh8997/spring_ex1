<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<script src="https://code.jquery.com/jquery-3.7.1.js" integrity="sha256-eKhayi8LEQwp4NKxN+CfCh+3qOVUtJn3QNZ0TciWLP4=" crossorigin="anonymous"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/vue/3.3.4/vue.global.min.js"></script>
	<script src="/js/page-Change.js"></script>
	<title>첫번째 페이지</title>
</head>
<style>
</style>
<body>
	<div id="app">
		<div>
			아이디 : <input v-model="userId" @keyup.enter="fnLogin">  
		</div>
		<div>
			비밀번호 : <input v-model="pwd" @keyup.enter="fnLogin">  
		</div>
		<button @click="fnLogin">로그인</button>
		<button @click="fnSearchPwd">비밀번호 찾기</button>
		<button @click="fnJoin">회원가입</button>
		<div>
			<a :href="location">
				<img src="../img/kakao.png">
			</a>
		</div>
	</div>
</body>
</html>
<script>
    const app = Vue.createApp({
        data() {
            return {
                userId : "",
				pwd : "",
				member : [],
				sessionId: "${sessionId}",
				sessionStatus: "${sessionStatus}",
				location : "${location}",
            };
        },
        methods: {
            fnLogin(){
				var self = this;
				var nparmap = {
					userId : self.userId,
					pwd : self.pwd
				};
				$.ajax({
					url:"/member/login.dox",
					dataType:"json",	
					type : "POST", 
					data : nparmap,
					success : function(data) { 
						self.member = data.member;
						console.log(self.member);
						if(data.result=="success"){
							alert(data.member.userName + "님 환영합니다!");
							pageChange("/board/list.do",{sessionId : self.sessionId , sessionStatus: self.sessionStatus});
						}else{
							alert("아이디/패스워드 확인하세요.");
						}
					}
				});
            },
			fnSearchPwd(){
				location.href="/member/pwd.do";
			},
			fnJoin(){
				location.href="/member/add.do";
			}
        },
        mounted() {
           
        }
    });
    app.mount('#app');
</script>