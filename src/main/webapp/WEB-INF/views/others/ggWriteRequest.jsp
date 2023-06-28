<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/common/ggWriteRequest.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/common/ggWrite.css">

<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param value="제목" name="title"/>
</jsp:include>

<!-- 
*제목 수정하기
*내용 들어갈 곳
*공구 요청 글쓰기 
-->

	<!-- 공구 참여하기 -->
    <div class="request-title">
        <h1>공구 요청 작성글</h1>
        <hr>
    </div>

    <div class="write-container">

        <form action="" method="post">

            <div class="write-category">
                <input class="write-stuff" type="text" placeholder="공구 요청할 물건">
                <select name="" id="">
                    <option value="">카테고리</option>
                    <option value="">의류</option>
                    <option value="">화장품/미용</option>
                    <option value="">식품/농산물</option>
                    <option value="">가구/인테리어</option>
                    <option value="">배달음식</option>
                    <option value="">유아동</option>
                    <option value="">생활용품</option>
                    <option value="">반려동물용품</option>
                </select>
            </div>

            <div class="write-price">
                <span>가격</span>
                <select name="" id="">
                    <option value="">상담 후 결정</option>
                    <option value="">가격 제시</option>
                    <option value="">직접 입력</option>
                </select>
                <input type="text" name="" id="" placeholder="직접 입력">￦
            </div>
            <div class="request-count">
                <span>요청 공구 수량</span>
                <input type="radio" form="rq1"><label for="rq1">인원 수 기준</label>
                <input type="text">
            </div>
                
                <!-- 요청 공구 사진 -->
            <div class="request-info2">
                <div>
                    요청 공구 사진
                </div>
                <div class="wirte-map">
                    <span>선호 지역 위치</span>
                    <img src="map.png" style="width: 300px;">
                </div>
            </div>
         <div class="ggStart-btn"><input type="button" value="공구 시작"></div>
       </form>
    </div>

<jsp:include page="/WEB-INF/views/common/footer.jsp" />