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
					<th>학번</th>
					<th>이름</th>
					<th>학과</th>
					<th>성별</th>
					<th>삭제</th>
				</tr>
				<tr v-for="item in list">
					<td>{{item.stuNo}}</td>
					<td>{{item.stuName}}</td>
					<td>{{item.stuDept}}</td>
					<td>{{item.stuGender}}</td>
					<td><button @click=fnRemove(item.userId)>삭제</button></td>
				</tr>
			</table>
		</div>
	</body>

	</html>
	<script>
		const app = Vue.createApp({
			data() {
				return {
					list:[]
				};
			},
			methods: {
				fnUserList() {
					let self = this;
					let nparmap = {

					};
					$.ajax({
						url: "/test/list.dox",
						dataType: "json",
						type: "POST",
						data: nparmap,
						success: function (data) {
							console.log(data);
							self.list = data.stu;

						}
					});
				}
			},
			mounted() {
				let self = this;
				self.fnUserList();
			}
		});
		app.mount('#app');
	</script>