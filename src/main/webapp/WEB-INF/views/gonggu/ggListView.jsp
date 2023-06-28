<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param value="공구게시판" name="title"/>
</jsp:include>

<style>
	/* 공구게시판 */
    .GGlistSec {
        width: 1100px;
        margin: 100px auto;
    }
    /* 한 줄에 세 이미지 박스 */
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
		width: 80%;
		height: 35%;
	}
	.ggTitle{
		font-size: 30px;
		font-weight: bold;
	}


	a {
		text-decoration: none;
		color: black;
		font-size: 15px;
	}

	/* 글쓰기 버튼 */
	#GGWriteBtn {
		background: rgba(95, 186, 24, 0.72);

		position: fixed;
		width: 40px;
		height: 40px;
		right: 5%; 
		bottom: 10%;

		border: 5px solid rgba(123, 123, 123, 0.28);
		border-radius: 50px;
		text-align: center;
		vertical-align: middle;
		line-height: 25px;
		font-size: 60px;
		color: rgb(78, 160, 15);
	}


</style>
<div class="GGlistSec">
    <a onclick="">최신순</a>&emsp;<a onclick="">마감 임박순</a>
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
	<a title="공구 글쓰기" onclick="location.href='글쓰기'">
		<div id="GGWriteBtn">+</div>
	</a>

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