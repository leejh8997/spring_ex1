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
    </style>

    <body>
        <div id="app">
            <input type="file" id="file1" name="file1">
            <button @click="fnAdd">저장</button>
        </div>
    </body>

    </html>
    <script>
        const app = Vue.createApp({
            data() {
                return {

                };
            },
            methods: {
                upload: function (form) {
                    let self = this;
                    $.ajax({
                        url: "/fileUpload.dox"
                        , type: "POST"
                        , processData: false
                        , contentType: false
                        , data: form
                        , success: function (response) {

                        }
                    });
                },
                fnAdd: function () {
                    var self = this;
                    var form = new FormData();
                    form.append("file1", $("#file1")[0].files[0]);
                    form.append("idx", 1234); // 임시 pk
                    self.upload(form);
                }
            },
            mounted() {
                let self = this;
            }
        });
        app.mount('#app');
    </script>