<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <!DOCTYPE html>
    <html lang="ko">

    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <script src="https://code.jquery.com/jquery-3.7.1.js"
            integrity="sha256-eKhayi8LEQwp4NKxN+CfCh+3qOVUtJn3QNZ0TciWLP4=" crossorigin="anonymous"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/vue/3.3.4/vue.global.min.js"></script>
        <script src="/js/page-Change.js"></script>
        <link rel="stylesheet" href="../css/product-style.css">
        <title>쇼핑몰 헤더</title>

    </head>

    <body>
        <jsp:include page="../common/header.jsp" />
        <div id="app">
            <main>
                <div class="board-add">
                    <button @click="fnProductAdd">제품등록</button>
                </div>
                <section class="product-list">
                    <!-- 제품 항목 -->
                    <div class="product-item" v-for="item in list">
                        <a href="javascript:;" @click="fnPageChange(item.itemNo)" style="text-decoration: none;">
                            <img :src="item.filePath" alt="제품 1">
                            <h3>{{item.itemName}}</h3>
                            <p>{{item.itemInfo}}</p>
                            <p class="price">￦ {{item.price}} 원</p>
                        </a>
                    </div>
                </section>

            </main>
        </div>
    </body>

    </html>
    <script>
        const app = Vue.createApp({
            data() {
                return {
                    list: [],
                    sessionId: "${sessionId}",
                    sessionStatus: "${sessionStatus}",
                    code: "",
                };
            },
            methods: {
                fnProductList(keyword) {
                    var self = this;

                    var nparmap = {
                        keyword: keyword
                    };
                    $.ajax({
                        url: "/product/list.dox",
                        dataType: "json",
                        type: "POST",
                        data: nparmap,
                        success: function (data) {
                            console.log(data);
                            self.list = data.product;
                            console.log(keyword);

                        }
                    });
                },
                fnPageChange(itemNo) {
                    pageChange("/product/view.do", { itemNo: itemNo });
                },
                fnProductAdd() {
                    location.href = "/product/add.do";
                },
                fnKakao() {
                    var self = this;
                    var nparmap = {
                        code: self.code
                    };
                    $.ajax({
                        url: "/kakao.dox",
                        dataType: "json",
                        type: "POST",
                        data: nparmap,
                        success: function (data) {
                            console.log(data);

                        }
                    });
                }
            },
            mounted() {
                var self = this;
                emitter.on('call-main-function', (data) => {
                    self.fnProductList(data.keyword);
                });
                const queryParams = new URLSearchParams(window.location.search);
                self.code = queryParams.get('code') || '';
                console.log(self.code);
                if(self.code != ""){
                    self.fnKakao();
                }
                
                self.fnProductList();
            }
        });
        app.mount('#app');
    </script>