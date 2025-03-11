<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <!DOCTYPE html>
    <html>

    <head>
        <meta charset="UTF-8">
        <script src="https://code.jquery.com/jquery-3.7.1.js"
            integrity="sha256-eKhayi8LEQwp4NKxN+CfCh+3qOVUtJn3QNZ0TciWLP4=" crossorigin="anonymous"></script>
        <script src="https://unpkg.com/vue@3/dist/vue.global.js"></script>
        <script src="https://cdn.iamport.kr/v1/iamport.js"></script>
        <script src="https://cdn.portone.io/v2/browser-sdk.js"></script>
        <script src="https://cdn.iamport.kr/js/iamport.payment-1.2.1.js"></script>
        <script src="https://cdn.iamport.kr/js/iamport.payment-1.2.0.js"></script>
        <script src="https://cdn.iamport.kr/js/iamport.payment-1.1.8.js"></script>

        <title>view 기본 세팅 파일</title>
    </head>
    <style>
    </style>

    <body>
        <div id="app">
            <button @click="fnAuth()">인증</button>
        </div>
    </body>

    </html>
    <script>
        const userCode = "imp04033346";
        IMP.init(userCode);
        const app = Vue.createApp({
            data() {
                return {

                };
            },
            methods: {
                fnAuth() {
                    IMP.certification({
                        channelKey: "channel-key-4ec74848-a239-49af-803e-b05b425dda7f",
                        merchant_uid: "merchant_" + new Date().getTime(),
                    }, function (rsp) {
                        if (rsp.success) {
                            alert("인증 성공");
                            console.log(rsp);
                        } else {
                            alert(rsp.error_msg);
                            console.log(rsp);
                        }
                    });
                }
            },
            mounted() {

            }
        });
        app.mount('#app');
    </script>