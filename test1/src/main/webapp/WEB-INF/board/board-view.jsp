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
		.btn-link {
			text-decoration: none;
			color: red;
		}
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
				내용 : <span v-html="info.contents"></span>
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
			<div v-if="info.userId == sessionId || sessionStatus == 'A'">
				<div>
					<button @click="fnEdit()">수정</button>
					<button @click="fnRemove()">삭제</button>
				</div>
			</div>
			<div v-for="item in cmtList">
				<label v-if="updateCmtNo==item.commentNo">
					{{item.userId}}:<input v-model="updateContents">
				</label>
				<label v-else>{{item.userId}}:{{item.contents}}</label>

				
				<template v-if="updateCmtNo == item.commentNo">
					<button class="btn-link" @click="fnCmtUpdate(item.commentNo)" href="javascript:;">저장</button>
					<button class="btn-link" @click="updateCmtNo=''" href="javascript:;">취소</button>
				</template>
					
				<template v-else>
					<template v-if="sessionId == item.userId || sessionStatus == 'A'"></template>
						<button class="btn-link" @click="fnCmtWrite(item)" href="javascript:;">🖍</button>
						<button class="btn-link" @click="fnCmtRemove(item.commentNo)" href="javascript:;">❌</button>
					</template>
				</template>
				<hr>
			</div>
			<div>
				<textarea v-model="editContents" cols="30" rows="10"></textarea>
				<button @click="fnCmtEdit">등록</button>
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
					sessionId: "${sessionId}",
					sessionStatus: "${sessionStatus}",
					cmtList: [],
					editContents: "",
					updateContents: "",
					updateCmtNo: "",
				};
			},
			methods: {
				fnGetBoard() {
					let self = this;
					let nparmap = {
						boardNo: self.boardNo,
						option: "select",

					};
					$.ajax({
						url: "/board/view.dox",
						dataType: "json",
						type: "POST",
						data: nparmap,
						success: function (data) {
							console.log(data);
							self.info = data.info;
							console.log(self.info);
							self.cmtList = data.cmtList;
							console.log(self.cmtList);
						}
					});
				},
				fnEdit: function () {
					let self = this;
					pageChange("/board/edit.do", { boardNo: self.boardNo });
				},
				fnRemove: function () {
					let self = this;
					let nparmap = {
						boardNo: self.boardNo,
					};
					$.ajax({
						url: "/board/remove.dox",
						dataType: "json",
						type: "POST",
						data: nparmap,
						success: function (data) {
							alert("삭제되었습니다.");
							location.href = "/board/list.do";
						}
					});
					location.href = "/board/list.do";
				},
				fnCmtEdit: function () {
					let self = this;
					let nparmap = {
						editContents: self.editContents,
						sessionId: self.sessionId,
						boardNo: self.boardNo
					};
					$.ajax({
						url: "/board/cmt-edit.dox",
						dataType: "json",
						type: "POST",
						data: nparmap,
						success: function (data) {
							self.fnGetBoard();
							self.editContents = "";
						}
					});
				},
				fnCmtUpdate: function (commentNo) {
					let self = this;
					let nparmap = {
						commentNo: commentNo,
						contents: self.updateContents
					};
					$.ajax({
						url: "/board/cmt-update.dox",
						dataType: "json",
						type: "POST",
						data: nparmap,
						success: function (data) {
								self.updateCmtNo = "";
								self.fnGetBoard();
						}
					});
				},
				fnCmtRemove: function (commentNo) {
					let self = this;
					let nparmap = {
						commentNo: commentNo,
					};
					if(!confirm("정말 삭제하시겠습니까?")){
                   		return;
                	}
					$.ajax({
						url: "/board/cmt-remove.dox",
						dataType: "json",
						type: "POST",
						data: nparmap,
						success: function (data) {
							self.fnGetBoard();
						}
					});
				},
				fnCmtWrite: function (item) {
					let self = this;
					self.updateCmtNo = item.commentNo;
					self.updateContents = item.contents;
				},
			},
			mounted() {
				let self = this;
				self.fnGetBoard();
			}
		});
		app.mount('#app');
	</script>