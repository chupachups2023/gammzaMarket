<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/gonggu/ggRead.css?<%=System.currentTimeMillis() %> %>" type="text/css" />
<script	src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.3/jquery.min.js"></script>
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=44e2b21ec219944c6d834fff124a603d&libraries=services,clusterer"></script>
<style>
.modal-report {
		display:none;
		}
.report-bg {
        position: fixed;
        top: 0;
        left: 0;
        width: 100%;
        height: 100%;
        background-color: rgba(0, 0, 0, 0.5);
        z-index: 9999;
}
.report-content {
        position: fixed;
        top: 50%;
        left: 50%;
        transform: translate(-49%, -50%);
        background-color: #fff;
        padding: 20px;
        border-radius: 5px;
        box-shadow: 0 2px 8px rgba(0, 0, 0, 0.1);
        z-index: 10000;
}

#close-report {
        position: absolute;
        top: 10px;
        right: 10px;
        background-color: transparent;
        border: none;
        font-size: 18px;
        cursor: pointer;
}
#reportContent{
	resize:none;
	padding:5px;
}
.report-gongguName, #reportWriter{
	border:none;
	width:500px;
	font-family: 'Apple SD Gothic Neo','MYArirang_gothic','Malgun Gothic',arial,sans-serif;
	font-size:16px
}
</style>

<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param value="${gonggu.gongguName }" name="title" />
</jsp:include>


<div class="ggRead-section">
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
            <div class="ggRead-num">
                <div>${gonggu.num}개 나눠요<span>/</span></div>
                <div class="ggRead-on"> 아직 <span>${gonggu.num - 1}개</span> 남았어요</div>
            </div><input type="hidden" id="endtime" value="${gonggu.endTime }">
            <fmt:parseDate value="${gonggu.endTime }" var="endTime" pattern="yyyy-MM-dd HH:mm"/>
            <div class="ggRead-endtime"><fmt:formatDate value="${endTime }" pattern="yyyy년 MM월 dd일 HH시 mm분"/>까지 기다려요</div>
            <div class="ggRead-lefttime" id="left-time"></div>
            <c:choose>
            	<c:when test="${empty gonggu.link }">
		            <div><a class="ggRead-link-empty"> </a></div>
            	</c:when>
            	<c:otherwise>
		            <div><a href="${gonggu.link}" target="_blank" class="ggRead-link">물건의 자세한 정보는 여기서 볼 수 있어요</a></div>
            	</c:otherwise>
            </c:choose>
            <div class="ggRead-map">
                <div>여기서 나눠드려요</div>
                <div class="ggRead-mapp" id="map"></div>
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
	            <a href="${pageContext.request.contextPath}/gonggu/update.go?gongguNo=${gonggu.gongguNo}" class="button">글 수정</a>
	            <a href="" class="button">공구삭제</a>
	            <a href="" class="button">채팅하기</a>
	            <a href="" class="button">끌올하기</a>
	            <a href="" class="button">참여자확인</a>
        	</div>
        	</c:when>
        	<c:otherwise>
	        <div class="ggRead-button">
	            <a href="" class="button">참여신청</a>
	            <a href="" class="button">채팅하기</a>
	        </div>
        	</c:otherwise>
        </c:choose>
        <div>
        <c:choose>
        	<c:when test="${empty loginMember.userId}">
        		<div class="ggRead-report"><a id="pzlogin">신고</a></div>
        	</c:when>
        	<c:when test="${gonggu.gongguWriter eq loginMember.userId}">
        		<div class="ggRead-report"><a id="report-none">신고</a></div>
        	</c:when>
        	<c:otherwise>
            	<div class="ggRead-report"><a id="open-report">신고</a></div>
            </c:otherwise>
        </c:choose>
            <div class="ggRead-info">
                <div>관심 수 <span>${zzimCount }</span> · </div>
                <div>조회 수 <span>${gonggu.count }</span></div>
                <input type="hidden" value="${gonggu.longitude }" id="longitude">
                <input type="hidden" value="${gonggu.latitude }" id="latitude">
            </div>
        </div>
    </div>
</div>

<!-- 신고 모달창 -->
<div class="modal-report" id="report" tabindex="-1">
    <form action="${pageContext.request.contextPath}/report/insertReport.do" method="post" id="reportFrm">

        <div class="report-bg"></div>
        <div class="report-content" id="report">
            <h2>신고하기</h2>
            <ul class="report-top">
                <li class="report-info">신고글: <input type="text" class="report-gongguName report-info" value="${gonggu.gongguName}" readonly></li>
                <li class="report-info">신고자: <input type="text" id="reportWriter" name="reportWriter" value="${loginMember.userId}"></li>
                <li class="report-info"><span><textarea id="reportContent" rows="20px" cols="90px" name="reportContent" placeholder="신고내용을 적어주세요"></textarea></span></li>
                <li class="report-input modal-footer"><input type="button" class="report-btn button" value="신고하기" id="report-modal"></li>
            </ul>
            <br>
            <button type="button" id="close-report">취소</button>
        </div>
        <input type="hidden" id="gongguNo" name="gongguNo" value="${gonggu.gongguNo}" />
    </form>
</div>

<script src="${pageContext.request.contextPath}/resources/js/gonggu/ggRead_Partic.js?<%=System.currentTimeMillis() %>"></script>
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

  
const report = document.getElementById("report");
const openReportBtn = document.getElementById("open-report");
const closeReportBtn = document.getElementById("close-report");
const reportModalBtn = document.getElementById("report-modal");
const pzlogin = document.getElementById("pzlogin");
const mappppp=document.getElementById('map');

// 모달창 열기
openReportBtn.addEventListener("click", () => {
	report.style.display = "block";
	document.body.style.overflow = "hidden";
	
});
// 모달창 닫기
closeReportBtn.addEventListener("click", () => {
	report.style.display = "none";
	document.body.style.overflow = "auto"; 
});
// 모달창 닫기
reportModalBtn.addEventListener("click", () => {
	report.style.display = "none";
	document.body.style.overflow = "auto";
	reportFrm.submit();
});
pzlogin.addEventListener("click", () => {
	alert("로그인 후 이용가능합니다");
	location.href="${pageContext.request.contextPath}/";
});
</script>

<jsp:include page="/WEB-INF/views/common/footer.jsp" />