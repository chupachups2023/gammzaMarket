<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/mypage/mainPage.css">

<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param value="제목" name="title"/>
</jsp:include>

<div align="center">
		<h1>O O O 님 안녕하세요💚</h1>
	</div>
	<div align="center" class="db">
		<div class="mypageTitle">
			<div><h2>현재 보유 포인트</h2></div>
			<div class="maypageMain-point"><h2>&emsp;<fmt:formatNumber type="number" maxFractionDigits="3" value="${loginMember.point}" />&emsp;</h2></div>
			<a href="" class="button">포인트 충전하기</a>
		</div>
	</div>
	<div align="center">
		<span class="point">매너점수</span>&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;
		<span class="point2">40점 <img src="${pageContext.request.contextPath}/resources/img/mypage/빈감자 1.png" width="35px"></span>
		<div class="bar">	
			<div class="bar2"></div>
		</div>
	</div>
	<div align="center">
		<button type="submit" href="" class="bo">참여한 공구 보기</button>&emsp;
		<button type="submit" href="" class="bo">채팅 보기</button>&emsp;
		<button type="submit" href="" class="bo">리뷰 보기</button><br><br><br>
		<button type="submit" href="" class="bo">참여한 공구 보기</button>&emsp;
		<button type="submit" href="" class="bo">참여한 공구 보기</button>&emsp;
		<button type="submit" href="" class="bo">참여한 공구 보기</button>
	</div>

<jsp:include page="/WEB-INF/views/common/footer.jsp" />