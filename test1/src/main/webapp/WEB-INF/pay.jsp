<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
	<!DOCTYPE html>
	<html>

	<head>
		<meta charset="UTF-8">
		<script src="https://cdn.iamport.kr/v1/iamport.js"></script>
		<script src="https://unpkg.com/vue@3/dist/vue.global.js"></script>
		<title>view 기본 세팅 파일</title>
	</head>
	<style>
	</style>

	<body>
		<div id="app">
			<button @click="fnPayment()">결제</button>
		</div>
	</body>

	</html>
	<script>
		const userCode = "imp14397622";
		IMP.init(userCode);
		const app = Vue.createApp({
			data() {
				return {

				};
			},
			methods: {
				fnPayment() {
					let self = this;
					IMP.request_pay({
						channelKey: "channel-key-bf43e218-5567-4875-96da-3270e1fba054",
						pay_method: "card",
						merchant_uid: "merchant" + new Date().getTime(),
						name: "테스트 결제",
						amount: 100,
						buyer_tel: "010-0000-0000",
					}, function (rsp) { // callback
						if (rsp.success) {
							// 결제 성공 시
							alert("성공");
							console.log(rsp);
						} else {
							// 결제 실패 시
							alert("실패");
						}
					});
				}
			},
			mounted() {

			}
		});
		app.mount('#app');
	</script>