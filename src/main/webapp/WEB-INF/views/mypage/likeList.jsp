<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/css/mypage/likeList.css">

<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param value="찜리스트" name="title"/>
</jsp:include>


<div class="mypage-likeListSec">
    <h1>찜한 공구💚</h1>
	<div class="likeList">
		<c:forEach items="${myLikelist}" var="zzim">
			<div class="onelineThreebox" onclick="location.href='${pageContext.request.contextPath}/mypage/likeListDetail.do?zzimNo=${zzim.zzimNo}'">
				<input type="checkbox" name="delZzim" value="${zzim.zzimNo }">
				<div class="onelineThreeImg">
					<img src="${pageContext.request.contextPath}/resources/upload/${zzim.photo1}">
				</div>
				<div class="onelineThreeTitle">
					<div class="ggTitle">${fn:substring(zzim.gongguName, 0, 10)}...</div>
					<div><b>${zzim.price} point</b></div>
					<div><small>${zzim.locationName}</small></div>
				</div>
			</div>
		</c:forEach>
	</div>
</div>

<jsp:include page="/WEB-INF/views/common/footer.jsp" />