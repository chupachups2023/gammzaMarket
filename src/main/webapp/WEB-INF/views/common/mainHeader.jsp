<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">

<title>${param.title }</title>
<link rel="shortcut icon" href="${pageContext.request.contextPath}/resources/img/header/shorcuticon.png">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.3/jquery.min.js"></script>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/member/login.css?<%=System.currentTimeMillis() %>">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/common/header.css?<%=System.currentTimeMillis() %>">

<!-- DB에 저장이 잘 되었다면 alert창 띄우기 -->
<c:if test="${not empty msg}">
	<script type="text/javascript">
		alert('${msg}');
	</script>
</c:if>
</head>
<body>
	<header>
		<div class="header-top">
	        <div class="header-head">
	            <a class="header-logos" href="${pageContext.request.contextPath}/">
	                <img src="${pageContext.request.contextPath}/resources/img/header/감자마켓.png" alt="logo" class="header-gamza"> 
	                <img src="${pageContext.request.contextPath}/resources/img/header/한글로고2.png" alt="korlogo" class="header-korlogo">
	            </a>
	            
	            <c:choose>
	            	<c:when test="${empty loginMember}">
			            <button type="button" class="header-login btn" id="open-modal">로그인</button>
			            <button class="header-login btn" onclick="location.href='${pageContext.request.contextPath}/member/memberEnroll.me'">회원가입</button>
	            	</c:when>
	            	<c:otherwise>
			            <img src="${pageContext.request.contextPath}/resources/img/header/loginicon.png" alt="korlogo" class="header-login" onclick="location.herf='${pageContext.request.contextPath}/mypage/mypageMain.me'">
					<!-- 230627 -->
		      			<a href="${pageContext.request.contextPath}/mypage/mypageMain.me">${loginMember.userId}님 반갑습니다.</a>&emsp;
		      			<button type="button" onclick="location.href='${pageContext.request.contextPath}/member/memberLogout.me'">로그아웃</button>
	            	</c:otherwise>
	            </c:choose>
	        </div>
	    </div>
	    <div class="header-midout">
	        <div class="header-mid">
	            <div class="header-category">
	                <img src="${pageContext.request.contextPath}/resources/img/header/menu.png" alt="logo" class="header-catemenu"> 
	                <a class="header-menu headder-cateA">카테고리</a>
	            </div>
	            <a href="${pageContext.request.contextPath}/gonggu/ggListView.go" class="header-menu">공구보기</a> 
	            <a href="" class="header-menu">요청게시판</a>
	            <a href="" class="header-menu">장소인증</a>
	            <a href="${pageContext.request.contextPath}/gonggu/ggWrite.go" class="header-menu">공구 글쓰기</a>
	        </div>
	    </div>
	    <div class="category-drop">
	        <div class="category-list category-top">
	            <a href="" class="category-menu cloth">의류</a>
	            <a href="" class="category-menu makeup">화장품/미용</a>
	            <a href="" class="category-menu food">식품/농산물</a>
	            <a href="" class="category-menu furniture">가구/인테리어</a>
	        </div>
	        <div class="category-list category-bottom">
	            <a href="" class="category-menu delivery">배달음식</a>
	            <a href="" class="category-menu baby">유아동</a>
	            <a href="" class="category-menu homeware">생활용품</a>
	            <a href="" class="category-menu pet">반려동물용품</a>
	        </div>
	    </div>
	    
	   <!--로그인 모달창 수정본 -->
		<div class="modal" tabindex="-1" id="modal">
			<div class="modal-dialog">
				<div class="modal-header">
					<h5 class="modal-title">로그인</h5>
				</div>
				<form action="${pageContext.request.contextPath}/member/memberLogin.me" method="post" id="loginFrm">
					<div class="modal-login">
						<div class="modal-bg"></div>
						<div class="modal-content">
							<h2>로그인</h2>
							<ul class="login-top">
								<li class="login-info">
									<input type="text" placeholder="아이디 입력!" name="userId">
								</li>
								<li class="login-info">
									<input type="password" placeholder="비밀번호 입력" name="userPwd">
								</li>
								<li class="login-chkbox">
									<input type="checkbox" id="chk1">
									<label for="chk1">아이디 저장</label>
								</li>
								<li class="login-input modal-footer">
									<input type="button" class="login-btn" value="로그인" id="login-modal">
								</li>
							</ul>
							<ul class="login-bottom">
								<li><a href="${pageContext.request.contextPath}/member/memberEnroll.me">회원가입</a></li>
								<li><a href="${pageContext.request.contextPath}/member/findId.me">아이디/비밀번호 찾기</a></li>
							</ul>
									
							<div class="social-container">
								<h3>간편 로그인</h3>
								<div class="social-icon">
									<ul>

											<!-- <li class="login-kakao">
                                        <a href="#">
                                            <!-- <img src="kakao_login_large_ko_resize.png" alt="카카오톡아이콘"> </li> -->

										<li class="login-naver"><a href="#"> </a>
											<img src="${pageContext.request.contextPath}/resources/img/login/btnG_축약형.png" alt="네이버아이콘">
										</li>
									</ul>
									<br>
									<button type="button" id="close-modal">임시닫기버튼</button>

								</div>
							</div>
						</div>
					</div>
				</form>
			</div>
		</div>
	    
	    <script>
	        $(function(){
	            $(".header-category").click(function(){
	                const p1 = $(".category-drop");
	                if(p1.css("display")=="none"){
	                    p1.slideDown();
	                }else{
	                    p1.slideUp();
	                }
	            })
	        })
		const modal = document.getElementById("modal");
		const openModalBtn = document.getElementById("open-modal");
		const closeModalBtn = document.getElementById("close-modal");
		const loginModalBtn = document.getElementById("login-modal");
		// 모달창 열기
		openModalBtn.addEventListener("click", () => {
			modal.style.display = "block";
			document.body.style.overflow = "hidden"; // 스크롤바 제거
		});
		// 모달창 닫기
		closeModalBtn.addEventListener("click", () => {
			modal.style.display = "none";
			document.body.style.overflow = "auto"; // 스크롤바 보이기
		});
		// 모달창 닫기
		loginModalBtn.addEventListener("click", () => {
			modal.style.display = "none";
			document.body.style.overflow = "auto"; // 스크롤바 보이기
			loginFrm.submit();
		});
	    </script>
	</header>
	<section>
	
	
