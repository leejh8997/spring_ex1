<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
	<!DOCTYPE html>
	<html>

	<head>
		<meta charset="UTF-8">
		<script src="https://code.jquery.com/jquery-3.7.1.js"
			integrity="sha256-eKhayi8LEQwp4NKxN+CfCh+3qOVUtJn3QNZ0TciWLP4=" crossorigin="anonymous"></script>
		<script src="https://unpkg.com/vue@3/dist/vue.global.js"></script>
		<link href="https://cdn.quilljs.com/1.3.6/quill.snow.css" rel="stylesheet">
		<script src="https://cdn.quilljs.com/1.3.6/quill.min.js"></script>
		<title>첫번째 페이지</title>
	</head>
	<style>
		div {
			margin-top: 5px
		}

		.ql-container {
			height: 80%;
		}
	</style>

	<body>
		<div id="app">
			<div>제목 : <input v-model="title"> </div>
			<div>
				<input type="file" id="file1" name="file1" accept=".jpg, .png" multiple> <!--multiple 추가하면 여러개 가능-->
			</div>
			<div style="width:500px; height:300px;">
				<div id="editor"></div>
			</div>
			<div>
				<button @click="fnInsert()">저장</button>
			</div>
		</div>
	</body>

	</html>
	<script>
		const app = Vue.createApp({
			data() {
				return {
					title: "",
					contents: "",
					userId: "${sessionId}"
				};
			},
			methods: {
				fnInsert() {
					let self = this;
					let nparmap = {
						title: self.title,
						contents: self.contents,
						userId: self.userId
					};
					$.ajax({
						url: "/board/add.dox",
						dataType: "json",
						type: "POST",
						data: nparmap,
						success: function (data) {
							console.log(data);
							if($("#file1")[0].files.length > 0){
								var form = new FormData();
								console.log($("#file1")[0].files)
								// form.append("file1", $("#file1")[0].files[0]);
								for(let i=0; i<$("#file1")[0].files.length; i++){
									form.append("file1", $("#file1")[0].files[i]);
								}
								form.append("boardNo", data.boardNo); // 임시 pk
								console.log(data.boardNo);
								self.upload(form);
							}else if (data.result == "success") {
								alert("저장");
								location.href = "/board/list.do";
							}else{
								location.href = "/board/list.do";
							}


						}
					});
				},
				upload: function (form) {
					var self = this;
					$.ajax({
						url: "/fileUpload.dox"
						, type: "POST"
						, processData: false
						, contentType: false
						, data: form
						, success: function (response) {
								alert("저장");
								location.href = "/board/list.do";
						}
					});
				}
			},
			mounted: function () {
				// Quill 에디터 초기화
				let self = this;
				var quill = new Quill('#editor', {
					theme: 'snow',
					modules: {
						toolbar: [
							[{ 'header': [1, 2, 3, 4, 5, 6, false] }],
							['bold', 'italic', 'underline'],
							[{ 'list': 'ordered' }, { 'list': 'bullet' }],
							['link', 'image'],
							['clean'],
							[{ 'color': [] }, { 'background': [] }]
						]
					}
				});

				// 에디터 내용이 변경될 때마다 Vue 데이터를 업데이트
				quill.on('text-change', function () {
					self.contents = quill.root.innerHTML;
				});
			}
		});
		app.mount('#app');
	</script>