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
        <title>첫번째 페이지</title>
    </head>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f8f8f8;
            padding: 20px;
            text-align: center;
        }

        .product-container {
            background: white;
            padding: 20px;
            border-radius: 10px;
            box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
            max-width: 800px;
            margin: auto;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        /* 왼쪽 영역 (이미지) */
        .image-container {
            width: 50%;
            text-align: center;
        }

        .main-image {
            width: 100%;
            max-height: 300px;
            object-fit: contain;
            border-radius: 10px;
        }

        .sub-images {
            display: flex;
            justify-content: center;
            gap: 10px;
            margin-top: 10px;
        }

        .sub-images img {
            width: 60px;
            height: 60px;
            object-fit: cover;
            cursor: pointer;
            border: 2px solid transparent;
            border-radius: 5px;
            transition: 0.3s;
        }

        .sub-images img:hover {
            border: 2px solid #007bff;
        }

        /* 오른쪽 영역 (구매 버튼, 개수 조절) */
        .info-container {
            width: 45%;
            text-align: left;
        }

        .product-name {
            font-size: 24px;
            font-weight: bold;
            margin-bottom: 10px;
        }

        .product-price {
            font-size: 20px;
            color: #e67e22;
            margin-bottom: 10px;
        }

        .quantity-container {
            display: flex;
            align-items: center;
            gap: 10px;
        }
        .quantity-input {
            width: 40px;
            text-align: center;
            font-size: 16px;
            padding: 5px;
            border: 1px solid #ddd;
            border-radius: 5px;
        }

        .buy-button {
            background-color: #007bff;
            color: white;
            border: none;
            padding: 10px 15px;
            font-size: 18px;
            cursor: pointer;
            border-radius: 5px;
            width: 100%;
        }

        .buy-button:hover {
            background-color: #0056b3;
        }
    </style>

    <body>
        <div id="app">
            <jsp:include page="../common/header.jsp" />
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
                    <div class="product-name">에이스침대 매트리스</div>
                    <div class="product-price">₩987,360</div>

                    <!-- 개수 선택 -->
                    <div class="quantity-container">
                        <label for="quantity">수량:</label>
                        <input type="number" id="quantity" class="quantity-input" value="1" min="1">
                    </div>

                    <!-- 구매 버튼 -->
                    <button class="buy-button">바로 구매</button>
                </div>
            </div>
        </div>
    </body>

    </html>
    <script>
        const app = Vue.createApp({
            data() {
                return {
                    itemNo:"${map.itemNo}",
                    info: [],
                    mainImage: "", // 기본 메인 이미지
                    subImages: [],
                    tempImage: "",
                    quantity: 1,
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
                            for(let i=0; i<data.subImage.length; i++){
                                self.subImages[i] = (data.subImage[i].filePath);
                            }
                            console.log(self.subImages);
                        }
                    });
                }
            },
            mounted() {
                let self = this;
                self.fnProductView();
            }
        });
        app.mount('#app');
    </script>