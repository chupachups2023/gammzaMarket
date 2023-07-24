<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/gonggu/ggRead.css?<%=System.currentTimeMillis() %>">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/gonggu/ggRead_End.css?<%=System.currentTimeMillis() %>">

<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param value="공구 이름 들어갈 곳" name="title"/>
</jsp:include>

<section class="ggRead-section">
    <div class="ggRead-head">
        <div class="ggRead-title">
            <div class="ggRead-writer ggRead-writer-none">${gonggu.gongguWriter }</div>
            <div class="ggRead-name">${gonggu.gongguName }</div>
            <div class="ggRead-writer" onclick="">${gonggu.gongguWriter }</div>
        </div>
    </div>
    <hr class="ggRead-hr">
    <div class="ggRead-body">
        <div class="ggRead-leftside">
            <div class="ggRead-slider-wrap">
                <div class="ggRead-slider-img">
                    <div class="ggRead-slider-inner">
                    	<c:if test="${not empty gonggu.photo1 }">
	                        <div class="ggRead-img-slider"><img src="${pageContext.request.contextPath}/resources/upload/${gonggu.photo1 }"></div>
                    	</c:if>
                    	<c:if test="${not empty gonggu.photo2 }">
	                        <div class="ggRead-img-slider"><img src="${pageContext.request.contextPath}/resources/upload/${gonggu.photo2 }"></div>
                    	</c:if>
                    	<c:if test="${not empty gonggu.photo3 }">
	                        <div class="ggRead-img-slider"><img src="${pageContext.request.contextPath}/resources/upload/${gonggu.photo3 }"></div>
                    	</c:if>
                    </div>
                </div>
                <div class="ggRead-slider-dot">
                </div>
            </div>
           <c:choose>
            	<c:when test="${empty gonggu.content }">
            		<div class="ggRead-content-empty"></div>
            	</c:when>
            	<c:otherwise>
		            <div class="ggRead-content">
		                ${gonggu.content }
		            </div>
            	</c:otherwise>
            </c:choose>
        </div>
        <div class="ggRead-detail">
            <div class="ggRead-price">개당 <fmt:formatNumber type="number" maxFractionDigits="3" value="${gonggu.price}" /> 포인트</div>
            <c:choose>
                	<c:when test="${gonggu.type eq 0 }">
			            <div class="ggRead-num">
			                <div>${gonggu.num}개 나눠요<span>/</span></div>
					        <div class="ggRead-on"> 지금 <span>${gonggu.num - partiNum}개</span> 남았어요</div>
			            </div>
                	</c:when>
                	<c:otherwise>
			            <div class="ggRead-num">
			                <div>${gonggu.num}명과 나눠요<span>/</span></div>
					        <div class="ggRead-on"> 지금 <span>${gonggu.num - partiNum}명</span> 남았어요</div>
			            </div>
                	</c:otherwise>
                </c:choose>
            <fmt:parseDate value="${gonggu.endTime }" var="endTime" pattern="yyyy-MM-dd HH:mm"/>
            <div class="ggRead-endtime"><fmt:formatDate value="${endTime }" pattern="yyyy년 MM월 dd일 HH시 mm분"/>까지 기다려요</div>
            <div class="ggRead-lefttime">00일 00시간 00분 남았어요</div>
            <c:choose>
            	<c:when test="${empty gonggu.link }">
		            <div><a class="ggRead-link-empty"> </a></div>
            	</c:when>
            	<c:otherwise>
		            <div><a href='${gonggu.link}"' target="_blank" class="ggRead-link">물건의 자세한 정보는 여기서 볼 수 있어요</a></div>
            	</c:otherwise>
            </c:choose>
            <div class="ggRead-map">
                <fmt:parseDate value="${gonggu.sendTime }" var="sendTime" pattern="yyyy-MM-dd"/>
                <div><fmt:formatDate value="${sendTime }" pattern="yyyy년 MM월 dd일"/>에 여기서 나눠드려요</div>
                <div class="ggRead-mapp" id="map"></div>
            </div>
        </div>
        <div class="ggRead-end">
            <div class="ggRead-endcont">
                마감되었습니다.
            </div>
        </div>
    </div>
    <div class="ggRead-btn">
        <div class="ggRead-title-right">
            <c:choose>
        		<c:when test="${gonggu.pullupAt eq gonggu.createAt}">
        			<fmt:parseDate value="${gonggu.createAt }" var="createAt" pattern="yyyy-MM-dd"/>
		            <div class="ggRead-date">작성 <fmt:formatDate value="${createAt }" pattern="yyyy년 MM월 dd일"/></div>
        		</c:when>
        		<c:otherwise>
        			<fmt:parseDate value="${gonggu.pullupAt }" var="pullupAt" pattern="yyyy-MM-dd"/>
		            <div class="ggRead-date">작성 <fmt:formatDate value="${pullupAt }" pattern="yyyy년 MM월 dd일"/></div>
        		</c:otherwise>
        	</c:choose>
            <div><img src="https://cdn-icons-png.flaticon.com/512/138/138533.png" alt="zzim" id="zzim"></div>
            <div><img src="https://cdn-icons-png.flaticon.com/512/2089/2089736.png" alt="share"></div>
        </div>
        <c:choose>
        	<c:when test="${gonggu.gongguWriter eq loginMember.userId}">
       		<div class="ggRead-button">
	            <a href="" class="button-end-writer">공구 마감하기</a>
	            <a href="javascript:deleteGonggu();"" class="button-end-writer">공구삭제</a>
	            <a href="" class="button-end-writer">채팅하기</a>
	            <a href="${pageContext.request.contextPath}/gonggu/checkPartis.pa?gongguNo=${gonggu.gongguNo}" class="button-end-writer">참여자확인</a>
        	</div>
        	</c:when>
        	<c:otherwise>
	        <div class="ggRead-button">
	            <a href="" class="button-end">참여신청</a>
	        </div>
        	</c:otherwise>
        </c:choose>
        <div>
            <div class="ggRead-report"><a href="#">신고</a></div>
            <div class="ggRead-info">
                <div>관심 수 <span>${zzimCount }</span> · </div>
                <div>조회 수 <span>${gonggu.count }</span></div>
                <input type="hidden" value="${gonggu.longitude }" id="longitude">
                <input type="hidden" value="${gonggu.latitude }" id="latitude">
            </div>
        </div>
    </div>
</section>

<script src="${pageContext.request.contextPath}/resources/js/gonggu/ggRead_Partic.js"></script>
<script>
const longitude= document.getElementById('longitude').value;
const latitude= document.getElementById('latitude').value;

 $.ajax({
	type:"get",
	url:"https://dapi.kakao.com/v2/local/geo/coord2address.json?x="+longitude+"&y="+latitude+"&input_coord=WGS84",
	beforeSend: function (header) {
		header.setRequestHeader("Authorization","KakaoAK ");
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
}) 
function deleteGonggu(){
	if(confirm("정말로 ${gonggu.gongguName} 공구를 삭제하시겠습니까?")){
		location.href="${pageContext.request.contextPath}/gonggu/deleteGonggu.go?gongguNo=${gonggu.gongguNo}";
	}else{
		return
	}
}
</script>

<jsp:include page="/WEB-INF/views/common/footer.jsp" />
