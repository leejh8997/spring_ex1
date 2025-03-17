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
			<div>
                <textarea name="contents" v-model="contents" rows="20" cols="30"></textarea>
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
					sessionId: "${sessionId}"
				};
			},
			methods: {
				fnInsert() {
					let self = this;
					let nparmap = {
						title: self.title,
						contents: self.contents,
						sessionId: self.sessionId
					};
					$.ajax({
						url: "/bbs/edit.dox",
						dataType: "json",
						type: "POST",
						data: nparmap,
						success: function (data) {
                            console.log(self.sessionId);
							console.log(data);
							if($("#file1")[0].files.length > 0){
								var form = new FormData();
								console.log($("#file1")[0].files)
								// form.append("file1", $("#file1")[0].files[0]);
								for(let i=0; i<$("#file1")[0].files.length; i++){
									form.append("file1", $("#file1")[0].files[i]);
								}
								form.append("bbsNum", data.bbsNum); // 임시 pk
								console.log(data.bbsNum);
								
							}
                            if (data.result == "success") {
                                alert("데이터 저장");
                                self.upload(form);
                            }else{
                                alert("데이터 저장 실패");
                            }
						}
					});
				},
				upload: function (form) {
					var self = this;
					$.ajax({
						url: "/bbs/fileUpload.dox"
						, type: "POST"
						, processData: false
						, contentType: false
						, data: form
						, success: function (response) {
								alert("파일 저장 성공");
								location.href = "/bbs/list.do";
						}
					});
				}
			},
			mounted: function () {
				// Quill 에디터 초기화
				let self = this;
			}
		});
		app.mount('#app');
	</script>