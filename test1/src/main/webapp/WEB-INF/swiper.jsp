<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <!DOCTYPE html>
    <html>

    <head>
        <meta charset="UTF-8">
        <script src="https://code.jquery.com/jquery-3.7.1.js"
            integrity="sha256-eKhayi8LEQwp4NKxN+CfCh+3qOVUtJn3QNZ0TciWLP4=" crossorigin="anonymous"></script>
        <script src="https://unpkg.com/vue@3/dist/vue.global.js"></script>
        <script src="/js/page-Change.js"></script>
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/swiper@8.4.7/swiper-bundle.min.css" />
        <script src="https://cdn.jsdelivr.net/npm/swiper@8.4.7/swiper-bundle.min.js"></script>
        <script src="/js/Swiper.js"></script>
        <title>첫번째 페이지</title>
    </head>
    <style>
        .swiper {
            width: 100%;
            max-width: 600px;
            /* 원하는 크기로 조정 */
            height: 400px;
            /* 원하는 크기로 조정 */
        }

        .swiper-slide {
            display: flex;
            justify-content: center;
            align-items: center;
        }

        .swiper-slide img {
            width: 100%;
            height: 100%;
            object-fit: cover;
            /* 이미지가 찌그러지지 않도록 설정 */
            border-radius: 10px;
            /* 둥근 모서리 효과 */
        }
    </style>

    <body>

        <div id="app">
            <div class="swiper">
                <div class="swiper-wrapper">
                    <div class="swiper-slide"><img class="swiper-slide" src="../img/기계식키보드.jpg"></div>
                    <div class="swiper-slide"><img class="swiper-slide" src="../img/기계식키보드3.jpg"></div>
                    <div class="swiper-slide"><img class="swiper-slide" src="../img/기계식키보드2.jpg"></div>
                </div>
                <div class="swiper-pagination"></div>
                <div class="swiper-button-next"></div>
                <div class="swiper-button-prev"></div>
            </div>
        </div>
    </body>

    </html>
    <script>
        const app = Vue.createApp({
            data() {
                return {
                    swiper: null,
                };
            },
            methods: {
                fn() {
                    let self = this;
                    let nparmap = {

                    };
                    $.ajax({
                        url: "member/list.dox",
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
                let self = this;

                self.swiper = new Swiper(".swiper", {
                    spaceBetween: 30,
                    centeredSlides: true,
                    effect: 'fade',
                    autoplay: {
                        delay: 1000,

                    },
                    pagination: {
                        el: ".swiper-pagination",
                        clickable: true,
                    },
                    navigation: {
                        nextEl: ".swiper-button-next",
                        prevEl: ".swiper-button-prev",
                    },
                });

            }
        });
        app.mount('#app');
    </script>