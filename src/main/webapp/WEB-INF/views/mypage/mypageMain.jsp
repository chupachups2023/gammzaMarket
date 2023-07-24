<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/mypage/mainPage.css?<%=System.currentTimeMillis() %>">

<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param value="${loginMember.name }님의 마이페이지" name="title"/>
</jsp:include>

	<div align="center" class="mainPage-title">
		<h1><a href="${pageContext.request.contextPath}/member/memberInfo.me" class="myMain-info">${loginMember.name} 님</a> 안녕하세요💚</h1>
	</div>
	<div align="center" class="db">
		<div class="mypageTitle">
			<div><h2>현재 보유 포인트</h2></div>
			<div class="maypageMain-point"><h2>&emsp;<fmt:formatNumber type="number" maxFractionDigits="3" value="${loginMember.point}" />&emsp;</h2></div>
			<a href="${pageContext.request.contextPath}/member/pointPurchase.do" class="button">포인트 충전하기</a>
		</div>
	</div>
	<div align="center">
		<span class="point"><img src="${pageContext.request.contextPath}/resources/img/mypage/빈감자 1.png" width="35px">매너온도</span>&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;
		<span class="point2">${loginMember.temperature }°C </span>
		<div class="bar">	
			<div class="bar2" id="bar"></div>
		</div>
	</div>
	<div align="center">
		<a href="${pageContext.request.contextPath}/gonggu/ggPartiList.pa" class="button-long">참여한 공구 보기</a>&emsp;
		<a href="${pageContext.request.contextPath}/chatRoom/myChatList.bo?roomOwner=${loginMember.userId}" class="button">채팅 보기</a>&emsp;
		<a href="${pageContext.request.contextPath}/review/reviewList.re" class="button">리뷰 보기</a><br><br><br>
		<a href="${pageContext.request.contextPath}/gonggu/ggLeadList.pa" class="button-long">내가 연 공구 보기</a>&emsp;
		<a href="${pageContext.request.contextPath}/mypage/likeList.do" class="button">찜한 공구 보기</a>&emsp;
		<a href="${pageContext.request.contextPath}/adminpage/noticeList.bo" class="button">공지사항</a>
	</div>
	<div class="qna-potato" onclick="location.href='${pageContext.request.contextPath}/mypage/myQuestionList.do'">
		<img src="${pageContext.request.contextPath}/resources/img/mypage/qna.png" width="120px" >
		<div>1:1문의</div>
		<c:if test="${loginMember.name eq '관리자'}">
			<div><a href="${pageContext.request.contextPath}/report/reportList.bo">신고리스트</a></div>
		</c:if>
	</div>
	<script>
		$(function(){
			var wid=700/100*${loginMember.temperature};
			document.getElementById("bar").style.width=wid;
		})
	</script>
<jsp:include page="/WEB-INF/views/common/footer.jsp" />