<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <!DOCTYPE html>
    <html lang="ko">

    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <script src="https://code.jquery.com/jquery-3.7.1.js"
            integrity="sha256-eKhayi8LEQwp4NKxN+CfCh+3qOVUtJn3QNZ0TciWLP4=" crossorigin="anonymous"></script>
        <script src="https://unpkg.com/vue@3/dist/vue.global.js"></script>
        <script src="/js/page-Change.js"></script>
        <link rel="stylesheet" href="../css/product-style.css">
        <title>쇼핑몰 헤더</title>
        
    </head>

    <body>
        <div id="app">
            <jsp:include page="../common/header.jsp" />

            <main>
                <section class="product-list">
                    <!-- 제품 항목 -->
                    <div class="product-item" v-for="item in list">
                        <a href="javascript:;" @click="fnPageChange(item.itemNo)" style="text-decoration: none;">
                            <img :src="item.filePath" alt="제품 1">
                            <h3>{{item.itemName}}</h3>
                            <p>{{item.itemInfo}}</p>
                            <p class="price">{{item.price}}</p>
                        </a>
                    </div>
                    <!-- <div class="product-item">
                    <img src="../img/202526104656272.png" alt="제품 2">
                    <h3>짜장면</h3>
                    <p>중국의 대표적인 면 요리, 짜장면!</p>
                    <p class="price">₩7,500</p>
                </div>
                <div class="product-item">
                    <img src="../img/202526105554262.png" alt="제품 3">
                    <h3>피자</h3>
                    <p>풍부한 치즈가 일품인 피자!</p>
                    <p class="price">₩12,000</p>
                </div> -->

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
                };
            },
            methods: {
                fnProductList() {
                    var self = this;
                    var nparmap = {};
                    $.ajax({
                        url: "/product/list.dox",
                        dataType: "json",
                        type: "POST",
                        data: nparmap,
                        success: function (data) {
                            console.log(data);
                            self.list = data.product;
                            console.log(self.list);
                        }
                    });
                },
                fnPageChange(itemNo){
                    pageChange("/product/view.do",{itemNo: itemNo});
                }
            },
            mounted() {
                var self = this;
                self.fnProductList();
            }
        });
        app.mount('#app');
    </script>