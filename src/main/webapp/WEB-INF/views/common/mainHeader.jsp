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
	            <div class="header-logos">
	                <img src="${pageContext.request.contextPath}/resources/img/header/감자마켓.png" alt="logo" class="header-gamza"> 
	                <img src="${pageContext.request.contextPath}/resources/img/header/한글로고2.png" alt="korlogo" class="header-korlogo">
	            </div>
	            <c:choose>
	            	<c:when test="${empty login }">
			            <button class="header-login btn" id="open-modal">로그인</button>
	            	</c:when>
	            	<c:otherwise>
			            <img src="${pageContext.request.contextPath}/resources/img/header/login.png" alt="korlogo" class="header-login">
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
	            <a href="" class="header-menu">공구보기</a>
	            <a href="" class="header-menu">요청게시판</a>
	            <a href="" class="header-menu">장소인증</a>
	            <a href="" class="header-menu">공구 글쓰기</a>
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
	    
	   <!-- 로그인 모달창 -->
		<div class="modal" tabindex="-1" id="modal">
			<div class="modal-dialog">
				<div class="modal-content">
				    <div class="modal-header">
						<h5 class="modal-title">로그인</h5>
				    </div>
			   		<form action="" method="post" name="loginFrm">
				      	<div class="modal-body">
				        	<table class="table">
								<tr>
									<td scope="col">아이디</td>
									<td scope="col">
										<input type="text" name="userId" placeholder="아이디를 입력하세요">
									</td>
								</tr>
								<tr>
									<td scope="col">비밀번호</td>
									<td scope="col">
										<input type="password" name="userPwd" placeholder="비밀번호를 입력하세요">
									</td>
								</tr>
							</table>
				      	</div>
				      	<div class="modal-footer">
					        <button type="button" id="login-modal">로그인</button>
					        <button type="button" id="close-modal">닫기</button>
				    	</div>
					</form>
			      
				</div>
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
	
	
