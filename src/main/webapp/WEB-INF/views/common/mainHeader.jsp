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
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">

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
				<div class="upperIconBox">
				<c:choose>
					<c:when test="${empty loginMember}">
						<button class="header-loginBtn btn" id="open-modal">
							<!-- <i class="fa-solid fa-arrow-right-to-bracket" style="color: #5eb162;"></i> -->
							<!-- <img src="https://cdn-icons-png.flaticon.com/512/1828/1828395.png" alt="loginButton"> -->
							<i class="fa-solid fa-right-to-bracket fa-3x" style="color: #5eb162;"></i>
						</button>
					</c:when>
					<c:when test="${loginMember.userId eq 'admin'}">
						<a href="${pageContext.request.contextPath}/admin/adminMain.ad">
							<img src="https://cdn-icons-png.flaticon.com/512/5909/5909015.png" alt="adminlogo" class="header-adminLogin" >
						</a>
		      			<button type="button" class="header-logoutBtn" onclick="location.href='${pageContext.request.contextPath}/member/memberLogout.me'">
		      				<i class="fa-solid fa-right-from-bracket fa-3x" style="color: #f9e8d0;"></i>
		      			</button>
					</c:when>
					<c:otherwise>
						<div class="notiBox">
							<img alt="알림" src="https://cdn-icons-png.flaticon.com/512/3247/3247251.png"  class="header-notify" onclick="alarmOpen()">
							<img alt="" src="https://cdn-icons-png.flaticon.com/512/8804/8804772.png" class="notiRedDot" id="notiRedDot" onclick="alarmOpen()">
						</div>
						<a href="${pageContext.request.contextPath}/mypage/mypageMain.me">
							<img src="${pageContext.request.contextPath}/resources/img/header/loginicon.png" alt="korlogo" class="header-memberLogin" >
						</a>
						<button class="header-logoutBtn" type="button" onclick="location.href='${pageContext.request.contextPath}/member/memberLogout.me'">
							<!-- <img src="https://cdn-icons-png.flaticon.com/512/1828/1828427.png" alt="logoutButton"> -->
							<i class="fa-solid fa-right-from-bracket fa-3x" style="color: #f9e8d0;"></i>
	      				</button>
					</c:otherwise>
				</c:choose>
				</div>
			</div>
		</div>
		<div class="header-midout">
			<div class="header-mid">
				<div class="header-category">
					<img src="${pageContext.request.contextPath}/resources/img/header/menu.png"	alt="logo" class="header-catemenu"> 
					<a class="header-menu headder-cateA">카테고리</a>
				</div>
				<a href="javascript:viewAllGonggu();" class="header-menu">공구보기</a> 
				<a href="javascript:viewRequest();" class="header-menu">요청게시판</a>  
				<a href="${pageContext.request.contextPath}/location/location.lo" class="header-menu">장소인증</a>
				<a href="${pageContext.request.contextPath}/gonggu/ggWrite.go" class="header-menu">공구 글쓰기</a>
			</div>
		</div>
		<div class="category-drop">
			<div class="category-list category-top">
				 <p onclick="fn_click(1)" id="category1" class="category-menu cloth" >의류</p>
				 <p onclick="fn_click(2)" id="category2" class="category-menu makeup">화장품/미용</p> 
				 <p onclick="fn_click(3)" id="category3" class="category-menu food">식품/농산물</p> 
				 <p onclick="fn_click(4)" id="category4" class="category-menu furniture" >가구/인테리어</p>
			</div>
			<div class="category-list category-bottom">
				<p onclick="fn_click(5)" id="category5" class="category-menu delivery" >배달음식</p> 
				<p onclick="fn_click(6)" id="category6" class="category-menu baby" >유아동</p> 
				<p onclick="fn_click(7)" id="category7" class="category-menu homeware" >생활용품</p> 
				<p onclick="fn_click(8)" id="category8" class="category-menu pet" >반려동물용품</p>
			</div>
		</div>


		<!--로그인 모달창 수정본 -->
		<div class="modal" tabindex="-1" id="modal">
			<div class="modal-dialog">
				<form action="${pageContext.request.contextPath}/member/memberLogin.me" method="post" id="loginFrm" name="loginFrm">
					<div class="modal-login">
						<div class="modal-bg" onclick="loginModalClose();"></div>
						<div class="modal-content">
							<h2>로그인</h2>
							<ul class="login-top">
								<li class="login-info">
									<input type="text" placeholder="아이디 입력" name="userId" onkeyup="loginEnterEvent(event);">
								</li>
								<li class="login-info">
									<input type="password" placeholder="비밀번호 입력" name="userPwd" onkeyup="loginEnterEvent(event);">
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
										<li class="login-kakao">
											<a href="https://kauth.kakao.com/oauth/authorize?client_id=&redirect_uri=http://localhost:8095/chupachups/auth/kakao/callback&response_type=code">
												<img src="${pageContext.request.contextPath}/resources/img/header/icon_kakao_long.png" alt="카카오로그인버튼">
											</a> 
										</li>
										<li class="login-naver">
											<a href="https://nid.naver.com/oauth2.0/authorize?response_type=code&state=test&client_id=&state=STATE_STRING&redirect_uri=http://localhost:8095/chupachups/auth/naver/callback">
												<img src="${pageContext.request.contextPath}/resources/img/header/icon_naver_long_resize2.png" alt="네이버로그인버튼">
											</a> 
									</ul>
									<br>
									<a id="close-modal" class="modal-closeBtn"  onclick="loginModalClose();">닫기</a>
								</div>
							</div>
						</div>
					</div>
				</form>
			</div>
		</div>
		
		<div class="notiModal" tabindex="-1" id="notiModal">
			<div class="notiModal-dialog">
				<div class="notiModal">
					<div class="notiModal-bg" onclick="alarmOpen();"></div>
					<div class="notiModal-content" id="notiModal-content">
					</div>
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


