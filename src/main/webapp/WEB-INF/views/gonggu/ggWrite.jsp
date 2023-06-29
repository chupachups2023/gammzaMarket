<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=44e2b21ec219944c6d834fff124a603d&libraries=services,clusterer"></script>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/common/ggWrite.css">

<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param value="공구 글 작성하기" name="title"/>
</jsp:include>

<!-- 
*제목 수정하기
*내용 들어갈 곳
*공구 글 작성 
-->


  <!--   <h1>공구 글 작성</h1>
    <hr>  -->
    <div class="write-container">
        <form action="${pageContext.request.contextPath}/gonggu/ggEnrollFrm.go" method="post" enctype="multipart/form-data" name="ggEnrollFrm">
            <div class="write-category">
                <input class="write-stuff" type="text" placeholder="공구할 물건" name="gongguName">
                <select name="category">
                    <option value="0">카테고리</option>
                    <option value="1">의류</option>
                    <option value="2">화장품/미용</option>
                    <option value="3">식품/농산물</option>
                    <option value="4">가구/인테리어</option>
                    <option value="5">배달음식</option>
                    <option value="6">유아동</option>
                    <option value="7">생활용품</option>
                    <option value="8">반려동물용품</option>
                </select>
            </div>
            <div>
                <div class="write-price">
                    <span>개당</span><input type="number" name="price" id="">￦
                </div>
                <div class="write-count">
                    공구 수량 <select name="type" >
                        <option value="0">수량 기준</option>
                        <option value="1">인원 기준</option>
                    </select>
                    <input type="text" name="num">명/개
                </div>
                
                <!-- 사진 파일 첨부 -->
                <div>
                    <input type="file" name="upPhoto1" accept=".jpg, .png, jpeg">
                    <input type="file" name="upPhoto2">
                    <input type="file" name="upPhoto3">
                </div>
            </div>
			<div>
				<pre><textarea name="content"></textarea></pre>
			</div>
			<div>
				<input name="link">
			</div>
            <!-- date/time -->
            <div class="write-info2">
                <div class="write-date">
                    <table class="write-tb">
                        <tr>
                            <td>공구 오픈 날짜</td>
                            <td><input type="datetime-local" name="openTime" id="openTime" onfocusout="mngEndTime();"></td>
                        </tr>
                        <tr>
                            <td>공구 마감 날짜</td>
                            <td><input type="datetime-local" name="endTime" ></td>
                        </tr>
                        <tr>
                            <td>물건 나눌 날짜</td>
                            <td><input type="datetime-local" name="sendTime" ></td>
                        </tr>
                        <tr>
                            <td></td>
                            <td><input type="checkbox" id="chk2" name="open_Time" value="sysdate"><label for="chk2">바로 시작하기</label></td>
                        </tr>
                    </table>
                </div>
                <div class="wirte-map">
                    <span>물건 나눌 장소</span>
                    <div id="map" class="ggWrite_map"></div>
                </div>
            </div>
            <input type="hidden" name="latitude" id="lat">
            <input type="hidden" name="longitude" id="lon">
            <input type="hidden" name="gongguWriter" value="${loginMember.userId }">
            <div class="ggStart-btn"><input type="button" value="공구 시작" onclick="ggEnrollFrmSubmit();"></div>
        </form>
    </div>
<script>
	var now_utc = Date.now();
	var timeOff = new Date().getTimezoneOffset()*60000;
	var today = new Date(now_utc-timeOff).toISOString().substring(0, 16);
	console.log("today: "+today);
	document.getElementById("openTime").setAttribute("min", today);
</script>

<script src="${pageContext.request.contextPath}/resources/js/gonggu/ggWriteMap.js"></script>
<script src="${pageContext.request.contextPath}/resources/js/gonggu/ggWrite.js"></script>
<jsp:include page="/WEB-INF/views/common/footer.jsp" />