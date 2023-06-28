<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param value="찜리스트" name="title"/>
</jsp:include>

<style>
	/* 마이페이지 찜리스트 */
    .mypage-likeListSec {
        width: 1100px;
        margin: 0 100px;
    }
    /* 한줄에 세 이미지 박스 */
	.onelineThreebox{
		display:inline-block;
		margin: 35px 0px 0px 35px;
		position: relative;
	}
	.onelineThreeImg{
		width: 300px;
		height:300px;
	}
	
    .onelineThreeImg>img{
		width: 100%;
		height: 100%;
		border-radius:10px;
    }
	.onelineThreeTitle {
		position: absolute;
		bottom: 0%;
		background-color: rgba(240, 248, 255, 0.692);
		padding: 10px;
		width: 150px;
	}
	.ggTitle{
		font-size: 30px;
		font-weight: bold;
	}
	
</style>
<div class="mypage-likeListSec">
    <h1>찜한 공구💚</h1>
	<div class="likeList">
		<div class="onelineThreebox" onclick="location.href='#';">
			<div class="onelineThreeImg">
				<img src="${pageContext.request.contextPath}/resources/img/testImg/testGoods.jpg">
			</div>
			<div class="onelineThreeTitle">
				<div class="ggTitle">물품이름</div>
				<div><b>30,000원</b></div>
				<div><small>서울시 영등포구 당산동</small></div>
			</div>
		</div>
		<div class="onelineThreebox" onclick="location.href='#';">
			<div class="onelineThreeImg">
				<img src="${pageContext.request.contextPath}/resources/img/testImg/testGoods.jpg">
			</div>
			<div class="onelineThreeTitle">
				<div class="ggTitle">물품이름</div>
				<div><b>30,000원</b></div>
				<div><small>서울시 영등포구 당산동</small></div>
			</div>
		</div>
		<div class="onelineThreebox" onclick="location.href='#';">
			<div class="onelineThreeImg">
				<img src="${pageContext.request.contextPath}/resources/img/testImg/testGoods.jpg">
			</div>
			<div class="onelineThreeTitle">
				<div class="ggTitle">물품이름</div>
				<div><b>30,000원</b></div>
				<div><small>서울시 영등포구 당산동</small></div>
			</div>
		</div>
		<div class="onelineThreebox" onclick="location.href='#';">
			<div class="onelineThreeImg">
				<img src="${pageContext.request.contextPath}/resources/img/testImg/testGoods.jpg">
			</div>
			<div class="onelineThreeTitle">
				<div class="ggTitle">물품이름</div>
				<div><b>30,000원</b></div>
				<div><small>서울시 영등포구 당산동</small></div>
			</div>
		</div>
		<div class="onelineThreebox" onclick="location.href='#';">
			<div class="onelineThreeImg">
				<img src="${pageContext.request.contextPath}/resources/img/testImg/testGoods.jpg">
			</div>
			<div class="onelineThreeTitle">
				<div class="ggTitle">물품이름</div>
				<div><b>30,000원</b></div>
				<div><small>서울시 영등포구 당산동</small></div>
			</div>
		</div>
		<div class="onelineThreebox" onclick="location.href='#';">
			<div class="onelineThreeImg">
				<img src="${pageContext.request.contextPath}/resources/img/testImg/testGoods.jpg">
			</div>
			<div class="onelineThreeTitle">
				<div class="ggTitle">물품이름</div>
				<div><b>30,000원</b></div>
				<div><small>서울시 영등포구 당산동</small></div>
			</div>
		</div>
	</div>
</div>

<%-- 

	<div class="likeList">
		<c:forEach items="${찜리스트}" var="찜">
			<div class="onelineThreebox" onclick="location.href='${pageContext.request.contextPath}찜상세페이지경로?찜번호=${찜번호}';">
				<div class="onelineThreeImg">
					<img src="${pageContext.request.contextPath}/찜이미지 경로/${찜.이미지이름}">
				</div>
				<div class=""onelineThreeTitle"">
					<div class="ggTitle">${찜.물품이름}</div>
					<div><b>${찜.가격}</b></div>
					<div><small>${찜.주소}</small></div>
				</div>
			</div>
		</c:forEach>
	</div>

 --%>



<jsp:include page="/WEB-INF/views/common/footer.jsp" />