function fn_click(category) {
	function success(position) {
	    /* const latitude = position.latitude; 
	    const longitude = position.longitude; */
 	    const latitude = position.coords.latitude;   // 위도(37.xxxx)
	    const longitude = position.coords.longitude;
	    const memLong="${loginMember.longitude}";	//로그인 했니?
	    
	    if(memLong != ""){	//했다
	    	location.href="${pageContext.request.contextPath}/gonggu/categoryList.go?category=" + category;
	    }else{		//안했다
	   		location.href="${pageContext.request.contextPath}/gonggu/categoryList.go?category=" + category+"&longitude="+longitude+"&latitude="+latitude;
	    }
	}
    navigator.geolocation.getCurrentPosition(success);
/* 	position={"latitude":37.533921602961506, "longitude":126.89677032759451 } */
    success(position);
   
}

function viewAllGonggu(){
	function success(position) {
		/* const latitude = position.latitude; 
	    const longitude = position.longitude; */
	    const latitude = position.coords.latitude;   // 위도(37.xxxx)
	    const longitude = position.coords.longitude;
	    const memLong="${loginMember.longitude}";
	    
	    if(memLong != ""){
	    	location.href="${pageContext.request.contextPath}/gonggu/ggListView.go";
	    }else{
	   		location.href="${pageContext.request.contextPath}/gonggu/ggListView.go?longitude="+longitude+"&latitude="+latitude;
	    }
	}
    navigator.geolocation.getCurrentPosition(success);
/* 	position={"latitude":37.533921602961506, "longitude":126.89677032759451 } */
    success(position);
}
function viewRequest(){
	function success(position) {
		/* const latitude = position.latitude; 
	    const longitude = position.longitude; */
	    const latitude = position.coords.latitude;   // 위도(37.xxxx)
	    const longitude = position.coords.longitude;
		location.href="${pageContext.request.contextPath}/ggRequest/requestView.req?longitude="+longitude+"&latitude="+latitude;
	}
	navigator.geolocation.getCurrentPosition(success);
/* 	position={"latitude":37.533921602961506, "longitude":126.89677032759451 } */
    success(position);
}
function loginEnterEvent(e){
	if(e.keyCode==13){
		loginFrm.submit();
	}
}
function alarmOpen(){
	$.ajax({
		url:"${pageContext.request.contextPath}/notify/selectNotifyList.no",
		success:function(result){
			let notifyList=result.notifyList;
			let str="";
			if(notifyList.length==0){
				str="<div class='notiDiv emptyNotify'>아직 알림이 없습니다.</div>";
			}else{
				for(let i=0;i<notifyList.length;i++){
					if(notifyList[i].status==0){
						str+="<div class='notiDiv'>"
								+ "<div class='notiContent'><b><a href='${pageContext.request.contextPath}"+notifyList[i].notiContent+"</b></div>"
								+	'<div class="notiTime">'+notifyList[i].createAt +'</div></div><hr>';
					}else{
						str+="<div class='notiDiv'>"
							+ "<div class='notiContent'><a href='${pageContext.request.contextPath}"+notifyList[i].notiContent+"</div>"
							+	'<div class="notiTime">'+notifyList[i].createAt +'</div></div><hr>';
					}
				}
			}
			document.getElementById("notiModal-content").innerHTML=str;
			$.ajax({
				url:"${pageContext.request.contextPath}/notify/updateNotifyStatus.no",
				success:function(){},
				error:function(){}
			})
		}
	})
	let display=$("#notiModal").css("display");
	if(display=="block"){
		$("#notiModal").css("display","none");
		$("#notiRedDot").css("display","none");
	}else{
		$("#notiModal").css("display","block");
	}
}

$(function(){
	if("${loginMember.userId}" != ""){
		$.ajax({
			url:"${pageContext.request.contextPath}/notify/selectNewNotify.no",
			success:function(result){
				let newNoti=result.newNoti*1;
				if(newNoti>0){
					$("#notiRedDot").css("display","block");
				}else{
					$("#notiRedDot").css("display","none");
				}
			},
			error: function(){
				console.log("에러")
			}
		})
	}
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
function loginModalClose(){
	modal.style.display = "none";
	document.body.style.overflow = "auto"; // 스크롤바 보이기
}
	// 모달창 닫기
	loginModalBtn.addEventListener("click", () => {
		loginModalClose();
		loginFrm.submit();
	});
</script>
	</header>
	<section id="wrapper-whole-section">
