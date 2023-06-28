<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/common/ggWrite.css">

<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param value="공구 글 작성하기" name="title"/>
</jsp:include>

<!-- 
*제목 수정하기
*내용 들어갈 곳
*공구 글 작성 
-->

	<!-- 공구 글 작성 -->
    <!-- <h1>공구 물건 이름: 참여폼</h1>
    <hr> -->
    <div class="write-container">
        <form action="" method="">
            <div class="write-category">
                <input class="write-stuff" type="text" placeholder="공구할 물건">
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
            <div>
                <div class="write-price">
                    <span>개당</span><input type="text" name="" id="">￦
                </div>
                <div class="write-count">
                    공구 수량 <select name="" id="">
                        <option value="">수량 기준</option>
                        <option value="">인원 수 기준</option>
                        <option value="">물건 수 기준</option>
                    </select>
                    <input type="text">명/개
                    <!-- <input type="text">명 -->
                </div>
                
                <!-- 사진 파일 첨부 -->
                <div>
                    <p>(파일첨부)</p>
                    <br>
                    <br>
                    <br>
                    <br>
                    <br>
                </div>
            </div>

            <!-- date/time -->
            <div class="write-info2">
                <div class="write-date">
                    <table class="write-tb">
                        <tr>
                            <td>물건 나눌 날짜</td>
                            <td><input type="date" name="" id=""></td>
                        </tr>
                        <tr>
                            <td>물건 나눌 시간</td>
                            <td><input type="time"></td>
                        </tr>
                        <tr></tr>
                        <tr>
                            <td>공구 마감 날짜</td>
                            <td><input type="date" name="" id=""></td>
                        </tr>
                        <tr>
                            <td>공구 마감 시간</td>
                            <td><input type="time"></td>
                        </tr>
                        <tr>
                            <td>공구 오픈 날짜</td>
                            <td><input type="date" name="" id=""></td>
                        </tr>
                        <tr>
                            <td>공구 오픈 시간</td>
                            <td><input type="time"></td>
                        </tr>
                        <tr>
                            <td></td>
                            <td><input type="checkbox" id="chk2"><label for="chk2">바로 시작하기</label></td>
                        </tr>
                    </table>
                </div>
                <div class="wirte-map">
                    <span>물건 나눌 장소</span>
                    <img src="map.png" alt="" style="width: 300px;">
                </div>
            </div>
            
            <div class="ggStart-btn"><input type="button" value="공구 시작"></div>
        </form>
    </div>


<jsp:include page="/WEB-INF/views/common/footer.jsp" />