<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/gonggu/ggListView.css">
<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param value="공구게시판" name="title"/>
</jsp:include>

<div class="GGlistSec">
    <a href="" class="GGlist-a">최신순</a>&emsp;<a href="" class="GGlist-a">마감 임박순</a>
	<div class="likeList">
		<div class="onelineThreebox" onclick="location.href='#';">
			<div class="onelineThreeImg">
				<img src="${pageContext.request.contextPath}/resources/img/testImg/testGoods.jpg">
			</div>
			<div class="onelineThreeTitle">
				<div class="ggTitle">물품이름</div>
				<div style="font-size: 20px;"><b>30,000원</b></div>
				<div><small>서울시 영등포구 당산동</small></div>
			</div>
		</div>
		<div class="onelineThreebox" onclick="location.href='#';">
			<div class="onelineThreeImg">
				<img src="${pageContext.request.contextPath}/resources/img/testImg/testGoods.jpg">
			</div>
			<div class="onelineThreeTitle">
				<div class="ggTitle">물품이름</div>
				<div style="font-size: 20px;"><b>30,000원</b></div>
				<div><small>서울시 영등포구 당산동</small></div>
			</div>
		</div>
		<div class="onelineThreebox" onclick="location.href='#';">
			<div class="onelineThreeImg">
				<img src="${pageContext.request.contextPath}/resources/img/testImg/testGoods.jpg">
			</div>
			<div class="onelineThreeTitle">
				<div class="ggTitle">물품이름</div>
				<div style="font-size: 20px;"><b>30,000원</b></div>
				<div><small>서울시 영등포구 당산동</small></div>
			</div>
		</div>
		<div class="onelineThreebox" onclick="location.href='#';">
			<div class="onelineThreeImg">
				<img src="${pageContext.request.contextPath}/resources/img/testImg/testGoods.jpg">
			</div>
			<div class="onelineThreeTitle">
				<div class="ggTitle">물품이름</div>
				<div style="font-size: 20px;"><b>30,000원</b></div>
				<div><small>서울시 영등포구 당산동</small></div>
			</div>
		</div>
		<div class="onelineThreebox" onclick="location.href='#';">
			<div class="onelineThreeImg">
				<img src="${pageContext.request.contextPath}/resources/img/testImg/testGoods.jpg">
			</div>
			<div class="onelineThreeTitle">
				<div class="ggTitle">물품이름</div>
				<div style="font-size: 20px;"><b>30,000원</b></div>
				<div><small>서울시 영등포구 당산동</small></div>
			</div>
		</div>
		<div class="onelineThreebox" onclick="location.href='#';">
			<div class="onelineThreeImg">
				<img src="${pageContext.request.contextPath}/resources/img/testImg/testGoods.jpg">
			</div>
			<div class="onelineThreeTitle">
				<div class="ggTitle">물품이름</div>
				<div style="font-size: 20px;"><b>30,000원</b></div>
				<div><small>서울시 영등포구 당산동</small></div>
			</div>
		</div>
	</div>
	
	

</div>


<%-- 

	<div class="GGlistSec">
		<c:forEach items="${공구리스트}" var="공구">
			<div class="onelineThreebox" onclick="location.href='${pageContext.request.contextPath}찜상세페이지경로?찜번호=${찜번호}';">
				<div class="onelineThreeImg">
					<img src="${pageContext.request.contextPath}/공구 경로/${공구.이미지이름}">
				</div>
				<div class=""onelineThreeTitle"">
					<div class="ggTitle">${공구.물품이름}</div>
					<div><b>${공구.가격}</b></div>
					<div><small>${공구.주소}</small></div>
				</div>
			</div>
		</c:forEach>
	</div>

 --%>



<jsp:include page="/WEB-INF/views/common/footer.jsp" />