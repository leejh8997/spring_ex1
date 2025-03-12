<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <!DOCTYPE html>
    <html>

    <head>
        <meta charset="UTF-8">
        <title>첫번째 페이지</title>
    </head>
    <style>
    </style>

    <body>
        <jsp:include page="../common/header.jsp" />
        <div id="app">

            <div>제품명 : <input v-model="itemName"> </div>
            <div>
                <input type="file" id="file1" name="file1" accept=".jpg, .png" multiple> <!--multiple 추가하면 여러개 가능-->
            </div>
            <div>가격 : <input v-model="price"> </div>
            <div>설명 : <input v-model="itemInfo"> </div>
            <button @click="fnProductAdd">제품 추가</button>

        </div>
    </body>

    </html>
    <script>
        const app = Vue.createApp({
            data() {
                return {
                    itemName: "",
                    price: "",
                    itemInfo: "",
                };
            },
            methods: {
                fnProductAdd() {
                    let self = this;
                    let nparmap = {
                        itemName: self.itemName,
                        price: parseInt(self.price),
                        itemInfo: self.itemInfo,
                    };
                    $.ajax({
                        url: "/product/add.dox",
                        dataType: "json",
                        type: "POST",
                        data: nparmap,
                        success: function (data) {
                            console.log(data.itemNo);
                            if($("#file1")[0].files.length > 0){
								var form = new FormData();
								console.log($("#file1")[0].files)
								// form.append("file1", $("#file1")[0].files[0]);
								for(let i=0; i<$("#file1")[0].files.length; i++){
									form.append("file1", $("#file1")[0].files[i]);
								}
								form.append("itemNo", data.itemNo); // 임시 pk
								self.upload(form);
							}else{
								alert("다시 시도해주세요.");
							}

                        }
                    });
                },
                upload: function (form) {
					var self = this;
					$.ajax({
						url: "/product/fileUpload.dox"
						, type: "POST"
						, processData: false
						, contentType: false
						, data: form
						, success: function (response) {
								alert("저장");
								location.href = "/product/list.do";
						}
					});
				}
            },
            mounted() {
                let self = this;
            }
        });
        app.mount('#app');
    </script>