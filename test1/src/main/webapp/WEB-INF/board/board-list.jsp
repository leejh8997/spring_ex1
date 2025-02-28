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
			<div>
				<select v-model="searchOption">
					<option value="all">:: 전체 ::</option>
					<option value="title">제목</option>
					<option value="name">작성자</option>
				</select>
				<input v-model="keyword" @keyup.enter="fnBoardList" placeholder="검색어">
				<button @click="fnBoardList">검색</button>
			</div>
			<table>
				<tr>
					<th>번호</th>
					<th>제목</th>
					<th>작성자</th>
					<th>조회수</th>					
					<th>작성일</th>
				</tr>
				<tr v-for="item in list">
					<td>{{item.boardNo}}</td>
					<td>
						<a href="javascript:;" @click="fnView(item.boardNo)">{{item.title}}</a>
					</td>
					<td>{{item.userName}}</td>
					<td>{{item.cnt}}</td>
					<td>{{item.cdateTime}}</td>
				</tr>
			</table>
			<button @click="fnAdd()">글쓰기</button>
		</div>
	</body>

	</html>
	<script>
		const app = Vue.createApp({
			data() {
				return {
					list : [],
					keyword : "",
					searchOption : "all",

					
				};
			},
			methods: {
				fnBoardList() {
					let self = this;
					let nparmap = {
						keyword: self.keyword,
						searchOption: self.searchOption
					};
					$.ajax({
						url: "/board/list.dox",
						dataType: "json",
						type: "POST",
						data: nparmap,
						success: function (data) {
							console.log(self.sessionId);
							console.log(data);
							self.list = data.list;
						}
					});
				},
				fnAdd : function(){
					location.href = "/board/add.do";
				},
				fnView : function(boardNo){
					pageChange("/board/view.do",{boardNo : boardNo});
				}
			},
			mounted() {
				let self = this;
				self.fnBoardList();
				
			}
		});
		app.mount('#app');
	</script>