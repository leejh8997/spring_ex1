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
        <script src="https://cdn.jsdelivr.net/npm/mitt/dist/mitt.umd.js"></script>
        <title>쇼핑몰 헤더</title>
        <link rel="stylesheet" href="../css/header.css">
        <style>

        </style>
    </head>

    <body>
        <div id="header">
            <header>
                <!-- 로고 -->
                <div class="logo">
                    <a href="/product/list.do">
                        <img src="https://mblogthumb-phinf.pstatic.net/MjAyMjEyMTVfMTg4/MDAxNjcxMDkwNTc1ODM5.72xNKr7Hvw77FSfnoIFYYCoRneDoxXIH5jqXXA3T5v8g.5rfVNPZ9_DVsOO4sDPenHZ7L_e6kYh1SHUkzqRjjnL4g.PNG.y2kwooga/%EB%84%A4%EC%9D%B4%EB%B2%84_AI-18.png?type=w800"
                            alt="쇼핑몰 로고">
                    </a>
                </div>

                <!-- 네비게이션 메뉴 -->
                <nav>
                    <ul>
                        <li class="dropdown" v-for="depth in mainList">
                            <a class="link" href="#">{{depth.menuName}}</a>
                            <ul v-if="depth.subCnt != 0" class="dropdown-menu">
                                <template v-for="depth2 in subList">
                                    <li v-if="depth.menuType == depth2.menuType">
                                        <a href="depth2.menuUrl">{{depth2.menuName}}</a>
                                    </li>
                                </template>
                            </ul>
                        </li>
                    </ul>
                </nav>

                <!-- 검색 바 -->
                <div class="search-bar">
                    <input v-model="keyword" type="text" @keyup.enter="fnSearch" placeholder="상품을 검색하세요...">
                    <button @click="fnSearch">검색</button>
                </div>

                <!-- 로그인 버튼 -->
                <div class="btn-group">
                    <div class="board-btn">
                        <a href="/board/list.do"><button>게시판</button></a>
                    </div>
                    <template v-if="sessionId == ''">
                        <div class="login-btn">
                            <a href="/member/login.do"><button>로그인</button></a>
                        </div>
                    </template>
                    <template v-else>
                        <div class="login-btn">
                            <a @click="fnLogout"><button>로그아웃</button></a>
                        </div>
                    </template>
                </div>
            </header>
        </div>
    </body>

    </html>
    <script>
        const emitter = mitt();

        const header = Vue.createApp({
            data() {
                return {
                    mainList: [],
                    subList: [],
                    keyword: "",
                    sessionId: "${sessionId}",
					sessionStatus: "${sessionStatus}",
                };
            },
            methods: {
                fnMenu() {
                    let self = this;
                    let nparmap = {
                    };
                    $.ajax({
                        url: "/menu.dox",
                        dataType: "json",
                        type: "POST",
                        data: nparmap,
                        success: function (data) {
                            console.log(data);
                            console.log("sessionId ===>" + self.sessionId);
                            self.mainList = data.mainList;
                            self.subList = data.subList;
                        }
                    });
                },
                fnSearch(){
                    // app._component.methods.fnSearch(this.keyword);
                    emitter.emit('call-main-function', {keyword : this.keyword});
                        
                    
                },
                fnLogout(){
                    let self = this;
                    let nparmap = {
                    };
                    $.ajax({
                        url: "/member/logout.dox",
                        dataType: "json",
                        type: "POST",
                        data: nparmap,
                        success: function (data) {
                            console.log(data);
                            location.href="/product/list.do";
                        }
                    });
                }
            },
            mounted() {
                var self = this;
                self.fnMenu();
            }
        });
        header.mount('#header');
    </script>