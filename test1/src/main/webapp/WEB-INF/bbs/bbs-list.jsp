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
        table,
		tr,
		th,
		td {
			text-align: center;
			border: 2px solid #bbb;
			border-collapse: collapse;
			padding: 5px;
		}

        .index {
			margin-right: 3px;
			text-decoration: none;
		}

		#nowPage {
			font-weight: bold;
			color: rgb(3, 230, 59);
			background-color: #e4e3e3;
		}

		#otherPage {
			color: rgb(48, 48, 48);
		}
    </style>

    <body>
        <div id="app">
            <div>
				<select v-model="searchOption">
					<option value="all">:: 전체 ::</option>
					<option value="title">제목</option>
					<option value="name">작성자</option>
				</select>

				<select @change="fnPageSizeChange" v-model="pageSize">
					<option value="3">3개씩</option>
					<option value="5">5개씩</option>
					<option value="10">10개씩</option>

				</select>

				<input v-model="keyword" @keyup.enter="fnBbsList" placeholder="검색어">
				<button @click="fnBbsList">검색</button>
			</div>
            <table>
                <tr>
                    <th>선택</th>
                    <th>번호</th>
                    <th>제목</th>
                    <th>아이디</th>
                    <th>작성일</th>
                </tr>
                <tr v-for="item in list">
                    <td><input type="radio" name="selectRemove" :value="item.bbsNum" v-model="selectRemove"></td>
                    <td>{{item.bbsNum}}</td>
                    <template v-if="item.hit>=30">
                        <td style="color: red;"><a @click="fnView(item.bbsNum)" style="cursor: pointer;">{{item.title}}</a></td>
                    </template>
                    <template v-else>
                        <td><a @click="fnView(item.bbsNum)" style="cursor: pointer;">{{item.title}}</a></td>
                    </template>
                    <td>{{item.userId}}</td>
                    <td>{{item.cDateTime}}</td>
                </tr>
            </table>
            <button @click="fnRemove">삭제</button>
            <button @click="fnEdit">글쓰기</button>
            <div>
                <div style="margin-left: 200px;">
                    <a href="javascript:;" class="index" @click="fnSetPage(page-1)" v-if="page!=1">	< </a>
                    <a href="javascript:;" class="index" v-for="num in index" @click="fnSetPage(num)">
                        <span v-if="page==num" id="nowPage">{{num}}</span>
                        <span v-else id="otherPage">{{num}}</span>
                    </a>
                    <a href="javascript:;" class="index" @click="fnSetPage(page+1)" v-if="page < index"> > </a>
                </div>
            </div>
        </div>
    </body>

    </html>
    <script>
        const app = Vue.createApp({
            data() {
                return {
                    searchOption:"all",
                    keyword:"",
                    pageSize:3,
                    selectRemove: "",
                    list: [],
                    sessionId: "${sessionId}",
                    index: 0,
					page: 1,
                };
            },
            methods: {
                fnBbsList() {
                    let self = this;
                    let nparmap = {
                        keyword: self.keyword,
						searchOption: self.searchOption,
						pageSize: self.pageSize,
						page: (self.page - 1) * self.pageSize
                    };
                    $.ajax({
                        url: "/bbs/list.dox",
                        dataType: "json",
                        type: "POST",
                        data: nparmap,
                        success: function (data) {
                            console.log(data);
                            // console.log(self.index);
                            // console.log(self.pageSize);
                            // console.log(data.count);
                            self.list = data.list;
                            self.index = Math.ceil(data.count / self.pageSize);
                            // console.log(self.index);
                        }
                    });
                },
                fnEdit() {
                    let self = this;
                    pageChange("/bbs/edit.do", { sessionId: self.sessionId });
                },
                fnRemove(){
                    let self = this;
                    let nparmap = {
                        bbsNum: self.selectRemove
                    };
                    $.ajax({
                        url: "/bbs/remove.dox",
                        dataType: "json",
                        type: "POST",
                        data: nparmap,
                        success: function (data) {
                            console.log(data);
                            console.log(self.selectRemove);
                            alert("삭제되었습니다.");
                            self.fnBbsList();
                        }
                    });
                },
                fnView(bbsNum){
                    pageChange("/bbs/view.do",{bbsNum:bbsNum});
                },
                fnSetPage: function (num) {
					let self = this;
					self.page = num;
					self.fnBbsList();
				},
				fnPageSizeChange: function () {
					let self = this;
					self.page = 1;  
					self.fnBbsList();
				},
            },
            mounted() {
                let self = this;
                self.fnBbsList();
            }
        });
        app.mount('#app');
    </script>