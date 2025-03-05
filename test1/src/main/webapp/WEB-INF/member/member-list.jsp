<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
	<!DOCTYPE html>
	<html>

	<head>
		<meta charset="UTF-8">
		<script src="https://code.jquery.com/jquery-3.7.1.js"
			integrity="sha256-eKhayi8LEQwp4NKxN+CfCh+3qOVUtJn3QNZ0TciWLP4=" crossorigin="anonymous"></script>
		<script src="https://unpkg.com/vue@3/dist/vue.global.js"></script>
		<script src="/js/page-Change.js"></script>
		<title>첫번째 페이지</title>
	</head>
	<style>
		#container {
			width: 425px;
			margin: 5px auto;
		}

		table,
		tr,
		th,
		td {
			text-align: center;
			border: 2px solid #bbb;
			border-collapse: collapse;
			padding: 5px;
		}
	</style>

	<body>
		<div id="app">
			<table>
				<tr>
					<th>선택</th>
					<th>아이디</th>
					<th>이름</th>
					<th>주소</th>

					<th>삭제</th>
				</tr>
				<tr v-for="item in list">
					<td><input type="checkbox" :value="item.userId" v-model="selectList"></td>
					<td>{{item.userId}}</td>
					<td>{{item.userName}}</td>
					<td>{{item.address}}</td>


					<td><button @click=fnRemove(item.userId)>삭제</button></td>
				</tr>
			</table>
			<button @click="fnRemoveList">삭제</button>

		</div>
	</body>

	</html>
	<script>
		const app = Vue.createApp({
			data() {
				return {
					list: [],
					selectList: []
				};
			},
			methods: {
				fnMemberList() {
					let self = this;
					let nparmap = {

					};
					$.ajax({
						url: "/member/list.dox",
						dataType: "json",
						type: "POST",
						data: nparmap,
						success: function (data) {
							console.log(data);
							self.list = data.list;
						}
					});
				},
				fnRemove: function (userId) {
					let self = this;
					let nparmap = {
						userId: userId
					};
					$.ajax({
						url: "/member/remove.dox",
						dataType: "json",
						type: "POST",
						data: nparmap,
						success: function (data) {
							console.log(data);
							if (data.result == 1) {
								alert("삭제되었습니다.");
								self.fnMemberList();
							} else {
								alert("삭제실패");
							}
						}
					});
				},
				fnRemoveList : function(){
					let self = this;
					let nparmap = {
						selectList : JSON.stringify(self.selectList)
					};
					$.ajax({
						url: "/member/remove-list.dox",
						dataType: "json",
						type: "POST",
						data: nparmap,
						success: function (data) {
							console.log(data);
							alert("삭제되었습니다.");
							self.fnMemberList();
							
						}
					});
				}
			},
			mounted() {
				let self = this;
				self.fnMemberList();
			}
		});
		app.mount('#app');
	</script>