<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param value="장소인증" name="title"/>
</jsp:include>

  <div class="location-body">
        <img src="../resources/map.png" alt="map" class="location-map">
        <div>
            <div>
                <div class="location-title">현재 접속 동네</div>
                <div class="location-cont">서울시 영등포구 당산 제2동</div>
            </div>
            <div class="location-part">
                <div class="location-title">우리 동네 근처 옆동네</div>
                <div class="location-cont">당산동, 당산동4가, 당산동5가, 당산동6가, 합정동, 여의동, 양평동, 영등포동</div>
            </div>
            <div class="location-btn">
                <a href="#" class="button">장소 인증하기</a>
            </div>
        </div>
    </div>


<jsp:include page="/WEB-INF/views/common/footer.jsp" />