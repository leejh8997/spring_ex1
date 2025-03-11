<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <!DOCTYPE html>
    <html>

    <head>
        <meta charset="UTF-8">
        <script src="https://code.jquery.com/jquery-3.7.1.js"
            integrity="sha256-eKhayi8LEQwp4NKxN+CfCh+3qOVUtJn3QNZ0TciWLP4=" crossorigin="anonymous"></script>
        <script src="https://unpkg.com/vue@3/dist/vue.global.js"></script>
        <script src="/js/page-Change.js"></script>
        <script src="https://cdn.iamport.kr/v1/iamport.js"></script>
        <title>첫번째 페이지</title>
    </head>
    <style>
    </style>

    <body>
        <div id="app">
            <div v-if="!authFlg">
                아이디:<input v-model="userId">
                <button @click="fnAuth">인증</button>
            </div>
            <div v-else>
                <div>
                    새 비밀번호 : <input v-model="pwd1">
                </div>
                <div>
                    비밀번호 확인 : <input v-model="pwd2">
                </div>
                <div>
                    <button @click="fnChangePwd">변경</button>
                </div>
            </div>
        </div>
    </body>

    </html>
    <script>
        const userCode = "imp04033346";
        IMP.init(userCode);
        const app = Vue.createApp({
            data() {
                return {
                    userId: "",
                    authFlg: false,
                    pwd1: self.pwd1,
                    pwd2: self.pwd2,
                };
            },
            methods: {
                fnAuth() {
                    let self = this;
                    let nparmap = {
                        userId: self.userId
                    };
                    $.ajax({
                        url: "/member/check.dox",
                        dataType: "json",
                        type: "POST",
                        data: nparmap,
                        success: function (data) {
                            console.log(data);
                            if (data.count == 0) {
                                alert("없는 아이디입니다.");
                                return;
                            } else {
                                IMP.certification({
                                    channelKey: "channel-key-4ec74848-a239-49af-803e-b05b425dda7f",
                                    merchant_uid: "merchant_" + new Date().getTime(),
                                }, function (rsp) {
                                    if (rsp.success) {
                                        alert("인증 성공");
                                        console.log(rsp);
                                        self.authFlg = true;
                                    } else {
                                        alert(rsp.error_msg);
                                        console.log(rsp);
                                    }
                                });
                            }
                        }
                    });
                },
                fnChangePwd() {
                    let self = this;
                    let nparmap = {
                        pwd1: self.pwd1,
                        pwd2: self.pwd2,
                        userId: self.userId
                    };
                    if (self.pwd1 != self.pwd2) {
                        alert("비밀번호가 다릅니다.");
                        return;
                    } else if (self.pwd1 == "" || self.pwd1 == null) {
                        alert("빈 값은 사용할 수 없습니다.");
                        return;
                    }
                    $.ajax({
                        url: "/member/reset-pwd.dox",
                        dataType: "json",
                        type: "POST",
                        data: nparmap,
                        success: function (data) {
                            console.log(data);
                            if (data.result == "success") {
                                alert("변경완료");
                                location.href = "/member/login.do";
                            } else {
                                alert("변경실패");
                            }
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