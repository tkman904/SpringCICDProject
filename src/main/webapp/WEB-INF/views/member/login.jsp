<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%--
	login
	| Spring Security
	| JWT
	| kakao 로그인 / google 로그인
	--------------------------
	Back-End
	=> 알림 : 카프카
	=> 실시간 : websocket / batch => Git Action / docker / docker-compose
									JenKins
	---------------------------
	MSA + React => 연습 : kube
 --%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
    <!-- Breadcrumb Section Begin -->
    <section class="breadcrumb-section set-bg" data-setbg="/img/breadcrumb.jpg">
        <div class="container">
            <div class="row">
                <div class="col-lg-12 text-center">
                    <div class="breadcrumb__text">
                        <h2>회원</h2>
                        <div class="breadcrumb__option">
                        	<span>로그인</span>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>
    <!-- Breadcrumb Section End -->
    
    <!-- Product Details Section Begin -->
    <section class="product-details spad" id="member_login">
    	<div class="container">
	    	<div class="row" style="margin: 0px auto; width: 240px;">
	    		<table class="table">
	    			<tr>
	    				<td class="text-center" width="10%">ID</td>
	    				<td class="text-left" width="90%">
	    					<input type="text" size="20" class="input-sm" ref="idRef" v-model="store.id">
	    				</td> 
	    			</tr>
	    			<tr>
	    				<td class="text-center" width="10%">PW</td>
	    				<td class="text-left" width="90%">
	    					<input type="password" size="20" class="input-sm" ref="pwdRef" v-model="store.pwd" @keyup.enter="store.login(idRef, pwdRef)">
	    				</td> 
	    			</tr>
	    			<tr>
	    				<td colspan="2" class="text-center">
	    					<!-- <a href="/member/login_ok" class="btn btn-sm btn-primary">로그인</a> -->
	    					<button type="button" class="btn-sm btn-primary" @click="store.login(idRef, pwdRef)">로그인</button>
	    					<button type="button" class="btn-sm btn-danger" onclick="javascript:history.back()" style="margin-left: 2px;">취소</button>
	    				</td>
	    			</tr>
	    		</table>
	    	</div>
    	</div>
   	</section>
   	<script src="/memberjs/memberStore.js"></script>
   	<script>
   		const { createApp, onMounted, ref } = Vue
   		const { createPinia } = Pinia
   		const app = createApp({
   			setup() {
   				const store = useMemberStore()
   				const idRef = ref(null)
   				const pwdRef = ref(null)
   				
   				return {
   					store,
   					idRef,
   					pwdRef
   				}
   			}
   		})
   		app.use(createPinia())
   		app.mount('#member_login')
   	</script>
</body>
</html>