<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
	<!DOCTYPE html>
	<html>

	<head>
		<meta charset="UTF-8">
		<script src="https://code.jquery.com/jquery-3.7.1.js"
			integrity="sha256-eKhayi8LEQwp4NKxN+CfCh+3qOVUtJn3QNZ0TciWLP4=" crossorigin="anonymous"></script>
		<script src="https://unpkg.com/vue@3/dist/vue.global.js"></script>
		<script src=""></script>
		<title>첫번째 페이지</title>
	</head>
	<style>
	</style>

	<body>
		<div id="app">
			<div>
				아이디 :
				<input v-model="userId">
				<button @click="fnCheck(userId)">중복체크</button>
			</div>
			<div>
				비밀번호 :
				<input v-model="pwd">
			</div>
			<div>
				재확인 :
				<input v-model="pwd2">
			</div>
			<div>
				이름 :
				<input v-model="userName">
			</div>
			<div>
				주소 :
				<input v-model="addr">
				<button @click="fnSearchAddr()">주소검색</button>
			</div>

			<div>
				번호 :
				<input v-model="phoneNum" placeholder="번호입력">
				<!-- <button @click="fnSmsAuth()">문자인증</button> -->
				<button @click="authCheckFlg = !authCheckFlg">문자인증</button>
			</div>
			<div v-if="authFlg">
				<div>
					인증번호 :
					<input v-model="authInputNum" :placeholder="timer">
					<button @click="fnNumAuth()">인증</button>
				</div>
				<div v-if="authCheckFlg" style="color: red;">
					문자인증완료
				</div>
			</div>

			<div>
				권한 :
				<input type="radio" name="status" value="C" v-model="status"> 일반
				<input type="radio" name="status" value="A" v-model="status"> 관리자
			</div>
			<div>
				<button @click="fnJoin()">가입</button>
			</div>
		</div>
	</body>

	</html>
	<script>
		function jusoCallBack(roadFullAddr, roadAddrPart1, addrDetail, roadAddrPart2, engAddr, jibunAddr, zipNo, admCd, rnMgtSn, bdMgtSn, detBdNmList, bdNm, bdKdcd, siNm, sggNm, emdNm, liNm, rn, udrtYn, buldMnnm, buldSlno, mtYn, lnbrMnnm, lnbrSlno, emdNo) {
			window.vueObj.fnResult(roadFullAddr, roadAddrPart1, addrDetail, engAddr);
		}
		const app = Vue.createApp({
			data() {
				return {
					userId: "",
					pwd: "",
					pwd2: "",
					userName: "",
					addr: "",
					status: "A",
					phoneNum: "",
					authNum: "", // 서버에서 만든 랜덤숫자
					authInputNum: "", // 사용자가 문자로 받고 입력한 숫자
					authFlg: false, //인증번호발송여부
					authCheckFlg: false, //인증성공여부
					idCheckFlg: false, //중복체크여부
					timer: "",
					count: 5,
					intervalId: null
				};
			},
			methods: {
				fnJoin() {
					let self = this;
					if (self.pwd != self.pwd2) {
						alert("비밀번호가다릅니다.");
					}
					if (!self.authCheckFlg || !self.idCheckFlg) {
						alert("중복체크 및 번호인증 모두 해주세요.");
						return;
					}
					if(self.phoneNum.length != 11){
						alert("전화번호는 11자리입니다. ex)01012345678");
						return;
					}
					let nparmap = {
						userId: self.userId,
						pwd: self.pwd,
						userName: self.userName,
						addr: self.addr,
						status: self.status
					};
					$.ajax({
						url: "/member/add.dox",
						dataType: "json",
						type: "POST",
						data: nparmap,
						success: function (data) {
							console.log(data);
							alert("가입되었습니다.");
							location.href = "/member/login.do";
						}
					});
				},
				fnCheck(userId) {
					let self = this;
					if (self.userId == "") {
						alert("아이디를 입력해주세요.");
					}
					let nparmap = {
						userId: self.userId
					};
					$.ajax({
						url: "/member/check.dox",
						dataType: "json",
						type: "POST",
						data: nparmap,
						success: function (data) {
							if (data.count == 0) {
								alert("사용가능");
								self.idCheckFlg = true;
							} else {
								alert("사용 불가능");
								self.idCheckFlg = false;
							}
						}
					});

				},
				fnSearchAddr() {
					window.open("/member/addr.do", "addr", "width=500 height=500")
				},
				fnResult: function (roadFullAddr, roadAddrPart1, addrDetail, engAddr) {
					console.log(roadFullAddr);
					console.log(roadAddrPart1);
					console.log(addrDetail);
					console.log(engAddr);
					this.addr = roadFullAddr;
				},
				fnSmsAuth: function () {
					let self = this;					
					let nparmap = {
						phoneNum: self.phoneNum
					};
					$.ajax({
						url: "/send-one",
						dataType: "json",
						type: "POST",
						data: nparmap,
						success: function (data) {
							console.log(data);
							if(data.response.statusCode == 2000){
								self.authNum = data.ranStr;
								self.authFlg = true;
								self.authCheckFlg = false;
								alert("문자발송완료!");
								setInterval(self.fnTimer,1000);
							} else{
								alert("잠시 후 다시 시도해주세요.");
							}
						}
					});
				},
				fnNumAuth: function () {
					if (this.authNum == this.authInputNum) {
						alert("인증에 성공했습니다.");
						this.authCheckFlg = true;
					} else {
						alert("인증번호를 확인해주십시오");
					}
				},
				fnTimer: function () {
					let self = this;
					let min = "";
					let sec = "";
					min = parseInt(self.count / 60);
					sec = parseInt(self.count % 60);
					min = min < 10 ? "0" + min : min;
					sec = sec < 10 ? "0" + sec : sec;
					self.timer = min + ":" + sec;
					self.count--;
					if (self.count < 0) {
						self.count=180;
						self.authFlg = false;
						clearInterval(self.intervalId);
						alert("다시 인증번호를 발급받으세요.");
						return;
					}
				}
			},
			mounted() {
				let self = this;
				window.vueObj = this;
			}
		});
		app.mount('#app');
	</script>