<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/gonggu/ggRead.css">
<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param value="제목" name="title"/>
</jsp:include>

<div class="ggRead-section">
    <div class="ggRead-head">
        <div class="ggRead-title">
            <div class="ggRead-writer ggRead-writer-none">감자감자</div>
            <div class="ggRead-name">도브 비누 화이트 뷰티바</div>
            <div class="ggRead-writer" onclick="">감자감자</div>
        </div>
    </div>
    <hr class="ggRead-hr">
    <div class="ggRead-body">
        <div class="ggRead-leftside">
            <div class="ggRead-slider-wrap">
                <div class="ggRead-slider-img">
                    <div class="ggRead-slider-inner">
                        <div class="ggRead-img-slider"><img src="${pageContext.request.contextPath}/resources/upload/sample1.jpg"></div>
                        <div class="ggRead-img-slider"><img src="${pageContext.request.contextPath}/resources/upload/sample2.jpg"></div>
                        <div class="ggRead-img-slider"><img src="${pageContext.request.contextPath}/resources/upload/sample3.jpg"></div>
                    </div>
                </div>
                <div class="ggRead-slider-dot">
                </div>
            </div>
            <div class="ggRead-content">
                같이 사서 나눠요!
            </div>
        </div>
        <div class="ggRead-detail">
            <div class="ggRead-price">개당 1,250 포인트</div>
            <div class="ggRead-num">
                <div>8개 나눠요<span>/</span></div>
                <div class="ggRead-on"> 아직 <span>5개</span> 남았어요</div>
            </div>
            <div class="ggRead-endtime">2023년 6월 10일 12시 00분까지 기다려요</div>
            <div class="ggRead-lefttime">2일 23시간 15분 22초 남았어요</div>
            <div><a href='https://smartstore.naver.com/ssage/products/2526266507' target="_blank" class="ggRead-link">물건의 자세한 정보는 여기서 볼 수 있어요</a></div>
            <div class="ggRead-map">
                <div>여기서 나눠드려요</div>
                <img src="${pageContext.request.contextPath}/resources/upload/image.png" class="ggRead-mapp">
            </div>
        </div>
    </div>
    <div class="ggRead-btn">
        <div class="ggRead-title-right">
            <div class="ggRead-date">끌올 2023년 6월 20일</div>
            <div><img src="https://cdn-icons-png.flaticon.com/512/2089/2089736.png" alt="share"></div>
        </div>
        <div class="ggRead-button">
            <a href="" class="button">글 수정</a>
            <a href="" class="button">공구삭제</a>
            <a href="" class="button">채팅하기</a>
            <a href="" class="button">참여자확인</a>
        </div>
        <div>
            <div class="ggRead-report"><a href="#">신고</a></div>
            <div class="ggRead-info">
                <div>관심 수 <span>5</span> · </div>
                <div>조회 수 <span>5</span></div>
            </div>
        </div>
    </div>
</div>
<script src="${pageContext.request.contextPath}/resources/js/gonggu/ggRead_Partic.js"></script>


<jsp:include page="/WEB-INF/views/common/footer.jsp" />