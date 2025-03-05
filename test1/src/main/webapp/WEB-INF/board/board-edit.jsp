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
		div {
			margin-top: 5px;
		}
	</style>

	<body>
		<div id="app">
			<div> 제목 : <input v-model="info.title"> </div>
			<div>
				내용 : <textarea v-model="info.contents" cols="50" rows="20"></textarea>
			</div>
			<div>
				<button @click="fnEdit">저장</button>
			</div>
		</div>
	</body>

	</html>
	<script>
		const app = Vue.createApp({
			data() {
				return {
					info: {},
					boardNo: "${map.boardNo}",
				};
			},
			methods: {
				fnGetBoard() {
					let self = this;
					let nparmap = {
						boardNo: self.boardNo,
						option: "UPDATE"
					};
					$.ajax({
						url: "/board/view.dox",
						dataType: "json",
						type: "POST",
						data: nparmap,
						success: function (data) {
							console.log(data);
							self.info = data.info;
						}
					});
				},
				fnEdit: function () {
					let self = this;
					let nparmap = self.info;
					$.ajax({
						url: "/board/edit.dox",
						dataType: "json",
						type: "POST",
						data: nparmap,
						success: function (data) {
							console.log(data);
							alert("수정되었습니다");
							location.href = "/board/list.do";
						}
					});
				}
			},
			mounted() {
				let self = this;
				self.fnGetBoard();
			}
		});
		app.mount('#app');
	</script>