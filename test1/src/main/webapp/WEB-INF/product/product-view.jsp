<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <!DOCTYPE html>
    <html>

    <head>
        <meta charset="UTF-8">
        <script src="https://code.jquery.com/jquery-3.7.1.js"
            integrity="sha256-eKhayi8LEQwp4NKxN+CfCh+3qOVUtJn3QNZ0TciWLP4=" crossorigin="anonymous"></script>
        <script src="https://unpkg.com/vue@3/dist/vue.global.js"></script>
        <script src="/js/page-Change.js"></script>
        <link rel="stylesheet" href="../css/product-style.css">
        <link rel="stylesheet" href="../css/view.css">
        <script src="https://cdn.iamport.kr/v1/iamport.js"></script>
        <title>첫번째 페이지</title>
    </head>
    <style>

    </style>

    <body>
        <jsp:include page="../common/header.jsp" />
        <div id="app">
            <div class="product-container">

                <!-- 왼쪽 (이미지) -->
                <div class="image-container">
                    <img :src="mainImage" alt="메인 이미지" class="main-image">
                    <div class="sub-images">
                        <img v-for="(image, index) in subImages" :key="index" :src="image" alt="서브 이미지"
                            @click="changeImage(index)">
                    </div>
                </div>

                <!-- 오른쪽 (구매 정보) -->
                <div class="info-container">
                    <div class="product-name">{{info.itemName}}</div>
                    <p>제품 설명 : {{info.itemInfo}}</p>
                    <div class="product-price">￦ {{info.price}} 원</div>

                    <!-- 개수 선택 -->
                    <div class="quantity-container">
                        <label for="quantity">수량:</label>
                        <input type="number" v-model="quantity" class="quantity-input" min="1">개
                    </div>

                    <!-- 구매 버튼 -->
                    <button @click="fnPayment" class="buy-button">바로 구매</button>
                </div>
            </div>
        </div>
    </body>

    </html>
    <script>
        const userCode = "imp14397622";
        IMP.init(userCode);
        const app = Vue.createApp({
            data() {
                return {
                    itemNo: "${map.itemNo}",
                    info: {},
                    mainImage: "", // 기본 메인 이미지
                    subImages: [],
                    tempImage: "",
                    quantity: 1,
                    userId: "${sessionId}",
                    phone: "${sessionPhone}",

                };
            },
            methods: {
                changeImage(index) {
                    this.tempImage = this.mainImage;
                    this.mainImage = this.subImages[index]; // 클릭한 이미지로 변경
                    this.subImages[index] = this.tempImage;

                },
                fnProductView() {
                    let self = this;
                    let nparmap = {
                        itemNo: self.itemNo

                    };
                    $.ajax({
                        url: "/product/view.dox",
                        dataType: "json",
                        type: "POST",
                        data: nparmap,
                        success: function (data) {
                            console.log(data);
                            self.info = data.info;
                            self.mainImage = data.info.filePath;
                            for (let i = 0; i < data.subImage.length; i++) {
                                self.subImages[i] = (data.subImage[i].filePath);
                            }
                            console.log(data.subImage);
                        }
                    });
                },
                fnPayment() {
                    let self = this;
                    if (!self.userId || self.userId.trim() == "") {
                        alert("로그인 후 사용하십시오.");
                        location.href = "/member/login.do";
                        return;
                    }
                    IMP.request_pay({
                        channelKey: "channel-key-bf43e218-5567-4875-96da-3270e1fba054",
                        pay_method: "card",
                        merchant_uid: "merchant" + new Date().getTime(),
                        name: self.info.itemName + " 결제",
                        amount: (self.info.price * self.quantity),
                        buyer_tel: self.phone,
                        buyer_email: "test@test.com",

                    }, function (rsp) { // callback
                        if (rsp.success) {
                            // 결제 성공 시
                            alert("성공");
                            console.log(rsp);
                            let nparmap = {
                                itemNo: self.itemNo,
                                orderId: rsp.merchant_uid,
                                userId: self.userId,
                                amount: (self.info.price * self.quantity),
                                buyerTel: self.phone,
                                productName: self.info.itemName + "결제",
                            };
                            $.ajax({
                                url: "/product/payHistory.dox",
                                dataType: "json",
                                type: "POST",
                                data: nparmap,
                                success: function (data) {
                                    alert("결제 정보 저장");
                                }
                            });
                        } else {
                            // 결제 실패 시
                            console.log(rsp);



                            console.log(self.itemNo);
                            console.log((self.info.price * self.quantity));
                            console.log(self.userId);
                            console.log(rsp.merchant_uid);

                            alert("실패");
                        }
                    });
                },
            },
            mounted() {
                let self = this;
                self.fnProductView();
            }
        });
        app.mount('#app');
    </script>