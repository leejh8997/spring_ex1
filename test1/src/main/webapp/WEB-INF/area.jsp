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
            <select @change="fnSelectGu()" v-model="selectSi">
                <option value="">:: 선택 ::</option>
                <template v-for="item in siList">
                        <option :value="item.si">{{item.si}}</option>

                </template>
            </select>
            <select @change="fnSelectDong()" v-model="selectGu">
                <option value="">:: 선택 ::</option>
                <template v-for="item in guList">
                        <option :value="item.gu">{{item.gu}}</option>
                </template>
            </select>
            <select @change="fnSelectDong()" v-model="selectDong">
                <option value="">:: 선택 ::</option>
                <template v-for="item in dongList">
                    <option :value="item.dong">{{item.dong}}</option>
                </template>
            </select>
        </div>
    </body>

    </html>
    <script>
        const app = Vue.createApp({
            data() {
                return {
                    siList: [],
                    guList: [],
                    dongList: [],
                    selectSi: "",
                    selectGu: "",
                    selectDong: "",
                };
            },
            methods: {
                fnSelectSi() {
                    let self = this;
                    let nparmap = {
                        // siList:self.siList,
                        // selectsi:self.selectsi
                    };
                    $.ajax({
                        url: "/area-si.dox",
                        dataType: "json",
                        type: "POST",
                        data: nparmap,
                        success: function (data) {
                            console.log(data);
                            self.siList = data.siList;
                            
                        }
                    });
                },
                fnSelectGu() {
                    let self = this;
                    // if(){}
                    let nparmap = {
                        selectSi: self.selectSi
                    };
                    $.ajax({
                        url: "/area-gu.dox",
                        dataType: "json",
                        type: "POST",
                        data: nparmap,
                        success: function (data) {
                            console.log(data);
                            self.guList = data.guList;
                            
                        }
                    });
                },
                fnSelectDong() {
                    let self = this;
                    let nparmap = {
                        selectSi: self.selectSi,
                        selectGu: self.selectGu
                    };
                    $.ajax({
                        url: "/area-dong.dox",
                        dataType: "json",
                        type: "POST",
                        data: nparmap,
                        success: function (data) {
                            console.log(data);
                            self.dongList = data.dongList;
                        }
                    });
                }
            },
            mounted() {
                let self = this;
                self.fnSelectSi();
            }
        });
        app.mount('#app');
        function fnApiCall() {
		var xhr = new XMLHttpRequest();
		var url = 'http://apis.data.go.kr/1360000/VilageFcstInfoService_2.0/getUltraSrtNcst'; /*URL*/
		var queryParams = '?' + encodeURIComponent('serviceKey') + '=' + 'NeMca8LnB2QZXZg33oQXeB57k5ehdiUxNjyBzPaMWnixI2RIvxfjH57Vq9lJhGXDLmFabkiEugBKMuDMrN3k5w%3D%3D'; /*Service Key*/
		queryParams += '&' + encodeURIComponent('pageNo') + '='
				+ encodeURIComponent('1'); /**/
		queryParams += '&' + encodeURIComponent('numOfRows') + '='
				+ encodeURIComponent('1000'); /**/
		queryParams += '&' + encodeURIComponent('dataType') + '='
				+ encodeURIComponent('JSON'); /**/
		queryParams += '&' + encodeURIComponent('base_date') + '='
				+ encodeURIComponent('20250225'); /**/
		queryParams += '&' + encodeURIComponent('base_time') + '='
				+ encodeURIComponent('1000'); /**/
		queryParams += '&' + encodeURIComponent('nx') + '='
				+ encodeURIComponent(nx); /**/
		queryParams += '&' + encodeURIComponent('ny') + '='
				+ encodeURIComponent(ny); /**/
		xhr.open('GET', url + queryParams);
		xhr.onreadystatechange = function() {
			if (this.readyState == 4) {
				console.log('Status: ' + this.status + 'nHeaders: '
						+ JSON.stringify(this.getAllResponseHeaders())
						+ 'nBody: ' + this.responseText);
			}
		};

		xhr.send('');
	}
    </script>