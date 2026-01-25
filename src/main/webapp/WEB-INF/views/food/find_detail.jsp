<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="/css/overlay.css">
</head>
<body>
	<section class="breadcrumb-section set-bg"
		data-setbg="../img/breadcrumb.jpg">
		<div class="container">
			<div class="row">
				<div class="col-lg-12 text-center">
					<div class="breadcrumb__text">
						<h2>맛집</h2>
						<div class="breadcrumb__option">
							<span>상세보기</span>
						</div>
					</div>
				</div>
			</div>
		</div>
	</section>
	<section class="product-details spad" id="food_detail">
		<div class="container">
			<div class="row" style="margin: 0px auto">
				<%-- 상세보기 --%>
				<table class="table">
					<tr>
						<td width=30% class="text-center" rowspan="8"><img
							:src="store.food_detail.poster"
							style="width: 270px; height: 300px"></td>
						<td colspan="2">
							<h3>
								{{store.food_detail.name}}&nbsp; <span style="color: orange;">{{store.food_detail.score}}</span>
							</h3>
						</td>
					</tr>
					<tr>
						<td width=10% class="text-center">주소</td>
						<td width=60% class="text-left">
							{{store.food_detail.address}}</td>
					</tr>
					<tr>
						<td width=10% class="text-center">전화</td>
						<td width=60% class="text-left">{{store.food_detail.phone}}</td>
					</tr>
					<tr>
						<td width=10% class="text-center">음식종류</td>
						<td width=60% class="text-left">{{store.food_detail.type}}</td>
					</tr>
					<tr>
						<td width=10% class="text-center">영업시간</td>
						<td width=60% class="text-left">{{store.food_detail.time}}</td>
					</tr>
					<tr>
						<td width=10% class="text-center">주차</td>
						<td width=60% class="text-left">
							{{store.food_detail.parking}}</td>
					</tr>
					<tr>
						<td width=10% class="text-center">가격대</td>
						<td width=60% class="text-left">{{store.food_detail.price}}</td>
					</tr>
					<tr>
						<td width=10% class="text-center">테마</td>
						<td width=60% class="text-left">{{store.food_detail.theme}}</td>
					</tr>
				</table>
				<table class="table">
					<tr>
						<td>{{store.food_detail.content}}</td>
					</tr>
					<tr>
						<td class="text-right">
							<button class="btn-xs btn-warning">예약</button>
							<button class="btn-xs btn-info"
								onclick="javascript:history.back()">목록</button>
						</td>
					</tr>
				</table>
			</div>
			<%-- 지도  --%>
			<div class="row" style="margin: 20px auto">
				<div id="map" style="width: 100%; height: 350px;"></div>
			</div>
			<%-- 댓글  --%>
			<div class="row" style="margin: 20px auto">
				<table class="table">
					<tr>
						<td>
							<table class="table" v-for="rvo in store.reply">
								<tr>
									<td class="text-left">◑{{rvo.name}} {{rvo.dbday}}</td>
									<td class="text-right"><a href="#"
										class="btn btn-xs btn-info" v-if="store.sessionId===rvo.id">수정</a>
										<a href="#" class="btn btn-xs btn-success"
										v-if="store.sessionId===rvo.id">삭제</a></td>
								</tr>
								<tr>
									<td colspan="2"><pre
											style="white-space: pre-wrap; background-color: white;">{{rvo.msg}}</pre>
									</td>
								</tr>
							</table>
						</td>
					</tr>
				</table>
				<c:if test="${sessionScope.id!=null }">
					<table class="table">
						<tr>
							<td class="text-center"><textarea rows="4" cols="60"
									style="float: left" ref="msgRef" v-model="store.msg"></textarea>
								<button class="btn-success"
									style="width: 80px; height: 100px; float: left"
									@click="store.foodReplyInsert(fno,msgRef)">댓글쓰기</button></td>
						</tr>
					</table>
				</c:if>
			</div>
		</div>

	</section>
	<script src="/foodjs/foodStore.js"></script>
	<script>
     const {createApp,onMounted,ref,watch} = Vue
     const {createPinia} = Pinia
     const app=createApp({
    	 setup()
    	 {
    		 const store=useFoodStore()
    		 const params=new URLSearchParams(location.search)
    		 const fno=params.get('fno')
    		 const msgRef=ref(null)
    		 
    		 onMounted(()=>{
    			 store.foodReplyData(fno)
    			 store.foodDetailData(fno)
    			 
    		 })
    		 watch(
				  () => store.food_detail,
				  (vo) => {
				    if (!vo || !vo.address) return
				
				    if (window.kakao && window.kakao.maps) {
				      initMap(vo)
				    } else {
				      addScript(vo)
				    }
				  },
				  { deep: true }
				)
    		 
    		 const initMap=(vo)=>{
    			 console.log(vo)
    			 var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
    			    mapOption = { 
    			        center: new kakao.maps.LatLng(37.502, 127.026581), // 지도의 중심좌표
    			        level: 4 // 지도의 확대 레벨
    			    };

    			var map = new kakao.maps.Map(mapContainer, mapOption); // 지도를 생성합니다

    			// 커스텀 오버레이에 표시할 내용입니다     
    			// HTML 문자열 또는 Dom Element 입니다 
    			var content = '<div class="overlaybox">' +
    			    '    <div class="boxtitle">'+vo.name+'</div>' +
    			    '    <div class="first" style="background-image: url('+vo.poster+');background-size: cover;background-repeat: no-repeat;background-position: center;position:relative;width:175px;height:100px;margin-bottom:8px;">' +
    			    '        <div class="triangle text">'+vo.score+'</div>' +
    			    '        <div class="movietitle text">'+vo.address+'</div>' +
    			    '    </div>' +
    			    '</div>';

    			// 커스텀 오버레이가 표시될 위치입니다 
    			var position = new kakao.maps.LatLng(37.49887, 127.026581);  

    			// 커스텀 오버레이를 생성합니다
    			var customOverlay = new kakao.maps.CustomOverlay({
    			    position: position,
    			    content: content,
    			    xAnchor: 0.3,
    			    yAnchor: 0.91
    			});

    			// 커스텀 오버레이를 지도에 표시합니다
    			customOverlay.setMap(map);
    		 }
    		 const addScript=(vo)=>{
    			 const script = document.createElement("script")
    			  script.onload = () => kakao.maps.load(() => initMap(vo))
    			 script.src="http://dapi.kakao.com/v2/maps/sdk.js?autoload=false&appkey=72fa81817487692b6dc093004af97650&libraries=services"
    			 document.head.appendChild(script)
    		 }
    		 
    		 return {
				 store,
				 msgRef,
				 fno
			 }
    	 }
    		 
     })
     app.use(createPinia())
     app.mount("#food_detail")
    </script>
</body>
</html>