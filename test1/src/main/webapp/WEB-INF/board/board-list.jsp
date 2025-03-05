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

		.index {
			margin-right: 3px;
			text-decoration: none;
		}

		#nowPage {
			font-weight: bold;
			color: rgb(3, 230, 59);
			background-color: #e4e3e3;
		}

		#otherPage {
			color: rgb(48, 48, 48);
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

				<select @change="fnBoardList" v-model="pageSize">
					<option value="5">5개씩</option>
					<option value="10">10개씩</option>
					<option value="15">15개씩</option>
					<option value="20">20개씩</option>
				</select>

				<input v-model="keyword" @keyup.enter="fnBoardList" placeholder="검색어">
				<button @click="fnBoardList">검색</button>
			</div>
			<table>
				<tr>
					<th><input type="checkbox" v-model="all" @change="fnAllCheck"></th>
					<th>번호</th>
					<th>제목</th>
					<th>작성자</th>
					<th>조회수</th>
					<th>작성일</th>
				</tr>
				<tr v-for="item in list">
					<td><input type="checkbox" :value="item.boardNo" v-model="selectList"></td>
					<td>{{item.boardNo}}</td>
					<td>
						<a href="javascript:;" @click="fnView(item.boardNo)">
							{{item.title}}
							<span v-if ="item.commentCount != null">({{item.commentCount}})</span>
						</a>
					</td>
					<td v-if="sessionStatus=='A'">
						<a href="javascript:;" @click="fnUser(item.userId)">
							{{item.userName}}
						</a>
					</td>
					<td v-else>
						{{item.userName}}
					</td>
					<td>{{item.cnt}}</td>
					<td>{{item.cdateTime}}</td>
				</tr>
			</table>
			<button @click="fnAdd()">글쓰기</button>
			<button @click="fnRemove">삭제</button>
			<div style="margin-left: 200px;">
				<a href="javascript:;" class="index" @click="fnSetPage(page-1)" v-if="page!=1">	< </a>
				<a href="javascript:;" class="index" v-for="num in index" @click="fnSetPage(num)">
					<span v-if="page==num" id="nowPage">{{num}}</span>
					<span v-else id="otherPage">{{num}}</span>
				</a>
				<a href="javascript:;" class="index" @click="fnSetPage(page+1)" v-if="page!=index"> > </a>
			</div>
		</div>
	</body>

	</html>
	<script>
		const app = Vue.createApp({
			data() {
				return {
					list: [],
					keyword: "",
					searchOption: "all",
					sessionStatus: "${sessionStatus}",
					selectList: [],
					all: "",
					pageSize: 5,
					index: 0,
					page: 1,
					

				};
			},
			methods: {
				fnBoardList() {
					let self = this;
					
					let nparmap = {
						keyword: self.keyword,
						searchOption: self.searchOption,
						pageSize: self.pageSize,
						page: (self.page - 1) * self.pageSize
					};
					
					$.ajax({
						url: "/board/list.dox",
						dataType: "json",
						type: "POST",
						data: nparmap,
						success: function (data) {
							console.log(self.sessionStatus);
							console.log(data);
							console.log(data.list.COMMENT_COUNT);
							self.list = data.list;
							console.log(self.list);
							self.index = Math.ceil(data.count / self.pageSize);
							
						}
					});
				},
				fnAdd: function () {
					location.href = "/board/add.do";
				},
				fnView: function (boardNo) {
					pageChange("/board/view.do", { boardNo: boardNo });
				},
				fnUser: function (userId) {
					pageChange("/board/user.do", { userId: userId });
				},
				fnRemove: function () {
					let self = this;
					let nparmap = {
						selectList: JSON.stringify(self.selectList)
					};
					$.ajax({
						url: "/board/remove-list.dox",
						dataType: "json",
						type: "POST",
						data: nparmap,
						success: function (data) {
							self.fnBoardList();
							alert("삭제되었습니다.");
						}
					});

				},
				fnAllCheck: function () {
					let self = this;
					if (self.all) {
						for (let i = 0; i < self.list.length; i++) {
							self.selectList.push(self.list[i].boardNo);
						}
					} else {
						self.selectList = [];
					}
				},
				fnSetPage: function (num) {
					let self = this;
					self.page = num;
					self.fnBoardList();
				}
			},
			mounted() {
				let self = this;
				self.fnBoardList();

			}
		});
		app.mount('#app');
	</script>