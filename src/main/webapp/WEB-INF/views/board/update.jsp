<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
                        <h2>게시판</h2>
                        <div class="breadcrumb__option">
                        	<span>수정하기</span>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>
    <!-- Breadcrumb Section End -->
    
    <!-- Product Details Section Begin -->
    <section class="product-details spad" id="board_update">
        <div class="container">
            <div class="row">
            	<table class="table">
            		<tbody>
            			<tr>
            				<td width="10%" class="text-center">이름</td>
            				<td width="90%" class="text-left">
            					<input type="text" ref="nameRef" v-model="store.name" size="20">
            				</td>
            			</tr>
            			<tr>
            				<td width="10%" class="text-center">제목</td>
            				<td width="90%" class="text-left">
            					<input type="text" ref="subRef" v-model="store.subject" size="60">
            				</td>
            			</tr>
            			<tr>
            				<td width="10%" class="text-center">내용</td>
            				<td width="90%" class="text-left">
            					<textarea rows="10" cols="60" ref="contRef" v-model="store.content"></textarea>
            				</td>
            			</tr>
            			<tr>
            				<td width="10%" class="text-center">비밀번호</td>
            				<td width="90%" class="text-left">
            					<input type="password" ref="pwdRef" v-model="store.pwd" size="10">
            				</td>
            			</tr>
            			<tr>
            				<td colspan="2" class="text-center">
            					<button class="btn-sm" style="background-color: #7fad39; color: white; border: none;" @click="store.boardUpdate({nameRef, subRef, contRef, pwdRef})">수정</button>&nbsp;
            					<button class="btn-sm" style="background-color: #7fad39; color: white; border: none;" onclick="javascript:history.back()">취소</button>
            				</td>
            			</tr>
            		</tbody>
           		</table>
       		</div>
   		</div>
	</section>
	<script src="/boardjs/boardUpdateStore.js"></script>
	<script>
		const { createApp, ref, onMounted } = Vue
		const { createPinia } = Pinia
		const app = createApp({
			setup() {
				const store = useBoardUpdateStore()
				// @Controller로 전송
				const params = new URLSearchParams(location.search)
				const no = params.get('no')
				// ref에 대한 초기화
				const nameRef = ref('')
				const subRef = ref('')
				const contRef = ref('')				
				const pwdRef = ref('')
				// 한번 수행
				onMounted(()=> {
					store.boardUpdateData(no)
				})
				// HTML에 적용하기 위한 값
				return {
					store,
					nameRef,
					subRef,
					contRef,
					pwdRef
				}
			}
		})
		// 회원 (가입 / 수정 / 정보보기 / 탈퇴)
		// 예약 
		app.use(createPinia())
		app.mount('#board_update')
	</script>
</body>
</html>