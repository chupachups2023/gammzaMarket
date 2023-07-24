<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script	src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.3/jquery.min.js"></script>
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=44e2b21ec219944c6d834fff124a603d&libraries=services,clusterer"></script>
<title>${param.title }</title>
<link rel="shortcut icon"
	href="${pageContext.request.contextPath}/resources/img/header/shorcuticon.png">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/common/header.css?<%=System.currentTimeMillis() %>">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/member/login.css?<%=System.currentTimeMillis() %>">
<style>
	.login-content {
		display: flex;
		justify-content: center;
		align-items: center;
		height: 60vh;
	}

	h2 {
		text-align: center;
		padding-bottom: 20px;
	}
</style>



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
			</div>
		</div>
		<div class="header-midout">
			<div class="header-mid">
				<div class="header-category">
					<img src="${pageContext.request.contextPath}/resources/img/header/menu.png"	alt="logo" class="header-catemenu"> 
					<a class="header-menu headder-cateA">카테고리</a>
				</div>
				<a href="javascript:viewAllGonggu();" class="header-menu">공구보기</a> 
				<a href="" class="header-menu">요청게시판</a> 
				<a href="${pageContext.request.contextPath}/location/location.lo" class="header-menu">장소인증</a>
				<a href="${pageContext.request.contextPath}/gonggu/ggWrite.go" class="header-menu">공구 글쓰기</a>
			</div>
			<form action="">
				<div class="header-searchbox">
					<img src="${pageContext.request.contextPath}/resources/img/header/search.png" alt="" class="header-searchicon" onclick="fn_srchGgLst()"> 
					<input type="text" class="header-search" name="gongguName" id="gongguName" onkeyup="if(window.event.keyCode==13){fn_srchGgLst()}">
				</div>
			</form>
		</div>
		<div class="category-drop">
			<div class="category-list category-top">
				<a href="" class="category-menu cloth">의류</a>
				 <a href=""	class="category-menu makeup">화장품/미용</a> 
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


		<form action="${pageContext.request.contextPath}/member/memberLogin.me" method="post" name="loginFrm">
			<div class="login-content">
				<div>
					<h2>로그인</h2>
					<ul class="login-top">
						<li class="login-info">
							<input type="text" placeholder="아이디 입력" name="userId" id="userId">
						</li>
						<li class="login-info">
							<input type="password" placeholder="비밀번호 입력" name="userPwd" id="userPwd">
						</li>
						<li class="login-chkbox">
							<input type="checkbox" id="chk1">
							<label for="chk1">아이디 저장</label>
						</li>
						<li class="login-input modal-footer">
							<input type="button" class="login-btn" value="로그인" id="login-modal" onclick="validation();">
						</li>
					</ul>
					<ul class="login-bottom">
						<li><a href="${pageContext.request.contextPath}/member/memberEnroll.me">회원가입</a></li>
						<li><a href="${pageContext.request.contextPath}/member/findId.me">아이디/비밀번호 찾기</a></li>
					</ul>
							
				</div>
			</div>
		</form>
		
		
		

<script>
	function validation() {
		var uid = document.getElementById("userId");
		var pw = document.getElementById("userPwd");
		
		if (uid.value == "") {
			alert("아이디를 입력하세요");
			uid.focus();
			return false;
		}
		
		// 비밀번호 확인 
		if (pw.value == "") {
			alert("비밀번호를 입력하세요");
			pw.focus();
			return false;
		}
		
		document.loginFrm.submit();
		
	}



	$(function(){
	    $(".header-category").click(function(){
	        const p1 = $(".category-drop");
	        if(p1.css("display")=="none"){
	            p1.slideDown();
	        }else{
	            p1.slideUp();
	        }
	    });
	});
       
</script>
	</header>
	<section>