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
            <div class="ggRead-writer"><a href="${pageContext.request.contextPath}/member/userPf.bo?userPl=${request.requestWriter}">${request.requestWriter }</a></div>
        </div>
    </div>
    <hr class="ggRead-hr">
    <div class="ggRead-body">
        <div class="ggRead-leftside">
            <div class="ggRead-slider-wrap">
                <div class="ggRead-slider-img">
                    <div class="ggRead-slider-inner">
                        <div class="ggRead-img-slider"><img src="${pageContext.request.contextPath}/resources/upload/${request.photo1 }"></div>
                   	<c:if test="${not empty request.photo2 }">
                        <div class="ggRead-img-slider"><img src="${pageContext.request.contextPath}/resources/upload/${request.photo2 }"></div>
                   	</c:if>
                   	<c:if test="${not empty request.photo3 }">
                        <div class="ggRead-img-slider"><img src="${pageContext.request.contextPath}/resources/upload/${request.photo3 }"></div>
                   	</c:if>
                    </div>
                </div>
                <div class="ggRead-slider-dot">
                </div>
            </div>
        </div>
        <div class="ggRead-detail">
        	<c:choose>
        		<c:when test="${not empty request.price }">
            <div class="ggRead-price">총 <fmt:formatNumber type="number" maxFractionDigits="3" value="${request.price}" /> 포인트 예상</div>
        		</c:when>
        	</c:choose>
            <div class="ggRead-price">이 공구를 ${request.num }명이 기다리고 있어요</div>
            <c:choose>
            	<c:when test="${empty request.link }">
		            <div><a class="ggRead-link-empty"> &emsp; </a></div>
            	</c:when>
            	<c:otherwise>
		            <div><a href="${request.link}" target="_blank" class="ggRead-link">자세한 정보는 여기서 볼 수 있어요</a></div>
            	</c:otherwise>
            </c:choose>
            <div class="ggRead-map">
                <div>공구를 기다리는 사람들은 여기에 있어요</div>
                <div class="ggRead-mapp" id="map"></div>
            </div>
        </div>
    </div>
    <div class="ggRead-btn">
        <div class="ggRead-title-right">
        	<div>조회 수 <span>${request.count }</span></div>
            <div><img src="https://cdn-icons-png.flaticon.com/512/2089/2089736.png" alt="share" onclick="clip();"></div>
        </div>
        <c:choose>
        	<c:when test="${request.requestWriter eq loginMember.userId}">
       		<div class="ggRead-button">
	            <button onclick="deleteReq();" class="button">글 삭제</button>
	            <a href="${pageContext.request.contextPath}/ggRequest/gongguWrite.req?requestNo=${request.requestNo}" class="button">공구열기</a>
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
	            <button onclick="enrollRequest();" class="button">참여신청</button>
	            <a href="${pageContext.request.contextPath}/ggRequest/gongguWrite.req?requestNo=${request.requestNo}" class="button">공구열기</a>
	        </div>
        	</c:otherwise>
        </c:choose>
    </div>
</div>

<script src="${pageContext.request.contextPath}/resources/js/others/ggRequest.js?<%=System.currentTimeMillis() %>"></script>
<script>
const longitude= "${request.longitude}";
const latitude= "${request.latitude}";

$.ajax({
	url:"${pageContext.request.contextPath}/ggRequest/requestMember.req",
	type:"post",
	data:{"requestNo" : "${request.requestNo}"},
	success:function(result){
		const reqMember=result.reqMember;
		
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
		    		level: 6 //지도의 레벨(확대, 축소 정도);
	    		};
		    	var map = new kakao.maps.Map(container, options); //지도 생성 및 객체 리턴
		    	
		    	for(let i=0;i<reqMember.length;i++){
			    	var markerPosition  = new kakao.maps.LatLng(reqMember[i].latitude, reqMember[i].longitude); 
			
			    	var marker = new kakao.maps.Marker({
			    	    position: markerPosition
			    	});
			
			    	marker.setMap(map);
		    	}
		    },
		    error:function(){
		    	console.log("실패");
		    }
		});
	},
	error:function(){
		console.log("에러")
	}
});


function enrollRequest(){
	const loginMember="${loginMember.userId}";
	if(loginMember=="" || loginMember == null){
		alert("먼저 로그인 해주세요");
	}else{
		if(confirm("공구 요청에 참여하시겠습니까?")){
			location.href="${pageContext.request.contextPath}/ggRequest/enrollRequest.req?requestNo=${request.requestNo}"
		}else{
			return
		}
	}
}
function deleteReq(){
	if(confirm("정말로 [${request.requestName}] 요청글을 삭제하시겠습니까?")){
		location.href="${pageContext.request.contextPath}/ggRequest/requestDelete.req?requestNo=${request.requestNo}"
	}else{
		return
	}
}

function clip(){

    var url = '';    // <a>태그에서 호출한 함수인 clip 생성
    var textarea = document.createElement("textarea");  
    //url 변수 생성 후, textarea라는 변수에 textarea의 요소를 생성
    
    document.body.appendChild(textarea); //</body> 바로 위에 textarea를 추가(임시 공간이라 위치는 상관 없음)
    url = window.document.location.href;  //url에는 현재 주소값을 넣어줌
    textarea.value = url;  // textarea 값에 url를 넣어줌
    textarea.select();  //textarea를 설정
    document.execCommand("copy");   // 복사
    document.body.removeChild(textarea); //extarea 요소를 없애줌
    
    alert("주소가 복사되었습니다.")  // 알림창
}
 
</script>

<jsp:include page="/WEB-INF/views/common/footer.jsp" />
