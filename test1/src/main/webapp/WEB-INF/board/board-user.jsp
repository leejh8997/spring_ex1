<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
	<!DOCTYPE html>
	<html>

	<head>
		<meta charset="UTF-8">
		<script src="https://code.jquery.com/jquery-3.7.1.js"
			integrity="sha256-eKhayi8LEQwp4NKxN+CfCh+3qOVUtJn3QNZ0TciWLP4=" crossorigin="anonymous"></script>
		<script src="https://unpkg.com/vue@3/dist/vue.global.js"></script>
		<title>첫번째 페이지</title>
	</head>
	<style>
	</style>

	<body>
		<div id="app">

			<div>
				아이디 : {{info.userId}}
			</div>
			<div>
				이름 : {{info.userName}}
			</div>
			<div>
				주소: {{info.address}}
			</div>
			<div>
				전화번호: {{info.phone}}
			</div>
			<div>
				이메일: {{info.email}}
			</div>
			<div>
				<button @click="fnBack()">되돌아가기</button>
			</div>
		</div>
	</body>

	</html>
	<script>
		const app = Vue.createApp({
			data() {
				return {
					info: {},
					userId: "${map.userId}"
				};
			},
			methods: {
				fnGetUser() {
					let self = this;
					let nparmap = {
						userId: self.userId
					};
					$.ajax({
						url: "/board/user.dox",
						dataType: "json",
						type: "POST",
						data: nparmap,
						success: function (data) {
							console.log(data);
							self.info = data.info;
						}
					});
				},
				fnBack : function(){
					location.href="/board/list.do";
				}
			},
			mounted() {
				let self = this;
				self.fnGetUser();
			}
		});
		app.mount('#app');
	</script>