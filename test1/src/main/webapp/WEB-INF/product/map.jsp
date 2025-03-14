<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
	<!DOCTYPE html>
	<html>

	<head>
		<meta charset="UTF-8">
		<script src="https://code.jquery.com/jquery-3.7.1.js"
			integrity="sha256-eKhayi8LEQwp4NKxN+CfCh+3qOVUtJn3QNZ0TciWLP4=" crossorigin="anonymous"></script>
		<script src="https://unpkg.com/vue@3/dist/vue.global.js"></script>
		<script src="/js/page-Change.js"></script>
		<script type="text/javascript"
        src="//dapi.kakao.com/v2/maps/sdk.js?appkey=5e03846a5bae385cef3b2da33124bd8d&libraries=services"></script>
		<title>Kakao 지도 시작하기</title>
	</head>
	<style>
	</style>

<body>
    <div id="app">
        <select v-model="category" @change="fnSearch" style="margin-bottom : 20px; padding:5px">
            <option value="">:: 선택 ::</option>
            <option value="MT1">대형마트</option>
            <option value="CS2">편의점</option>
            <option value="PS3">어린이집, 유치원</option>
            <option value="SC4">학교</option>
            <option value="AC5">학원</option>
            <option value="PK6">주차장</option>
            <option value="OL7">주유소, 충전소</option>
            <option value="SW8">지하철역</option>
            <option value="BK9">은행</option>
            <option value="CT1">문화시설</option>
            <option value="AG2">중개업소</option>
            <option value="PO3">공공기관</option>
            <option value="AT4">관광명소</option>
            <option value="AD5">숙박</option>
            <option value="FD6">음식점</option>
            <option value="CE7">카페</option>
            <option value="HP8">병원</option>
            <option value="PM9">약국</option>
          </select>
        <div id="map" style="width:500px;height:400px;"></div>

    </div>
</body>

<script>
    const app = Vue.createApp({
        data() {
            return {
                map: null,
                infowindow: null,
                placesService: null,
                markers: [],  // 지도에 표시된 마커들을 저장할 배열
                category : ""
            };
        },
        methods: {
            fnSearch() {
                // 기존 마커 삭제
                this.removeMarkers();
                this.searchPlaces(this.category);
            },
            // 장소 검색 후 마커 표시 함수
            searchPlaces(category) {
                // 카테고리로 장소를 검색
                this.placesService.categorySearch(category, this.placesSearchCB, { useMapBounds: true });
            },

            // 카테고리 검색 콜백 함수
            placesSearchCB(data, status, pagination) {
                if (status === kakao.maps.services.Status.OK) {
                    // 검색된 장소들을 마커로 표시
                    data.forEach(place => this.displayMarker(place));
                }
            },

            // 마커를 표시하는 함수
            displayMarker(place) {
                const marker = new kakao.maps.Marker({
                    map: this.map,
                    position: new kakao.maps.LatLng(place.y, place.x)
                });

                // 표시된 마커를 배열에 추가
                this.markers.push(marker);

                kakao.maps.event.addListener(marker, 'click', () => {
                    // 마커 클릭 시 인포윈도우 표시
                    this.infowindow.setContent('<div style="padding:5px;font-size:12px;">' + place.place_name + '</div>');
                    this.infowindow.open(this.map, marker);
                });
            },

            // 지도에 표시된 모든 마커를 삭제하는 함수
            removeMarkers() {
                for (let i = 0; i < this.markers.length; i++) {
                    this.markers[i].setMap(null);  // 마커를 지도에서 제거
                }
                this.markers = [];  // 마커 배열 초기화
            }
        },
        mounted() {
            var container = document.getElementById('map');
            var options = {
                center: new kakao.maps.LatLng(37.566826, 126.9786567),
                level: 3
            };

            this.map = new kakao.maps.Map(container, options); // 지도 생성
            this.infowindow = new kakao.maps.InfoWindow({ zIndex: 1 }); // 인포윈도우 생성
            this.placesService = new kakao.maps.services.Places(this.map); // 장소 서비스 객체 생성

            // 처음에는 기본 카테고리로 장소 검색
            // this.searchPlaces('BK9');
        }
    });

    app.mount('#app');
</script>

</html>