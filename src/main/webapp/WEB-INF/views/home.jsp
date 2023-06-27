<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<jsp:include page="/WEB-INF/views/common/mainHeader.jsp" >
	<jsp:param value="main" name="title"/>
</jsp:include>

<style>
	/* 메인화면 검색바 */
	.mainSearchSec {
		background-color: #F9E8D0; 
		height: 150px;
		padding: 50px 150px;
	}
	.mainHeader-search{
	    border-radius: 10px;
	    height: 40px;
	    width: 400px;
	    padding-left: 35px;
	    border: rgb(175, 175, 175) solid 2px;
	}
	/* 메인화면 공구게시글 */
	.main-listSec {
		width: 1200px;
		margin: 30px auto;
	}
	.list-gg {
		width:250px;
		height:350px;
		display:inline-block;
		margin: 10px 0px 0px 35px;
	}
	.ggImg{
		height:250px;
	}
	.ggImg>img {
		width:100%;
		height:100%;
		border-radius: 5px;
	}
	.ggTitle{
		font-size:30px;
		font-weight : bold;
	}
	/* 더보기 버튼 */
	.moreBtnBox {
		text-align: center;
	}
	.moreBtn{
		height: 40px;
        width: 100px;

        background: rgba(94, 177, 98, 0.75);
        border: none;
        border-radius: 15px;
        color: aliceblue;
        font-size: large;
        font-weight: bold;
		
	}
</style>


	<div class="mainSearchSec">
		<h2>어떤 공구를 찾으세요?</h2>
		<form action="">
			<div class="header-searchbox">
				<img src="${pageContext.request.contextPath}/resources/img/header/search.png" alt="" class="header-searchicon" onclick="search();">
				<input type="text" class="mainHeader-search">
			</div>
		</form>
	</div>
	
	<div class="main-listSec">
		<div class="list-gg" onclick="location.href='#';">
			<div class="ggImg"><img src="${pageContext.request.contextPath}/resources/img/testImg/testGoods.jpg" alt="이미지 없음"></div>
			<div class="ggTitle">물품이름</div>
			<div><b>30,000원</b></div>
			<div><small>서울시 영등포구 당산동</small></div>
		</div>
		<div class="list-gg">
			<div class="ggImg"><img src="${pageContext.request.contextPath}/resources/img/testImg/verticalBig.png"></div>
			<div class="ggTitle">물품이름</div>
			<div><b>30,000원</b></div>
			<div><small>서울시 영등포구 당산동</small></div>
		</div>
		<div class="list-gg">
			<div class="ggImg"><img src="${pageContext.request.contextPath}/resources/img/testImg/testGoods.jpg"></div>
			<div class="ggTitle">물품이름</div>
			<div><b>30,000원</b></div>
			<div><small>서울시 영등포구 당산동</small></div>
		</div>
		<div class="list-gg">
			<div class="ggImg"><img src="${pageContext.request.contextPath}/resources/img/testImg/testGoods.jpg"></div>
			<div class="ggTitle">물품이름</div>
			<div><b>30,000원</b></div>
			<div><small>서울시 영등포구 당산동</small></div>
		</div>
		<div class="list-gg">
			<div class="ggImg"><img src="${pageContext.request.contextPath}/resources/img/testImg/testGoods.jpg"></div>
			<div class="ggTitle">물품이름</div>
			<div><b>30,000원</b></div>
			<div><small>서울시 영등포구 당산동</small></div>
		</div>
		<div class="list-gg">
			<div class="ggImg"><img src="${pageContext.request.contextPath}/resources/img/testImg/testGoods.jpg"></div>
			<div class="ggTitle">물품이름</div>
			<div><b>30,000원</b></div>
			<div><small>서울시 영등포구 당산동</small></div>
		</div>
		<div class="list-gg">
			<div class="ggImg"><img src="${pageContext.request.contextPath}/resources/img/testImg/testGoods.jpg"></div>
			<div class="ggTitle">물품이름</div>
			<div><b>30,000원</b></div>
			<div><small>서울시 영등포구 당산동</small></div>
		</div>
		<div class="list-gg">
			<div class="ggImg"><img src="${pageContext.request.contextPath}/resources/img/testImg/testGoods.jpg"></div>
			<div class="ggTitle">물품이름</div>
			<div><b>30,000원</b></div>
			<div><small>서울시 영등포구 당산동</small></div>
		</div>
		
        <div class="moreBtnBox"><button type="button" class="btn moreBtn">더보기</button></div>
	</div>
<%-- 	<div class="main-listSec">
        <c:forEach items="${list}" var="list" varStatus="status">
			<div class="list-goods">
				<div class="ggImg"><img src="${pageContext.request.contextPath}/이미지파일 올리는 경로/${list.photo1}" alt="이미지 없음"></div>
				<div class="ggTitle">${list.제목}</div>
				<div><b>${list.가격}</b></div>
				<div><small>${list.주소}</small></div>
			</div>
        </c:forEach>
        <div class="moreBtnBox"><button type="button" class="btn moreBtn">더보기</button></div>
	</div>
	<script>
		$(function(){
			$(".main-listSec  .list-goods").hide();
			$(".main-listSec  .list-goods").slice(0, 8).css({display:inline-block;}); 
			$("#load").click(function(e){
				e.preventDefault();
				$(".main-listSec .list-goods:hidden").slice(0, 8).fadeIn(200).css({display:inline-block;}); // 클릭시 more 갯수 지저정
				if($(".main-listSec .list-goods:hidden").length == 0){ // 컨텐츠 남아있는지 확인
					$('#load').fadeOut(100); // 컨텐츠 없을 시 버튼 사라짐
				}
			});
		});
	</script>
	
	 --%>
		<hr>
<jsp:include page="/WEB-INF/views/common/footer.jsp" />

