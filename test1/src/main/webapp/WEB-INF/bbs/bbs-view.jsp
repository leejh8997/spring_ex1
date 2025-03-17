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
				번호 : {{info.bbsNum}}
			</div>
			<div>
				제목 : {{info.title}}
			</div>
			<div>
				내용 : <span v-html="info.contents"></span>
			</div>
			<div v-for="item in fileList"> <!-- div에 v-if쓰거나 src에 옵셔널체이닝(fileList[0]?.filePath) 사용 -->
				<img :src="item.filePath" alt="Image">
			</div>
			<div>
				작성자 : {{info.userId}}
			</div>
			<div>
				조회수 : {{info.hit}}
			</div>
			<div>
				작성일 : {{info.cDateTime}}
			</div>
				<div>
					<button @click="fnUpdate()">수정</button>
				</div>
			
		</div>
	</body>

	</html>
	<script>
		const app = Vue.createApp({
			data() {
				return {
					info: {},
					bbsNum: "${map.bbsNum}",
					sessionId: "${sessionId}",
					sessionStatus: "${sessionStatus}",
					fileList: [],
				};
			},
			methods: {
				fnGetBbs() {
					let self = this;
					let nparmap = {
						bbsNum: self.bbsNum,
						option: "select",

					};
					$.ajax({
						url: "/bbs/view.dox",
						dataType: "json",
						type: "POST",
						data: nparmap,
						success: function (data) {
							console.log(data);
							self.info = data.info;
							console.log(self.info);
							self.fileList = data.file;
							console.log(self.fileList);			
						}
					});
				},
				fnUpdate: function () {
					let self = this;
					pageChange("/bbs/update.do", { bbsNum: self.bbsNum });
				},
			},
			mounted() {
				let self = this;
				self.fnGetBbs();
			}
		});
		app.mount('#app');
	</script>