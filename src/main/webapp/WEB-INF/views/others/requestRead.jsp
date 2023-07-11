<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/others/requestRead.css?<%=System.currentTimeMillis() %>" type="text/css" />
<script	src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.3/jquery.min.js"></script>
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=44e2b21ec219944c6d834fff124a603d&libraries=services,clusterer"></script>

<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param value="${request.requestName }" name="title" />
</jsp:include>


<div class="ggRead-section">
    <div class="ggRead-head">
        <div class="ggRead-title">
            <div class="ggRead-writer ggRead-writer-none">${request.requestWriter }</div>
            <div class="ggRead-name">${request.requestName }</div>
            <div class="ggRead-writer" onclick="">${request.requestWriter }</div>
        </div>
    </div>
    <hr class="ggRead-hr">
    <div class="ggRead-body">
        <div class="ggRead-leftside">
            <div class="ggRead-slider-wrap">
                <div class="ggRead-slider-img">
                    <div class="ggRead-slider-inner">
                        <div class="ggRead-img-slider"><img src="${pageContext.request.contextPath}/resources/upload/${request.photo1 }"></div>
                    	<c:if test="${not empty gonggu.photo2 }">
	                        <div class="ggRead-img-slider"><img src="${pageContext.request.contextPath}/resources/upload/${request.photo2 }"></div>
                    	</c:if>
                    	<c:if test="${not empty gonggu.photo3 }">
	                        <div class="ggRead-img-slider"><img src="${pageContext.request.contextPath}/resources/upload/${request.photo3 }"></div>
                    	</c:if>
                    </div>
                </div>
                <div class="ggRead-slider-dot">
                </div>
            </div>
        </div>
        <div class="ggRead-detail">
            <div class="ggRead-price">총 <fmt:formatNumber type="number" maxFractionDigits="3" value="${request.price}" /> 포인트 예상</div>
            <div class="ggRead-lefttime" id="left-time"></div>
            <c:choose>
            	<c:when test="${empty request.link }">
		            <div><a class="ggRead-link-empty"> </a></div>
            	</c:when>
            	<c:otherwise>
		            <div><a href="${request.link}" target="_blank" class="ggRead-link">자세한 정보는 여기서 볼 수 있어요</a></div>
            	</c:otherwise>
            </c:choose>
            <div class="ggRead-map">
                <div>공구를 원하는 사람들은 여기에 있어요</div>
                <div class="ggRead-mapp" id="map"></div>
            </div>
        </div>
    </div>
    <div class="ggRead-btn">
        <div class="ggRead-title-right">
        	<div>조회 수 <span>${request.count }</span></div>
            <div><img src="https://cdn-icons-png.flaticon.com/512/2089/2089736.png" alt="share"></div>
        </div>
        <c:choose>
        	<c:when test="${request.requestWriter eq loginMember.userId}">
       		<div class="ggRead-button">
	            <a href="" class="button">글 삭제</a>
	            <a href="" class="button">공구열기</a>
        	</div>
        	</c:when>
        	<c:when test="${empty loginMember }">
	        <div class="ggRead-button">
	            <a onclick="alert('공구 요청에 참여하려면 먼저 로그인 하세요')" class="button">참여신청</a>
	            <a onclick="alert('공구를 열려면 먼저 로그인 하세요')" class="button">공구열기</a>
	        </div>
        	</c:when>
        	<c:otherwise>
	        <div class="ggRead-button">
	            <a href="${pageContext.request.contextPath}/gonggu/partiEnroll.pa?gongguNo=${gonggu.gongguNo}" class="button">참여신청</a>
	            <a href="" class="button">공구열기</a>
	        </div>
        	</c:otherwise>
        </c:choose>
    </div>
</div>

<script src="${pageContext.request.contextPath}/resources/js/others/ggRequest.js?<%=System.currentTimeMillis() %>"></script>
<script>
const longitude= document.getElementById('longitude').value;
const latitude= document.getElementById('latitude').value;

 $.ajax({
	type:"get",
	url:"https://dapi.kakao.com/v2/local/geo/coord2address.json?x="+longitude+"&y="+latitude+"&input_coord=WGS84",
	beforeSend: function (header) {
		header.setRequestHeader("Authorization","KakaoAK 840539f3651afe19f12cc19a1dc9e0ab");
    },
    success:function(result){
    	var container = document.getElementById('map'); //지도를 담을 영역의 DOM 레퍼런스
    	var options = { //지도를 생성할 때 필요한 기본 옵션
    		center: new kakao.maps.LatLng(latitude, longitude), //지도의 중심좌표.
    		level: 3 //지도의 레벨(확대, 축소 정도);
    		
    	};
    	var map = new kakao.maps.Map(container, options); //지도 생성 및 객체 리턴
    	
    	// 마커가 표시될 위치입니다 
    	var markerPosition  = new kakao.maps.LatLng(latitude, longitude); 

    	// 마커를 생성합니다
    	var marker = new kakao.maps.Marker({
    	    position: markerPosition
    	});

    	// 마커가 지도 위에 표시되도록 설정합니다
    	marker.setMap(map);
    },
    error:function(){
    	console.log("실패");
    }
});

</script>

<jsp:include page="/WEB-INF/views/common/footer.jsp" />